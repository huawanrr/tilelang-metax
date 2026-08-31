#!/usr/bin/env python3
"""Stage 1 with gate and up concatenated along N into a single GEMM.

The shipped stage 1 runs two 128x128 GEMMs against one shared A tile, so it needs
two fp32 accumulators.  Two accumulators of 128x128 over 256 threads is 128
registers a thread, which is what pins the block at 2 per CU, and the 2x2 wave
grid it implies gives a 64x64 wave tile -- i.e. every A and B slab is read from
LDS by two waves, twice (once per GEMM).

Concatenating the two weight tiles into one (2*bn, bk) shared buffer turns that
into a single GEMM with *one* (bm, 2*bn) accumulator: identical register count,
identical bytes filled into shared memory per flop, but a 64x128 wave tile, which
reads 25% fewer bytes from LDS per MMA, and one fewer __syncthreads per k-step.
The catch is the shared footprint, (bm + 2*bn) * bk * 2, which only stays inside
the 32 KiB that keeps two blocks resident per CU if block_k drops to 32 -- and a
32-wide k slice makes the global row segments 64 B instead of 128 B, which
`exp_bw.py` prices at 691 vs 911 GB/s.  This script measures which side wins.
"""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

from local_bench import BLOCK_TOKEN, build_case, load_cases
import tune_moe as tm

PASS = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True}


