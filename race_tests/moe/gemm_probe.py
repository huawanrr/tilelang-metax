#!/usr/bin/env python3
"""How fast can a plain TileLang GEMM be on this device, in the MoE's layout?

The MoE kernel is capped at M=128 per block because routing metadata is emitted
per 128 tokens.  This probe measures the same C[M,N] = A[M,K] @ B[N,K]^T shape
as stage 1 without any routing, so the cost of that cap (and the distance to
torch/cuBLAS) can be separated from the rest of the kernel.

    python gemm_probe.py            # dense weight-layout GEMM sweep
"""
import itertools
import json

import torch
import tilelang
import tilelang.language as T

from local_bench import time_fn

JIT_ARGS = dict(pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
SMEM_LIMIT = 64 * 1024
POLICIES = {"square": T.GemmWarpPolicy.Square, "row": T.GemmWarpPolicy.FullRow,
            "col": T.GemmWarpPolicy.FullCol}


@tilelang.jit(**JIT_ARGS)
def build_gemm(M, N, K, block_m, block_n, block_k, threads, num_stages, swizzle, policy):
    bm, bn, bk = block_m, block_n, block_k
    dtype, accum = T.float16, T.float32
    pol = POLICIES[policy]

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
            if swizzle:
                T.use_swizzle(swizzle)
            T.clear(c_l)
            for k in T.Pipelined(T.ceildiv(K, bk), num_stages=num_stages):
                T.copy(a[bx * bm : (bx + 1) * bm, k * bk : (k + 1) * bk], a_s)
                T.copy(b[by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], b_s)
                T.gemm(a_s, b_s, c_l, transpose_B=True, policy=pol)
            for i, j in T.Parallel(bm, bn):
                c[bx * bm + i, by * bn + j] = c_l[i, j]

    return kernel


def main():
    dev = torch.device("cuda")
    M, N, K = 4096, 2048, 7168  # one expert of the `func_a` stage-1 GEMM
    flops = 2 * M * N * K
    a = torch.randn((M, K), device=dev, dtype=torch.float16) / 8
    b = torch.randn((N, K), device=dev, dtype=torch.float16) / 8
    c = torch.empty((M, N), device=dev, dtype=torch.float16)
    ref = (a.float() @ b.float().t()).half()

    bt = b.t().contiguous()
    ms = time_fn(lambda: torch.mm(a, bt, out=c), 5, 20)
    print(f"torch.mm (B pre-transposed)      {ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s")
    ms = time_fn(lambda: torch.mm(a, b.t(), out=c), 5, 20)
    print(f"torch.mm (B^T view, MoE layout)  {ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s\n")

    results = []
    for bm, bn, bk, th, ns, swz, pol in itertools.product(
        [64, 128, 256], [64, 128, 256], [32, 64, 128], [256, 512], [0, 1, 2, 3], [8], ["square"]
    ):
        if bm * bn < th or (bn * bk + bm * bk) * 2 * max(1, ns) > SMEM_LIMIT:
            continue
        if bm * bn / th > 160:
            continue
        cfg = dict(block_m=bm, block_n=bn, block_k=bk, threads=th, num_stages=ns,
                   swizzle=swz, policy=pol)
        tag = f"bm{bm} bn{bn} bk{bk} t{th} s{ns} z{swz} {pol[:3]}"
        try:
            kern = build_gemm(M, N, K, **cfg)
            c.zero_()
            kern(a, b, c)
            torch.cuda.synchronize()
            err = float((c.float() - ref.float()).abs().max().item()) / float(ref.abs().max().item())
            if err > 2e-2:
                print(f"{tag:36} WRONG err={err:.2e}")
                continue
            ms = time_fn(lambda: kern(a, b, c), 3, 10)
            results.append((ms, cfg))
            print(f"{tag:36} {ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s  err={err:.1e}")
        except Exception as exc:
            print(f"{tag:36} FAIL {str(exc).splitlines()[0][:70]}")
        finally:
            torch.cuda.empty_cache()

    print("\n=== top 10 ===")
    for ms, cfg in sorted(results, key=lambda r: r[0])[:10]:
        print(f"{ms:8.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s  {json.dumps(cfg)}")


if __name__ == "__main__":
    main()
