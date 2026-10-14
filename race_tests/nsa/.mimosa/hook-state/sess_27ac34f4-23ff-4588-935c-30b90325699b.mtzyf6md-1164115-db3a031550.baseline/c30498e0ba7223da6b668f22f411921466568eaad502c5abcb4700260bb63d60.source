"""Decompose the per-CTA critical path of the S==1 kernel on a tiny case.

Measures, under the same CUDA-graph methodology as benchmark_nsa.py:
  empty      -- launch/replay floor, no work
  loads      -- Q/K/V global->shared copies + one barrier
  gemm       -- loads + QK and PV gemms (no softmax, no output)
  softmax    -- loads + gemms + max/exp2/sum + normalize
  out        -- loads + gemms + softmax + fragment->global output copy
  full       -- the real kernel
"""

import json
import statistics

import torch
import tilelang
import tilelang.language as T

import benchmark_nsa as bn
import nsa


def graph_latency(fn, repeat=200, samples=9):
    stream = torch.cuda.Stream()
    stream.wait_stream(torch.cuda.current_stream())
    with torch.cuda.stream(stream):
        for _ in range(5):
            fn()
    stream.synchronize()
    graph = torch.cuda.CUDAGraph()
    with torch.cuda.graph(graph, stream=stream):
        for _ in range(repeat):
            fn()
    graph.replay()
    torch.cuda.synchronize()
    starts = [torch.cuda.Event(enable_timing=True) for _ in range(samples)]
    ends = [torch.cuda.Event(enable_timing=True) for _ in range(samples)]
    for start, end in zip(starts, ends):
        start.record()
        graph.replay()
        end.record()
    ends[-1].synchronize()
    latency = statistics.median(s.elapsed_time(e) / repeat for s, e in zip(starts, ends))
    del graph
    return latency


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def make_variant(batch, seq_len, head_kv, groups, dim, block_size, threads, stage):
    G, BS, B = groups, block_size, batch
    BK = BV = dim
    dtype, accum = T.float16, T.float32

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, head_kv * G, dim], dtype),
        K: T.Tensor([batch, seq_len, head_kv, dim], dtype),
        V: T.Tensor([batch, seq_len, head_kv, dim], dtype),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor([batch, seq_len, head_kv * G, dim], dtype),
    ):
        with T.Kernel(seq_len, 1, batch * head_kv, threads=threads) as (bx, by, bz):
            Q_shared = T.alloc_shared([G, BK], dtype)
            K_shared = T.alloc_shared([BS, BK], dtype)
            V_shared = T.alloc_shared([BS, BV], dtype)
            if stage >= 1:
                acc_s = T.alloc_fragment([G, BS], accum)
                acc_o = T.alloc_fragment([G, BV], accum)
                acc_p = T.alloc_fragment([G, BS], dtype)
            if stage >= 2:
                scores_max = T.alloc_fragment([G], accum)
                scores_sum = T.alloc_fragment([G], accum)
            if stage >= 3:
                acc_s_cast = T.alloc_fragment([G, BS], dtype)

            i_t, i_bh = bx, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS

            if i_s >= 0 and i_s < seq_len:
                T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_shared)
                T.copy(K[i_b, i_s:i_s + BS, i_h, :], K_shared)
                T.copy(V[i_b, i_s:i_s + BS, i_h, :], V_shared)
                if stage >= 1:
                    T.clear(acc_s)
                    T.clear(acc_o)
                    T.fill(acc_p, 0.5)
                    T.gemm(Q_shared, K_shared, acc_s, transpose_B=True, policy=T.GemmWarpPolicy.FullRow)
                    T.gemm(acc_p, V_shared, acc_o, policy=T.GemmWarpPolicy.FullRow)
                if stage >= 2:
                    T.fill(scores_max, -T.infinity(accum))
                    T.reduce_max(acc_s, scores_max, dim=1, clear=True)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.exp2((acc_s[i, j] - scores_max[i]) * 0.1)
                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                if stage >= 3:
                    T.copy(acc_s, acc_s_cast)
                    T.clear(acc_o)
                    T.gemm(acc_s_cast, V_shared, acc_o, policy=T.GemmWarpPolicy.FullRow)
            if stage >= 4:
                T.copy(acc_o, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])

    return kernel


def main():
    torch.manual_seed(0)
    B, T, H, HQ, D, S, BS = 1, 64, 1, 16, 32, 1, 16
    q = torch.randn(B, T, HQ, D, dtype=torch.float16, device="cuda")
    k = torch.randn(B, T, H, D, dtype=torch.float16, device="cuda")
    v = torch.randn(B, T, H, D, dtype=torch.float16, device="cuda")
    idx = torch.zeros(B, T, H, S, dtype=torch.int32, device="cuda")
    out = torch.empty_like(q)

    real = nsa._get_kernel(B, T, H, HQ, D, S, BS, True, 0.1)
    print(f"{'stage':<10} {'us':>7}")
    for stage, name in [(0, "loads"), (1, "gemm"), (2, "softmax"), (3, "pv"), (4, "out")]:
        ker = make_variant(B, T, H, HQ // H, D, BS, 64, stage)
        us = graph_latency(lambda: ker(q, k, v, idx, out)) * 1e3
        print(f"{name:<10} {us:>7.2f}")
    us = graph_latency(lambda: real(q, k, v, idx, out)) * 1e3
    print(f"{'full':<10} {us:>7.2f}")

    empty = torch.empty(1, device="cuda")
    us = graph_latency(lambda: empty.zero_()) * 1e3
    print(f"{'zero_1':<10} {us:>7.2f}  (1-CTA launch floor)")
    big = torch.empty(64, device="cuda")
    us = graph_latency(lambda: big.zero_()) * 1e3
    print(f"{'zero_64':<10} {us:>7.2f}  (64-CTA launch floor)")


if __name__ == "__main__":
    main()
