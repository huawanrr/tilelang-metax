#!/usr/bin/env python3
"""Dump the generated MACA source for one stage so the inner loop can be read."""
import argparse
import sys

import tune_moe as tm

p = argparse.ArgumentParser()
p.add_argument("--stage", type=int, default=2)
p.add_argument("--block-m", type=int, default=128)
p.add_argument("--block-n", type=int, default=128)
p.add_argument("--block-k", type=int, default=64)
p.add_argument("--threads", type=int, default=256)
p.add_argument("--num-stages", type=int, default=0)
p.add_argument("--k-pack", type=int, default=1)
p.add_argument("--one-buf", action="store_true")
p.add_argument("--out", default=None)
a = p.parse_args()

builder = tm.build_stage1 if a.stage == 1 else tm.build_stage2
kern = builder(
    7168, 2048, 8, 33792, 32768, 264,
    a.block_m, a.block_n, a.block_k, a.threads, a.num_stages, True,
    swizzle=8, policy="square", k_pack=a.k_pack, one_buf=a.one_buf,
)
src = kern.get_kernel_source()
if a.out:
    with open(a.out, "w") as fh:
        fh.write(src)
    print(f"{len(src.splitlines())} lines -> {a.out}")
else:
    sys.stdout.write(src)