def build(cfg, shape):
    hidden, intermediate, num_experts, padded, valid, num_blocks = shape
    bm, bn, bk = cfg["bm"], cfg["bn"], cfg["bk"]
    threads, swizzle, merge = cfg["threads"], cfg["swizzle"], cfg["merge"]
    unroll, mask = cfg["unroll"], cfg["mask"]
    scale = 1.44269504
    dtype = T.float16
    accum = T.float32
    sub = max(1, BLOCK_TOKEN // bm)
    grid_m = num_blocks * sub
    n_tiles = intermediate // bn

    @T.prim_func
    def kernel(
        tokens: T.Tensor((padded, hidden), dtype),
        gate_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        up_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        group_sizes: T.Tensor((num_experts,), T.int32),
        group_padded_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((num_blocks,), T.int32),
        up_logits: T.Tensor((padded, intermediate), dtype),
    ):
        with T.Kernel(grid_m, n_tiles, threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype=dtype)
            if merge:
                # Rows [0, bn) hold the gate tile and [bn, 2*bn) the up tile, so
                # one GEMM produces both halves of the accumulator.
                w_s = T.alloc_shared((2 * bn, bk), dtype=dtype)
                acc = T.alloc_fragment((bm, 2 * bn), dtype=accum)
                # The epilogue needs acc[i, j] and acc[i, j + bn] together, and a
                # single T.Parallel loop may only index a fragment one way, so the
                # activated gate half lands in a half-precision temp first (32 VGPRs
                # a thread) and the second loop touches acc only as [i, j + bn].
                act = T.alloc_fragment((bm, bn), dtype=dtype)
            else:
                w_s = T.alloc_shared((bn, bk), dtype=dtype)
                gate_l = T.alloc_fragment((bm, bn), dtype=accum)
                up_l = T.alloc_fragment((bm, bn), dtype=accum)
            if cfg["pad_kb"]:
                # A shared buffer that does nothing but occupy LDS.  It is filled from
                # a loaded value and the epilogue multiplies by it, so neither the
                # allocation nor the writes can be folded away.  Sweeping its size is
                # a direct measurement of how much shared memory per block the CU can
                # hold before it stops holding two blocks.
                pad_s = T.alloc_shared((cfg["pad_kb"] * 512,), dtype=dtype)
            if swizzle:
                T.use_swizzle(swizzle)

            ext = bx // sub
            # `mask` replaces the min/max clamp with a bitwise AND.  Both prove the
            # index is in [0, E), but the generated source shows TileLang's safe-access
            # pass still wraps every weight load in `if (0 <= e && e < E)` under the
            # clamp; a mask may be something its range analysis can see through.
            if mask:
                expert = group_idx_for_bx[ext] & (num_experts - 1)
            else:
                expert = T.min(T.max(group_idx_for_bx[ext], 0), num_experts - 1)
            row0 = ext * BLOCK_TOKEN + (bx % sub) * bm
            rows = T.max(0, T.min(bm, group_sizes[expert]
                                  - (row0 - group_padded_offsets[expert])))
            if rows > 0:
                if cfg["pad_kb"]:
                    for i in T.Parallel(cfg["pad_kb"] * 512):
                        pad_s[i] = T.cast(T.min(rows, 1), dtype)
                if merge:
                    T.clear(acc)
                else:
                    T.clear(gate_l)
                    T.clear(up_l)
                for k in T.unroll(hidden // bk, explicit=False, unroll_factor=unroll):
                    T.copy(tokens[row0:row0 + bm, k * bk:(k + 1) * bk], a_s)
                    if merge:
                        T.copy(gate_w[expert, by * bn:(by + 1) * bn,
                                      k * bk:(k + 1) * bk], w_s[0:bn, :])
                        T.copy(up_w[expert, by * bn:(by + 1) * bn,
                                    k * bk:(k + 1) * bk], w_s[bn:2 * bn, :])
                        T.gemm(a_s, w_s, acc, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                    else:
                        T.copy(gate_w[expert, by * bn:(by + 1) * bn,
                                      k * bk:(k + 1) * bk], w_s)
                        T.gemm(a_s, w_s, gate_l, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                        T.copy(up_w[expert, by * bn:(by + 1) * bn,
                                    k * bk:(k + 1) * bk], w_s)
                        T.gemm(a_s, w_s, up_l, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)

                if merge:
                    for i, j in T.Parallel(bm, bn):
                        act[i, j] = T.cast(
                            acc[i, j] * (1.0 / (1.0 + T.exp2(-acc[i, j] * scale))),
                            dtype,
                        )
                    for i, j in T.Parallel(bm, bn):
                        if i < rows:
                            up_logits[row0 + i, by * bn + j] = (
                                T.cast(acc[i, bn + j], dtype) * act[i, j]
                            )
                else:
                    for i, j in T.Parallel(bm, bn):
                        if i < rows:
                            up_logits[row0 + i, by * bn + j] = (
                                up_l[i, j] * gate_l[i, j]
                                * (1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                                * (T.cast(pad_s[0], accum) if cfg["pad_kb"] else 1.0)
                            )

    return kernel


DEFAULT = {"bm": 128, "bn": 128, "bk": 64, "threads": 256, "swizzle": 8,
           "merge": False, "unroll": 1, "mask": False, "nosafe": False,
           "pad_kb": 0}


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--case", default="oj2exact")
    p.add_argument("--extra", action="append", default=[])
    p.add_argument("--iters", type=int, default=30)
    p.add_argument("--warmup", type=int, default=8)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()
    os.environ["TILELANG_CACHE_DIR"] = os.path.join(
        os.path.expanduser("~"), ".tilelang", "cache_stock")

    case = load_cases(a.configs, [a.case])[0]
    device = torch.device("cuda")
    args, meta = build_case(case, device)
    shape = (case.dhidden, case.dexpert, case.nroutedexperts, case.n_padded,
             case.n_valid, case.num_blocks_m)
    ref = tm.ref_stage1(args, meta)
    flops = 4 * case.n_valid * case.dhidden * case.dexpert

    print(f"case={a.case} valid={case.n_valid} padded={case.n_padded} "
          f"H={case.dhidden} I={case.dexpert}")
    print(f"{'variant':<22}{'ms':>10}{'TF/s':>9}{'err':>11}  note")
    for spec in a.extra:
        name, _, body = spec.partition(":")
        cfg = dict(DEFAULT)
        for kv in body.split(","):
            if not kv:
                continue
            k, _, val = kv.partition("=")
            cfg[k] = val.lower() in ("1", "true") if isinstance(DEFAULT[k], bool) else int(val)
        try:
            passes = dict(PASS)
            if cfg["nosafe"]:
                passes[tilelang.PassConfigKey.TL_DISABLE_SAFE_MEMORY_ACCESS] = True
            fn = tilelang.compile(build(cfg, shape), out_idx=None, pass_configs=passes)
        except Exception as exc:
            print(f"{name:<22}{'COMPILE FAIL':>10}  {type(exc).__name__}: {str(exc)[:90]}")
            continue
        dst = torch.zeros((case.n_padded, case.dexpert), device=device, dtype=torch.float16)
        pos = (args["stacked_expert_tokens"], args["gate_w"], args["up_w"],
               args["group_sizes"], args["group_padded_offsets"],
               args["group_idx_for_bx"], dst)
        try:
            fn(*pos)
            torch.cuda.synchronize()
        except Exception as exc:
            print(f"{name:<22}{'RUN FAIL':>10}  {type(exc).__name__}: {str(exc)[:90]}")
            continue
        err = tm.max_err_valid(dst, ref, meta)
        for _ in range(a.warmup):
            fn(*pos)
        torch.cuda.synchronize()
        s, e = torch.cuda.Event(True), torch.cuda.Event(True)
        s.record()
        for _ in range(a.iters):
            fn(*pos)
        e.record()
        torch.cuda.synchronize()
        ms = s.elapsed_time(e) / a.iters
        smem = ((cfg["bm"] + (2 if cfg["merge"] else 1) * cfg["bn"]) * cfg["bk"] * 2
                + cfg["pad_kb"] * 1024)
        print(f"{name:<22}{ms:>10.3f}{flops / (ms * 1e-3) / 1e12:>9.2f}{err:>11.2e}  "
              f"{'OK' if err < 5e-3 else 'MISMATCH':<9} smem={smem // 1024}K")
        del dst


if __name__ == "__main__":
    main()
