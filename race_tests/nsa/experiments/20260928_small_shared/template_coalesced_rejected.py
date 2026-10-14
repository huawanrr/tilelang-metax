@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def single_small_shared(B, N, H, D, BS, causal, scale_log2, width=64):
    G, W = 16, width
    qk, _ = _emitters(T.float16, T.float32, BS, D)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=G, warp_col_tiles=W, chunk=BS, k_pack=1)
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
            kv = T.alloc_shared([BS, W], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, W], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'A'),
                k: T.Fragment([BS, D],
                    forward_thread_fn=lambda j, d: (j * D + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * D + d) // 512 * 8 + d % 8),
                v: T.Fragment([BS, D],
                    forward_thread_fn=lambda j, d: (j * D + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * D + d) // 512 * 8 + d % 8),
                kv: tilelang.maca.intrinsics.make_mma_swizzle_layout(kv, vecSize=8),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
                lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16,
                                      forward_index_fn=lambda i, j: 0),
            })
            b, h = bh // H, bh % H
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            block = Indices[b, token, h, 0]
            start = block * BS
            valid = block >= 0 and block < T.ceildiv(N, BS) and (not causal or start <= token)
            if valid:
                T.copy(K[b, start:start + BS, h, :], k)
                T.copy(V[b, start:start + BS, h, :], v)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.if_then_else(start + j < N and (not causal or start + j <= token),
                                                  0.0, -T.infinity(T.float32))
                for kt in T.unroll(D // W):
                    T.copy(k[0:BS, kt * W:(kt + 1) * W], kv)
                    for ki in T.serial(W // 32):
                        qk.ldmatrix_b(kb, kv, ki)
                        qk.mma(q, kb, scores, kt * (W // 32) + ki)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                for i, lane in T.Parallel(G, 4):
                    lane_sum[i, lane] = 0
                    for block_k in T.unroll(BS // 16):
                        for j in T.unroll(4):
                            lane_sum[i, lane] += scores[i, block_k * 16 + lane * 4 + j]
                for i, lane in T.Parallel(G, 4):
                    lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                    lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                    lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                                      1.0 / lane_sum[i, lane], 0.0)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] *= lane_sum[i, j % 16 // 4]
                T.copy(scores, prob)
            for vo in T.unroll(D // W):
                T.clear(out)
                if valid:
                    T.copy(v[0:BS, vo * W:(vo + 1) * W], kv)
                    for ki in T.serial(BS // 16):
                        pv.ldmatrix_b(vb, kv, ki)
                        pv.mma(prob, vb, out, ki)
                T.copy(out, Output[b, token, h * G:(h + 1) * G, vo * W:(vo + 1) * W])
    return kernel
