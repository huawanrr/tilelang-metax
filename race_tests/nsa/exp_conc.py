#!/usr/bin/env python3
"""Concurrency probe for the NSA block footprints.

The oj6 kernel (64 threads, ~8.4 KiB shared, ~88 regs) shows ~6 resident
blocks/CU in mcTracer -- but that number is *average* concurrency over a
wave-quantised grid, not necessarily a resource cap.  This probe spins a
64-thread block with the same shared-memory footprint (and optionally a
register pad) and sweeps the grid: wall time is flat while every block
runs concurrently and steps up linearly once the grid exceeds the real
capacity.  The knee gives cap_per_CU * usable_CUs.

    GRIDS=... python exp_conc.py --smem 8448 --regs 0
    GRIDS=... python exp_conc.py --smem 8448 --regs 80
"""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

BASE = {
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
}


def build(n_blocks, threads, smem_bytes, reg_pad, iters):
    smem_halfs = smem_bytes // 2

    @T.prim_func
    def spin(out: T.Tensor((n_blocks,), T.float32)):
        with T.Kernel(n_blocks, threads=threads) as bx:
            pad = T.alloc_shared((smem_halfs,), T.float16)
            tx = T.get_thread_binding()
            for i in T.serial(0, smem_halfs // threads):
                pad[i * threads + tx] = T.cast(bx + i, T.float16)
            # Trace-time-unrolled dependent chains: these live in registers
            # (a T.serial loop with dynamic indices would fall to local
            # memory and measure the wrong resource).
            n = max(4, reg_pad)
            acc = T.alloc_local((n,), T.float32)
            acc[0] = T.cast(pad[tx], T.float32)
            for i in T.serial(1, n):
                acc[i] = acc[0] + T.cast(i, T.float32)
            for _ in T.serial(0, iters):
                for i in range(n):
                    acc[i] = acc[i] * 1.0000001 + 1.0
            if tx == 0:
                for i in T.serial(1, n):
                    acc[0] += acc[i]
                out[bx] = acc[0] + T.cast(pad[(bx * 4099) % smem_halfs], T.float32)

    return spin


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--threads", type=int, default=64)
    p.add_argument("--smem", type=int, default=8448)
    p.add_argument("--regs", type=int, default=0, help="local-array register pad")
    p.add_argument("--iters", type=int, default=20000)
    p.add_argument("--reps", type=int, default=3)
    a = p.parse_args()

    grids = [int(x) for x in (os.environ.get("GRIDS")
             or "26,52,104,156,208,312,416,624,832,1248").split(",")]
    print(f"threads={a.threads} shared={a.smem}B/block reg_pad={a.regs} iters={a.iters}")
    print(f"{'grid':>6}{'ms':>10}{'ms/26CU-wave':>16}")
    base = None
    for g in grids:
        kern = tilelang.compile(build(g, a.threads, a.smem, a.regs, a.iters),
                                out_idx=None, pass_configs=BASE)
        out = torch.zeros(g, device="cuda", dtype=torch.float32)
        kern(out)
        torch.cuda.synchronize()
        best = None
        for _ in range(a.reps):
            s, e = torch.cuda.Event(True), torch.cuda.Event(True)
            s.record()
            kern(out)
            e.record()
            torch.cuda.synchronize()
            ms = s.elapsed_time(e)
            best = ms if best is None else min(best, ms)
        base = base or best
        print(f"{g:>6}{best:>10.3f}{best / base:>16.2f}x")


if __name__ == "__main__":
    main()
