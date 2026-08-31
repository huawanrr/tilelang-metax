#!/usr/bin/env python3
"""Sweep expert-scoped M tiles for the graded Config1 layout."""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

from local_bench import build_case, load_cases, time_fn
import tune_moe as tm


PASS = {
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_SAFE_MEMORY_ACCESS: True,
}


def build_stage1(shape, bm, max_tiles, threads, panel, policy_name, compact):
    hidden, intermediate, experts, padded, valid, blocks = shape
    bn, bk = 128, 64
    dtype, accum = T.float16, T.float32
    scale = 1.44269504
    policy = {
        "square": T.GemmWarpPolicy.Square,
        "row": T.GemmWarpPolicy.FullRow,
        "col": T.GemmWarpPolicy.FullCol,
    }[policy_name]

    @T.prim_func
    def kernel(
        tokens: T.Tensor((padded, hidden), dtype),
        gate_w: T.Tensor((experts, intermediate, hidden), dtype),
        up_w: T.Tensor((experts, intermediate, hidden), dtype),
        group_sizes: T.Tensor((experts,), T.int32),
        group_padded_offsets: T.Tensor((experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((blocks,), T.int32),
        dst: T.Tensor((padded, intermediate), dtype),
    ):
        grid_m = blocks if compact else experts * max_tiles
        with T.Kernel(grid_m, T.ceildiv(intermediate, bn),
                      threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype)
            w_s = T.alloc_shared((bn, bk), dtype)
            gate_l = T.alloc_fragment((bm, bn), accum)
            up_l = T.alloc_fragment((bm, bn), accum)
            T.use_swizzle(panel)

            if compact:
                expert = T.min(T.max(group_idx_for_bx[bx], 0), experts - 1)
                tile = bx - group_padded_offsets[expert] // 128
            else:
                expert = bx // max_tiles
                tile = bx % max_tiles
            row0 = group_padded_offsets[expert] + tile * bm
            rows = T.max(0, T.min(bm, group_sizes[expert] - tile * bm))
            if rows > 0:
                T.clear(gate_l)
                T.clear(up_l)
                for k in T.Pipelined(T.ceildiv(hidden, bk), num_stages=0):
                    T.copy(tokens[row0 : row0 + bm,
                                  k * bk : (k + 1) * bk], a_s)
                    T.copy(gate_w[expert, by * bn : (by + 1) * bn,
                                  k * bk : (k + 1) * bk], w_s)
                    T.gemm(a_s, w_s, gate_l, transpose_B=True,
                           policy=policy)
                    T.copy(up_w[expert, by * bn : (by + 1) * bn,
                                k * bk : (k + 1) * bk], w_s)
                    T.gemm(a_s, w_s, up_l, transpose_B=True,
                           policy=policy)
                for i, j in T.Parallel(bm, bn):
                    if i < rows:
                        dst[row0 + i, by * bn + j] = (
                            up_l[i, j]
                            * gate_l[i, j]
                            * (1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
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
    os.environ["TILELANG_CACHE_DIR"] = os.path.expanduser(
        "~/.tilelang/cache_config1_m")
    case = load_cases(args_cli.configs, [args_cli.case])[0]
    args, meta = build_case(case, torch.device("cuda"))
    ref = tm.ref_stage1(args, meta)
    shape = (case.dhidden, case.dexpert, case.nroutedexperts,
             case.n_padded, case.n_valid, case.num_blocks_m)
    max_count = max(meta["counts"])
    print(f"case={case.name} counts={meta['counts']} max={max_count}")
    print(f"{'variant':<18}{'ms':>9}{'err':>12}{'active':>10}{'rows':>10}")
    variants = [
        (128, 256, "square", False),
        (128, 256, "square", True),
        (112, 256, "col", False),
        (112, 256, "col", True),
    ]
    for bm, threads, policy_name, compact in variants:
        max_tiles = (max_count + bm - 1) // bm
        active = sum((c + bm - 1) // bm for c in meta["counts"])
        computed = sum((c + bm - 1) // bm * bm for c in meta["counts"])
        name = f"m{bm}-t{threads}-{policy_name}-{'compact' if compact else 'expert'}"
        try:
            kernel = tilelang.compile(
                build_stage1(shape, bm, max_tiles, threads, 64, policy_name, compact),
                out_idx=None, pass_configs=PASS)
            dst = torch.zeros((case.n_padded, case.dexpert), device="cuda",
                              dtype=torch.float16)
            call = lambda: kernel(
                args["stacked_expert_tokens"], args["gate_w"], args["up_w"],
                args["group_sizes"], args["group_padded_offsets"],
                args["group_idx_for_bx"], dst)
            call()
            torch.cuda.synchronize()
            err = tm.max_err_valid(dst, ref, meta)
            elapsed = time_fn(call, args_cli.warmup, args_cli.iters)
            print(f"{name:<18}{elapsed:9.3f}{err:12.3e}{active:10d}{computed:10d}")
        except Exception as exc:
            print(f"{name:<18}{'-':>9}{'-':>12}{active:10d}{computed:10d}  "
                  f"{type(exc).__name__}: {str(exc).splitlines()[0][:100]}")


if __name__ == "__main__":
    main()
