import os, sys
import torch
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter

_orig_init = TensorCoreIntrinEmitter._initialize_k_pack
def _patched(self, k_pack=None):
    _orig_init(self, 2)
TensorCoreIntrinEmitter._initialize_k_pack = _patched

def make(batch=1, seqlen_kv=2048, dim=512, pe_dim=64, block_N=32, block_H=16, num_split=64):
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
    ):
        with T.Kernel(batch, 1, num_split, threads=128) as (bid, hid, split_id):
            Q_shared = T.alloc_shared([block_H, dim], T.float16)
            Q_pe_shared = T.alloc_shared([block_H, pe_dim], T.float16)
            KV_shared = T.alloc_shared([block_N, dim], T.float16)
            K_pe_shared = T.alloc_shared([block_N, pe_dim], T.float16)
            S_shared = T.alloc_shared([block_H, block_N], T.float16)
            acc_s = T.alloc_fragment([block_H, block_N], T.float32)
            acc_o = T.alloc_fragment([block_H, dim], T.float32)
            scores_sum = T.alloc_fragment([block_H], T.float32)
            softmax_l = T.alloc_fragment([block_H], T.float32)
            T.copy(Q[bid, 0:block_H, :], Q_shared)
            T.copy(Q_pe[bid, 0:block_H, :], Q_pe_shared)
            T.fill(acc_o, 0)
            T.fill(softmax_l, 0)
            for k in T.Pipelined(blocks_per_split, num_stages=num_stages):
                kv_block_id = k * num_split + split_id
                if kv_block_id < total_kv_blocks:
                    kv_start = kv_block_id * block_N
                    T.copy(KV[bid, kv_start:kv_start + block_N, 0, :], KV_shared)
                    T.copy(K_pe[bid, kv_start:kv_start + block_N, 0, :], K_pe_shared)
                    T.clear(acc_s)
                    T.gemm(Q_shared, KV_shared, acc_s, transpose_B=True,
                           policy=T.GemmWarpPolicy.FullCol)          # k_pack=1 (default)
                    T.gemm(Q_pe_shared, K_pe_shared, acc_s, transpose_B=True,
                           policy=T.GemmWarpPolicy.FullCol)
                    for i, j in T.Parallel(block_H, block_N):
                        acc_s[i, j] = T.exp2(acc_s[i, j] * 0.0603)
                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                    for i in T.Parallel(block_H):
                        softmax_l[i] = scores_sum[i]
                    T.copy(acc_s, S_shared)
                    T.gemm(S_shared, KV_shared, acc_o,
                           policy=T.GemmWarpPolicy.FullCol, k_pack=2)   # PV only
            for i, j in T.Parallel(block_H, dim):
                Out[bid, i, j] = (acc_o[i, j] * softmax_l[i]).astype(T.float16)
            Sink[bid] = 1.0
    return kern

if __name__ == '__main__':
    b, n, d, p, bn, bh, ns = 1, 2048, 512, 64, 32, 16, 64
    xs = tuple(torch.randn(*s, device='cuda', dtype=torch.float16,
                generator=torch.Generator(device='cuda').manual_seed(0))
               for s in [(b, bh, d), (b, bh, p), (b, n, 1, d), (b, n, 1, p)])
    sink = torch.zeros(b, device='cuda', dtype=torch.float32)
    outg = torch.zeros(b, bh, d, device='cuda', dtype=torch.float16)
    k = make()
    args = xs + (sink, outg)
    k(*args)
    torch.cuda.synchronize()
    print('PV-only k_pack=2: RUN OK')
    import probe_floor
    us = probe_floor.bench(k, args)
    print(f'level-7 equivalent with PV k_pack=2: {us:.2f} us (baseline 14.33)')
