#!/usr/bin/env python3
"""Compare eager SwiGLU activation with one in-place TileLang kernel."""

import torch
import tilelang
import tilelang.language as T

from local_bench import Case, build_case, time_fn


@tilelang.jit(
    pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}
)
def make_activation(batches, rows, width):
    @T.prim_func
    def kernel(
        gate: T.Tensor((batches, rows, width), T.float16),
        up: T.Tensor((batches, rows, width), T.float16),
    ):
        with T.Kernel(
            batches, rows, T.ceildiv(width, 256), threads=256
        ) as (bx, by, bz):
            for j in T.Parallel(256):
                col = bz * 256 + j
                if col < width:
                    value = T.cast(gate[bx, by, col], T.float32)
                    gate[bx, by, col] = T.cast(
                        value
                        * (1.0 / (1.0 + T.exp2(-value * 1.44269504)))
                        * T.cast(up[bx, by, col], T.float32),
                        T.float16,
                    )

    return kernel


def main():
    case = Case(
        name="oj3-layout2",
        dhidden=7168,
        dexpert=2048,
        nroutedexperts=64,
        nexpertspertoken=2,
        bs=1,
        seqlen=4544,
        counts=(220, 64) * 32,
    )
    args, _ = build_case(case, torch.device("cuda"))
    pairs, rows, hidden, width = 32, 256, 7168, 2048
    tokens = args["stacked_expert_tokens"].view(pairs, 384, hidden)[:, :rows]
    weights = slice(0, None, 2)
    activation = make_activation(pairs, rows, width)

    def eager():
        gate = tokens @ args["gate_w"][weights].transpose(1, 2)
        up = tokens @ args["up_w"][weights].transpose(1, 2)
        swiglu = gate * torch.sigmoid(gate) * up
        return swiglu @ args["down_w"][weights].transpose(1, 2)

    def fused():
        gate = tokens @ args["gate_w"][weights].transpose(1, 2)
        up = tokens @ args["up_w"][weights].transpose(1, 2)
        activation(gate, up)
        return gate @ args["down_w"][weights].transpose(1, 2)

    eager_out = eager()
    fused_out = fused()
    torch.cuda.synchronize()
    print(
        "max_abs",
        (eager_out.float() - fused_out.float()).abs().max().item(),
    )
    for name, fn in (
        ("eager", eager),
        ("fused", fused),
        ("eager2", eager),
        ("fused2", fused),
    ):
        print(name, f"{time_fn(fn, 10, 40):.3f} ms")


if __name__ == "__main__":
    main()
