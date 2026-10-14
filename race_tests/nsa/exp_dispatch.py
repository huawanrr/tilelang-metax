"""Empty-kernel dispatch scaling: cost per CTA when a CTA does no memory work.

Decides the gather-kernel grid shape: a 3D (nblocks x chunks x B*H) grid with
mostly-empty CTAs is only viable if empty CTAs retire far faster than the
~14ns/CTA that memory-bound CTAs cost.
"""
import sys

import torch
import tilelang
import tilelang.language as T

sys.path.insert(0, "/data/tilelang-metax/race_tests/nsa")
from bench_oj import graph_latency


def build(n, guarded):
    @T.prim_func
    def k(out: T.Tensor((n,), T.int32)):
        with T.Kernel(n, threads=64) as bx:
            if guarded:
                # Read-and-exit pattern of the gather kernel's empty CTAs.
                if out[bx] >= 0:
                    out[bx] = bx
            else:
                out[bx] = bx

    return k


for guarded in (False, True):
    for n in (1024, 8192, 24320, 65536):
        kern = tilelang.compile(build(n, guarded), out_idx=None,
                                pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
        out = torch.ones(n, device="cuda", dtype=torch.int32)
        kern(out)
        torch.cuda.synchronize()
        us = graph_latency(lambda: kern(out)) * 1e3
        print(f"guarded={guarded} grid {n:>6}: {us:7.2f}us  {us / n * 1000:6.2f}ns/CTA")
