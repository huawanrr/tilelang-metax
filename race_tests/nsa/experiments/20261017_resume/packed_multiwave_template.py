@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_packed_multiwave(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, width=128, late=False, waves=2, q_vec=4,
):
    assert groups == 16 and threads == 64 and dim == 128 and block_size == 32
    assert not late and width == 128 and waves in (1, 2, 4) and q_vec in (4, 8)
    G, BS, D, W, NW = groups, block_size, dim, width, waves
    MG, H, NB = G * NW, heads // groups, tilelang.cdiv(seq_len, BS)
    qk = TensorCoreIntrinEmitter(
        a_dtype="float16", b_dtype="float16", accum_dtype="float32",
        a_transposed=False, b_transposed=True, block_row_warps=NW,
        block_col_warps=1, warp_row_tiles=G, warp_col_tiles=BS,
        chunk=D, k_pack=2,
    )
    pv = TensorCoreIntrinEmitter(
        a_dtype="float16", b_dtype="float16", accum_dtype="float32",
        a_transposed=False, b_transposed=False, block_row_warps=NW,
        block_col_warps=1, warp_row_tiles=G, warp_col_tiles=W,
        chunk=BS, k_pack=1,
    )

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedKV: T.Tensor([batch, NB, H, 2, D // 32 * (BS // 16), 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, NW), batch * H, threads=64 * NW) as (bx, bh):
            q = T.alloc_fragment([MG, D], T.float16)
            q_stage = T.alloc_fragment([MG, D], T.float16)
            q_shared = T.alloc_shared([MG, D], T.float16)
            output_reg = T.alloc_fragment([MG, D], T.float16)
            output_write = T.alloc_fragment([MG, D], T.float16)
            k = T.alloc_fragment([NW, BS, D], T.float16)
            v = T.alloc_fragment([NW, BS, W], T.float16)
            scores = T.alloc_fragment([MG, BS], T.float32)
            prob = T.alloc_fragment([MG, BS], T.float16)
            out = T.alloc_fragment([MG, W], T.float32)
            denom = T.alloc_fragment([MG], T.float32)
            inv = T.alloc_fragment([MG], T.float32)
            T.annotate_layout({
                q_stage: T.Fragment([MG, D],
                    forward_thread_fn=lambda qi, qd: qi // G * 64 + (qi % G * D + qd) // q_vec % 64,
                    forward_index_fn=lambda qi, qd: (qi % G * D + qd) // (64 * q_vec) * q_vec + qd % q_vec),
                q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8),
                output_reg: T.Fragment([MG, D],
                    forward_thread_fn=lambda oi, od: oi // G * 64 + oi % G + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                output_write: T.Fragment([MG, D],
                    forward_thread_fn=lambda oi, od: oi // G * 64 + (oi % G * D + od) // 8 % 64,
                    forward_index_fn=lambda oi, od: (oi % G * D + od) // 512 * 8 + od % 8),
                q: qk.make_mma_load_layout(q, "A"),
                k: T.Fragment([NW, BS, D],
                    forward_thread_fn=lambda w, j, d: w * 64 + d % 32 // 8 * 16 + j % 16,
                    forward_index_fn=lambda w, j, d: (d // 32 * (BS // 16) + j // 16) * 8 + d % 8),
                v: T.Fragment([NW, BS, W],
                    forward_thread_fn=lambda w, j, d: w * 64 + j % 16 // 4 * 16 + d % 16,
                    forward_index_fn=lambda w, j, d: (j // 16 * (W // 32) + d // 32) * 8 + d % 32 // 16 * 4 + j % 4),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, "A"),
                out: pv.make_mma_store_layout(out),
            })
            b, h = bh // H, bh % H
            token = bx * NW + T.get_thread_binding() // 64
            for i, d in T.Parallel(MG, D):
                q_stage[i, d] = T.if_then_else(
                    bx * NW + i // G < seq_len,
                    Q[b, bx * NW + i // G, h * G + i % G, d], T.float16(0.0))
            block = T.if_then_else(token < seq_len, Indices[b, token, h, 0], -1)
            start = block * BS
            valid = block >= 0 and block < NB and (not is_causal or start <= token)
            if valid:
                for w, j, d in T.Parallel(NW, BS, D):
                    k[w, j, d] = PackedKV[b, block, h, 0, d // 32 * (BS // 16) + j // 16,
                                                 d % 32 // 8 * 16 + j % 16, d % 8]
                T.copy(q_stage, q_shared)
                T.sync_warp()
                T.copy(q_shared, q)
                for i, j in T.Parallel(MG, BS):
                    scores[i, j] = T.if_then_else(
                        start + j < seq_len and (not is_causal or start + j <= token),
                        0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
                for w, j, d in T.Parallel(NW, BS, W):
                    v[w, j, d] = PackedKV[b, block, h, 1, j // 16 * (D // 32) + d // 32,
                                                 j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]
                if scale_log2 > 0:
                    for i, j in T.Parallel(MG, BS):
                        scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                else:
                    for i, j in T.Parallel(MG, BS):
                        scores[i, j] = T.if_then_else(
                            start + j < seq_len and (not is_causal or start + j <= token),
                            T.exp2(T.min(scores[i, j] * scale_log2, 15.0)), 0.0)
                T.reduce_sum(scores, denom, dim=1, clear=True)
                for i in T.Parallel(MG):
                    inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                for i, j in T.Parallel(MG, BS):
                    scores[i, j] *= inv[i]
                for cc in T.unroll(BS // 16):
                    for cl in T.unroll(4):
                        prob[T.get_thread_binding() // 64 * G + T.get_thread_binding() % 16,
                             cc * 16 + T.get_thread_binding() % 64 // 16 * 4 + cl] = scores[
                             T.get_thread_binding() // 64 * G + T.get_thread_binding() % 16,
                             cc * 16 + T.get_thread_binding() % 64 // 16 * 4 + cl]
                T.clear(out)
                for ki in T.serial(BS // 16):
                    pv.mma(prob, v, out, ki)
                for cc in T.unroll(W // 16):
                    for cl in T.unroll(4):
                        output_reg[T.get_thread_binding() // 64 * G + T.get_thread_binding() % 16,
                                   cc * 16 + T.get_thread_binding() % 64 // 16 * 4 + cl] = out[
                                   T.get_thread_binding() // 64 * G + T.get_thread_binding() % 16,
                                   cc * 16 + T.get_thread_binding() % 64 // 16 * 4 + cl]
            else:
                T.clear(output_reg)
            output_shared = T.alloc_shared([MG, D], T.float16)
            T.annotate_layout({output_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)})
            T.sync_warp()
            T.copy(output_reg, output_shared)
            T.sync_warp()
            T.copy(output_shared, output_write)
            for i, d in T.Parallel(MG, D):
                if bx * NW + i // G < seq_len:
                    Output[b, bx * NW + i // G, h * G + i % G, d] = output_write[i, d]
    return kernel
