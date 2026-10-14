@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def fused_bucket_attention(B, N, H, D, BS, QT, CQ, causal, scale_log2):
    G = 16
    M = QT * G
    NB = tilelang.cdiv(N, BS)
    qk = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True, block_row_warps=QT, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False, block_row_warps=QT, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=D, chunk=BS, k_pack=1)
    @T.prim_func
    def kernel(Q: T.Tensor([B, N, H * G, D], T.float16),
               K: T.Tensor([B, N, H, D], T.float16),
               V: T.Tensor([B, N, H, D], T.float16),
               Indices: T.Tensor([B, N, H, 1], T.int32),
               Output: T.Tensor([B, N, H * G, D], T.float16)):
        with T.Kernel(NB + 1, T.ceildiv(N, CQ), B * H, threads=QT * 64) as (bucket, tile, bh):
            prefix = T.alloc_shared([CQ], T.int32)
            order = T.alloc_shared([CQ], T.int32)
            mask = T.alloc_fragment([CQ], T.int32)
            q = T.alloc_fragment([M, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            kv = T.alloc_shared([BS, D], T.float16)
            scores = T.alloc_fragment([M, BS], T.float32)
            prob = T.alloc_fragment([M, BS], T.float16)
            out = T.alloc_fragment([M, D], T.float32)
            denom = T.alloc_fragment([M], T.float32)
            kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            T.annotate_layout({q: qk.make_mma_load_layout(q, 'A'),
                kv: tilelang.maca.intrinsics.make_mma_swizzle_layout(kv, vecSize=8),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out)})
            for i in T.Parallel(CQ):
                token = tile * CQ + i
                raw = T.if_then_else(token < N, Indices[bh // H, token, bh % H, 0], -1)
                dest = T.if_then_else(raw >= 0 and raw < NB and (not causal or raw * BS <= token), raw, NB)
                mask[i] = T.if_then_else(token < N and dest == bucket, 1, 0)
            T.copy(mask, prefix)
            T.cumsum(prefix)
            for i in T.Parallel(CQ):
                if mask[i] != 0:
                    order[prefix[i] - 1] = tile * CQ + i
            T.sync_threads()
            count = prefix[CQ - 1]
            wave = T.get_thread_binding() // 64
            if count > 0:
                if bucket < NB:
                    T.copy(K[bh // H, bucket * BS:(bucket + 1) * BS, bh % H, :], k)
                    T.copy(V[bh // H, bucket * BS:(bucket + 1) * BS, bh % H, :], v)
                for group in T.serial(T.ceildiv(count, QT)):
                    token = T.if_then_else(group * QT + wave < count, order[group * QT + wave], 0)
                    T.clear(out)
                    if bucket < NB:
                        for m, d in T.Parallel(M, D):
                            q[m, d] = T.if_then_else(group * QT + m // G < count,
                                Q[bh // H, token, bh % H * G + m % G, d], 0)
                        T.copy(k, kv)
                        for m, j in T.Parallel(M, BS):
                            pos = bucket * BS + j
                            scores[m, j] = T.if_then_else(group * QT + m // G < count
                                and pos < N and (not causal or pos <= token), 0.0, -T.infinity(T.float32))
                        for ki in T.serial(D // 32):
                            qk.ldmatrix_b(kb, kv, ki)
                            qk.mma(q, kb, scores, ki)
                        T.copy(v, kv)
                        for m, j in T.Parallel(M, BS):
                            scores[m, j] = T.exp2(T.min(scores[m, j] * scale_log2, 15.0))
                        T.copy(scores, prob)
                        for ki in T.serial(BS // 16):
                            pv.ldmatrix_b(vb, kv, ki)
                            pv.mma(prob, vb, out, ki)
                        T.reduce_sum(scores, denom, dim=1, clear=True)
                        for m, d in T.Parallel(M, D):
                            out[m, d] *= T.if_then_else(denom[m] > 0, 1.0 / denom[m], 0.0)
                    for m, d in T.Parallel(M, D):
                        if group * QT + m // G < count:
                            Output[bh // H, token, bh % H * G + m % G, d] = out[m, d]
    return kernel
