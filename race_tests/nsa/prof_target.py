"""Minimal single-case driver for mcTracer on the NSA kernels."""
import argparse
import os
import sys

import torch

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nsa
from bench_oj import make_case

p = argparse.ArgumentParser()
p.add_argument("--case", default="oj6")
p.add_argument("--iters", type=int, default=10)
p.add_argument("--warmup", type=int, default=3)
a = p.parse_args()

SHAPES = {
    "oj6": dict(B=8, T=1024, H=1, HQ=16, D=128, S=1, bs=32, causal=True),
    "oj12": dict(B=4, T=1024, H=1, HQ=16, D=64, S=8, bs=16, causal=True),
}
cfg = SHAPES[a.case]
q, k, v, idx = make_case(cfg)
out = torch.empty_like(q)
kern = nsa.run_kernel
B, T, H, HQ, D, S, bs = (cfg["B"], cfg["T"], cfg["H"], cfg["HQ"],
                         cfg["D"], cfg["S"], cfg["bs"])
for _ in range(a.warmup):
    kern(q, k, v, idx, out, B, T, H, HQ, D, S, bs, cfg["causal"], 0.1)
torch.cuda.synchronize()
for _ in range(a.iters):
    kern(q, k, v, idx, out, B, T, H, HQ, D, S, bs, cfg["causal"], 0.1)
torch.cuda.synchronize()
print("done", out.float().abs().sum().item())
