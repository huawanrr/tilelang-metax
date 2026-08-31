#!/usr/bin/env python3
"""Zero-copy two-bucket BMM probe for the graded 64/220 routing layout."""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

from local_bench import (SENTINEL, build_case, check_reference, check_untouched,
                         load_cases, time_fn)


@tilelang.jit
def build_scatter(pairs, hidden):
    @T.prim_func
    def kernel(
        small: T.Tensor((pairs, 128, hidden), T.float16),
        big: T.Tensor((pairs, 256, hidden), T.float16),
        route_small: T.StridedTensor((pairs, 64), (284, 1), T.float32),
        route_big: T.StridedTensor((pairs, 220), (284, 1), T.float32),
        out: T.Tensor((pairs, 384, hidden), T.float16),
    ):
        with T.Kernel(pairs, T.ceildiv(hidden, 256), threads=256) as (bx, by):
            for i, j in T.Parallel(64, 256):
                out[bx, i, by * 256 + j] = T.cast(
                    small[bx, i, by * 256 + j] * route_small[bx, i], T.float16
                )
        with T.Kernel(pairs, T.ceildiv(hidden, 256), threads=256) as (bx, by):
            for i, j in T.Parallel(220, 256):
                out[bx, 128 + i, by * 256 + j] = T.cast(
                    big[bx, i, by * 256 + j] * route_big[bx, i], T.float16
                )
    return kernel


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--case", default="oj3real")
    p.add_argument("--iters", type=int, default=40)
    p.add_argument("--warmup", type=int, default=10)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()

    case = load_cases(a.configs, [a.case])[0]
    args, meta = build_case(case, torch.device("cuda"))
    counts = meta["counts"]
    if len(counts) % 2 or any(
        counts[e] != 64 or counts[e + 1] != 220 for e in range(0, len(counts), 2)
    ):
        raise SystemExit("probe requires repeating 64/220 expert counts")

    pairs = len(counts) // 2
    h, i = case.dhidden, case.dexpert
    padded_pair = 128 + 256
    valid_pair = 64 + 220
    x_pair = args["stacked_expert_tokens"].view(pairs, padded_pair, h)
    x_small = x_pair[:, :128]
    x_big = x_pair[:, 128:]
    route_pair = args["routed_expert_weights"].view(pairs, valid_pair)
    route_small = route_pair[:, :64]
    route_big = route_pair[:, 64:]

    gate_small = args["gate_w"][0::2].transpose(1, 2)
    gate_big = args["gate_w"][1::2].transpose(1, 2)
    up_small = args["up_w"][0::2].transpose(1, 2)
    up_big = args["up_w"][1::2].transpose(1, 2)
    down_small = args["down_w"][0::2].transpose(1, 2)
    down_big = args["down_w"][1::2].transpose(1, 2)
    out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
    out_pair = out.view(pairs, padded_pair, h)
    scatter_kernel = build_scatter(pairs, h)

    def project(x, gate_w, up_w, down_w):
        gate = torch.bmm(x, gate_w)
        up = torch.bmm(x, up_w)
        gate = gate * torch.sigmoid(gate) * up
        return torch.bmm(gate, down_w)

    def core():
        small = project(x_small, gate_small, up_small, down_small)
        big = project(x_big, gate_big, up_big, down_big)
        out_pair[:, :64].copy_(small[:, :64] * route_small.unsqueeze(-1))
        out_pair[:, 128:348].copy_(big[:, :220] * route_big.unsqueeze(-1))

    def core_tl():
        small = project(x_small, gate_small, up_small, down_small)
        big = project(x_big, gate_big, up_big, down_big)
        scatter_kernel(small, big, route_small, route_big, out_pair)

    core()
    torch.cuda.synchronize()
    stats = check_reference(out, args, meta, atol=0.05, rtol=0.05)
    padding = check_untouched(out, meta)
    total_ms = time_fn(core, a.warmup, a.iters)
    small_fixed = project(x_small, gate_small, up_small, down_small)
    big_fixed = project(x_big, gate_big, up_big, down_big)
    def scatter():
        out_pair[:, :64].copy_(small_fixed[:, :64] * route_small.unsqueeze(-1))
        out_pair[:, 128:348].copy_(big_fixed[:, :220] * route_big.unsqueeze(-1))
    scatter_ms = time_fn(scatter, a.warmup, a.iters)
    scatter_tl_ms = time_fn(
        lambda: scatter_kernel(small_fixed, big_fixed, route_small, route_big, out_pair),
        a.warmup, a.iters)
    total_tl_ms = time_fn(core_tl, a.warmup, a.iters)
    small_ms = time_fn(
        lambda: project(x_small, gate_small, up_small, down_small),
        a.warmup, a.iters)
    big_ms = time_fn(
        lambda: project(x_big, gate_big, up_big, down_big),
        a.warmup, a.iters)

    print(f"{a.case}: pairs={pairs} H={h} I={i}")
    print(f"correctness={'PASS' if stats['ok'] else 'FAIL'} "
          f"max_abs={stats['max_abs']:.3e} bad={stats['bad']}/{stats['total']} "
          f"padding={'clean' if padding['ok'] else 'TOUCHED'}")
    print(f"small={small_ms:.3f} ms big={big_ms:.3f} ms "
          f"scatter={scatter_ms:.3f}/{scatter_tl_ms:.3f} ms "
          f"total={total_ms:.3f}/{total_tl_ms:.3f} ms (torch/TL scatter)")


if __name__ == "__main__":
    main()
