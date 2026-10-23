@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_single_packed_qo_v2_mathcast_block_joint_window_pairs(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    scale_log2, threads=64, width=128, late=False, window=128,
):
    assert groups == 16 and threads == 64 and dim == 128 and block_size == 32
    assert width in (32, 64, 128) and window == 128 and not late
    G, D, BS, W, M = groups, dim, block_size, width, groups * 2
    H = heads // groups
    NB = tilelang.cdiv(seq_len, BS)
    NW = tilelang.cdiv(seq_len, window)
    CAP = min(window, (window + NB + 1) // 2)
    assert NB <= 63
    qk = TensorCoreIntrinEmitter(
        a_dtype="float16", b_dtype="float16", accum_dtype="float32",
        a_transposed=False, b_transposed=True, block_row_warps=1,
        block_col_warps=1, warp_row_tiles=M, warp_col_tiles=BS,
        chunk=D, k_pack=2,
    )
    pv = TensorCoreIntrinEmitter(
        a_dtype="float16", b_dtype="float16", accum_dtype="float32",
        a_transposed=False, b_transposed=False, block_row_warps=1,
        block_col_warps=1, warp_row_tiles=M, warp_col_tiles=W,
        chunk=BS, k_pack=1,
    )

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedKV: T.Tensor([batch, NB, H, 2, D // 32 * (BS // 16), 64, 8], T.float16),
        Schedule: T.Tensor([batch, H, NW, CAP], T.int64),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(CAP, batch * H * NW, threads=64) as (task, bhw):
            q = T.alloc_fragment([M, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            shared_tile = T.alloc_shared([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, W], T.float16)
            scores = T.alloc_fragment([M, BS], T.float32)
            prob = T.alloc_fragment([M, BS], T.float16)
            out = T.alloc_fragment([M, W], T.float32)
            output_reg = T.alloc_fragment([M, D], T.float16)
            denom = T.alloc_fragment([M], T.float32)
            inv = T.alloc_fragment([M], T.float32)
            T.annotate_layout({
                q_stage: T.Fragment([G, D],
                    forward_thread_fn=lambda qi, qd: (qi * D + qd) // 4 % 64,
                    forward_index_fn=lambda qi, qd: (qi * D + qd) // 256 * 4 + qd % 4),
                shared_tile: tilelang.maca.intrinsics.make_mma_swizzle_layout(shared_tile, vecSize=8),
                q: qk.make_mma_load_layout(q, "A"),
                k: qk.make_mma_load_layout(k, "B"),
                v: pv.make_mma_load_layout(v, "B"),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, "A"),
                out: pv.make_mma_store_layout(out),
                output_reg: T.Fragment([M, D],
                    forward_thread_fn=lambda oi, od: oi % G + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: oi // G * (D // 4) + od // 16 * 4 + od % 4),
            })
            b = bhw // (H * NW)
            h = bhw // NW % H
            window_index = bhw % NW
            record = Schedule[b, h, window_index, task]
            block = T.cast((record >> 32) & T.int64(63), "int32")
            first_token = T.min(T.cast(record & T.int64(65535), "int32") - 1, seq_len - 1)
            second_token = T.min(T.cast((record >> 16) & T.int64(65535), "int32") - 1, seq_len - 1)
            if first_token >= 0:
                if block < NB:
                    for query in T.unroll(2):
                        token = T.if_then_else(query == 0, first_token, second_token)
                        if token >= 0:
                            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
                            if query == 0:
                                for j, d in T.Parallel(BS, D):
                                    k[j, d] = PackedKV[b, block, h, 0, d // 32 * (BS // 16) + j // 16, d % 32 // 8 * 16 + j % 16, d % 8]
                            if query > 0:
                                T.sync_warp()
                            T.copy(q_stage, shared_tile)
                            T.sync_warp()
                            for qi, qd in T.Parallel(G, D):
                                q[query * G + qi, qd] = shared_tile[qi, qd]
                        else:
                            for qi, qd in T.Parallel(G, D):
                                q[query * G + qi, qd] = 0
                    start = block * BS
                    for i, j in T.Parallel(M, BS):
                        token_for_row = T.if_then_else(i < G, first_token, second_token)
                        scores[i, j] = T.if_then_else(token_for_row >= 0 and start + j < seq_len and (not is_causal or start + j <= token_for_row), 0.0, -T.infinity(T.float32))
                    for ki in T.serial(D // 32):
                        qk.mma(q, k, scores, ki)
                    for j, d in T.Parallel(BS, W):
                        v[j, d] = PackedKV[b, block, h, 1, j // 16 * (D // 32) + d // 32, j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]
                    if scale_log2 > 0:
                        for i, j in T.Parallel(M, BS):
                            scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                    else:
                        for i, j in T.Parallel(M, BS):
                            token_for_row = T.if_then_else(i < G, first_token, second_token)
                            scores[i, j] = T.if_then_else(token_for_row >= 0 and start + j < seq_len and (not is_causal or start + j <= token_for_row), T.exp2(T.min(scores[i, j] * scale_log2, 15.0)), 0.0)
                    T.reduce_sum(scores, denom, dim=1, clear=True)
                    for i in T.Parallel(M):
                        inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                    for i, j in T.Parallel(M, BS):
                        scores[i, j] *= inv[i]
                    for query in T.unroll(2):
                        for chunk in T.unroll(BS // 16):
                            for element in T.unroll(4):
                                prob[query * G + T.get_thread_binding() % 16, chunk * 16 + T.get_thread_binding() // 16 * 4 + element] = scores[query * G + T.get_thread_binding() % 16, chunk * 16 + T.get_thread_binding() // 16 * 4 + element]
                    for vo in T.unroll(D // W):
                        T.clear(out)
                        if vo > 0:
                            for j, d in T.Parallel(BS, W):
                                v[j, d] = PackedKV[b, block, h, 1, j // 16 * (D // 32) + vo * (W // 32) + d // 32, j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]
                        for ki in T.serial(BS // 16):
                            pv.mma(prob, v, out, ki)
                        for query in T.unroll(2):
                            for chunk in T.unroll(W // 16):
                                for element in T.unroll(4):
                                    output_reg[query * G + T.get_thread_binding() % 16, vo * W + chunk * 16 + T.get_thread_binding() // 16 * 4 + element] = out[query * G + T.get_thread_binding() % 16, chunk * 16 + T.get_thread_binding() // 16 * 4 + element]
                else:
                    T.clear(output_reg)
                for query in T.unroll(2):
                    token = T.if_then_else(query == 0, first_token, second_token)
                    if token >= 0:
                        T.sync_warp()
                        for oi, od in T.Parallel(G, D):
                            shared_tile[oi, od] = output_reg[query * G + oi, od]
                        T.sync_warp()
                        T.copy(shared_tile, Output[b, token, h * G:(h + 1) * G, :])
    return kernel
