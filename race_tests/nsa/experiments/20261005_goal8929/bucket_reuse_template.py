@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_bucket_reuse(batch, heads, seq_len, dim, is_causal,
        block_size, groups, scale_log2, threads=64, scan_tokens=256):
    """Compact each query window by selected block, then reuse register K/V."""
    assert threads == 64 and groups == 16
    G, D, BS, QC = groups, dim, block_size, scan_tokens
    H, NB = heads // groups, tilelang.cdiv(seq_len, block_size)
    qk, pv = _emitters(T.float16, T.float32, BS, D)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, QC), NB + 1, batch * H,
                      threads=threads) as (window, block, bh):
            b, h = bh // H, bh % H
            matches = T.alloc_fragment([QC], T.int32)
            prefix = T.alloc_shared([QC], T.int32)
            tokens = T.alloc_shared([QC], T.int32)
            count = T.alloc_local([1], T.int32)
            for i in T.Parallel(QC):
                token_id = window * QC + i
                raw = T.if_then_else(token_id < seq_len, Indices[b, token_id, h, 0], -1)
                invalid = raw < 0 or raw >= NB or (is_causal and raw > token_id // BS)
                matches[i] = T.if_then_else(token_id < seq_len and
                    T.if_then_else(block < NB,
                        raw == block and (not is_causal or block <= token_id // BS),
                        invalid), 1, 0)
            T.copy(matches, prefix)
            T.sync_warp()
            T.cumsum(prefix)
            T.sync_warp()
            count[0] = prefix[QC - 1]
            for i in T.Parallel(QC):
                if matches[i] != 0:
                    tokens[prefix[i] - 1] = window * QC + i
            T.sync_warp()

            q = T.alloc_fragment([G, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            q_shared = T.alloc_shared([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            output_reg = T.alloc_fragment([G, D], T.float16)
            output_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({
                q_stage: T.Fragment([G, D],
                    forward_thread_fn=lambda qi, qd: (qi * D + qd) // 4 % 64,
                    forward_index_fn=lambda qi, qd: (qi * D + qd) // 256 * 4 + qd % 4),
                q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8),
                output_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8),
                output_reg: T.Fragment([G, D],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                q: qk.make_mma_load_layout(q, 'A'),
                k: qk.make_mma_load_layout(k, 'B'),
                v: pv.make_mma_load_layout(v, 'B'),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
            })
            if count[0] > 0:
                if block < NB:
                    for j, d in T.Parallel(BS, D):
                        k[j, d] = K[b, block, h, d // 32, j // 16,
                            (d % 32 // 8) * 16 + j % 16, d % 8]
                    for j, d in T.Parallel(BS, D):
                        v[j, d] = V[b, block, h, j // 16, d // 32,
                            (j % 16 // 4) * 16 + d % 16,
                            (d % 32 // 16) * 4 + j % 4]
                for task in T.serial(count[0]):
                    token = tokens[task]
                    T.clear(out)
                    if block < NB:
                        T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
                        T.copy(q_stage, q_shared)
                        T.sync_warp()
                        T.copy(q_shared, q)
                        for i, j in T.Parallel(G, BS):
                            scores[i, j] = T.if_then_else(block * BS + j < seq_len
                                and (not is_causal or block * BS + j <= token),
                                0.0, -T.infinity(T.float32))
                        for ki in T.serial(D // 32):
                            qk.mma(q, k, scores, ki)
                        for i, j in T.Parallel(G, BS):
                            scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                        T.reduce_sum(scores, denom, dim=1, clear=True)
                        for i in T.Parallel(G):
                            inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                        for i, j in T.Parallel(G, BS):
                            scores[i, j] *= inv[i]
                        T.copy(scores, prob)
                        for ki in T.serial(BS // 16):
                            pv.mma(prob, v, out, ki)
                    T.copy(out, output_reg)
                    T.sync_warp()
                    T.copy(output_reg, output_shared)
                    T.sync_warp()
                    T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])
                    # Finish reading shared output before the next query reuses it.
                    T.sync_warp()
    return kernel
