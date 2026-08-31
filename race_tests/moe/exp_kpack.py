#!/usr/bin/env python3
"""Does forwarding `k_pack` to the MACA MMA emitter beat the LDS-read wall?

`exp_stage.py` shows both stages spend ~80% of their time in a loop whose only
non-MMA work is `ds_read_b64` pairs feeding `__builtin_mxc_mma_16x16x16f16`.
The emitter in `tilelang/maca/intrinsics/macro/mma_macro_generator.py` already
supports `k_pack`, which reads `k_pack * 4` halves per instruction (a 16-byte
LDS read at k_pack=2) and then issues `k_pack` MMAs -- but
`tilelang/maca/op/gemm/gemm_mma.py` never passes it on, and its `ki` loop bound
and fragment sizes assume `k_pack == 1`.

This script monkey-patches those three things at runtime -- it does not touch the
installed files -- and times the patched lowering against the stock one.  It
answers whether the inner loop is bound by LDS *instructions* (halving them
would help) or by LDS *bytes* (it would not).

    python exp_kpack.py --stage 2 --case mid --k-pack 2
"""
import argparse
import os

import torch
import tilelang
import tilelang.language as T
from tilelang import tvm as tvm
from tvm import tir

from tilelang.maca.op.gemm.gemm_mma import GemmMMA, GEMM_INST_MMA
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter
from tilelang.utils.language import is_full_region
from tilelang.transform.simplify import _Simplify

import exp_stage as ex
from local_bench import build_case, load_cases, time_fn
import tune_moe as tm

# The kernel cache keys on the prim_func, not on the monkey-patched lowering, so
# a patched build would otherwise be served the stock kernel from cache.
tilelang.disable_cache()

FORCED_K_PACK = [1]


