@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def single_packed_pv(batch, heads, seq_len, dim, is_causal, block_size,
                     groups, scale_log2, threads=64, width=32, late=False):
    G, BS, D = groups, block_size, dim
    H = heads // groups
    W = min(width, D)
    NB = tilelang.cdiv(seq_len, BS)
    qk, _ = _emitters(T.float16, T.float32, BS, D)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=W, chunk=BS, k_pack=1)
    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, W], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, W], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'A'),
                k: qk.make_mma_load_layout(k, 'B'),
                v: pv.make_mma_load_layout(v, 'B'),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
            })
            b, h = bh // H, bh % H
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            block = Indices[b, token, h, 0]
            start = block * BS
            valid = block >= 0 and block < NB and (not is_causal or start <= token)
            if valid:
                for j, d in T.Parallel(BS, D):
                    k[j, d] = K[b, block, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8]
                for j, d in T.Parallel(BS, W):
                    v[j, d] = V[b, block, h, j // 16, d // 32,
                        (j % 16 // 4) * 16 + d % 16,
                        (d % 32 // 16) * 4 + j % 4]
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.if_then_else(
                        start + j < seq_len and (not is_causal or start + j <= token),
                        0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                if not late:
                    T.reduce_sum(scores, denom, dim=1, clear=True)
                    for i in T.Parallel(G):
                        inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] *= inv[i]
                T.copy(scores, prob)
            for vo in T.unroll(D // W):
                T.clear(out)
                if valid:
                    if vo > 0:
                        for j, d in T.Parallel(BS, W):
                            v[j, d] = V[b, block, h, j // 16, vo * (W // 32) + d // 32,
                                (j % 16 // 4) * 16 + d % 16,
                                (d % 32 // 16) * 4 + j % 4]
                    for ki in T.serial(BS // 16):
                        pv.mma(prob, v, out, ki)
                    if late:
                        if vo == 0:
                            T.reduce_sum(scores, denom, dim=1, clear=True)
                            for i in T.Parallel(G):
                                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                        for i, j in T.Parallel(G, W):
                            out[i, j] *= inv[i]
                T.copy(out, Output[b, token, h * G:(h + 1) * G, vo * W:(vo + 1) * W])
    return kernel
