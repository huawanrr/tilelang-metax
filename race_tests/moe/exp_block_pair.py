#!/usr/bin/env python3
"""Stage-1 probe that shares each weight tile across two token blocks."""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

import tune_moe as tm
from local_bench import build_case, load_cases, time_fn


PASS = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}
BM, BN, BK, THREADS = 128, 128, 64, 512


@tilelang.jit(pass_configs=PASS)
def build(hidden, intermediate, num_experts, padded, valid, num_blocks, paired):
    dtype, accum = T.float16, T.float32
    scale = 1.44269504

    @T.prim_func
    def kernel(
        tokens: T.Tensor((padded, hidden), dtype),
        gate_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        up_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        group_sizes: T.Tensor((num_experts,), T.int32),
        group_padded_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((num_blocks,), T.int32),
        dst: T.Tensor((padded, intermediate), dtype),
    ):
        with T.Kernel(num_blocks, T.ceildiv(intermediate, BN), threads=THREADS) as (bx, by):
            a_s = T.alloc_shared((BM, BK), dtype)
            w_s = T.alloc_shared((BN, BK), dtype)
            acc0 = T.alloc_fragment((BM, BN), accum)
            acc1 = T.alloc_fragment((BM, BN), accum)
            T.use_swizzle(8)

            expert = T.min(T.max(group_idx_for_bx[bx], 0), num_experts - 1)
            row0 = bx * BM
            size = group_sizes[expert]
            padded0 = group_padded_offsets[expert]
            offset = row0 - padded0
            rows0 = T.max(0, T.min(BM, size - offset))

            if paired:
                active = ((offset // BM) % 2 == 0) and size - offset > BM
                rows1 = T.max(0, T.min(BM, size - offset - BM))
                if active:
                    # Gate pass: one weight tile feeds both token blocks.
                    T.clear(acc0)
                    T.clear(acc1)
                    for k in T.Pipelined(T.ceildiv(hidden, BK), num_stages=0):
                        T.copy(gate_w[expert, by * BN:(by + 1) * BN,
                                      k * BK:(k + 1) * BK], w_s)
                        T.copy(tokens[row0:row0 + BM, k * BK:(k + 1) * BK], a_s)
                        T.gemm(a_s, w_s, acc0, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                        T.copy(tokens[row0 + BM:row0 + 2 * BM,
                                      k * BK:(k + 1) * BK], a_s)
                        T.gemm(a_s, w_s, acc1, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                    for i, j in T.Parallel(BM, BN):
                        acc0[i, j] = acc0[i, j] * (
                            1.0 / (1.0 + T.exp2(-acc0[i, j] * scale)))
                        acc1[i, j] = acc1[i, j] * (
                            1.0 / (1.0 + T.exp2(-acc1[i, j] * scale)))
                        if i < rows0:
                            dst[row0 + i, by * BN + j] = acc0[i, j]
                        if i < rows1:
                            dst[row0 + BM + i, by * BN + j] = acc1[i, j]

                    # Up pass reuses the accumulator registers.  The rounded gate
                    # value in dst is the only extra traffic versus the baseline.
                    T.clear(acc0)
                    T.clear(acc1)
                    for k in T.Pipelined(T.ceildiv(hidden, BK), num_stages=0):
                        T.copy(up_w[expert, by * BN:(by + 1) * BN,
                                    k * BK:(k + 1) * BK], w_s)
                        T.copy(tokens[row0:row0 + BM, k * BK:(k + 1) * BK], a_s)
                        T.gemm(a_s, w_s, acc0, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                        T.copy(tokens[row0 + BM:row0 + 2 * BM,
                                      k * BK:(k + 1) * BK], a_s)
                        T.gemm(a_s, w_s, acc1, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                    for i, j in T.Parallel(BM, BN):
                        if i < rows0:
                            dst[row0 + i, by * BN + j] = T.cast(
                                acc0[i, j] * dst[row0 + i, by * BN + j], dtype)
                        if i < rows1:
                            dst[row0 + BM + i, by * BN + j] = T.cast(
                                acc1[i, j] * dst[row0 + BM + i, by * BN + j], dtype)
            else:
                if size > BM and rows0 > 0:
                    T.clear(acc0)
                    T.clear(acc1)
                    for k in T.Pipelined(T.ceildiv(hidden, BK), num_stages=0):
                        T.copy(tokens[row0:row0 + BM, k * BK:(k + 1) * BK], a_s)
                        T.copy(gate_w[expert, by * BN:(by + 1) * BN,
                                      k * BK:(k + 1) * BK], w_s)
                        T.gemm(a_s, w_s, acc0, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                        T.copy(up_w[expert, by * BN:(by + 1) * BN,
                                    k * BK:(k + 1) * BK], w_s)
                        T.gemm(a_s, w_s, acc1, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                    for i, j in T.Parallel(BM, BN):
                        acc0[i, j] = acc0[i, j] * (
                            1.0 / (1.0 + T.exp2(-acc0[i, j] * scale)))
                        if i < rows0:
                            dst[row0 + i, by * BN + j] = T.cast(
                                acc0[i, j] * acc1[i, j], dtype)

    return kernel


def pair_error(got, ref, meta):
    worst = 0.0
    bad = 0
    total = 0
    for expert, count in enumerate(meta["counts"]):
        if count <= BM:
            continue
        p0 = meta["pad_off"][expert]
        g = got[p0:p0 + count].float()
        r = ref[p0:p0 + count].float()
        d = (g - r).abs()
        bad += int((d > 0.05 + 0.05 * r.abs()).sum().item())
        total += d.numel()
        worst = max(worst, float(d.max().item()))
    return worst, bad, total


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--case", default="oj3real")
    p.add_argument("--iters", type=int, default=30)
    p.add_argument("--warmup", type=int, default=8)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()
    case = load_cases(a.configs, [a.case])[0]
    args, meta = build_case(case, torch.device("cuda"))
    ref = tm.ref_stage1(args, meta)
    shape = (case.dhidden, case.dexpert, case.nroutedexperts,
             case.n_padded, case.n_valid, case.num_blocks_m)
    print(f"{a.case}: H={case.dhidden} I={case.dexpert} blocks={case.num_blocks_m}")
    for name, paired in (("baseline-pairs", False), ("shared-weight", True)):
        dst = torch.zeros((case.n_padded, case.dexpert), device="cuda", dtype=torch.float16)
        kernel = build(*shape, paired)
        call = lambda: kernel(args["stacked_expert_tokens"], args["gate_w"], args["up_w"],
                              args["group_sizes"], args["group_padded_offsets"],
                              args["group_idx_for_bx"], dst)
        call()
        torch.cuda.synchronize()
        worst, bad, total = pair_error(dst, ref, meta)
        ms = time_fn(call, a.warmup, a.iters)
        print(f"{name:<18} {ms:7.3f} ms  max_abs={worst:.3e} bad={bad}/{total}")


if __name__ == "__main__":
    main()
