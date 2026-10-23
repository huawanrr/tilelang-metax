"""Ladder probe: cost of each phase of the main-kernel loop, real streamed loop.

Levels: 0 empty; 1 +Q loads; 2 +KV/Kpe streamed loads; 3 +QK gemms; 4 +exp2;
5 +reduce_sum; 6 +S cast copy; 7 +PV gemm.  min-of-30 graph replay.
"""
import os
import torch
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics import make_mma_swizzle_layout

SWZ = int(os.environ.get('SWZ', '0'))
KPACK = int(os.environ.get('KPACK', '1'))
if KPACK > 1:
    from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter
    TensorCoreIntrinEmitter.k_pack = KPACK


def make(level: int, batch=1, seqlen_kv=2048, dim=512, pe_dim=64,
         block_N=32, block_H=16, num_split=64):
    total_kv_blocks = (seqlen_kv + block_N - 1) // block_N
    blocks_per_split = (total_kv_blocks + num_split - 1) // num_split
    num_stages = 1 if blocks_per_split <= 32 else 0

    @tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True})
    def kern(
        Q: T.Tensor([batch, block_H, dim], T.float16),
        Q_pe: T.Tensor([batch, block_H, pe_dim], T.float16),
        KV: T.Tensor([batch, seqlen_kv, 1, dim], T.float16),
        K_pe: T.Tensor([batch, seqlen_kv, 1, pe_dim], T.float16),
        Sink: T.Tensor([batch], T.float32),
        Out: T.Tensor([batch, block_H, dim], T.float16),
        Out_s: T.Tensor([batch, block_H, block_N], T.float16),
    ):
        with T.Kernel(batch, 1, num_split, threads=128) as (bid, hid, split_id):
            Q_shared = T.alloc_shared([block_H, dim], T.float16)
            Q_pe_shared = T.alloc_shared([block_H, pe_dim], T.float16)
            KV_shared = T.alloc_shared([block_N, dim], T.float16)
            K_pe_shared = T.alloc_shared([block_N, pe_dim], T.float16)
            if level >= 6:
                S_shared = T.alloc_shared([block_H, block_N], T.float16)
            if level >= 3:
                acc_s = T.alloc_fragment([block_H, block_N], T.float32)
            if level >= 7:
                acc_o = T.alloc_fragment([block_H, dim], T.float32)
            if level >= 5:
                scores_sum = T.alloc_fragment([block_H], T.float32)
                softmax_l = T.alloc_fragment([block_H], T.float32)

            if SWZ:
                T.annotate_layout({
                    Q_shared: make_mma_swizzle_layout(Q_shared, vecSize=SWZ),
                    Q_pe_shared: make_mma_swizzle_layout(Q_pe_shared, vecSize=SWZ),
                    KV_shared: make_mma_swizzle_layout(KV_shared, vecSize=SWZ),
                    K_pe_shared: make_mma_swizzle_layout(K_pe_shared, vecSize=SWZ),
                })

            if level >= 1:
                T.copy(Q[bid, 0:block_H, :], Q_shared)
                T.copy(Q_pe[bid, 0:block_H, :], Q_pe_shared)
            if level >= 7:
                T.fill(acc_o, 0)
            if level >= 5:
                T.fill(softmax_l, 0)
            if level >= 2:
                for k in T.Pipelined(blocks_per_split, num_stages=num_stages):
                    kv_block_id = k * num_split + split_id
                    if kv_block_id < total_kv_blocks:
                        kv_start = kv_block_id * block_N
                        T.copy(KV[bid, kv_start:kv_start + block_N, 0, :], KV_shared)
                        T.copy(K_pe[bid, kv_start:kv_start + block_N, 0, :], K_pe_shared)
                        if level >= 3:
                            T.clear(acc_s)
                            T.gemm(Q_shared, KV_shared, acc_s, transpose_B=True,
                                   policy=T.GemmWarpPolicy.FullCol)
                            T.gemm(Q_pe_shared, K_pe_shared, acc_s, transpose_B=True,
                                   policy=T.GemmWarpPolicy.FullCol)
                        if level >= 4:
                            for i, j in T.Parallel(block_H, block_N):
                                acc_s[i, j] = T.exp2(acc_s[i, j] * 0.0603)
                        if level >= 5:
                            T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                            for i in T.Parallel(block_H):
                                softmax_l[i] = scores_sum[i]
                        if level >= 6:
                            T.copy(acc_s, S_shared)
                        if level >= 7:
                            T.gemm(S_shared, KV_shared, acc_o,
                                   policy=T.GemmWarpPolicy.FullCol)
            # sinks
            if level == 0:
                Sink[bid] = 1.0
            elif level == 1:
                Sink[bid] = T.cast(Q_shared[0, 0], T.float32)
            elif level == 2:
                Sink[bid] = T.cast(KV_shared[0, 0], T.float32) + T.cast(K_pe_shared[0, 0], T.float32)
            elif level <= 5:
                for i, j in T.Parallel(block_H, block_N):
                    Out_s[bid, i, j] = acc_s[i, j].astype(T.float16)
                Sink[bid] = 1.0
            elif level == 6:
                Sink[bid] = T.cast(S_shared[0, 0], T.float32)
            else:
                for i, j in T.Parallel(block_H, dim):
                    Out[bid, i, j] = (acc_o[i, j] * softmax_l[i]).astype(T.float16)
                Sink[bid] = 1.0
    return kern


def bench(kern, args, repeat=100, samples=30):
    for _ in range(5):
        kern(*args)
    torch.cuda.synchronize()
    g = torch.cuda.CUDAGraph()
    with torch.cuda.graph(g):
        for _ in range(repeat):
            kern(*args)
    g.replay()
    torch.cuda.synchronize()
    ts = []
    for _ in range(samples):
        a, b = torch.cuda.Event(True), torch.cuda.Event(True)
        a.record(); g.replay(); b.record(); b.synchronize()
        ts.append(a.elapsed_time(b) * 1000 / repeat)
    return min(ts)
