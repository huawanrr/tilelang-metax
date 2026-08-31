#!/usr/bin/env python3
"""Config1 stage-1 probe: share one A tile across adjacent N tiles."""
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
}


def build(cfg, shape):
    hidden, intermediate, experts, padded, valid, blocks = shape
    bm, bn, bk = 128, 128, 64
    pair = cfg["pair"]
    threads = cfg["threads"]
    panel = cfg["panel"]
    approx = cfg["approx"]
    policy = {
        "square": T.GemmWarpPolicy.Square,
        "row": T.GemmWarpPolicy.FullRow,
        "col": T.GemmWarpPolicy.FullCol,
    }[cfg["policy"]]
    dtype, accum = T.float16, T.float32
    scale = 1.44269504

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
        with T.Kernel(blocks, T.ceildiv(intermediate, bn * pair),
                      threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype)
            w_s = T.alloc_shared((bn, bk), dtype)
            gate0 = T.alloc_fragment((bm, bn), accum)
            up0 = T.alloc_fragment((bm, bn), accum)
            if pair == 2:
                gate1 = T.alloc_fragment((bm, bn), accum)
                up1 = T.alloc_fragment((bm, bn), accum)
            else:
                gate1 = gate0
                up1 = up0

            T.use_swizzle(panel)
            expert = T.min(T.max(group_idx_for_bx[bx], 0), experts - 1)
            row0 = bx * bm
            rows = T.max(
                0,
                T.min(
                    bm,
                    group_sizes[expert]
                    - (row0 - group_padded_offsets[expert]),
                ),
            )

            if rows > 0:
                T.clear(gate0)
                T.clear(up0)
                if pair == 2:
                    T.clear(gate1)
                    T.clear(up1)
                for k in T.unroll(
                    T.ceildiv(hidden, bk),
                    explicit=False,
                    unroll_factor=cfg["unroll_factor"],
                ):
                    T.copy(
                        tokens[row0 : row0 + bm, k * bk : (k + 1) * bk],
                        a_s,
                    )
                    T.copy(
                        gate_w[
                            expert,
                            (by * pair) * bn : (by * pair + 1) * bn,
                            k * bk : (k + 1) * bk,
                        ],
                        w_s,
                    )
                    T.gemm(a_s, w_s, gate0, transpose_B=True, policy=policy)
                    T.copy(
                        up_w[
                            expert,
                            (by * pair) * bn : (by * pair + 1) * bn,
                            k * bk : (k + 1) * bk,
                        ],
                        w_s,
                    )
                    T.gemm(a_s, w_s, up0, transpose_B=True, policy=policy)
                    if pair == 2:
                        T.copy(
                            gate_w[
                                expert,
                                (by * pair + 1) * bn : (by * pair + 2) * bn,
                                k * bk : (k + 1) * bk,
                            ],
                            w_s,
                        )
                        T.gemm(a_s, w_s, gate1, transpose_B=True, policy=policy)
                        T.copy(
                            up_w[
                                expert,
                                (by * pair + 1) * bn : (by * pair + 2) * bn,
                                k * bk : (k + 1) * bk,
                            ],
                            w_s,
                        )
                        T.gemm(a_s, w_s, up1, transpose_B=True, policy=policy)

                for i, j in T.Parallel(bm, bn):
                    if i < rows:
                        x = gate0[i, j]
                        if approx == 3:
                            x2 = x * x
                            sigmoid = 0.5 + x * (
                                0.2166062211 - 0.006604184463 * x2
                            )
                        elif approx == 5:
                            x2 = x * x
                            sigmoid = 0.5 + x * (
                                0.2395370049
                                + x2 * (-0.01329166109 + 0.0003761329529 * x2)
                            )
                        elif approx == 7:
                            x2 = x * x
                            sigmoid = 0.5 + x * (
                                0.2469143921
                                + x2 * (
                                    -0.01744102664
                                    + x2 * (0.0009466136882 - 0.00002206996505 * x2)
                                )
                            )
                        else:
                            sigmoid = 1.0 / (1.0 + T.exp2(-x * scale))
                        dst[row0 + i, (by * pair) * bn + j] = up0[i, j] * x * sigmoid
                if pair == 2:
                    for i, j in T.Parallel(bm, bn):
                        if i < rows:
                            dst[row0 + i, (by * pair + 1) * bn + j] = (
                                up1[i, j]
                                * gate1[i, j]
                                * (1.0 / (1.0 + T.exp2(-gate1[i, j] * scale)))
                            )

    return kernel


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--case", default="oj1real")
    parser.add_argument("--iters", type=int, default=30)
    parser.add_argument("--warmup", type=int, default=8)
    parser.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    args_cli = parser.parse_args()
    os.environ["TILELANG_CACHE_DIR"] = os.path.expanduser(
        "~/.tilelang/cache_stage1_npair")

    case = load_cases(args_cli.configs, [args_cli.case])[0]
    args, meta = build_case(case, torch.device("cuda"))
    ref = tm.ref_stage1(args, meta)
    shape = (case.dhidden, case.dexpert, case.nroutedexperts,
             case.n_padded, case.n_valid, case.num_blocks_m)
    variants = (
        ("unroll1", {"pair": 1, "threads": 256, "panel": 64,
                     "policy": "square", "approx": 0, "unroll_factor": 1}),
        ("unroll2", {"pair": 1, "threads": 256, "panel": 64,
                     "policy": "square", "approx": 0, "unroll_factor": 2}),
        ("unroll4", {"pair": 1, "threads": 256, "panel": 64,
                     "policy": "square", "approx": 0, "unroll_factor": 4}),
        ("unroll8", {"pair": 1, "threads": 256, "panel": 64,
                     "policy": "square", "approx": 0, "unroll_factor": 8}),
    )
    print(f"case={case.name} valid={case.n_valid} padded={case.n_padded} "
          f"H={case.dhidden} I={case.dexpert}")
    for name, cfg in variants:
        try:
            kernel = tilelang.compile(build(cfg, shape), out_idx=None,
                                      pass_configs=PASS)
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
            print(f"{name:<16} {elapsed:7.3f} ms  err={err:.3e} "
                  f"{'OK' if err < 5e-3 else 'MISMATCH'}")
        except Exception as exc:
            print(f"{name:<16} build/run failed: {type(exc).__name__}: {exc}")


if __name__ == "__main__":
    main()
