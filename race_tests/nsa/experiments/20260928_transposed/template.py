@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def single_transposed(B, N, H, D, BS, causal, scale_log2, late=False):
    G = 16
    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True, block_row_warps=1, block_col_warps=1,
        warp_row_tiles=BS, warp_col_tiles=G, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=True, b_transposed=False, block_row_warps=1, block_col_warps=1,
        warp_row_tiles=D, warp_col_tiles=G, chunk=BS, k_pack=1)
    @T.prim_func
    def kernel(Q: T.Tensor([B, N, H * G, D], T.float16),
               K: T.Tensor([B, N, H, D], T.float16),
               V: T.Tensor([B, N, H, D], T.float16),
               Indices: T.Tensor([B, N, H, 1], T.int32),
               Output: T.Tensor([B, N, H * G, D], T.float16)):
        with T.Kernel(N, B * H, threads=64) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            kv = T.alloc_shared([BS, D], T.float16)
            prob = T.alloc_shared([BS, G], T.float16)
            scores = T.alloc_fragment([BS, G], T.float32)
            out = T.alloc_fragment([D, G], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            ka = T.alloc_local([qk.warp_rows * qk.k_pack * qk.local_size_a], T.float16)
            va = T.alloc_local([pv.warp_rows * pv.k_pack * pv.local_size_a], T.float16)
            pb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'B'),
                kv: tilelang.maca.intrinsics.make_mma_swizzle_layout(kv, vecSize=8),
                prob: tilelang.maca.intrinsics.make_mma_swizzle_layout(prob, vecSize=8),
                scores: qk.make_mma_store_layout(scores),
                out: pv.make_mma_store_layout(out),
            })
            b, h = bh // H, bh % H
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            block = Indices[b, token, h, 0]
            start = block * BS
            T.clear(out)
            if block >= 0 and block < T.ceildiv(N, BS) and (not causal or start <= token):
                T.copy(K[b, start:start + BS, h, :], k)
                T.copy(V[b, start:start + BS, h, :], v)
                T.copy(k, kv)
                for j, g in T.Parallel(BS, G):
                    scores[j, g] = T.if_then_else(start + j < N and (not causal or start + j <= token),
                                                  0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.ldmatrix_a(ka, kv, ki)
                    qk.mma(ka, q, scores, ki)
                T.copy(v, kv)
                for j, g in T.Parallel(BS, G):
                    scores[j, g] = T.exp2(T.min(scores[j, g] * scale_log2, 15.0))
                if not late:
                    T.reduce_sum(scores, denom, dim=0, clear=True)
                    for g in T.Parallel(G):
                        inv[g] = T.if_then_else(denom[g] > 0, 1.0 / denom[g], 0.0)
                    for j, g in T.Parallel(BS, G):
                        scores[j, g] *= inv[g]
                T.copy(scores, prob)
                for ki in T.serial(BS // 16):
                    pv.ldmatrix_a(va, kv, ki)
                    pv.ldmatrix_b(pb, prob, ki)
                    pv.mma(va, pb, out, ki)
                if late:
                    T.reduce_sum(scores, denom, dim=0, clear=True)
                    for g in T.Parallel(G):
                        inv[g] = T.if_then_else(denom[g] > 0, 1.0 / denom[g], 0.0)
                    for d, g in T.Parallel(D, G):
                        out[d, g] *= inv[g]
            for d, g in T.Parallel(D, G):
                Output[b, token, h * G + g, d] = out[d, g]
    return kernel
