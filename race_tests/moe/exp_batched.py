#!/usr/bin/env python3
"""Upper-bound probe for a dense batched-MoE implementation.

Every expert is padded to a common M=256 so the original weight tensors can be
consumed by three zero-copy torch.bmm calls.  Packing is deliberately outside
the timed region here; this first probe answers whether the dense GEMMs leave
enough time budget to justify a TileLang pack/unpack path.
"""
import argparse
import os

import torch

from local_bench import (SENTINEL, build_case, check_reference, check_untouched,
                         load_cases, time_fn)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--case", default="oj3real")
    p.add_argument("--m", type=int, default=256)
    p.add_argument("--iters", type=int, default=30)
    p.add_argument("--warmup", type=int, default=8)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()

    case = load_cases(a.configs, [a.case])[0]
    args, meta = build_case(case, torch.device("cuda"))
    e, m, h, i = case.nroutedexperts, a.m, case.dhidden, case.dexpert
    if max(meta["counts"]) > m:
        raise SystemExit(f"M={m} is smaller than max group size {max(meta['counts'])}")

    xb = torch.zeros((e, m, h), device="cuda", dtype=torch.float16)
    rw = torch.zeros((e, m), device="cuda", dtype=torch.float16)
    for expert, count in enumerate(meta["counts"]):
        p0 = meta["pad_off"][expert]
        r0 = meta["offsets"][expert]
        xb[expert, :count].copy_(args["stacked_expert_tokens"][p0:p0 + count])
        rw[expert, :count].copy_(
            args["routed_expert_weights"][r0:r0 + count].to(torch.float16))

    gate_t = args["gate_w"].transpose(1, 2)
    up_t = args["up_w"].transpose(1, 2)
    down_t = args["down_w"].transpose(1, 2)

    def core():
        gate = torch.bmm(xb, gate_t)
        up = torch.bmm(xb, up_t)
        gate.mul_(torch.sigmoid(gate))
        gate.mul_(up)
        result = torch.bmm(gate, down_t)
        result.mul_(rw.unsqueeze(-1))
        return result

    result = core()
    torch.cuda.synchronize()
    out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
    for expert, count in enumerate(meta["counts"]):
        p0 = meta["pad_off"][expert]
        out[p0:p0 + count].copy_(result[expert, :count])
    torch.cuda.synchronize()
    stats = check_reference(out, args, meta, atol=0.05, rtol=0.05)
    padding = check_untouched(out, meta)
    ms = time_fn(core, a.warmup, a.iters)
    gate_fixed = torch.bmm(xb, gate_t)
    up_fixed = torch.bmm(xb, up_t)
    hidden_fixed = gate_fixed * torch.sigmoid(gate_fixed) * up_fixed
    bmm1_ms = time_fn(lambda: torch.bmm(xb, gate_t), a.warmup, a.iters)
    bmm2_ms = time_fn(lambda: torch.bmm(hidden_fixed, down_t), a.warmup, a.iters)
    epi_ms = time_fn(
        lambda: gate_fixed.clone().mul_(torch.sigmoid(gate_fixed)).mul_(up_fixed),
        a.warmup, a.iters)
    actual_flops = 6 * case.n_valid * h * i
    padded_flops = 6 * e * m * h * i
    print(f"{a.case}: E={e} M={m} H={h} I={i} valid={case.n_valid}")
    print(f"correctness={'PASS' if stats['ok'] else 'FAIL'} "
          f"max_abs={stats['max_abs']:.3e} bad={stats['bad']}/{stats['total']} "
          f"padding={'clean' if padding['ok'] else 'TOUCHED'}")
    print(f"core={ms:.3f} ms  actual={actual_flops / (ms * 1e-3) / 1e12:.1f} TF/s  "
          f"padded={padded_flops / (ms * 1e-3) / 1e12:.1f} TF/s")
    print(f"one input bmm={bmm1_ms:.3f} ms  down bmm={bmm2_ms:.3f} ms  "
          f"SwiGLU={epi_ms:.3f} ms  estimated sum={2 * bmm1_ms + bmm2_ms + epi_ms:.3f} ms")


if __name__ == "__main__":
    main()
