"""Compute several selected blocks together from freshly packed K/V."""

import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_grouped_packed(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, block_group=2,
    late_v=False, output_stage=True, query_stage=False, batch_minor=True,
):
    assert groups == 16 and threads == 64 and dim == 64 and block_size == 16
    H, G, D, BS = heads // groups, groups, dim, block_size
    S, N = selected_blocks, block_group
    assert S % N == 0
    J = BS * N
    NB = tilelang.cdiv(seq_len, BS)
    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=G, warp_col_tiles=J, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=G, warp_col_tiles=D, chunk=J, k_pack=1)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, S], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(batch * H if batch_minor else seq_len,
                      seq_len if batch_minor else batch * H,
                      threads=threads) as (bx, by):
            token = by if batch_minor else bx
            bh = bx if batch_minor else by
            b, h = bh // H, bh % H
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([J, D], T.float16)
            v = T.alloc_fragment([J, D], T.float16)
            scores = T.alloc_fragment([G, J], T.float32)
            prob = T.alloc_fragment([G, J], T.float16)
            sums = T.alloc_fragment([G, J], T.float32)
            out = T.alloc_fragment([G, D], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            indices = T.alloc_local([S], T.int32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, "A"),
                k: qk.make_mma_load_layout(k, "B"),
                v: pv.make_mma_load_layout(v, "B"),
                scores: qk.make_mma_store_layout(scores),
                sums: qk.make_mma_store_layout(sums),
                prob: pv.make_mma_load_layout(prob, "A"),
                out: pv.make_mma_store_layout(out),
            })
            for si in T.unroll(S):
                indices[si] = Indices[b, token, h, si]
            if query_stage:
                qs = T.alloc_fragment([G, D], T.float16)
                qshared = T.alloc_shared([G, D], T.float16)
                T.annotate_layout({
                    qs: T.Fragment([G, D],
                        forward_thread_fn=lambda qi, qd: (qi * D + qd) // 8 % 64,
                        forward_index_fn=lambda qi, qd: (qi * D + qd) // 512 * 8 + qd % 8),
                    qshared: tilelang.maca.intrinsics.make_mma_swizzle_layout(qshared, vecSize=8),
                })
                T.copy(Q[b, token, h * G:(h + 1) * G, :], qs)
                T.copy(qs, qshared)
                T.sync_warp()
                T.copy(qshared, q)
            else:
                T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            T.clear(out)
            T.clear(sums)
            for chunk in T.serial(S // N):
                for nj in T.unroll(N):
                    block = indices[chunk * N + nj]
                    valid = block >= 0 and block < NB and (not is_causal or block * BS <= token)
                    for j, d in T.Parallel(BS, D):
                        k[nj * BS + j, d] = T.if_then_else(valid,
                            K[b, block, h, d // 32, j // 16,
                              (d % 32 // 8) * 16 + j % 16, d % 8], 0)
                    if not late_v:
                        for j, d in T.Parallel(BS, D):
                            v[nj * BS + j, d] = T.if_then_else(valid,
                                V[b, block, h, j // 16, d // 32,
                                  (j % 16 // 4) * 16 + d % 16,
                                  (d % 32 // 16) * 4 + j % 4], 0)
                    for i, j in T.Parallel(G, BS):
                        pos = block * BS + j
                        scores[i, nj * BS + j] = T.if_then_else(
                            valid and pos < seq_len and (not is_causal or pos <= token),
                            0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
                if late_v:
                    for nj in T.unroll(N):
                        block = indices[chunk * N + nj]
                        valid = block >= 0 and block < NB and (not is_causal or block * BS <= token)
                        for j, d in T.Parallel(BS, D):
                            v[nj * BS + j, d] = T.if_then_else(valid,
                                V[b, block, h, j // 16, d // 32,
                                  (j % 16 // 4) * 16 + d % 16,
                                  (d % 32 // 16) * 4 + j % 4], 0)
                for i, j in T.Parallel(G, J):
                    scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                    sums[i, j] += scores[i, j]
                T.copy(scores, prob)
                for ki in T.serial(J // 16):
                    pv.mma(prob, v, out, ki)
            T.reduce_sum(sums, denom, dim=1, clear=True)
            for i in T.Parallel(G):
                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
            for i, d in T.Parallel(G, D):
                out[i, d] *= inv[i]
            if output_stage:
                os = T.alloc_fragment([G, D], T.float16)
                oshared = T.alloc_shared([G, D], T.float16)
                T.annotate_layout({
                    os: T.Fragment([G, D],
                        forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                        forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                    oshared: tilelang.maca.intrinsics.make_mma_swizzle_layout(oshared, vecSize=8),
                })
                T.copy(out, os)
                if query_stage:
                    T.sync_warp()
                T.copy(os, oshared)
                T.sync_warp()
                T.copy(oshared, Output[b, token, h * G:(h + 1) * G, :])
            else:
                T.copy(out, Output[b, token, h * G:(h + 1) * G, :])
    return kernel
