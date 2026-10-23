"""Two waves independently compute disjoint sparse blocks, then merge FP32."""

@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_short_waves(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, stage_v=False,
    balanced=False,
):
    assert threads == 64 and groups == 16 and dim == 64 and block_size == 16
    assert selected_blocks in (2, 4) and seq_len % block_size == 0
    G, BS, D, NW = groups, block_size, dim, 2
    M, R = G * NW, selected_blocks // NW
    H, NB = heads // G, seq_len // BS
    qk = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True, block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False, block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=D, chunk=BS, k_pack=1)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, seq_len, H, D], T.float16),
        V: T.Tensor([batch, seq_len, H, D], T.float16),
        Indices: T.Tensor([batch, seq_len, H, selected_blocks], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=128) as (token, bh):
            tid = T.get_thread_binding()
            wave = tid // 64
            lane = tid % 64
            b, h = bh // H, bh % H
            q = T.alloc_fragment([M, D], T.float16)
            k = T.alloc_fragment([NW, BS, D], T.float16)
            v = T.alloc_fragment([NW, BS, D], T.float16)
            v_stage = T.alloc_fragment([NW, BS, D], T.float16)
            v_shared = T.alloc_shared([NW * BS, D], T.float16)
            scores = T.alloc_fragment([M, BS], T.float32)
            prob = T.alloc_fragment([M, BS], T.float16)
            sums = T.alloc_fragment([M, BS], T.float32)
            out = T.alloc_fragment([M, D], T.float32)
            denom = T.alloc_fragment([M], T.float32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, "A"),
                k: T.Fragment([NW, BS, D],
                    forward_thread_fn=lambda w, j, d: w * 64 + d % 32 // 8 * 16 + j % 16,
                    forward_index_fn=lambda w, j, d: (d // 32 * (BS // 16) + j // 16) * 8 + d % 8),
                v: T.Fragment([NW, BS, D],
                    forward_thread_fn=lambda w, j, d: w * 64 + j % 16 // 4 * 16 + d % 16,
                    forward_index_fn=lambda w, j, d: (j // 16 * (D // 32) + d // 32) * 8 + d % 32 // 16 * 4 + j % 4),
                v_stage: T.Fragment([NW, BS, D],
                    forward_thread_fn=lambda w, j, d: w * 64 + (j * D + d) // 8 % 64,
                    forward_index_fn=lambda w, j, d: (j * D + d) // 512 * 8 + d % 8),
                v_shared: T.Layout([NW * BS, D], lambda i, d: i * D + d),
                scores: qk.make_mma_store_layout(scores),
                sums: qk.make_mma_store_layout(sums),
                prob: pv.make_mma_load_layout(prob, "A"),
                out: pv.make_mma_store_layout(out),
            })
            K_blocks = T.reshape(K, [batch, NB, BS, H, D])
            V_blocks = T.reshape(V, [batch, NB, BS, H, D])
            blocks = T.alloc_local([R], T.int32)
            for s in T.unroll(R):
                blocks[s] = Indices[b, token, h, s * NW + wave if balanced else wave * R + s]
            for m, d in T.Parallel(M, D):
                q[m, d] = Q[b, token, h * G + m % G, d]
            T.clear(sums)
            T.clear(out)
            for s in T.unroll(R):
                block = blocks[s]
                if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                    for w, j, d in T.Parallel(NW, BS, D):
                        k[w, j, d] = K_blocks[b, block, j, h, d]
                    if stage_v:
                        for w, j, d in T.Parallel(NW, BS, D):
                            v_stage[w, j, d] = V_blocks[b, block, j, h, d]
                        T.sync_warp()
                        for w, j, d in T.Parallel(NW, BS, D):
                            v_shared[w * BS + j, d] = v_stage[w, j, d]
                        T.sync_warp()
                        for w, j, d in T.Parallel(NW, BS, D):
                            v[w, j, d] = v_shared[w * BS + j, d]
                    else:
                        for w, j, d in T.Parallel(NW, BS, D):
                            v[w, j, d] = V_blocks[b, block, j, h, d]
                    T.clear(scores)
                    for ki in T.serial(D // 32):
                        qk.mma(q, k, scores, ki)
                    for m, j in T.Parallel(M, BS):
                        scores[m, j] = T.exp(T.min(scores[m, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                    if is_causal and block == token // BS:
                        for m, j in T.Parallel(M, BS):
                            scores[m, j] = T.if_then_else(j <= token % BS, scores[m, j], T.float32(0.0))
                    for m, j in T.Parallel(M, BS):
                        sums[m, j] += scores[m, j]
                    for p in T.unroll(4):
                        prob[wave * G + lane % 16, lane // 16 * 4 + p] = scores[wave * G + lane % 16, lane // 16 * 4 + p]
                    pv.mma(prob, v, out, 0)
            T.reduce_sum(sums, denom, dim=1, clear=True)
            partial = T.alloc_shared([M, D], T.float32)
            den_shared = T.alloc_shared([M], T.float32)
            if stage_v:
                T.sync_threads()
            T.copy(out, partial)
            T.copy(denom, den_shared)
            T.sync_threads()
            result = T.alloc_fragment([G, D], T.float16)
            T.annotate_layout({result: T.Fragment([G, D],
                forward_thread_fn=lambda oi, od: (oi * D + od) // 8 % 128,
                forward_index_fn=lambda oi, od: (oi * D + od) // 1024 * 8 + od % 8)})
            for i, d in T.Parallel(G, D):
                total = den_shared[i] + den_shared[G + i]
                result[i, d] = T.if_then_else(total > 0,
                    (partial[i, d] + partial[G + i, d]) / total, T.float32(0.0))
            T.copy(result, Output[b, token, h * G:(h + 1) * G, :])
    return kernel
