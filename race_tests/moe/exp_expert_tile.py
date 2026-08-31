#!/usr/bin/env python3
"""Expert-scoped M=192/M=64 MoE probe for arbitrary padded ordering."""

import argparse
import random

import torch
import tilelang
import tilelang.language as T

import moe
from local_bench import (
    ARG_ORDER,
    Case,
    SENTINEL,
    build_case,
    check_reference,
    check_untouched,
    time_fn,
)


PASS = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}


@tilelang.jit(pass_configs=PASS)
def build_expert_moe(hidden, intermediate, experts, padded, valid, block_m, threads):
    dtype = T.float16
    accum = T.float32
    block_n = 128
    block_k = 64
    tail_m = 256 - block_m
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
        group_padded_offsets: T.Tensor((experts + 1,), T.int32),
        up_logits: T.Tensor((padded, intermediate), dtype),
        out: T.Tensor((padded, hidden), dtype),
    ):
        with T.Kernel(
            experts, T.ceildiv(intermediate, block_n), threads=threads
        ) as (bx, by):
            a_s = T.alloc_shared((block_m, block_k), dtype)
            w_s = T.alloc_shared((block_n, block_k), dtype)
            gate_l = T.alloc_fragment((block_m, block_n), accum)
            up_l = T.alloc_fragment((block_m, block_n), accum)
            T.use_swizzle(8)
            row0 = group_padded_offsets[bx]
            rows = T.min(block_m, group_sizes[bx])
            T.clear(gate_l)
            T.clear(up_l)
            for k in T.Pipelined(T.ceildiv(hidden, block_k), num_stages=0):
                T.copy(tokens[row0 : row0 + block_m,
                              k * block_k : (k + 1) * block_k], a_s)
                T.copy(gate_w[bx, by * block_n : (by + 1) * block_n,
                              k * block_k : (k + 1) * block_k], w_s)
                T.gemm(a_s, w_s, gate_l, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
                T.copy(up_w[bx, by * block_n : (by + 1) * block_n,
                            k * block_k : (k + 1) * block_k], w_s)
                T.gemm(a_s, w_s, up_l, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
            for i, j in T.Parallel(block_m, block_n):
                gate_l[i, j] = gate_l[i, j] * (
                    1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                if i < rows:
                    up_logits[row0 + i, by * block_n + j] = T.cast(
                        up_l[i, j] * gate_l[i, j], dtype)

        if tail_m > 0:
            with T.Kernel(
                experts, T.ceildiv(intermediate, block_n), threads=512
            ) as (bx, by):
                a_s = T.alloc_shared((tail_m, block_k), dtype)
                w_s = T.alloc_shared((block_n, block_k), dtype)
                gate_l = T.alloc_fragment((tail_m, block_n), accum)
                up_l = T.alloc_fragment((tail_m, block_n), accum)
                T.use_swizzle(8)
                row0 = group_padded_offsets[bx] + block_m
                rows = T.min(tail_m, T.max(0, group_sizes[bx] - block_m))
                if rows > 0:
                    T.clear(gate_l)
                    T.clear(up_l)
                    for k in T.Pipelined(T.ceildiv(hidden, block_k), num_stages=0):
                        T.copy(tokens[row0 : row0 + tail_m,
                                      k * block_k : (k + 1) * block_k], a_s)
                        T.copy(gate_w[bx, by * block_n : (by + 1) * block_n,
                                      k * block_k : (k + 1) * block_k], w_s)
                        T.gemm(a_s, w_s, gate_l, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                        T.copy(up_w[bx, by * block_n : (by + 1) * block_n,
                                    k * block_k : (k + 1) * block_k], w_s)
                        T.gemm(a_s, w_s, up_l, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                    for i, j in T.Parallel(tail_m, block_n):
                        gate_l[i, j] = gate_l[i, j] * (
                            1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                        if i < rows:
                            up_logits[row0 + i, by * block_n + j] = T.cast(
                                up_l[i, j] * gate_l[i, j], dtype)

        with T.Kernel(
            experts, T.ceildiv(hidden, block_n * 2), threads=threads
        ) as (bx, by):
            a_s = T.alloc_shared((block_m, block_k), dtype)
            w_s = T.alloc_shared((block_n, block_k), dtype)
            out_l0 = T.alloc_fragment((block_m, block_n), accum)
            out_l1 = T.alloc_fragment((block_m, block_n), accum)
            route_l = T.alloc_fragment((block_m,), T.float32)
            T.use_swizzle(T.ceildiv(hidden, block_n * 2))
            row0 = group_padded_offsets[bx]
            raw0 = group_offsets[bx]
            rows = T.min(block_m, group_sizes[bx])
            T.clear(out_l0)
            T.clear(out_l1)
            for k in T.Pipelined(T.ceildiv(intermediate, block_k), num_stages=0):
                T.copy(up_logits[row0 : row0 + block_m,
                                 k * block_k : (k + 1) * block_k], a_s)
                T.copy(down_w[bx, (by * 2) * block_n : (by * 2 + 1) * block_n,
                              k * block_k : (k + 1) * block_k], w_s)
                T.gemm(a_s, w_s, out_l0, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
                T.copy(down_w[bx, (by * 2 + 1) * block_n : (by * 2 + 2) * block_n,
                              k * block_k : (k + 1) * block_k], w_s)
                T.gemm(a_s, w_s, out_l1, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
            for i in T.Parallel(block_m):
                route_l[i] = T.if_then_else(
                    i < rows, routed_w[raw0 + i], T.cast(0, T.float32))
            for i, j in T.Parallel(block_m, block_n):
                if i < rows:
                    out[row0 + i, (by * 2) * block_n + j] = T.cast(
                        out_l0[i, j] * route_l[i], dtype)
                    out[row0 + i, (by * 2 + 1) * block_n + j] = T.cast(
                        out_l1[i, j] * route_l[i], dtype)

        if tail_m > 0:
            with T.Kernel(
                experts, T.ceildiv(hidden, block_n * 2), threads=512
            ) as (bx, by):
                a_s = T.alloc_shared((tail_m, block_k), dtype)
                w_s = T.alloc_shared((block_n, block_k), dtype)
                out_l0 = T.alloc_fragment((tail_m, block_n), accum)
                out_l1 = T.alloc_fragment((tail_m, block_n), accum)
                route_l = T.alloc_fragment((tail_m,), T.float32)
                T.use_swizzle(T.ceildiv(hidden, block_n * 2))
                row0 = group_padded_offsets[bx] + block_m
                raw0 = group_offsets[bx] + block_m
                rows = T.min(tail_m, T.max(0, group_sizes[bx] - block_m))
                if rows > 0:
                    T.clear(out_l0)
                    T.clear(out_l1)
                    for k in T.Pipelined(T.ceildiv(intermediate, block_k), num_stages=0):
                        T.copy(up_logits[row0 : row0 + tail_m,
                                         k * block_k : (k + 1) * block_k], a_s)
                        T.copy(down_w[bx, (by * 2) * block_n : (by * 2 + 1) * block_n,
                                      k * block_k : (k + 1) * block_k], w_s)
                        T.gemm(a_s, w_s, out_l0, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                        T.copy(down_w[bx, (by * 2 + 1) * block_n : (by * 2 + 2) * block_n,
                                      k * block_k : (k + 1) * block_k], w_s)
                        T.gemm(a_s, w_s, out_l1, transpose_B=True,
                               policy=T.GemmWarpPolicy.Square)
                    for i in T.Parallel(tail_m):
                        route_l[i] = T.if_then_else(
                            i < rows, routed_w[raw0 + i], T.cast(0, T.float32))
                    for i, j in T.Parallel(tail_m, block_n):
                        if i < rows:
                            out[row0 + i, (by * 2) * block_n + j] = T.cast(
                                out_l0[i, j] * route_l[i], dtype)
                            out[row0 + i, (by * 2 + 1) * block_n + j] = T.cast(
                                out_l1[i, j] * route_l[i], dtype)

    return kernel


def counts_for(name):
    if name == "balanced":
        values = [114] * 32 + [170] * 32
    elif name == "edge":
        values = [127] * 32 + [157] * 32
    elif name == "skew":
        values = [92] * 32 + [192] * 32
    elif name == "old":
        values = [64] * 32 + [220] * 32
    else:
        raise ValueError(name)
    random.Random(9182).shuffle(values)
    return tuple(values)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--layout", default="balanced", choices=("balanced", "edge", "skew", "old"))
    parser.add_argument("--block-m", type=int, default=192)
    parser.add_argument("--threads", type=int, default=768)
    parser.add_argument("--warmup", type=int, default=8)
    parser.add_argument("--iters", type=int, default=30)
    args_cli = parser.parse_args()
    counts = counts_for(args_cli.layout)
    case = Case(
        name=args_cli.layout,
        dhidden=7168,
        dexpert=2048,
        nroutedexperts=64,
        nexpertspertoken=2,
        bs=1,
        seqlen=4544,
        counts=counts,
    )
    args, meta = build_case(case, torch.device("cuda"))
    out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
    up_logits = torch.empty((case.n_padded, case.dexpert), device="cuda", dtype=torch.float16)
    moe._k_pack_on()
    kernel = build_expert_moe(
        case.dhidden,
        case.dexpert,
        case.nroutedexperts,
        case.n_padded,
        case.n_valid,
        args_cli.block_m,
        args_cli.threads,
    )

    def call():
        kernel(
            args["stacked_expert_tokens"],
            args["gate_w"],
            args["up_w"],
            args["down_w"],
            args["routed_expert_weights"],
            args["group_sizes"],
            args["group_offsets"],
            args["group_padded_offsets"],
            up_logits,
            out,
        )

    call()
    torch.cuda.synchronize()
    stats = check_reference(out, args, meta, atol=0.05, rtol=0.05)
    padding = check_untouched(out, meta)
    elapsed = time_fn(call, args_cli.warmup, args_cli.iters)
    print(
        f"layout={args_cli.layout} M={args_cli.block_m} threads={args_cli.threads} "
        f"time={elapsed:.3f} ms correct={stats['ok']} max_abs={stats['max_abs']:.3e} "
        f"bad={stats['bad']}/{stats['total']} padding={padding['ok']}"
    )


if __name__ == "__main__":
    main()
