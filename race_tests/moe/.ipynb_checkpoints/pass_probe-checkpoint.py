#!/usr/bin/env python3
"""Does any TileLang pass config close the gap to the vendor GEMM on MACA?

`gemm_probe.py` shows a plain TileLang GEMM topping out near 100 TF/s where
torch reaches 166-224 TF/s on the same shape, so the ceiling is in lowering, not
in the MoE kernel's tiling.  This script keeps the tile fixed at the best config
found there and varies the pass configs that touch copy lowering, pipelining and
register pressure.

    python pass_probe.py
"""
import json

import torch
import tilelang
import tilelang.language as T

from local_bench import time_fn

K_ASYNC = tilelang.PassConfigKey
BASE = {K_ASYNC.TL_DISABLE_WARP_SPECIALIZED: True}

VARIANTS = [
    ("baseline (as submitted)", {}),
    ("warp specialised", {K_ASYNC.TL_DISABLE_WARP_SPECIALIZED: False}),
    ("tl async copy", {K_ASYNC.TL_ENABLE_ASYNC_COPY: True}),
    ("tir async copy", {K_ASYNC.TIR_USE_ASYNC_COPY: True}),
    ("both async copy", {K_ASYNC.TL_ENABLE_ASYNC_COPY: True, K_ASYNC.TIR_USE_ASYNC_COPY: True}),
    ("ldg/stg lowering", {K_ASYNC.TL_ENABLE_LOWER_LDGSTG: True}),
    ("ldg/stg predicated", {K_ASYNC.TL_ENABLE_LOWER_LDGSTG: True,
                            K_ASYNC.TL_ENABLE_LOWER_LDGSTG_PREDICATED: True}),
    ("fast math", {K_ASYNC.TL_ENABLE_FAST_MATH: True}),
    ("merge static smem", {K_ASYNC.TIR_MERGE_STATIC_SMEM: True}),
    ("reg usage level 0", {K_ASYNC.TL_PTXAS_REGISTER_USAGE_LEVEL: 0}),
    ("no data race check", {K_ASYNC.TL_DISABLE_DATA_RACE_CHECK: True}),
    ("no safe mem access", {K_ASYNC.TL_DISABLE_SAFE_MEMORY_ACCESS: True}),
    ("vectorize 256", {K_ASYNC.TL_DISABLE_VECTORIZE_256: False}),
    ("async + ldgstg", {K_ASYNC.TL_ENABLE_ASYNC_COPY: True,
                        K_ASYNC.TL_ENABLE_LOWER_LDGSTG: True}),
]


def gemm_func(M, N, K, bm, bn, bk, threads, num_stages, swizzle):
    dtype, accum = T.float16, T.float32

    @T.prim_func
    def kernel(
        a: T.Tensor((M, K), dtype),
        b: T.Tensor((N, K), dtype),
        c: T.Tensor((M, N), dtype),
    ):
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
    print(f"torch.mm reference               {ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s\n")

    # Best tile from gemm_probe.py, plus the tile the MoE stage 1 actually uses.
    tiles = [
        dict(bm=128, bn=128, bk=64, threads=256, num_stages=1, swizzle=8),
        dict(bm=128, bn=256, bk=64, threads=512, num_stages=0, swizzle=8),
    ]
    results = []
    for tile in tiles:
        print(f"--- tile {json.dumps(tile)} ---")
        for label, extra in VARIANTS:
            cfg = dict(BASE)
            cfg.update(extra)
            try:
                kern = tilelang.compile(gemm_func(M, N, K, **tile), out_idx=None, pass_configs=cfg)
                c.zero_()
                kern(a, b, c)
                torch.cuda.synchronize()
                err = float((c.float() - ref.float()).abs().max().item()) / scale
                if err > 2e-2:
                    print(f"  {label:26} WRONG err={err:.2e}")
                    continue
                ms = time_fn(lambda: kern(a, b, c), 3, 10)
                results.append((ms, label, tile))
                print(f"  {label:26} {ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s")
            except Exception as exc:
                print(f"  {label:26} FAIL {str(exc).splitlines()[0][:70]}")
            finally:
                torch.cuda.empty_cache()

    print("\n=== top 8 ===")
    for ms, label, tile in sorted(results, key=lambda r: r[0])[:8]:
        print(f"{ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s  {label}  {json.dumps(tile)}")


if __name__ == "__main__":
    main()
