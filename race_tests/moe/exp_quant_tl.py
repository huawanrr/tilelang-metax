#!/usr/bin/env python3
"""TileLang int8 quantisation of the stage-1 A operand, end to end.

`exp_quant.py` priced the *accuracy* of this in torch; this builds the real thing:

1. a TileLang kernel that quantises `stacked_expert_tokens` to int8 with one fp16
   scale per 16 elements along k (per-row scales are not accurate enough -- see
   NOTES.md §7), and
2. stage 1 reading that int8 tile and dequantising it into shared memory, so the MMA
   and the weights stay fp16 and only the global-to-shared traffic shrinks.

The point is the global traffic: stage 1 streams the token tile once per n-tile block,
16x its own size on Config3, and both stages sit within 8% of their bandwidth roof.
int8 plus a per-16 fp16 scale is 18 bytes per 16 elements against 32, so that stream
gets 44% cheaper.

**Result: it works and it loses.** The quantiser is exact to the theoretical int8 bound
(worst |deq-x| = 3.94e-3 of the row maximum, and 1/(2*127) = 3.9e-3) and costs 0.432 ms
on Config3, but the dequantising stage 1 runs **6.526 -> 10.586 ms, +62%**: the
per-element pass over the tile costs far more than the 0.72 ms of global traffic it
saves, the same lesson as routing MMA operands through `T.copy`.  And the ceiling is
low even with a free dequantiser: A is only 30% of stage 1's streamed bytes, the
weights are the other 70% and cannot be quantised (they are streamed 1.5x per call, so
converting them costs more than it saves), so a perfect implementation would be
-4.4% on stage 1, about -3% end to end, in exchange for dropping the accuracy margin
from ~170x to 1.45x.

    python exp_quant_tl.py --case oj3real
"""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

from local_bench import ARG_ORDER, BLOCK_TOKEN, build_case, load_cases, time_fn
import tune_moe as tm

BASE_PASS = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}
GROUP = int(os.environ.get("GROUP", "16"))  # elements per scale


