#!/usr/bin/env python3
"""Can MACA's explicit async copy beat the ~101 TF/s plain-GEMM ceiling?

`gemm_probe.py` / `pass_probe.py` showed that `T.copy` + `T.Pipelined` tops out
near 101 TF/s on this C500 while torch reaches 165 TF/s, and that no pass config
changes it.  The MetaX fork added an explicit `T.maca_async_copy` +
`T.alloc_maca_barrier` + `T.gemm(mbar=...)` path (commit c9a206cb), which is the
one remaining lowering-level lever.  This probe times both forms on the MoE's
own GEMM shape and layout.

    python async_probe.py
"""
import itertools
import json

import torch
import tilelang
import tilelang.language as T

from local_bench import time_fn

JIT_ARGS = dict(pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
SMEM_LIMIT = 64 * 1024


@tilelang.jit(**JIT_ARGS)
def build_sync(M, N, K, bm, bn, bk, threads, num_stages, swizzle):
    dtype, accum = T.float16, T.float32

    @T.prim_func
    def kernel(a: T.Tensor((M, K), dtype), b: T.Tensor((N, K), dtype), c: T.Tensor((M, N), dtype)):
        with T.Kernel(T.ceildiv(M, bm), T.ceildiv(N, bn), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype=dtype)
            b_s = T.alloc_shared((bn, bk), dtype=dtype)
            c_l = T.alloc_fragment((bm, bn), dtype=accum)
            T.use_swizzle(swizzle)
            T.clear(c_l)
            for k in T.Pipelined(T.ceildiv(K, bk), num_stages=num_stages):
                T.copy(a[bx * bm : (bx + 1) * bm, k * bk : (k + 1) * bk], a_s)
                T.copy(b[by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], b_s)
                T.gemm(a_s, b_s, c_l, transpose_B=True)
            for i, j in T.Parallel(bm, bn):
                c[bx * bm + i, by * bn + j] = c_l[i, j]

    return kernel


@tilelang.jit(**JIT_ARGS)
def build_async(M, N, K, bm, bn, bk, threads, num_stages, swizzle):
    dtype, accum = T.float16, T.float32

    @T.prim_func
    def kernel(a: T.Tensor((M, K), dtype), b: T.Tensor((N, K), dtype), c: T.Tensor((M, N), dtype)):
        with T.Kernel(T.ceildiv(M, bm), T.ceildiv(N, bn), threads=threads) as (bx, by):
            a_s = T.alloc_shared((bm, bk), dtype=dtype)
            b_s = T.alloc_shared((bn, bk), dtype=dtype)
            c_l = T.alloc_fragment((bm, bn), dtype=accum)
            bar = T.alloc_maca_barrier()
            T.use_swizzle(swizzle)
            T.clear(c_l)
            for k in T.Pipelined(T.ceildiv(K, bk), num_stages=num_stages):
                T.maca_async_copy(a[bx * bm, k * bk], a_s, barrier=bar)
                T.maca_async_copy(b[by * bn, k * bk], b_s, barrier=bar)
                T.gemm(a_s, b_s, c_l, transpose_B=True, mbar=bar)
            for i, j in T.Parallel(bm, bn):
                c[bx * bm + i, by * bn + j] = c_l[i, j]

    return kernel


def main():
    dev = torch.device("cuda")
    M, N, K = 4096, 2048, 7168
    flops = 2 * M * N * K
    a = torch.randn((M, K), device=dev, dtype=torch.float16) / 8
    b = torch.randn((N, K), device=dev, dtype=torch.float16) / 8
    c = torch.empty((M, N), device=dev, dtype=torch.float16)
    ref = (a.float() @ b.float().t()).half()
    scale = float(ref.abs().max().item())

    ms = time_fn(lambda: torch.mm(a, b.t(), out=c), 5, 20)
    print(f"torch.mm reference                    {ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s\n")

    results = []
    for kind, bm, bn, bk, th, ns in itertools.product(
        ["sync", "async"], [128], [128, 256], [32, 64, 128], [256, 512], [0, 1, 2, 3, 4]
    ):
        if bm * bn < th or bm * bn / th > 160:
            continue
        if (bn * bk + bm * bk) * 2 * max(1, ns) > SMEM_LIMIT:
            continue
        cfg = dict(bm=bm, bn=bn, bk=bk, threads=th, num_stages=ns, swizzle=8)
        tag = f"{kind:5} bm{bm} bn{bn} bk{bk} t{th} s{ns}"
        try:
            build = build_sync if kind == "sync" else build_async
            kern = build(M, N, K, **cfg)
            c.zero_()
            kern(a, b, c)
            torch.cuda.synchronize()
            err = float((c.float() - ref.float()).abs().max().item()) / scale
            if err > 2e-2:
                print(f"{tag:34} WRONG err={err:.2e}")
                continue
            ms = time_fn(lambda: kern(a, b, c), 3, 10)
            results.append((ms, kind, cfg))
            print(f"{tag:34} {ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s  err={err:.1e}")
        except Exception as exc:
            print(f"{tag:34} FAIL {str(exc).splitlines()[0][:64]}")
        finally:
            torch.cuda.empty_cache()

    print("\n=== top 12 ===")
    for ms, kind, cfg in sorted(results, key=lambda r: r[0])[:12]:
        print(f"{ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s  {kind:5} {json.dumps(cfg)}")


if __name__ == "__main__":
    main()
