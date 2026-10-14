"""Isolate the [32,64] fragment bug: gemm with a T.Parallel acc-init vs T.fill.

The NSA union-tile kernel writes a per-row mask into the [32,64] acc fragment
with T.Parallel before the gemm; even rows come out exact, odd rows wrong.
This probe does exactly that pattern standalone: acc[i,j] = init[i,j] via
T.Parallel, then gemm accumulates onto it.  If the result is wrong at M=32
but right at M=16, tilelang's Parallel-write layout and the gemm accumulator
layout disagree at this size.
"""
import sys

import torch
import tilelang
import tilelang.language as T

sys.path.insert(0, "/data/tilelang-metax/race_tests/nsa")


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def gemm_probe(M, N, K, mode, threads=64):
    @T.prim_func
    def k(A: T.Tensor((M, K), T.float16), B: T.Tensor((N, K), T.float16),
          init: T.Tensor((M, N), T.float32), C: T.Tensor((M, N), T.float32)):
        with T.Kernel(1, threads=threads) as _:
            A_sh = T.alloc_shared([M, K], T.float16)
            B_sh = T.alloc_shared([N, K], T.float16)
            acc = T.alloc_fragment([M, N], T.float32)
            T.copy(A, A_sh)
            T.copy(B, B_sh)
            if mode == "par":
                for i, j in T.Parallel(M, N):
                    acc[i, j] = init[i, j]
            else:
                T.fill(acc, 0)
            T.gemm(A_sh, B_sh, acc, transpose_B=True,
                   policy=T.GemmWarpPolicy.FullRow)
            T.copy(acc, C)

    return k


torch.manual_seed(3)
for (M, N, K) in ((16, 32, 128), (32, 64, 128), (32, 32, 128), (16, 64, 128)):
    for mode in ("fill", "par"):
        k = gemm_probe(M, N, K, mode)
        a = torch.randn(M, K, dtype=torch.float16, device="cuda")
        b = torch.randn(N, K, dtype=torch.float16, device="cuda")
        init = torch.randn(M, N, dtype=torch.float32, device="cuda")
        c = torch.zeros(M, N, dtype=torch.float32, device="cuda")
        k(a, b, init, c)
        ref = a.float() @ b.float().T + init
        err = (c - ref).abs().max().item()
        print(f"M{M} N{N} K{K} {mode:>4}: max_err {err:.4f} {'OK' if err < 0.05 else 'BROKEN'}")
