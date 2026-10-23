"""Dissect the per-iteration cost of the MLA main loop.

One CTA loops over 2048 KV blocks; variants strip pieces of the body.
Output is garbage for stripped variants -- timing only.
"""
import os
import statistics
import sys

import torch
import tilelang
import tilelang.language as T

PROBE = os.environ.get('PROBE', 'full')


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    }
)
def probe(batch, heads, kv_head_num, seqlen_kv, dim, pe_dim, block_N, block_H, softmax_scale):
    scale = float(softmax_scale * 1.44269504)
    dtype = T.float16
    accum_dtype = T.float32
    valid_block_h = block_H
    total_kv_blocks = seqlen_kv // block_N

    @T.prim_func
    def main(
        Q: T.Tensor([batch, heads, dim], dtype),
        Q_pe: T.Tensor([batch, heads, pe_dim], dtype),
        KV: T.Tensor([batch, seqlen_kv, kv_head_num, dim], dtype),
        K_pe: T.Tensor([batch, seqlen_kv, kv_head_num, pe_dim], dtype),
        Output: T.Tensor([batch, heads, dim], dtype),
    ):
        with T.Kernel(1, 1, 1, threads=128) as (bid, hid, split_id):
            Q_shared = T.alloc_shared([block_H, dim], dtype)
            Q_pe_shared = T.alloc_shared([block_H, pe_dim], dtype)
            KV_shared = T.alloc_shared([block_N, dim], dtype)
            K_pe_shared = T.alloc_shared([block_N, pe_dim], dtype)
            S_shared = T.alloc_shared([block_H, block_N], dtype)

            acc_s = T.alloc_fragment([block_H, block_N], accum_dtype)
            acc_o = T.alloc_fragment([block_H, dim], accum_dtype)
            scores_max = T.alloc_fragment([block_H], accum_dtype)
            scores_max_prev = T.alloc_fragment([block_H], accum_dtype)
            scores_scale = T.alloc_fragment([block_H], accum_dtype)
            scores_sum = T.alloc_fragment([block_H], accum_dtype)
            softmax_l = T.alloc_fragment([block_H], accum_dtype)

            T.copy(Q[bid, 0:block_H, :], Q_shared)
            T.copy(Q_pe[bid, 0:block_H, :], Q_pe_shared)
            T.fill(acc_o, 0)
            T.fill(softmax_l, 0)
            T.fill(scores_max, -T.infinity(accum_dtype))

            for k in T.Pipelined(total_kv_blocks, num_stages=0):
                kv_start = k * block_N
                kv_end = kv_start + block_N
                T.copy(KV[bid, kv_start:kv_end, 0, :], KV_shared)
                T.copy(K_pe[bid, kv_start:kv_end, 0, :], K_pe_shared)

                T.clear(acc_s)
                if PROBE != 'noqk':
                    T.gemm(Q_shared, KV_shared, acc_s, transpose_B=True, policy=T.GemmWarpPolicy.FullCol, clear_accum=True)
                    T.gemm(Q_pe_shared, K_pe_shared, acc_s, transpose_B=True, policy=T.GemmWarpPolicy.FullCol)

                if PROBE not in ('nosoftmax', 'nocopy'):
                    for i, j in T.Parallel(block_H, block_N):
                        acc_s[i, j] = T.exp2(acc_s[i, j] * scale)
                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                    for i in T.Parallel(block_H):
                        softmax_l[i] = softmax_l[i] + scores_sum[i]

                if PROBE not in ('nopv', 'nocopy'):
                    T.copy(acc_s, S_shared)
                    T.gemm(S_shared, KV_shared, acc_o, policy=T.GemmWarpPolicy.FullCol)

            for i, j in T.Parallel(block_H, dim):
                Output[bid, 0 + i, j] = acc_o[i, j] + softmax_l[0]

    return main


def latency(fn, repeat=20, samples=5):
    for _ in range(3):
        fn()
    torch.cuda.synchronize()
    graph = torch.cuda.CUDAGraph()
    with torch.cuda.graph(graph):
        for _ in range(repeat):
            fn()
    graph.replay()
    torch.cuda.synchronize()
    times = []
    for _ in range(samples):
        a, b = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
        a.record(); graph.replay(); b.record(); b.synchronize()
        times.append(a.elapsed_time(b) * 1000 / repeat)
    return statistics.median(times)


if __name__ == '__main__':
    b, h, n, d, p = 1, 16, 65536, 512, 64
    bn, bh = 32, 16
    g = torch.Generator(device='cuda').manual_seed(0)
    kw = dict(device='cuda', dtype=torch.float16, generator=g)
    xs = (torch.randn(b, h, d, **kw), torch.randn(b, h, p, **kw),
          torch.randn(b, n, 1, d, **kw), torch.randn(b, n, 1, p, **kw))
    out = torch.empty(b, h, d, device='cuda', dtype=torch.float16)
    kern = probe(b, h, 1, n, d, p, bn, bh, (d + p) ** -0.5)
    iters = n // bn
    us = latency(lambda: kern(*xs, out))
    print(f'PROBE={PROBE:10s} total={us:9.1f} us  iters={iters}  per-iter={us/iters:7.3f} us')
