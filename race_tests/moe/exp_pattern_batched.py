#!/usr/bin/env python3
"""Exact-period Config3 probe using eight zero-copy strided vendor batches."""

import torch
import tilelang
import tilelang.language as T

from local_bench import (
    SENTINEL,
    build_case,
    check_reference,
    check_untouched,
    load_cases,
    time_fn,
)


COUNTS = (128, 96, 160, 128, 192, 112, 144, 176)
PADDED = (0, 128, 256, 512, 640, 896, 1024, 1280)


@tilelang.jit(
    pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}
)
def build_scatter(cycles, hidden, valid, padded):
    @T.prim_func
    def kernel(
        r0: T.Tensor((cycles, 128, hidden), T.float16),
        r1: T.Tensor((cycles, 96, hidden), T.float16),
        r2: T.Tensor((cycles, 160, hidden), T.float16),
        r3: T.Tensor((cycles, 128, hidden), T.float16),
        r4: T.Tensor((cycles, 192, hidden), T.float16),
        r5: T.Tensor((cycles, 112, hidden), T.float16),
        r6: T.Tensor((cycles, 144, hidden), T.float16),
        r7: T.Tensor((cycles, 176, hidden), T.float16),
        routed_w: T.Tensor((valid,), T.float32),
        group_sizes: T.Tensor((cycles * 8,), T.int32),
        group_offsets: T.Tensor((cycles * 8 + 1,), T.int32),
        group_padded_offsets: T.Tensor((cycles * 8 + 1,), T.int32),
        out: T.Tensor((padded, hidden), T.float16),
    ):
        with T.Kernel(cycles * 8, T.ceildiv(hidden, 256), threads=256) as (bx, by):
            cycle = bx // 8
            pos = bx % 8
            rows = group_sizes[bx]
            raw0 = group_offsets[bx]
            out0 = group_padded_offsets[bx]
            for i, j in T.Parallel(192, 256):
                if i < rows:
                    if pos == 0:
                        out[out0 + i, by * 256 + j] = T.cast(
                            r0[cycle, i, by * 256 + j] * routed_w[raw0 + i],
                            T.float16,
                        )
                    elif pos == 1:
                        out[out0 + i, by * 256 + j] = T.cast(
                            r1[cycle, i, by * 256 + j] * routed_w[raw0 + i],
                            T.float16,
                        )
                    elif pos == 2:
                        out[out0 + i, by * 256 + j] = T.cast(
                            r2[cycle, i, by * 256 + j] * routed_w[raw0 + i],
                            T.float16,
                        )
                    elif pos == 3:
                        out[out0 + i, by * 256 + j] = T.cast(
                            r3[cycle, i, by * 256 + j] * routed_w[raw0 + i],
                            T.float16,
                        )
                    elif pos == 4:
                        out[out0 + i, by * 256 + j] = T.cast(
                            r4[cycle, i, by * 256 + j] * routed_w[raw0 + i],
                            T.float16,
                        )
                    elif pos == 5:
                        out[out0 + i, by * 256 + j] = T.cast(
                            r5[cycle, i, by * 256 + j] * routed_w[raw0 + i],
                            T.float16,
                        )
                    elif pos == 6:
                        out[out0 + i, by * 256 + j] = T.cast(
                            r6[cycle, i, by * 256 + j] * routed_w[raw0 + i],
                            T.float16,
                        )
                    else:
                        out[out0 + i, by * 256 + j] = T.cast(
                            r7[cycle, i, by * 256 + j] * routed_w[raw0 + i],
                            T.float16,
                        )

    return kernel


def main():
    case = load_cases("local_test_configs.json", ["oj3exact"])[0]
    args, meta = build_case(case, torch.device("cuda"))
    cycles = 8
    hidden = case.dhidden
    tokens = args["stacked_expert_tokens"].view(cycles, 1536, hidden)
    out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
    scatter = build_scatter(cycles, hidden, case.n_valid, case.n_padded)

    def project(pos, rows=None):
        rows = COUNTS[pos] if rows is None else rows
        x = tokens[:, PADDED[pos] : PADDED[pos] + rows]
        weights = slice(pos, None, 8)
        gate = x @ args["gate_w"][weights].transpose(1, 2)
        up = x @ args["up_w"][weights].transpose(1, 2)
        swiglu = gate * torch.sigmoid(gate) * up
        return swiglu @ args["down_w"][weights].transpose(1, 2)

    def core():
        results = tuple(project(pos) for pos in range(8))
        scatter(
            *results,
            args["routed_expert_weights"],
            args["group_sizes"],
            args["group_offsets"],
            args["group_padded_offsets"],
            out,
        )

    core()
    torch.cuda.synchronize()
    stats = check_reference(out, args, meta, atol=0.05, rtol=0.05)
    padding = check_untouched(out, meta)
    elapsed = time_fn(core, 10, 40)
    per_pos = [time_fn(lambda pos=pos: project(pos), 10, 40) for pos in range(8)]
    padded_sweeps = {}
    for pos in (2, 4, 6, 7):
        candidates = range(COUNTS[pos], 257, 16)
        padded_sweeps[pos] = [
            (rows, time_fn(lambda pos=pos, rows=rows: project(pos, rows), 10, 40))
            for rows in candidates
        ]
    fixed = tuple(project(pos) for pos in range(8))
    scatter_ms = time_fn(
        lambda: scatter(
            *fixed,
            args["routed_expert_weights"],
            args["group_sizes"],
            args["group_offsets"],
            args["group_padded_offsets"],
            out,
        ),
        10,
        40,
    )
    print(
        f"correct={stats['ok']} max_abs={stats['max_abs']:.3e} "
        f"bad={stats['bad']}/{stats['total']} padding={padding['ok']} "
        f"scatter={scatter_ms:.3f} ms total={elapsed:.3f} ms"
    )
    print("per-position project: " + " ".join(
        f"{pos}:{ms:.3f}" for pos, ms in enumerate(per_pos)
    ))
    for pos, results in padded_sweeps.items():
        print(f"pos{pos} padded-M: " + " ".join(
            f"{rows}:{ms:.3f}" for rows, ms in results
        ))


if __name__ == "__main__":
    main()
