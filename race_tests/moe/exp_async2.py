#!/usr/bin/env python3
"""Why does a `T.maca_async_copy` GEMM give wrong results here, when the upstream
example (`examples/maca/gemm/example_gemm_with_maca_async_copy.py`) passes?

Varies one thing at a time against that example's configuration: the B layout
(the MoE weights are (N, K) and want `transpose_B`, the example's are (K, N)),
the thread count, block_k, and num_stages.
"""
import argparse
import os

import torch
import tilelang
import tilelang.language as T

BASE = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}
M = N = K = 1024


def build_nk(bm, bn, bk, threads, stages, asyncc):
    """B is (N, K), consumed with transpose_B -- the MoE weight layout."""

    @T.prim_func
    def g(A: T.Tensor((M, K), T.float16), B: T.Tensor((N, K), T.float16),
          C: T.Tensor((M, N), T.float16)):
        with T.Kernel(T.ceildiv(N, bn), T.ceildiv(M, bm), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), T.float16)
            b_s = T.alloc_shared((bn, bk), T.float16)
            c_l = T.alloc_fragment((bm, bn), T.float32)
            bar = T.alloc_maca_barrier()
            T.clear(c_l)
            for k in T.Pipelined(T.ceildiv(K, bk), num_stages=stages):
                if asyncc:
                    T.maca_async_copy(A[by * bm, k * bk], a_s, barrier=bar)
                    T.maca_async_copy(B[bx * bn, k * bk], b_s, barrier=bar)
                    T.gemm(a_s, b_s, c_l, transpose_B=True, mbar=bar)
                else:
                    T.copy(A[by * bm : (by + 1) * bm, k * bk : (k + 1) * bk], a_s)
                    T.copy(B[bx * bn : (bx + 1) * bn, k * bk : (k + 1) * bk], b_s)
                    T.gemm(a_s, b_s, c_l, transpose_B=True)
            T.copy(c_l, C[by * bm : (by + 1) * bm, bx * bn : (bx + 1) * bn])

    return g


def build_kn(bm, bn, bk, threads, stages, asyncc):
    """B is (K, N), consumed directly -- the upstream example's layout."""

    @T.prim_func
    def g(A: T.Tensor((M, K), T.float16), B: T.Tensor((K, N), T.float16),
          C: T.Tensor((M, N), T.float16)):
        with T.Kernel(T.ceildiv(N, bn), T.ceildiv(M, bm), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), T.float16)
            b_s = T.alloc_shared((bk, bn), T.float16)
            c_l = T.alloc_fragment((bm, bn), T.float32)
            bar = T.alloc_maca_barrier()
            T.clear(c_l)
            for k in T.Pipelined(T.ceildiv(K, bk), num_stages=stages):
                if asyncc:
                    T.maca_async_copy(A[by * bm, k * bk], a_s, barrier=bar)
                    T.maca_async_copy(B[k * bk, bx * bn], b_s, barrier=bar)
                    T.gemm(a_s, b_s, c_l, mbar=bar)
                else:
                    T.copy(A[by * bm : (by + 1) * bm, k * bk : (k + 1) * bk], a_s)
                    T.copy(B[k * bk : (k + 1) * bk, bx * bn : (bx + 1) * bn], b_s)
                    T.gemm(a_s, b_s, c_l)
            T.copy(c_l, C[by * bm : (by + 1) * bm, bx * bn : (bx + 1) * bn])

    return g


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--iters", type=int, default=10)
    a = p.parse_args()
    os.environ.setdefault("TILELANG_CACHE_DIR",
                          os.path.expanduser("~/.tilelang/cache_async_probe"))
    dev = "cuda"
    A = torch.randn(M, K, device=dev, dtype=torch.float16) / 8
    Bt = torch.randn(N, K, device=dev, dtype=torch.float16) / 8
    Bn = Bt.t().contiguous()
    ref = (A.float() @ Bt.float().t()).half()
    C = torch.empty(M, N, device=dev, dtype=torch.float16)
    flops = 2 * M * N * K

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

    print(f"{'variant':<40}{'ms':>8}{'TF/s':>8}{'err':>11}")
    for layout in ("kn", "nk"):
        build = build_kn if layout == "kn" else build_nk
        Bx = Bn if layout == "kn" else Bt
        for asyncc in (False, True):
            for bm, bn, bk, threads, stages in (
                (128, 128, 32, 128, 2), (128, 128, 32, 128, 0),
                (128, 128, 32, 512, 2), (128, 128, 64, 512, 2),
                (128, 128, 64, 512, 0),
            ):
                name = (f"{layout} {'async' if asyncc else 'sync '} "
                        f"{bm}x{bn}x{bk} t{threads} s{stages}")
                try:
                    kern = tilelang.compile(build(bm, bn, bk, threads, stages, asyncc),
                                            out_idx=None, pass_configs=BASE)
                    C.zero_()
                    kern(A, Bx, C)
                    torch.cuda.synchronize()
                    err = ((C.float() - ref.float()).abs().max().item()
                           / ref.abs().max().item())
                    ms = bench(lambda: kern(A, Bx, C))
                    print(f"{name:<40}{ms:8.3f}{flops/(ms*1e-3)/1e12:8.1f}{err:11.2e}"
                          f"{'' if err < 5e-3 else '  MISMATCH'}")
                except Exception as exc:
                    print(f"{name:<40}{'-':>8}{'-':>8}{'-':>11}  "
                          f"{type(exc).__name__}: {str(exc)[:50]}")


if __name__ == "__main__":
    main()
