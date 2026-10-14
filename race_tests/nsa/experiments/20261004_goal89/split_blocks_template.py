"""A template appended to the baseline by make_split_blocks.py."""

@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_split_blocks_packed(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, waves=2, prefetch=2,
):
    assert groups == 16 and dim == 64 and block_size == 16 and threads == 64
    assert selected_blocks % waves == 0 and (selected_blocks // waves) % prefetch == 0
    G, D, BS, NW = groups, dim, block_size, waves
    M = G * NW
    R = selected_blocks // NW
    H = heads // G
    NB = tilelang.cdiv(seq_len, BS)
    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=D, chunk=BS, k_pack=1)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, selected_blocks], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(batch * H, seq_len, threads=threads * NW) as (bh, token):
            b, h = bh // H, bh % H
            wave = T.get_thread_binding() // 64
            q = T.alloc_fragment([M, D], T.float16)
            k0 = T.alloc_fragment([NW, BS, D], T.float16)
            k1 = T.alloc_fragment([NW, BS, D], T.float16)
            v = T.alloc_fragment([NW, BS, D], T.float16)
            scores = T.alloc_fragment([M, BS], T.float32)
            prob = T.alloc_fragment([M, BS], T.float16)
            sums = T.alloc_fragment([M, BS], T.float32)
            out = T.alloc_fragment([M, D], T.float32)
            denom = T.alloc_fragment([M], T.float32)
            inv = T.alloc_fragment([M], T.float32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'A'),
                k0: T.Fragment([NW, BS, D],
                    forward_thread_fn=lambda kw, kj, kd: kw * 64 + kd % 32 // 8 * 16 + kj % 16,
                    forward_index_fn=lambda kw, kj, kd: (kd // 32 * (BS // 16) + kj // 16) * 8 + kd % 8),
                k1: T.Fragment([NW, BS, D],
                    forward_thread_fn=lambda kw, kj, kd: kw * 64 + kd % 32 // 8 * 16 + kj % 16,
                    forward_index_fn=lambda kw, kj, kd: (kd // 32 * (BS // 16) + kj // 16) * 8 + kd % 8),
                v: T.Fragment([NW, BS, D],
                    forward_thread_fn=lambda vw, vj, vd: vw * 64 + vj % 16 // 4 * 16 + vd % 16,
                    forward_index_fn=lambda vw, vj, vd: (vj // 16 * (D // 32) + vd // 32) * 8 + vd % 32 // 16 * 4 + vj % 4),
                scores: qk.make_mma_store_layout(scores),
                sums: qk.make_mma_store_layout(sums),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
            })
            indices = T.alloc_local([R], T.int32)
            for s in T.unroll(R):
                indices[s] = Indices[b, token, h, wave * R + s]
            for m, d in T.Parallel(M, D):
                q[m, d] = Q[b, token, h * G + m % G, d]
            T.clear(out)
            T.clear(sums)
            for group in T.unroll(R // prefetch):
                raw0 = indices[group * prefetch]
                if raw0 >= 0 and raw0 < NB and (not is_causal or raw0 <= token // BS):
                    for w, j, d in T.Parallel(NW, BS, D):
                        k0[w, j, d] = K[b, raw0, h, d // 32, j // 16,
                            d % 32 // 8 * 16 + j % 16, d % 8]
                if prefetch > 1:
                    raw1 = indices[group * prefetch + 1]
                    if raw1 >= 0 and raw1 < NB and (not is_causal or raw1 <= token // BS):
                        for w, j, d in T.Parallel(NW, BS, D):
                            k1[w, j, d] = K[b, raw1, h, d // 32, j // 16,
                                d % 32 // 8 * 16 + j % 16, d % 8]
                for p in T.unroll(prefetch):
                    raw = indices[group * prefetch + p]
                    if raw >= 0 and raw < NB and (not is_causal or raw <= token // BS):
                        for w, j, d in T.Parallel(NW, BS, D):
                            v[w, j, d] = V[b, raw, h, j // 16, d // 32,
                                j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]
                        for m, j in T.Parallel(M, BS):
                            scores[m, j] = T.if_then_else(raw * BS + j < seq_len
                                and (not is_causal or raw * BS + j <= token), 0.0, -T.infinity(T.float32))
                        for ki in T.serial(D // 32):
                            if p == 0:
                                qk.mma(q, k0, scores, ki)
                            else:
                                qk.mma(q, k1, scores, ki)
                        for m, j in T.Parallel(M, BS):
                            scores[m, j] = T.exp2(T.min(scores[m, j] * scale_log2, 15.0))
                            sums[m, j] += scores[m, j]
                        T.copy(scores, prob)
                        pv.mma(prob, v, out, 0)
            T.reduce_sum(sums, denom, dim=1, clear=True)
            for m in T.Parallel(M):
                inv[m] = T.if_then_else(denom[m] > 0, 1.0 / denom[m], 0.0)
            for m, d in T.Parallel(M, D):
                out[m, d] *= inv[m]

            partial = T.alloc_shared([M, D], T.float16)
            denominators = T.alloc_shared([M], T.float32)
            T.copy(out, partial)
            T.copy(denom, denominators)
            T.sync_threads()
            result = T.alloc_fragment([G, D], T.float16)
            T.annotate_layout({result: T.Fragment([G, D],
                forward_thread_fn=lambda oi, od: (oi * D + od) // 8 % (64 * NW),
                forward_index_fn=lambda oi, od: (oi * D + od) // (512 * NW) * 8 + od % 8)})
            for i, d in T.Parallel(G, D):
                # MAKE_SPLIT_BLOCKS_COMBINE
                result[i, d] = T.float16(0)
            T.copy(result, Output[b, token, h * G:(h + 1) * G, :])
    return kernel
