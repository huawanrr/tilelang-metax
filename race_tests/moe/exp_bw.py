#!/usr/bin/env python3
"""What bandwidth does the kernel's *access pattern* actually get?

The roofline in NOTES.md §6 uses 1.42 TB/s, measured with a fully sequential read
(`torch.sum` over 512 MiB).  Every global read the MoE kernel makes is different: a
(128 row x block_k) tile out of a (rows, hidden) matrix, i.e. 128 segments of
`block_k * 2` bytes with a `hidden * 2` byte stride.  For hidden = 7168 that is 128 B
out of every 14 KiB.  If that pattern is much slower than a sequential read then the
kernel is at 100% of the roof that matters and there is headroom behind a layout
change; if it is the same, the roofline stands as written.

    python exp_bw.py --hidden 7168 --block-k 64
"""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

BASE = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}


def build_tiles(rows, hidden, bm, bk, threads, n_rep):
    """Read (bm, bk) tiles into shared memory, exactly as stage 1 copies its operands.

    `n_rep` blocks per row-block walk different k offsets so the whole matrix is read
    once, and the sum of one element per tile is stored so nothing is dead code.
    """

    @T.prim_func
    def read(src: T.Tensor((rows, hidden), T.float16), out: T.Tensor((rows // bm,), T.float32)):
        with T.Kernel(rows // bm, threads=threads) as bx:
            tile = T.alloc_shared((bm, bk), T.float16)
            acc = T.alloc_local((1,), T.float32)
            acc[0] = 0.0
            for k in T.serial(0, n_rep):
                T.copy(src[bx * bm : (bx + 1) * bm, k * bk : (k + 1) * bk], tile)
                acc[0] += T.cast(tile[0, 0], T.float32)
            if T.get_thread_binding() == 0:
                out[bx] = acc[0]

    return read


def build_flat(n, threads):
    """Sequential read of the same bytes, for the reference number."""
    per = 8

    @T.prim_func
    def read(src: T.Tensor((n,), T.float16), out: T.Tensor((1,), T.float32)):
        with T.Kernel(T.ceildiv(n, threads * per), threads=threads) as bx:
            acc = T.alloc_local((1,), T.float32)
            acc[0] = 0.0
            tx = T.get_thread_binding()
            for i in T.serial(0, per):
                acc[0] += T.cast(src[(bx * threads + tx) * per + i], T.float32)
            if tx == 0 and bx == 0:
                out[0] = acc[0]

    return read


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--rows", type=int, default=12288)
    p.add_argument("--hidden", type=int, default=7168)
    p.add_argument("--block-m", type=int, default=128)
    p.add_argument("--iters", type=int, default=20)
    a = p.parse_args()
    os.environ.setdefault("TILELANG_CACHE_DIR", os.path.expanduser("~/.tilelang/cache_bw"))
    dev = "cuda"
    x = torch.randn(a.rows, a.hidden, device=dev, dtype=torch.float16)
    gb = x.numel() * 2 / 1e9

    def bench(fn):
        for _ in range(3):
            fn()
        torch.cuda.synchronize()
        s, e = torch.cuda.Event(True), torch.cuda.Event(True)
        s.record()
        for _ in range(a.iters):
            fn()
        e.record()
        torch.cuda.synchronize()
        return s.elapsed_time(e) / a.iters

    ms = bench(lambda: x.sum(dtype=torch.float32))
    print(f"{'torch.sum (sequential)':<34}{ms:8.3f} ms  {gb / (ms * 1e-3):7.0f} GB/s")

    out1 = torch.zeros(1, device=dev, dtype=torch.float32)
    k = tilelang.compile(build_flat(x.numel(), 256), out_idx=None, pass_configs=BASE)
    ms = bench(lambda: k(x.view(-1), out1))
    print(f"{'tilelang flat read':<34}{ms:8.3f} ms  {gb / (ms * 1e-3):7.0f} GB/s")

    out = torch.zeros(a.rows // a.block_m, device=dev, dtype=torch.float32)
    for bk in (32, 64, 96, 128, 256):
        n_rep = a.hidden // bk
        effective_gb = a.rows * n_rep * bk * 2 / 1e9
        for threads in (256, 512):
            kern = tilelang.compile(
                build_tiles(a.rows, a.hidden, a.block_m, bk, threads, n_rep),
                out_idx=None, pass_configs=BASE)
            ms = bench(lambda: kern(x, out))
            print(f"{f'tiles {a.block_m}x{bk} t{threads}':<34}{ms:8.3f} ms  "
                  f"{effective_gb / (ms * 1e-3):7.0f} GB/s   {bk * 2} B per row segment")


if __name__ == "__main__":
    main()
