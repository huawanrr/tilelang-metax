#!/usr/bin/env python3
"""Exact Config3 hybrid: TileLang for one-block experts, @ for two-block experts."""

import os

import torch
import tilelang
import tilelang.language as T

import moe
from local_bench import (
    SENTINEL,
    build_case,
    check_reference,
    check_untouched,
    load_cases,
    time_fn,
)


@tilelang.jit(
    pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}
)
def build_hybrid(hidden, intermediate, experts, padded, valid, cycles,
                 stage1_swizzle, stage2_swizzle):
    dtype = T.float16
    accum = T.float32
    block_m = 128
    block_n = 128
    block_k = 64
    threads = 512
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
        r2: T.Tensor((cycles, 176, hidden), dtype),
        r4: T.Tensor((cycles, 208, hidden), dtype),
        r6: T.Tensor((cycles, 176, hidden), dtype),
        r7: T.Tensor((cycles, 176, hidden), dtype),
        up_logits: T.Tensor((padded, intermediate), dtype),
        out: T.Tensor((padded, hidden), dtype),
    ):
        with T.Kernel(
            cycles * 4, T.ceildiv(intermediate, block_n), threads=threads
        ) as (bx, by):
            a_s = T.alloc_shared((block_m, block_k), dtype)
            w_s = T.alloc_shared((block_n, block_k), dtype)
            gate_l = T.alloc_fragment((block_m, block_n), accum)
            up_l = T.alloc_fragment((block_m, block_n), accum)
            T.use_swizzle(stage1_swizzle)
            cycle = bx // 4
            slot = bx % 4
            expert = cycle * 8 + T.if_then_else(
                slot == 0,
                0,
                T.if_then_else(
                    slot == 1,
                    1,
                    T.if_then_else(slot == 2, 3, 5),
                ),
            )
            row0 = group_padded_offsets[expert]
            rows = group_sizes[expert]
            T.clear(gate_l)
            T.clear(up_l)
            for k in T.Pipelined(T.ceildiv(hidden, block_k), num_stages=0):
                T.copy(tokens[row0 : row0 + block_m,
                              k * block_k : (k + 1) * block_k], a_s)
                T.copy(gate_w[expert, by * block_n : (by + 1) * block_n,
                              k * block_k : (k + 1) * block_k], w_s)
                T.gemm(a_s, w_s, gate_l, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
                T.copy(up_w[expert, by * block_n : (by + 1) * block_n,
                            k * block_k : (k + 1) * block_k], w_s)
                T.gemm(a_s, w_s, up_l, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
            for i, j in T.Parallel(block_m, block_n):
                gate_l[i, j] = gate_l[i, j] * (
                    1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                if i < rows:
                    up_logits[row0 + i, by * block_n + j] = T.cast(
                        up_l[i, j] * gate_l[i, j], dtype)

        with T.Kernel(
            cycles * 4, T.ceildiv(hidden, block_n * 2), threads=threads
        ) as (bx, by):
            a_s = T.alloc_shared((block_m, block_k), dtype)
            w_s = T.alloc_shared((block_n, block_k), dtype)
            out_l0 = T.alloc_fragment((block_m, block_n), accum)
            out_l1 = T.alloc_fragment((block_m, block_n), accum)
            route_l = T.alloc_fragment((block_m,), T.float32)
            T.use_swizzle(stage2_swizzle)
            cycle = bx // 4
            slot = bx % 4
            expert = cycle * 8 + T.if_then_else(
                slot == 0,
                0,
                T.if_then_else(
                    slot == 1,
                    1,
                    T.if_then_else(slot == 2, 3, 5),
                ),
            )
            row0 = group_padded_offsets[expert]
            raw0 = group_offsets[expert]
            rows = group_sizes[expert]
            T.clear(out_l0)
            T.clear(out_l1)
            for k in T.Pipelined(T.ceildiv(intermediate, block_k), num_stages=0):
                T.copy(up_logits[row0 : row0 + block_m,
                                 k * block_k : (k + 1) * block_k], a_s)
                T.copy(down_w[expert, (by * 2) * block_n : (by * 2 + 1) * block_n,
                              k * block_k : (k + 1) * block_k], w_s)
                T.gemm(a_s, w_s, out_l0, transpose_B=True,
                       policy=T.GemmWarpPolicy.Square)
                T.copy(down_w[expert, (by * 2 + 1) * block_n : (by * 2 + 2) * block_n,
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

        with T.Kernel(
            cycles * 4, T.ceildiv(hidden, 256), threads=256
        ) as (bx, by):
            cycle = bx // 4
            slot = bx % 4
            expert = cycle * 8 + T.if_then_else(
                slot == 0,
                2,
                T.if_then_else(
                    slot == 1,
                    4,
                    T.if_then_else(slot == 2, 6, 7),
                ),
            )
            row0 = group_padded_offsets[expert]
            raw0 = group_offsets[expert]
            rows = group_sizes[expert]
            for i, j in T.Parallel(192, 256):
                if i < rows:
                    if slot == 0:
                        out[row0 + i, by * 256 + j] = T.cast(
                            r2[cycle, i, by * 256 + j] * routed_w[raw0 + i], dtype)
                    elif slot == 1:
                        out[row0 + i, by * 256 + j] = T.cast(
                            r4[cycle, i, by * 256 + j] * routed_w[raw0 + i], dtype)
                    elif slot == 2:
                        out[row0 + i, by * 256 + j] = T.cast(
                            r6[cycle, i, by * 256 + j] * routed_w[raw0 + i], dtype)
                    else:
                        out[row0 + i, by * 256 + j] = T.cast(
                            r7[cycle, i, by * 256 + j] * routed_w[raw0 + i], dtype)

    return kernel


def main():
    case = load_cases("local_test_configs.json", ["oj3exact"])[0]
    args, meta = build_case(case, torch.device("cuda"))
    cycles = 8
    hidden = case.dhidden
    tokens = args["stacked_expert_tokens"].view(cycles, 1536, hidden)
    out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
    up_logits = torch.empty((case.n_padded, case.dexpert), device="cuda", dtype=torch.float16)
    moe._k_pack_on()
    stage1_swizzle = int(os.environ.get("S1_SWIZZLE", "8"))
    stage2_swizzle = int(os.environ.get("S2_SWIZZLE", "28"))
    kernel = build_hybrid(
        hidden, case.dexpert, case.nroutedexperts, case.n_padded, case.n_valid,
        cycles, stage1_swizzle, stage2_swizzle)
    rows = {2: 160, 4: 192, 6: 144, 7: 176}
    compute_rows = {2: 176, 4: 208, 6: 176, 7: 176}
    starts = {2: 256, 4: 640, 6: 1024, 7: 1280}

    def project(pos, mode):
        count = compute_rows[pos]
        x = tokens[:, starts[pos] : starts[pos] + count]
        weights = slice(pos, None, 8)
        gate = x @ args["gate_w"][weights].transpose(1, 2)
        up = x @ args["up_w"][weights].transpose(1, 2)
        if mode == "inplace":
            gate *= torch.sigmoid(gate)
            gate *= up
            hidden = gate
        else:
            hidden = gate * torch.sigmoid(gate) * up
        return hidden @ args["down_w"][weights].transpose(1, 2)

    def core(mode):
        results = tuple(project(pos, mode) for pos in (2, 4, 6, 7))
        kernel(
            args["stacked_expert_tokens"],
            args["gate_w"],
            args["up_w"],
            args["down_w"],
            args["routed_expert_weights"],
            args["group_sizes"],
            args["group_offsets"],
            args["group_padded_offsets"],
            *results,
            up_logits,
            out,
        )

    for mode in ("base", "inplace"):
        out.fill_(SENTINEL)
        core(mode)
        torch.cuda.synchronize()
        stats = check_reference(out, args, meta, atol=0.05, rtol=0.05)
        padding = check_untouched(out, meta)
        elapsed = time_fn(lambda: core(mode), 10, 40)
        print(
            f"{mode}: correct={stats['ok']} max_abs={stats['max_abs']:.3e} "
            f"bad={stats['bad']}/{stats['total']} padding={padding['ok']} "
            f"total={elapsed:.3f} ms"
        )
    fixed = tuple(project(pos, "base") for pos in (2, 4, 6, 7))
    tilelang_ms = time_fn(
        lambda: kernel(
            args["stacked_expert_tokens"],
            args["gate_w"],
            args["up_w"],
            args["down_w"],
            args["routed_expert_weights"],
            args["group_sizes"],
            args["group_offsets"],
            args["group_padded_offsets"],
            *fixed,
            up_logits,
            out,
        ),
        10,
        40,
    )
    print(f"swizzle={stage1_swizzle}/{stage2_swizzle} "
          f"TL+scatter={tilelang_ms:.3f} ms")


if __name__ == "__main__":
    main()
