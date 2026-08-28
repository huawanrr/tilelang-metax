#!/usr/bin/env python3
"""Does MACA async copy (global -> shared DMA) plus multistage beat the synchronous
copy the MoE kernel uses?

The MoE loop cannot overlap its global-to-shared copies with the MMAs: the copies go
through registers and four `__syncthreads()` per k-step fence them, so a block
alternates between copying and computing and the only overlap comes from the second
block resident on the SM.  `T.maca_async_copy` issues a real DMA against a MACA
barrier, which is what lets a vendor kernel run one stage's copy under the previous
stage's MMAs.  This prices that on a plain GEMM of the MoE's own shape before any of
it is worth building into the kernel.

    python exp_async.py --m 12288 --n 2048 --k 7168
"""
import argparse
import itertools
import os

import torch
import tilelang
import tilelang.language as T

BASE_PASS = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}


def build(M, N, K, bm, bn, bk, threads, stages, asyncc, dtype=T.float16, accum=T.float32):
    """B is (N, K) and transposed in the GEMM, exactly as the MoE weights are."""

    @T.prim_func
    def gemm(
        A: T.Tensor((M, K), dtype),
        B: T.Tensor((N, K), dtype),
        C: T.Tensor((M, N), dtype),
    ):
        with T.Kernel(T.ceildiv(M, bm), T.ceildiv(N, bn), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype)
            b_s = T.alloc_shared((bn, bk), dtype)
            c_l = T.alloc_fragment((bm, bn), accum)
            if asyncc:
                bar = T.alloc_maca_barrier()
            T.clear(c_l)
            for k in T.Pipelined(T.ceildiv(K, bk), num_stages=stages):
                if asyncc:
                    T.maca_async_copy(A[bx * bm, k * bk], a_s, barrier=bar)
                    T.maca_async_copy(B[by * bn, k * bk], b_s, barrier=bar)
                    T.gemm(a_s, b_s, c_l, transpose_B=True, mbar=bar)
                else:
                    T.copy(A[bx * bm : (bx + 1) * bm, k * bk : (k + 1) * bk], a_s)
                    T.copy(B[by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], b_s)
                    T.gemm(a_s, b_s, c_l, transpose_B=True)
            T.copy(c_l, C[bx * bm : (bx + 1) * bm, by * bn : (by + 1) * bn])

    return gemm


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--m", type=int, default=12288)
    p.add_argument("--n", type=int, default=2048)
    p.add_argument("--k", type=int, default=7168)
    p.add_argument("--iters", type=int, default=15)
    p.add_argument("--warmup", type=int, default=4)
    p.add_argument("--kpack", action="store_true", help="apply moe.py's k_pack override")
    a = p.parse_args()

    os.environ["TILELANG_CACHE_DIR"] = os.path.join(
        os.path.expanduser("~"), ".tilelang", "cache_async" + ("_kp" if a.kpack else ""))
    if a.kpack:
        import moe
        print("k_pack override:", moe._k_pack_on())

    dev = torch.device("cuda")
    A = torch.randn(a.m, a.k, device=dev, dtype=torch.float16) / 8
    B = torch.randn(a.n, a.k, device=dev, dtype=torch.float16) / 8
    C = torch.empty(a.m, a.n, device=dev, dtype=torch.float16)
    ref = (A.float() @ B.float().t()).half()
    flops = 2 * a.m * a.n * a.k

    def bench(fn):
        for _ in range(a.warmup):
            fn()
        torch.cuda.synchronize()
        s, e = torch.cuda.Event(True), torch.cuda.Event(True)
        s.record()
        for _ in range(a.iters):
            fn()
        e.record()
        torch.cuda.synchronize()
        return s.elapsed_time(e) / a.iters

    ms = bench(lambda: torch.matmul(A, B.t(), out=C))
    print(f"{'torch.matmul':<34}{ms:8.3f} ms {flops/(ms*1e-3)/1e12:7.1f} TF/s")

    print(f"{'variant':<34}{'ms':>8} {'TF/s':>7}  {'err':>9}  smem")
    for bm, bn, bk, threads, stages, asyncc in itertools.chain(
        [(128, 128, 64, 512, 0, False), (128, 128, 64, 128, 0, False),
         (128, 128, 32, 128, 0, False)],
        # Async copy is only *correct* at 128 threads on this build (exp_async2.py:
        # 512 threads mismatches at every tile), so the async sweep stays there.
        [(bm, bn, bk, 128, st, True)
         for bm, bn, bk in ((128, 128, 32), (128, 128, 64), (256, 128, 32),
                            (128, 256, 32), (256, 256, 32), (256, 128, 64))
         for st in (2, 3)],
    ):
        name = f"{'async' if asyncc else 'sync '} {bm}x{bn}x{bk} t{threads} s{stages}"
        smem = (bm * bk + bn * bk) * 2 * max(1, stages)
        try:
            kern = tilelang.compile(build(a.m, a.n, a.k, bm, bn, bk, threads, stages, asyncc),
                                    out_idx=None, pass_configs=BASE_PASS)
            C.zero_()
            kern(A, B, C)
            torch.cuda.synchronize()
            err = (C.float() - ref.float()).abs().max().item() / ref.abs().max().item()
            ms = bench(lambda: kern(A, B, C))
            print(f"{name:<34}{ms:8.3f} {flops/(ms*1e-3)/1e12:7.1f}  {err:9.2e}  "
                  f"{smem // 1024}K{'  MISMATCH' if err > 5e-3 else ''}")
        except Exception as exc:
            print(f"{name:<34}{'-':>8} {'-':>7}  {'-':>9}  {smem // 1024}K  "
                  f"{type(exc).__name__}: {str(exc)[:60]}")


if __name__ == "__main__":
    main()
