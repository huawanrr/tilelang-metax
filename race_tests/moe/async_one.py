#!/usr/bin/env python3
"""Time exactly one GEMM config, in its own process.

The MACA async-copy path can fault the context ("illegal memory access"), after
which every later launch in the same process fails, so sweeping it inside one
process is meaningless.  This runs a single config and exits.

    python async_one.py --kind async --layout kn --bm 128 --bn 128 --bk 32 \
        --threads 128 --stages 2 --m 4096 --n 2048 --k 7168
"""
import argparse
import sys

import torch
import tilelang
import tilelang.language as T

from local_bench import time_fn

JIT_ARGS = dict(pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})


def build(kind, layout, M, N, K, bm, bn, bk, threads, num_stages, swizzle):
    dtype, accum = T.float16, T.float32
    b_shape = (K, N) if layout == "kn" else (N, K)
    b_tile = (bk, bn) if layout == "kn" else (bn, bk)

    @T.prim_func
    def kernel(a: T.Tensor((M, K), dtype), b: T.Tensor(b_shape, dtype), c: T.Tensor((M, N), dtype)):
        with T.Kernel(T.ceildiv(M, bm), T.ceildiv(N, bn), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype=dtype)
            b_s = T.alloc_shared(b_tile, dtype=dtype)
            c_l = T.alloc_fragment((bm, bn), dtype=accum)
            if swizzle:
                T.use_swizzle(swizzle)
            if kind == "async":
                bar = T.alloc_maca_barrier()
            T.clear(c_l)
            for k in T.Pipelined(T.ceildiv(K, bk), num_stages=num_stages):
                if kind == "async":
                    T.maca_async_copy(a[bx * bm, k * bk], a_s, barrier=bar)
                    if layout == "kn":
                        T.maca_async_copy(b[k * bk, by * bn], b_s, barrier=bar)
                    else:
                        T.maca_async_copy(b[by * bn, k * bk], b_s, barrier=bar)
                    T.gemm(a_s, b_s, c_l, transpose_B=(layout == "nk"), mbar=bar)
                else:
                    T.copy(a[bx * bm : (bx + 1) * bm, k * bk : (k + 1) * bk], a_s)
                    if layout == "kn":
                        T.copy(b[k * bk : (k + 1) * bk, by * bn : (by + 1) * bn], b_s)
                    else:
                        T.copy(b[by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], b_s)
                    T.gemm(a_s, b_s, c_l, transpose_B=(layout == "nk"))
            for i, j in T.Parallel(bm, bn):
                c[bx * bm + i, by * bn + j] = c_l[i, j]

    return tilelang.compile(kernel, out_idx=None, **JIT_ARGS)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--kind", choices=("sync", "async"), required=True)
    p.add_argument("--layout", choices=("kn", "nk"), default="nk")
    p.add_argument("--m", type=int, default=4096)
    p.add_argument("--n", type=int, default=2048)
    p.add_argument("--k", type=int, default=7168)
    p.add_argument("--bm", type=int, default=128)
    p.add_argument("--bn", type=int, default=128)
    p.add_argument("--bk", type=int, default=64)
    p.add_argument("--threads", type=int, default=256)
    p.add_argument("--stages", type=int, default=1)
    p.add_argument("--swizzle", type=int, default=8)
    p.add_argument("--iters", type=int, default=10)
    o = p.parse_args()

    dev = torch.device("cuda")
    M, N, K = o.m, o.n, o.k
    flops = 2 * M * N * K
    a = torch.randn((M, K), device=dev, dtype=torch.float16) / 8
    b_nk = torch.randn((N, K), device=dev, dtype=torch.float16) / 8
    b = b_nk.t().contiguous() if o.layout == "kn" else b_nk
    c = torch.empty((M, N), device=dev, dtype=torch.float16)
    ref = (a.float() @ b_nk.float().t()).half()
    scale = float(ref.abs().max().item())

    tag = (f"{o.kind:5} {o.layout} bm{o.bm} bn{o.bn} bk{o.bk} t{o.threads} "
           f"s{o.stages} z{o.swizzle} M{M} N{N} K{K}")
    try:
        kern = build(o.kind, o.layout, M, N, K, o.bm, o.bn, o.bk, o.threads, o.stages, o.swizzle)
        c.zero_()
        kern(a, b, c)
        torch.cuda.synchronize()
        err = float((c.float() - ref.float()).abs().max().item()) / scale
        ms = time_fn(lambda: kern(a, b, c), 3, o.iters)
        state = "ok" if err <= 2e-2 else "WRONG"
        print(f"RESULT {tag:56} {ms:8.3f} ms {flops / (ms * 1e-3) / 1e12:7.2f} TF/s {state} err={err:.1e}")
        return 0 if state == "ok" else 2
    except Exception as exc:
        print(f"RESULT {tag:56} FAIL {str(exc).splitlines()[0][:60]}")
        return 3


if __name__ == "__main__":
    sys.exit(main())
