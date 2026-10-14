"""Join selected keys for QK, redistribute probabilities, split PV columns."""

@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_s8_colwaves(
    batch, heads, seq_len, dim, is_causal, block_size,
    groups, selected_blocks, scale_log2, threads=64,
):
    assert groups == 16 and threads == 64 and dim == 64 and block_size == 16 and selected_blocks == 8
    G, D, BS, S, NW = groups, dim, block_size, selected_blocks, NW_TEMPLATE
    N = BS * S
    H = heads // G
    NB = tilelang.cdiv(seq_len, BS)
    q_stage_enabled = QSTAGE_TEMPLATE
    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=1, block_col_warps=NW,
        warp_row_tiles=16, warp_col_tiles=N // NW, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=NW,
        warp_row_tiles=16, warp_col_tiles=D // NW, chunk=N, k_pack=1)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, S], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(batch * H, seq_len, threads=64 * NW) as (bh, token):
            b, h = bh // H, bh % H
            q = T.alloc_fragment([G, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            q_shared = T.alloc_shared([G, D], T.float16)
            k = T.alloc_fragment([N, D], T.float16)
            v = T.alloc_fragment([N, D], T.float16)
            scores = T.alloc_fragment([G, N], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            prob_shared = T.alloc_shared([G, N], T.float16)
            denom_shared = T.alloc_shared([G], T.float32)
            prob = T.alloc_fragment([G, N], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            out_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({
                q_stage: T.Fragment([G, D],
                    forward_thread_fn=lambda i, d: (i * D + d) // 4 % (64 * NW),
                    forward_index_fn=lambda i, d: (i * D + d) // (256 * NW) * 4 + d % 4),
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
            if q_stage_enabled:
                T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
                T.copy(q_stage, q_shared)
                T.sync_threads()
                T.copy(q_shared, q)
            else:
                T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            for j, d in T.Parallel(N, D):
                raw_k = Indices[b, token, h, j // BS]
                k[j, d] = T.if_then_else(raw_k >= 0 and raw_k < NB
                    and (not is_causal or raw_k <= token // BS),
                    K[b, raw_k, h, d // 32, j % BS // 16,
                      d % 32 // 8 * 16 + j % 16, d % 8], T.float16(0))
            for i, j in T.Parallel(G, N):
                raw_s = Indices[b, token, h, j // BS]
                scores[i, j] = T.if_then_else(raw_s >= 0 and raw_s < NB
                    and raw_s * BS + j % BS < seq_len
                    and (not is_causal or raw_s * BS + j % BS <= token),
                    0.0, -T.infinity(T.float32))
            for ki in T.serial(D // 32):
                qk.mma(q, k, scores, ki)
            for i, j in T.Parallel(G, N):
                scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
            T.reduce_sum(scores, denom, dim=1, clear=True)
            T.sync_threads()
            T.copy(scores, prob_shared)
            T.copy(denom, denom_shared)
            T.sync_threads()
            T.copy(prob_shared, prob)
            for j, d in T.Parallel(N, D):
                raw_v = Indices[b, token, h, j // BS]
                v[j, d] = T.if_then_else(raw_v >= 0 and raw_v < NB
                    and (not is_causal or raw_v <= token // BS),
                    V[b, raw_v, h, j % BS // 16, d // 32,
                      j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4], T.float16(0))
            T.clear(out)
            for ki in T.serial(N // 16):
                pv.mma(prob, v, out, ki)
            for i, d in T.Parallel(G, D):
                out[i, d] = T.if_then_else(denom_shared[i] > 0, out[i, d] / denom_shared[i], 0.0)
            T.sync_threads()
            T.copy(out, out_shared)
            T.sync_threads()
            T.copy(out_shared, Output[b, token, h * G:(h + 1) * G, :])
    return kernel
