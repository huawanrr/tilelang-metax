"""Packed BS32: split keys for QK, then split output columns for PV."""

@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_single_packed_qo_v2(
    batch, heads, seq_len, dim, is_causal, block_size,
    groups, scale_log2, threads=64, width=32, late=False,
):
    assert groups == 16 and threads == 64 and dim == 128 and block_size == 32
    G, D, BS, NW = groups, dim, block_size, 2
    H = heads // G
    NB = tilelang.cdiv(seq_len, BS)
    QV = QV_TEMPLATE
    late = LATE_TEMPLATE
    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=1, block_col_warps=NW,
        warp_row_tiles=16, warp_col_tiles=BS // NW, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=NW,
        warp_row_tiles=16, warp_col_tiles=D // NW, chunk=BS, k_pack=1)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=64 * NW) as (token, bh):
            b, h = bh // H, bh % H
            q = T.alloc_fragment([G, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            q_shared = T.alloc_shared([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            prob_shared = T.alloc_shared([G, BS], T.float16)
            denom_shared = T.alloc_shared([G], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            out_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({
                q_stage: T.Fragment([G, D],
                    forward_thread_fn=lambda i, d: (i * D + d) // QV % (64 * NW),
                    forward_index_fn=lambda i, d: (i * D + d) // (64 * NW * QV) * QV + d % QV),
                q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8),
                q: qk.make_mma_load_layout(q, "A"),
                k: qk.make_mma_load_layout(k, "B"),
                scores: qk.make_mma_store_layout(scores),
                prob_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(prob_shared, vecSize=8),
                prob: pv.make_mma_load_layout(prob, "A"),
                v: pv.make_mma_load_layout(v, "B"),
                out: pv.make_mma_store_layout(out),
                out_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(out_shared, vecSize=8),
            })
            raw = Indices[b, token, h, 0]
            valid = raw >= 0 and raw < NB and (not is_causal or raw <= token // BS)
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
            T.copy(q_stage, q_shared)
            T.sync_threads()
            T.copy(q_shared, q)
            T.fill(scores, -T.infinity(T.float32))
            if valid:
                for j, d in T.Parallel(BS, D):
                    k[j, d] = K[b, raw, h, d // 32, j // 16,
                        d % 32 // 8 * 16 + j % 16, d % 8]
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.if_then_else(raw * BS + j < seq_len
                        and (not is_causal or raw * BS + j <= token), 0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
            for i, j in T.Parallel(G, BS):
                scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
            T.reduce_sum(scores, denom, dim=1, clear=True)
            if not late:
                for i in T.Parallel(G):
                    inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] *= inv[i]
            # End Q reads before the allocator can reuse its shared storage.
            T.sync_threads()
            T.copy(scores, prob_shared)
            if late:
                T.copy(denom, denom_shared)
            T.sync_threads()
            T.copy(prob_shared, prob)
            T.clear(out)
            if valid:
                for j, d in T.Parallel(BS, D):
                    v[j, d] = V[b, raw, h, j // 16, d // 32,
                        j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]
                for ki in T.serial(BS // 16):
                    pv.mma(prob, v, out, ki)
            if late:
                for i, d in T.Parallel(G, D):
                    out[i, d] = T.if_then_else(denom_shared[i] > 0, out[i, d] / denom_shared[i], 0.0)
            # Publish both waves' disjoint columns for a coalesced output copy.
            T.sync_threads()
            T.copy(out, out_shared)
            T.sync_threads()
            T.copy(out_shared, Output[b, token, h * G:(h + 1) * G, :])
    return kernel
