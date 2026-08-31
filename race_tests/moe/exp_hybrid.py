#!/usr/bin/env python3
"""Hybrid probe: vendor BMM for 256-row experts, TileLang for 64-row experts."""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

import moe
from local_bench import (SENTINEL, build_case, check_reference, check_untouched,
                         load_cases, time_fn)


PASS = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}


@tilelang.jit(pass_configs=PASS)
def build_hybrid(hidden, intermediate, experts, padded, valid, pairs, reverse):
    dtype, accum = T.float16, T.float32
    bm, bn, bk, threads = 64, 128, 64, 512
    scale = 1.44269504

    @T.prim_func
    def kernel(
        tokens: T.Tensor((padded, hidden), dtype),
        gate_w: T.Tensor((experts, intermediate, hidden), dtype),
        up_w: T.Tensor((experts, intermediate, hidden), dtype),
        down_w: T.Tensor((experts, hidden, intermediate), dtype),
        routed_w: T.Tensor((valid,), T.float32),
        group_sizes: T.Tensor((experts,), T.int32),
        group_offsets: T.Tensor((experts + 1,), T.int32),
        big_result: T.Tensor((pairs, 256, hidden), dtype),
        up_logits: T.Tensor((padded, intermediate), dtype),
        out: T.Tensor((pairs, 384, hidden), dtype),
    ):
        with T.Kernel(pairs, T.ceildiv(intermediate, bn), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype)
            w_s = T.alloc_shared((bn, bk), dtype)
            gate_l = T.alloc_fragment((bm, bn), accum)
            up_l = T.alloc_fragment((bm, bn), accum)
            T.use_swizzle(8)

            expert = bx * 2 + (1 if reverse else 0)
            block_start = bx * 384 + (256 if reverse else 0)
            rows = group_sizes[expert]
            T.clear(gate_l)
            T.clear(up_l)
            for k in T.Pipelined(T.ceildiv(hidden, bk), num_stages=0):
                T.copy(tokens[block_start:block_start + bm,
                              k * bk:(k + 1) * bk], a_s)
                T.copy(gate_w[expert, by * bn:(by + 1) * bn,
                              k * bk:(k + 1) * bk], w_s)
                T.gemm(a_s, w_s, gate_l, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
                T.copy(up_w[expert, by * bn:(by + 1) * bn,
                            k * bk:(k + 1) * bk], w_s)
                T.gemm(a_s, w_s, up_l, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
            for i, j in T.Parallel(bm, bn):
                gate_l[i, j] = gate_l[i, j] * (
                    1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                if i < rows:
                    up_logits[block_start + i, by * bn + j] = T.cast(
                        up_l[i, j] * gate_l[i, j], dtype)

        with T.Kernel(pairs, T.ceildiv(hidden, bn * 2), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype)
            w_s = T.alloc_shared((bn, bk), dtype)
            out_l0 = T.alloc_fragment((bm, bn), accum)
            out_l1 = T.alloc_fragment((bm, bn), accum)
            route_l = T.alloc_fragment((bm,), T.float32)
            T.use_swizzle(T.ceildiv(hidden, bn * 2))

            expert = bx * 2 + (1 if reverse else 0)
            block_start = bx * 384 + (256 if reverse else 0)
            rows = group_sizes[expert]
            raw_start = group_offsets[expert]
            T.clear(out_l0)
            T.clear(out_l1)
            for k in T.Pipelined(T.ceildiv(intermediate, bk), num_stages=0):
                T.copy(up_logits[block_start:block_start + bm,
                                 k * bk:(k + 1) * bk], a_s)
                T.copy(down_w[expert, (by * 2) * bn:(by * 2 + 1) * bn,
                              k * bk:(k + 1) * bk], w_s)
                T.gemm(a_s, w_s, out_l0, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
                T.copy(down_w[expert, (by * 2 + 1) * bn:(by * 2 + 2) * bn,
                              k * bk:(k + 1) * bk], w_s)
                T.gemm(a_s, w_s, out_l1, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
            for i in T.Parallel(bm):
                route_l[i] = T.if_then_else(
                    i < rows, routed_w[raw_start + i], T.cast(0, T.float32))
            padded_start = 256 if reverse else 0
            for i, j in T.Parallel(bm, bn):
                if i < rows:
                    out[bx, padded_start + i, (by * 2) * bn + j] = T.cast(
                        out_l0[i, j] * route_l[i], dtype)
            for i, j in T.Parallel(bm, bn):
                if i < rows:
                    out[bx, padded_start + i, (by * 2 + 1) * bn + j] = T.cast(
                        out_l1[i, j] * route_l[i], dtype)

        with T.Kernel(pairs, T.ceildiv(hidden, 256), threads=256) as (bx, by):
            expert = bx * 2 + (0 if reverse else 1)
            rows = group_sizes[expert]
            raw_start = group_offsets[expert]
            padded_start = 0 if reverse else 128
            for i, j in T.Parallel(256, 256):
                if i < rows:
                    out[bx, padded_start + i, by * 256 + j] = T.cast(
                        big_result[bx, i, by * 256 + j]
                        * routed_w[raw_start + i], dtype)
    return kernel


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--case", default="oj3real")
    p.add_argument("--iters", type=int, default=50)
    p.add_argument("--warmup", type=int, default=12)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()

    moe._k_pack_on()
    case = load_cases(a.configs, [a.case])[0]
    args, meta = build_case(case, torch.device("cuda"))
    counts = meta["counts"]
    normal = all(counts[i] <= 64 and 128 <= counts[i + 1] <= 255
                 for i in range(0, len(counts), 2))
    reverse = all(128 <= counts[i] <= 255 and counts[i + 1] <= 64
                  for i in range(0, len(counts), 2))
    if not normal and not reverse:
        raise SystemExit("routing is not alternating <=64 / 128..255")

    pairs = len(counts) // 2
    h, i = case.dhidden, case.dexpert
    pair_tokens = args["stacked_expert_tokens"].view(pairs, 384, h)
    big_x = pair_tokens[:, :256] if reverse else pair_tokens[:, 128:384]
    big_weights = slice(0, None, 2) if reverse else slice(1, None, 2)
    out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
    out_pair = out.view(pairs, 384, h)
    up_logits = torch.empty((case.n_padded, i), device="cuda", dtype=torch.float16)
    kernel = build_hybrid(h, i, case.nroutedexperts, case.n_padded,
                          case.n_valid, pairs, reverse)

    def big_project():
        gate = torch.bmm(big_x, args["gate_w"][big_weights].transpose(1, 2))
        up = torch.bmm(big_x, args["up_w"][big_weights].transpose(1, 2))
        hidden = gate * torch.sigmoid(gate) * up
        return torch.bmm(hidden, args["down_w"][big_weights].transpose(1, 2))

    def hybrid():
        big = big_project()
        kernel(args["stacked_expert_tokens"], args["gate_w"], args["up_w"],
               args["down_w"], args["routed_expert_weights"], args["group_sizes"],
               args["group_offsets"], big, up_logits, out_pair)

    hybrid()
    torch.cuda.synchronize()
    stats = check_reference(out, args, meta, atol=0.05, rtol=0.05)
    padding = check_untouched(out, meta)
    big_ms = time_fn(big_project, a.warmup, a.iters)
    fixed = big_project()
    tl_ms = time_fn(
        lambda: kernel(args["stacked_expert_tokens"], args["gate_w"], args["up_w"],
                       args["down_w"], args["routed_expert_weights"],
                       args["group_sizes"], args["group_offsets"], fixed,
                       up_logits, out_pair), a.warmup, a.iters)
    total_ms = time_fn(hybrid, a.warmup, a.iters)
    print(f"correctness={'PASS' if stats['ok'] else 'FAIL'} "
          f"max_abs={stats['max_abs']:.3e} bad={stats['bad']}/{stats['total']} "
          f"padding={'clean' if padding['ok'] else 'TOUCHED'}")
    print(f"big_bmm={big_ms:.3f} ms small_TL+scatter={tl_ms:.3f} ms "
          f"total={total_ms:.3f} ms")


if __name__ == "__main__":
    main()
