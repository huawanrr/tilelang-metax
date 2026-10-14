@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_pair_ilp(batch, heads, seq_len, dim, is_causal,
                                   block_size, groups, scale_log2, threads=64,
                                   query_pair=2, width=64):
    """Interleave independent query products, streaming packed operand tiles."""
    assert heads == groups == 16 and dim == 128 and block_size == 32 and threads == 64
    assert query_pair in (1, 2) and seq_len % query_pair == 0
    assert width in (32, 64, 128)
    P, G, D, BS, W = query_pair, groups, dim, block_size, width
    M, NB = P * G, tilelang.cdiv(seq_len, BS)
    qk = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True, block_row_warps=1, block_col_warps=1,
        warp_row_tiles=M, warp_col_tiles=BS, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1,
        warp_row_tiles=M, warp_col_tiles=W, chunk=BS, k_pack=1)
    mma_suffix = qk.mma_suffix

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, G, D], T.float16),
        K: T.Tensor([batch, NB, 1, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, 1, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, 1, 1], T.int32),
        Output: T.Tensor([batch, seq_len, G, D], T.float16),
    ):
        with T.Kernel(seq_len // P, batch, threads=64) as (bx, b):
            token = bx * P
            tid = T.get_thread_binding()
            Q_flat = T.reshape(Q, [batch, seq_len * G, D])
            O_flat = T.reshape(Output, [batch, seq_len * G, D])
            q_stage = T.alloc_fragment([M, D], T.float16)
            q_shared = T.alloc_shared([M, D], T.float16)
            q = T.alloc_fragment([M, D], T.float16)
            kb = T.alloc_local([P * (BS // 16) * 8], T.float16)
            vb = T.alloc_local([P * (W // 16) * 4], T.float16)
            block = T.alloc_local([P], T.int32)
            scores = T.alloc_fragment([M, BS], T.float32)
            prob = T.alloc_fragment([M, BS], T.float16)
            denom = T.alloc_fragment([M], T.float32)
            inv = T.alloc_fragment([M], T.float32)
            out = T.alloc_fragment([M, W], T.float32)
            result = T.alloc_fragment([M, W], T.float16)
            output_shared = T.alloc_shared([M, W], T.float16)
            T.annotate_layout({
                q_stage: T.Fragment([M, D],
                    forward_thread_fn=lambda i, d: (i * D + d) // 8 % 64,
                    forward_index_fn=lambda i, d: (i * D + d) // 512 * 8 + d % 8),
                q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8),
                q: qk.make_mma_load_layout(q, 'A'),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
                result: pv.make_mma_store_layout(result),
                output_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8),
            })
            T.copy(Q_flat[b, token * G:token * G + M, :], q_stage)
            for pi in T.unroll(P):
                block[pi] = Indices[b, token + pi, 0, 0]
            T.copy(q_stage, q_shared)
            T.sync_warp()
            T.copy(q_shared, q)
            T.clear(scores)
            for ki in T.unroll(D // 32):
                T.clear(kb)
                for pi in T.unroll(P):
                    if block[pi] >= 0 and block[pi] < NB and (not is_causal or block[pi] <= (token + pi) // BS):
                        for kj in T.unroll(BS // 16):
                            for e in T.vectorized(8):
                                kb[(pi * (BS // 16) + kj) * 8 + e] = K[b, block[pi], 0, ki, kj, tid, e]
                # Each query row tile consumes only its own selected K tile.
                for kp in T.unroll(2):
                    for pi in T.unroll(P):
                        for kj in T.unroll(BS // 16):
                            T.tvm_mfma(mma_suffix, 'row', 'row', 'float16x4', 'float16x4', 'float32x4',
                                kb.data, (pi * (BS // 16) + kj) * 2 + kp,
                                q.data, ki * P * 2 + pi * 2 + kp,
                                scores.data, pi * (BS // 16) + kj, dtype='float32x4')
            for i, j in T.Parallel(M, BS):
                raw = block[i // G]
                scores[i, j] = T.if_then_else(raw >= 0 and raw < NB and raw * BS + j < seq_len
                    and (not is_causal or raw * BS + j <= token + i // G),
                    T.exp2(T.min(scores[i, j] * scale_log2, 15.0)), T.float32(0.0))
            T.reduce_sum(scores, denom, dim=1, clear=True)
            for i in T.Parallel(M):
                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
            for i, j in T.Parallel(M, BS):
                scores[i, j] *= inv[i]
            for pi in T.unroll(P):
                for chunk in T.unroll(BS // 16):
                    for e in T.unroll(4):
                        prob[pi * G + tid % 16, chunk * 16 + tid // 16 * 4 + e] = scores[pi * G + tid % 16, chunk * 16 + tid // 16 * 4 + e]
            for vo in T.unroll(D // W):
                T.clear(out)
                for ki in T.unroll(BS // 16):
                    T.clear(vb)
                    for pi in T.unroll(P):
                        if block[pi] >= 0 and block[pi] < NB and (not is_causal or block[pi] <= (token + pi) // BS):
                            for vj in T.unroll(W // 32):
                                for e in T.vectorized(8):
                                    vb[pi * (W // 16) * 4 + vj * 8 + e] = V[b, block[pi], 0, ki, vo * (W // 32) + vj, tid, e]
                    for pi in T.unroll(P):
                        for vj in T.unroll(W // 16):
                            T.tvm_mfma(mma_suffix, 'row', 'row', 'float16x4', 'float16x4', 'float32x4',
                                vb.data, pi * (W // 16) + vj,
                                prob.data, ki * P + pi,
                                out.data, pi * (W // 16) + vj, dtype='float32x4')
                for pi in T.unroll(P):
                    for chunk in T.unroll(W // 16):
                        for e in T.unroll(4):
                            result[pi * G + tid % 16, chunk * 16 + tid // 16 * 4 + e] = out[pi * G + tid % 16, chunk * 16 + tid // 16 * 4 + e]
                T.sync_warp()
                T.copy(result, output_shared)
                T.sync_warp()
                T.copy(output_shared, O_flat[b, token * G:token * G + M, vo * W:(vo + 1) * W])
    return kernel
