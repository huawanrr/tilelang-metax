#!/usr/bin/env python3
"""Minimal single-case driver used as the target for mcTracer / profilers.

Builds one case, runs `run_kernel` a fixed number of times, exits.  Keeps the
traced region as small as possible so the trace is dominated by the two MoE
kernels rather than by input generation.
"""
import argparse
import os

import torch

from local_bench import ARG_ORDER, build_case, load_cases, load_module, time_fn

p = argparse.ArgumentParser()
p.add_argument("--case", default="mid")
p.add_argument("--module", default="moe.py")
p.add_argument("--iters", type=int, default=10)
p.add_argument("--warmup", type=int, default=3)
p.add_argument("--configs", default=os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                                 "local_test_configs.json"))
a = p.parse_args()

case = load_cases(a.configs, [a.case])[0]
mod = load_module(a.module)
device = torch.device("cuda")
args, meta = build_case(case, device)
pos = tuple(args[k] for k in ARG_ORDER)
out = torch.zeros_like(args["stacked_expert_tokens"])

for _ in range(a.warmup):
    mod.run_kernel(*pos, out)
torch.cuda.synchronize()

ms = time_fn(lambda: mod.run_kernel(*pos, out), 0, a.iters)
print(f"{a.case} {a.module}: {ms:.3f} ms  {case.flops() / (ms * 1e-3) / 1e12:.2f} TFLOP/s")
