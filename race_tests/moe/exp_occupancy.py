#!/usr/bin/env python3
"""How many blocks actually run at once on this box?

`torch.cuda.get_device_properties` reports `multi_processor_count = 104`, but mx-smi
says the sGPU slice gets 25% of the compute, and the two cannot both be the number
that matters for tuning.  A block that spins on a dependent FMA chain for a fixed
number of iterations takes the same wall time however many such blocks run
*concurrently*; the wall time steps up once the grid exceeds what fits.  So the knee
in time-vs-grid gives the real concurrency, and dividing by the blocks-per-CU that
the shared-memory footprint allows gives the usable CU count.

    python exp_occupancy.py --threads 512 --smem 32768
"""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

BASE = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}


def build(n_blocks, threads, smem_halfs, iters):
    @T.prim_func
    def spin(out: T.Tensor((n_blocks,), T.float32)):
        with T.Kernel(n_blocks, threads=threads) as bx:
            # Sized to control how many blocks fit per CU, and touched so it is not
            # optimised away.
            pad = T.alloc_shared((smem_halfs,), T.float16)
            acc = T.alloc_local((4,), T.float32)
            tx = T.get_thread_binding()
            pad[tx] = T.cast(bx, T.float16)
            # Four independent chains, so one wave already saturates its SIMD's issue
            # slots.  With a single dependent chain the knee measures when the issue
            # slots fill rather than when the blocks stop being resident.
            acc[0] = T.cast(pad[tx], T.float32)
            acc[1] = acc[0] + 1.0
            acc[2] = acc[0] + 2.0
            acc[3] = acc[0] + 3.0
            for _ in T.serial(0, iters):
                acc[0] = acc[0] * 1.0000001 + 1.0
                acc[1] = acc[1] * 1.0000002 + 1.0
                acc[2] = acc[2] * 1.0000003 + 1.0
                acc[3] = acc[3] * 1.0000004 + 1.0
            if tx == 0:
                out[bx] = acc[0] + acc[1] + acc[2] + acc[3]

    return spin


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--threads", type=int, default=512)
    p.add_argument("--smem", type=int, default=32768, help="shared bytes per block")
    p.add_argument("--iters", type=int, default=200000)
    p.add_argument("--reps", type=int, default=5)
    a = p.parse_args()

    smem_halfs = max(a.threads, a.smem // 2)
    grids = [int(x) for x in (os.environ.get('GRIDS') or '1,13,26,52,78,104,156,208,312,416').split(',')]
    print(f"threads={a.threads} shared={smem_halfs * 2 // 1024} KiB/block "
          f"(so at most {65536 // max(1, smem_halfs * 2)} blocks/CU by shared memory)")
    print(f"{'grid':>6}{'ms':>10}{'ms/block-wave':>16}")
    base = None
    for g in grids:
        kern = tilelang.compile(build(g, a.threads, smem_halfs, a.iters), out_idx=None,
                                pass_configs=BASE)
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
