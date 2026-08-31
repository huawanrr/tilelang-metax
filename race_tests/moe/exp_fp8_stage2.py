#!/usr/bin/env python3
"""Config1 stage-2 probe using TileLang's public FP8 GEMM path."""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

from local_bench import build_case, load_cases, time_fn
import tune_moe as tm


PASS = {
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_ENABLE_AGGRESSIVE_SHARED_MEMORY_MERGE: True,
}


def build(shape, fp8, global_fp8, staged, unroll_factor):
    hidden, intermediate, experts, padded, valid, blocks = shape
    bm, bn, bk, threads, pair = 128, 128, 64, 256, 2
    input_dtype = T.float8_e4m3fn if global_fp8 else T.float16
    mma_dtype = T.float8_e4m3fn if fp8 else T.float16

    @T.prim_func
    def kernel(
        up_logits: T.Tensor((padded, intermediate), input_dtype),
        down_w: T.Tensor((experts, hidden, intermediate), T.float16),
        routed_w: T.Tensor((valid,), T.float32),
        group_sizes: T.Tensor((experts,), T.int32),
        group_offsets: T.Tensor((experts + 1,), T.int32),
        group_padded_offsets: T.Tensor((experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((blocks,), T.int32),
        out: T.Tensor((padded, hidden), T.float16),
    ):
        with T.Kernel(blocks, T.ceildiv(hidden, bn * pair),
                      threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), mma_dtype)
            w_s = T.alloc_shared((bn, bk), mma_dtype)
            out0 = T.alloc_fragment((bm, bn), T.float32)
            out1 = T.alloc_fragment((bm, bn), T.float32)
            route = T.alloc_fragment((bm,), T.float16)
            if staged:
                out_s = T.alloc_shared((bm, bn), T.float16)
            T.use_swizzle(8)

            expert = T.min(T.max(group_idx_for_bx[bx], 0), experts - 1)
            row0 = bx * bm
            padded0 = group_padded_offsets[expert]
            offset = row0 - padded0
            rows = T.max(0, T.min(bm, group_sizes[expert] - offset))
            raw0 = group_offsets[expert] + offset
            if rows > 0:
                T.clear(out0)
                T.clear(out1)
                for k in T.unroll(
                    T.ceildiv(intermediate, bk),
                    explicit=False,
                    unroll_factor=unroll_factor,
                ):
                    T.copy(up_logits[row0 : row0 + bm,
                                     k * bk : (k + 1) * bk], a_s)
                    T.copy(down_w[expert, (by * pair) * bn : (by * pair + 1) * bn,
                                  k * bk : (k + 1) * bk], w_s)
                    T.gemm(a_s, w_s, out0, transpose_B=True,
                           policy=T.GemmWarpPolicy.Square)
                    T.copy(down_w[expert,
                                  (by * pair + 1) * bn : (by * pair + 2) * bn,
                                  k * bk : (k + 1) * bk], w_s)
                    T.gemm(a_s, w_s, out1, transpose_B=True,
                           policy=T.GemmWarpPolicy.Square)
                for i in T.Parallel(bm):
                    if i < rows:
                        route[i] = T.cast(routed_w[raw0 + i], T.float16)
                if staged:
                    for i, j in T.Parallel(bm, bn):
                        out_s[i, j] = T.cast(out0[i, j], T.float16) * route[i]
                    T.sync_threads()
                    for i, j in T.Parallel(bm, bn):
                        if i < rows:
                            out[row0 + i, (by * pair) * bn + j] = out_s[i, j]
                    T.sync_threads()
                    for i, j in T.Parallel(bm, bn):
                        out_s[i, j] = T.cast(out1[i, j], T.float16) * route[i]
                    T.sync_threads()
                    for i, j in T.Parallel(bm, bn):
                        if i < rows:
                            out[row0 + i, (by * pair + 1) * bn + j] = out_s[i, j]
                else:
                    for i, j in T.Parallel(bm, bn):
                        if i < rows:
                            out[row0 + i, (by * pair) * bn + j] = (
                                T.cast(out0[i, j], T.float16) * route[i]
                            )
                            out[row0 + i, (by * pair + 1) * bn + j] = (
                                T.cast(out1[i, j], T.float16) * route[i]
                            )

    return kernel


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--case", default="oj1real")
    parser.add_argument("--iters", type=int, default=60)
    parser.add_argument("--warmup", type=int, default=12)
    parser.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    args_cli = parser.parse_args()
    os.environ["TILELANG_CACHE_DIR"] = os.path.expanduser("~/.tilelang/cache_fp8_stage2")
    case = load_cases(args_cli.configs, [args_cli.case])[0]
    args, meta = build_case(case, torch.device("cuda"))
    up16 = tm.ref_stage1(args, meta)
    up8 = up16.to(torch.float8_e4m3fn)
    ref = tm.ref_stage2(up16, args, meta)
    shape = (case.dhidden, case.dexpert, case.nroutedexperts,
             case.n_padded, case.n_valid, case.num_blocks_m)

    print(f"case={case.name} H={case.dhidden} I={case.dexpert}")
    for name, fp8, global_fp8, staged, unroll_factor in (
        ("fp16-u1", False, False, False, 1),
        ("fp16-u2", False, False, False, 2),
        ("fp16-u4", False, False, False, 4),
        ("fp16-u8", False, False, False, 8),
    ):
        try:
            kernel = tilelang.compile(
                build(shape, fp8, global_fp8, staged, unroll_factor), out_idx=None,
                                      pass_configs=PASS)
            dst = torch.zeros((case.n_padded, case.dhidden), device="cuda",
                              dtype=torch.float16)
            up = up8 if global_fp8 else up16
            call = lambda: kernel(
                up, args["down_w"], args["routed_expert_weights"],
                args["group_sizes"], args["group_offsets"],
                args["group_padded_offsets"], args["group_idx_for_bx"], dst)
            call()
            torch.cuda.synchronize()
            err = tm.max_err_valid(dst, ref, meta)
            elapsed = time_fn(call, args_cli.warmup, args_cli.iters)
            print(f"{name:<16}{elapsed:8.3f} ms  max_abs={err:.3e}")
        except Exception as exc:
            print(f"{name:<16} failed: {type(exc).__name__}: {str(exc).splitlines()[0][:140]}")


if __name__ == "__main__":
    main()