def _patched_make_emitter(self, target, thread_nums, thread_var=None):
    m_warp, n_warp = self.policy.compute_warp_partition(
        self.M, self.N, thread_nums, target, GEMM_INST_MMA)
    return TensorCoreIntrinEmitter(
        a_dtype=self.in_dtype,
        b_dtype=self.in_dtype,
        accum_dtype=self.accum_dtype,
        a_transposed=self.trans_A,
        b_transposed=self.trans_B,
        block_row_warps=m_warp,
        block_col_warps=n_warp,
        warp_row_tiles=int(self.M // m_warp),
        warp_col_tiles=int(self.N // n_warp),
        chunk=self.chunk,
        k_pack=FORCED_K_PACK[0],
        thread_var=thread_var,
    )


def _patched_lower(self, layout_map, target, thread_bounds, thread_var, mbar_phase_expr=None):
    if not self.is_gemm_ss():
        return _STOCK_LOWER(self, layout_map, target, thread_bounds, thread_var, mbar_phase_expr)
    emitter = self._make_mma_emitter(target, thread_bounds.extent, thread_var=thread_var)
    in_dtype = self.in_dtype
    warp_rows, warp_cols = emitter.warp_rows, emitter.warp_cols
    local_size_a, local_size_b = emitter.local_size_a, emitter.local_size_b
    kp = emitter.k_pack
    steps = emitter.chunk // (kp * emitter.micro_size_k)
    A_region, B_region, C_buf = self.ARegion, self.BRegion, self.CRegion.buffer
    clear_accum = self.clear_accum
    assert is_full_region(self.CRegion)

    @T.prim_func
    def _gemm_ssr() -> None:
        A_local = T.alloc_local((warp_rows * kp * local_size_a), in_dtype)
        B_local = T.alloc_local((warp_cols * kp * local_size_b), in_dtype)
        if clear_accum:
            T.clear(C_buf)
        for ki in T.serial(0, steps):
            emitter.ldmatrix_a(A_local, A_region, ki)
            emitter.ldmatrix_b(B_local, B_region, ki)
            emitter.mma(A_local, B_local, C_buf, ki)

    return _Simplify(_gemm_ssr, inline_let=True)


_STOCK_LOWER = GemmMMA.lower
_STOCK_EMITTER = GemmMMA._make_mma_emitter


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--stage", type=int, default=2)
    p.add_argument("--case", default="mid")
    p.add_argument("--k-pack", type=int, default=2)
    p.add_argument("--threads", type=int, default=256)
    p.add_argument("--n-pair", type=int, default=1)
    p.add_argument("--iters", type=int, default=15)
    p.add_argument("--warmup", type=int, default=6)
    p.add_argument("--configs", default=os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                                     "local_test_configs.json"))
    a = p.parse_args()

    case = load_cases(a.configs, [a.case])[0]
    device = torch.device("cuda")
    args, meta = build_case(case, device)
    shape = (case.dhidden, case.dexpert, case.nroutedexperts, case.n_padded,
             case.n_valid, case.num_blocks_m)
    if a.stage == 1:
        ref = tm.ref_stage1(args, meta)
        flops = 4 * case.n_valid * case.dhidden * case.dexpert
    else:
        up_logits = tm.ref_stage1(args, meta)
        ref = tm.ref_stage2(up_logits, args, meta)
        flops = 2 * case.n_valid * case.dhidden * case.dexpert

    cfg = dict(ex.DEFAULT)
    cfg["swizzle"] = 8
    cfg["threads"] = a.threads
    cfg["n_pair"] = a.n_pair
    flag = torch.zeros((1,), device=device, dtype=torch.int32)
    print(f"case={a.case} stage={a.stage}")
    print(f"{'variant':<16}{'ms':>10}{'TF/s':>9}{'err':>11}")

    for name, kp, patched in (("stock", 1, False), (f"kpack{a.k_pack}", a.k_pack, True),
                              ("stock_again", 1, False)):
        FORCED_K_PACK[0] = kp
        if patched:
            GemmMMA.lower = _patched_lower
            GemmMMA._make_mma_emitter = _patched_make_emitter
        else:
            GemmMMA.lower = _STOCK_LOWER
            GemmMMA._make_mma_emitter = _STOCK_EMITTER
        builder = ex.build_stage1 if a.stage == 1 else ex.build_stage2
        try:
            kern = tilelang.compile(builder(cfg, shape), out_idx=None,
                                    pass_configs=dict(ex.BASE_PASS))
        except Exception as exc:
            print(f"{name:<16}{'-':>10}{'-':>9}{'-':>11}  build failed: "
                  f"{type(exc).__name__}: {str(exc)[:180]}")
            continue
        if a.stage == 1:
            dst = torch.zeros((case.n_padded, case.dexpert), device=device, dtype=torch.float16)
            call = lambda: kern(args["stacked_expert_tokens"], args["gate_w"], args["up_w"],
                                args["group_sizes"], args["group_padded_offsets"],
                                args["group_idx_for_bx"], flag, dst)
        else:
            dst = torch.zeros((case.n_padded, case.dhidden), device=device, dtype=torch.float16)
            call = lambda: kern(up_logits, args["down_w"], args["routed_expert_weights"],
                                args["group_sizes"], args["group_offsets"],
                                args["group_padded_offsets"], args["group_idx_for_bx"], flag, dst)
        try:
            call()
            torch.cuda.synchronize()
        except Exception as exc:
            print(f"{name:<16}{'-':>10}{'-':>9}{'-':>11}  run failed: {str(exc)[:150]}")
            continue
        err = tm.max_err_valid(dst, ref, meta)
        ms = time_fn(call, a.warmup, a.iters)
        print(f"{name:<16}{ms:>10.3f}{flops / (ms * 1e-3) / 1e12:>9.2f}{err:>11.2e}"
              f"  {'OK' if err < 5e-3 else 'MISMATCH'}")
        del dst
        torch.cuda.empty_cache()

    GemmMMA.lower = _STOCK_LOWER
    GemmMMA._make_mma_emitter = _STOCK_EMITTER


if __name__ == "__main__":
    main()
