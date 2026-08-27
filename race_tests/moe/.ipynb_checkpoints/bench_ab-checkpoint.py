#!/usr/bin/env python3
"""Interleaved A/B timing for submission variants.

`local_bench.py` times each module once, back to back, which turned out to be
too noisy on this sliced GPU to resolve differences below ~5% (the same kernel
measured 32.1-35.6 ms on `func_a` across runs).  This alternates modules round
by round and reports the per-module minimum, which is what a fair comparison
needs when the noise is one-sided (interference, clock drift).

    python bench_ab.py --module moe.py --module moe_clamp.py --only func_a --rounds 7
"""
import argparse
import statistics

import torch

from local_bench import ARG_ORDER, build_case, load_cases, load_module, time_fn


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--module", action="append", required=True)
    p.add_argument("--only", default="mid")
    p.add_argument("--configs", default="local_test_configs.json")
    p.add_argument("--rounds", type=int, default=7)
    p.add_argument("--iters", type=int, default=10)
    p.add_argument("--warmup", type=int, default=2)
    o = p.parse_args()

    device = torch.device("cuda")
    mods = [load_module(m) for m in o.module]
    for case in load_cases(o.configs, o.only.split(",")):
        args, meta = build_case(case, device)
        pos = tuple(args[k] for k in ARG_ORDER)
        out = torch.zeros_like(args["stacked_expert_tokens"])
        samples = {m.__bench_label__: [] for m in mods}
        for _ in range(o.rounds):
            for m in mods:
                samples[m.__bench_label__].append(
                    time_fn(lambda: m.run_kernel(*pos, out), o.warmup, o.iters)
                )
        print(f"=== {case.name}  valid={case.n_valid} padded={case.n_padded} "
              f"rounds={o.rounds} iters={o.iters} ===")
        best = min(min(v) for v in samples.values())
        for label, v in samples.items():
            print(f"  {label:22} min {min(v):8.3f}  med {statistics.median(v):8.3f}  "
                  f"max {max(v):8.3f}  spread {(max(v) / min(v) - 1) * 100:5.1f}%  "
                  f"rel {min(v) / best:5.3f}")
        del args, meta, out, pos
        for m in mods:
            getattr(m, "_WORKSPACE_CACHE", {}).clear()
        torch.cuda.empty_cache()


if __name__ == "__main__":
    main()