def build_quant(rows, hidden, bm=64, bk=256, threads=256):
    """fp16 (rows, hidden) -> int8 codes + fp16 scales, one scale per GROUP elements.

    The scale is written first and then read back to build the codes, so the value the
    dequantiser multiplies by is exactly the one the quantiser divided by.
    """
    nchunk = bk // GROUP

    @T.prim_func
    def quant(
        src: T.Tensor((rows, hidden), T.float16),
        dst: T.Tensor((rows, hidden), T.int8),
        scale: T.Tensor((rows, hidden // GROUP), T.float16),
    ):
        with T.Kernel(T.ceildiv(hidden, bk), T.ceildiv(rows, bm), threads=threads) as (bx, by):
            x = T.alloc_shared((bm, bk), T.float16)
            mx = T.alloc_fragment((bm, nchunk), T.float32)
            s = T.alloc_fragment((bm, nchunk), T.float16)
            T.copy(src[by * bm : (by + 1) * bm, bx * bk : (bx + 1) * bk], x)
            T.clear(mx)
            # One thread per (row, chunk): the fragment slot is private, so the serial
            # reduction over the group needs no synchronisation.
            for i, c in T.Parallel(bm, nchunk):
                for e in T.serial(GROUP):
                    mx[i, c] = T.max(mx[i, c], T.abs(T.cast(x[i, c * GROUP + e], T.float32)))
            for i, c in T.Parallel(bm, nchunk):
                s[i, c] = T.cast(T.max(mx[i, c], 1e-12) * (1.0 / 127.0), T.float16)
                scale[by * bm + i, bx * nchunk + c] = s[i, c]
            for i, j in T.Parallel(bm, bk):
                v = T.cast(x[i, j], T.float32) / T.cast(s[i, j // GROUP], T.float32)
                dst[by * bm + i, bx * bk + j] = T.cast(
                    T.round(T.max(T.min(v, 127.0), -127.0)), T.int8
                )

    return quant


def build_stage1(shape, quantized, bm=128, bn=128, bk=64, threads=512):
    """Stage 1, with the A tile either read as fp16 or as int8 + per-16 scales.

    The int8 path stages the codes and the scales through their own (small) shared
    tiles and then writes the dequantised fp16 tile, which costs an extra shared-memory
    round trip -- shared-memory traffic has repeatedly measured free here, unlike global
    traffic, so that is the cheap place to put the conversion.
    """
    hidden, intermediate, num_experts, padded, valid, num_blocks = shape
    scale = 1.44269504
    dtype, accum = T.float16, T.float32
    nchunk = bk // GROUP

    @T.prim_func
    def kernel(
        tokens: T.Tensor((padded, hidden), dtype),
        tokens_q: T.Tensor((padded, hidden), T.int8),
        tokens_s: T.Tensor((padded, hidden // GROUP), dtype),
        gate_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        up_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        group_sizes: T.Tensor((num_experts,), T.int32),
        group_padded_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((num_blocks,), T.int32),
        up_logits: T.Tensor((padded, intermediate), dtype),
    ):
        with T.Kernel(num_blocks, T.ceildiv(intermediate, bn), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype=dtype)
            w_s = T.alloc_shared((bn, bk), dtype=dtype)
            gate_l = T.alloc_fragment((bm, bn), dtype=accum)
            up_l = T.alloc_fragment((bm, bn), dtype=accum)
            if quantized:
                q_s = T.alloc_shared((bm, bk), dtype=T.int8)
                sc_s = T.alloc_shared((bm, nchunk), dtype=dtype)
            T.use_swizzle(8)

            expert = T.min(T.max(group_idx_for_bx[bx], 0), num_experts - 1)
            row0 = bx * BLOCK_TOKEN
            rows = T.max(0, T.min(bm, group_sizes[expert] - (row0 - group_padded_offsets[expert])))

            if rows > 0:
                T.clear(gate_l)
                T.clear(up_l)
                for k in T.Pipelined(T.ceildiv(hidden, bk), num_stages=0):
                    if quantized:
                        T.copy(tokens_q[row0 : row0 + bm, k * bk : (k + 1) * bk], q_s)
                        T.copy(tokens_s[row0 : row0 + bm,
                                        k * nchunk : (k + 1) * nchunk], sc_s)
                        # Scalar on purpose.  Wrapping the group in `T.vectorized(16)`
                        # to get one int8x16 read per thread made it both slower
                        # (+126% instead of +62%) and wrong (err 5.5e+01): the
                        # vectorised int8 read against an fp16 destination is not the
                        # cast this expression asks for.
                        for i, j in T.Parallel(bm, bk):
                            a_s[i, j] = T.cast(q_s[i, j], dtype) * sc_s[i, j // GROUP]
                    else:
                        T.copy(tokens[row0 : row0 + bm, k * bk : (k + 1) * bk], a_s)
                    T.copy(gate_w[expert, by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], w_s)
                    T.gemm(a_s, w_s, gate_l, transpose_B=True)
                    T.copy(up_w[expert, by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], w_s)
                    T.gemm(a_s, w_s, up_l, transpose_B=True)

                for i, j in T.Parallel(bm, bn):
                    gate_l[i, j] = gate_l[i, j] * (1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                    up_l[i, j] = up_l[i, j] * gate_l[i, j]
                    if i < rows:
                        up_logits[row0 + i, by * bn + j] = up_l[i, j]

    return kernel


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--case", default="oj3real")
    p.add_argument("--iters", type=int, default=15)
    p.add_argument("--warmup", type=int, default=4)
    p.add_argument("--kpack", action="store_true", default=True)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()
    os.environ["TILELANG_CACHE_DIR"] = os.path.expanduser("~/.tilelang/cache_quant")
    if a.kpack:
        import moe
        print("k_pack override:", moe._k_pack_on())

    case = load_cases(a.configs, [a.case])[0]
    dev = torch.device("cuda")
    args, meta = build_case(case, dev)
    shape = (case.dhidden, case.dexpert, case.nroutedexperts, case.n_padded,
             case.n_valid, case.num_blocks_m)
    tokens = args["stacked_expert_tokens"]
    rows, hidden = tokens.shape
    ref = tm.ref_stage1(args, meta)

    # --- the quantiser -------------------------------------------------------
    q = torch.empty((rows, hidden), device=dev, dtype=torch.int8)
    s = torch.empty((rows, hidden // GROUP), device=dev, dtype=torch.float16)
    qk = tilelang.compile(build_quant(rows, hidden), out_idx=None, pass_configs=BASE_PASS)
    qk(tokens, q, s)
    torch.cuda.synchronize()
    deq = q.float().reshape(rows, hidden // GROUP, GROUP) * s.float().unsqueeze(-1)
    deq = deq.reshape(rows, hidden)
    amax = tokens.float().abs().amax(dim=1, keepdim=True).clamp_min(1e-6)
    err = ((deq - tokens.float()).abs() / amax).max().item()
    ms_q = time_fn(lambda: qk(tokens, q, s), a.warmup, a.iters)
    gb = (tokens.numel() * 2 + q.numel() + s.numel() * 2) / 1e9
    print(f"quantise kernel: {ms_q:.3f} ms  {gb / (ms_q * 1e-3):.2f} TB/s  "
          f"worst |deq-x|/max|row| = {err:.2e}  (a perfect int8 code is <= 3.9e-3)")
    del deq

    # --- stage 1, fp16 A vs int8 A ------------------------------------------
    flops = 4 * case.n_valid * case.dhidden * case.dexpert
    print(f"{'variant':<16}{'ms':>9}{'TF/s':>8}{'err':>11}")
    base_ms = None
    for name, quantized in (("A fp16", False), ("A int8/16", True)):
        kern = tilelang.compile(build_stage1(shape, quantized), out_idx=None,
                                pass_configs=BASE_PASS)
        dst = torch.zeros((case.n_padded, case.dexpert), device=dev, dtype=torch.float16)
        call = lambda: kern(tokens, q, s, args["gate_w"], args["up_w"], args["group_sizes"],
                            args["group_padded_offsets"], args["group_idx_for_bx"], dst)
        call()
        torch.cuda.synchronize()
        e = tm.max_err_valid(dst, ref, meta)
        ms = time_fn(call, a.warmup, a.iters)
        base_ms = base_ms or ms
        print(f"{name:<16}{ms:>9.3f}{flops / (ms * 1e-3) / 1e12:>8.2f}{e:>11.2e}"
              f"   {ms / base_ms:.3f}x")
        if quantized:
            print(f"stage 1 alone: {(ms - base_ms) / base_ms * 100:+.1f}%; "
                  f"with the quantiser: {(ms + ms_q - base_ms) / base_ms * 100:+.1f}%")
        del dst
        torch.cuda.empty_cache()


if __name__ == "__main__":
    main()


