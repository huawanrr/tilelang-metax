@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_single_multiwave(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    scale_log2, threads=64, natural=False, linear_v=True, warps=2,
):
    """Independent waves reuse one shared region per token.

    Seven wave barriers protect each RAW/WAR transition independently.
    No CTA-wide communication occurs; each wave owns disjoint shared storage.
    """
    assert groups == 16 and threads == 64 and block_size == 16
    assert dim == 64 and seq_len % block_size == 0
    G, BS, D = groups, block_size, dim
    M = warps * G
    H, NB = heads // groups, seq_len // block_size
    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=warps, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=warps, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=D, chunk=BS, k_pack=1)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, seq_len, H, D], T.float16),
        V: T.Tensor([batch, seq_len, H, D], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len // warps, batch * H, threads=64 * warps) as (tile, bh):
            q_stage = T.alloc_fragment([M, D], T.float16)
            q = T.alloc_fragment([M, D], T.float16)
            k = T.alloc_fragment([warps * BS, D], T.float16)
            v = T.alloc_fragment([warps * BS, D], T.float16)
            storage = T.alloc_shared([M * D], T.float16)
            scores = T.alloc_fragment([M, BS], T.float32)
            prob = T.alloc_fragment([M, BS], T.float16)
            out = T.alloc_fragment([M, D], T.float32)
            result = T.alloc_fragment([M, D], T.float16)
            lane_sum = T.alloc_fragment([M, 4], T.float32)
            T.annotate_layout({
                q_stage: T.Fragment([M, D],
                    forward_thread_fn=lambda i, d: i // G * 64 + (i % G * D + d) // 8 % 64,
                    forward_index_fn=lambda i, d: (i % G * D + d) // 512 * 8 + d % 8),
                q: qk.make_mma_load_layout(q, 'A'),
                k: T.Fragment([warps * BS, D],
                    forward_thread_fn=lambda j, d: j // BS * 64 + (j % BS * D + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j % BS * D + d) // 512 * 8 + d % 8),
                v: T.Fragment([warps * BS, D],
                    forward_thread_fn=lambda j, d: j // BS * 64 + (j % BS * D + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j % BS * D + d) // 512 * 8 + d % 8),
                storage: T.Layout([M * D], lambda i: i),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
                result: pv.make_mma_store_layout(result),
                lane_sum: T.Fragment([M, 4],
                    forward_thread_fn=lambda i, j: i // G * 64 + i % G + j * 16,
                    forward_index_fn=lambda i, j: 0),
            })
            K_blocks = T.reshape(K, [batch, NB, BS, H, D])
            V_blocks = T.reshape(V, [batch, NB, BS, H, D])
            kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            b, h = bh // H, bh % H
            thread = T.get_thread_binding()
            wave, tid = thread // 64, thread % 64
            token = tile * warps + wave
            for slot in T.unroll(G * D // 512):
                for e in T.vectorized(8):
                    row = (slot * 512 + tid * 8) // D
                    col = tid % (D // 8) * 8 + e
                    q_stage[wave * G + row, col] = Q[b, token, h * G + row, col]
            block = Indices[b, token, h, 0]
            T.clear(out)
            if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                for slot in T.unroll(BS * D // 512):
                    for word in T.unroll(4):
                        for element in T.vectorized(2):
                            k[wave * BS + (slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = K_blocks[b, block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                for slot in T.unroll(BS * D // 512):
                    for word in T.unroll(4):
                        for element in T.vectorized(2):
                            v[wave * BS + (slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = V_blocks[b, block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                for i, d in T.Parallel(M, D):
                    storage[i * D + (d // 8 ^ i % (D // 8)) * 8 + d % 8] = q_stage[i, d]
                if is_causal and block * BS + BS > token + 1:
                    for i, j in T.Parallel(M, BS):
                        scores[i, j] = T.if_then_else(block * BS + j <= token, 0.0, -T.infinity(T.float32))
                else:
                    T.clear(scores)
                T.sync_warp()
                for i, d in T.Parallel(M, D):
                    q[i, d] = storage[i * D + (d // 8 ^ i % (D // 8)) * 8 + d % 8]
                T.sync_warp()
                for j, d in T.Parallel(warps * BS, D):
                    storage[j * D + (d // 8 ^ j % (D // 8)) * 8 + d % 8] = k[j, d]
                T.sync_warp()
                for ki in T.serial(D // 32):
                    for e in T.vectorized(8):
                        kb[e] = storage[wave * G * D + tid % 16 * D + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ tid % 16 % (D // 8)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                    qk.mma(q, kb, scores, ki)
                T.sync_warp()
                for j, d in T.Parallel(warps * BS, D):
                    if linear_v:
                        storage[j * D + d] = v[j, d]
                    else:
                        storage[j * D + (d // 8 ^ j % (D // 8)) * 8 + d % 8] = v[j, d]
                for i, j in T.Parallel(M, BS):
                    if natural:
                        scores[i, j] = T.if_then_else(not is_causal or block * BS + j <= token,
                            T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                    else:
                        scores[i, j] = T.if_then_else(not is_causal or block * BS + j <= token,
                            T.exp2(T.min(scores[i, j] * scale_log2, 15.0)), 0.0)
                for i, lane in T.Parallel(M, 4):
                    lane_sum[i, lane] = 0.0
                    for j in T.unroll(4):
                        lane_sum[i, lane] += scores[i, lane * 4 + j]
                for i, lane in T.Parallel(M, 4):
                    lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                    lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                    lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                for i, j in T.Parallel(M, BS):
                    scores[i, j] *= lane_sum[i, j // 4]
                for lane in T.unroll(4):
                    prob[wave * G + tid % 16, tid // 16 * 4 + lane] = scores[wave * G + tid % 16, tid // 16 * 4 + lane]
                T.sync_warp()
                for j in T.serial(D // 16):
                    for e in T.serial(4):
                        row = tid // 16 * 4 + e
                        col = j * 16 + tid % 16
                        if linear_v:
                            vb[j * 4 + e] = storage[wave * BS * D + row * D + col]
                        else:
                            vb[j * 4 + e] = storage[wave * BS * D + row * D + (col // 8 ^ row % (D // 8)) * 8 + col % 8]
                pv.mma(prob, vb, out, 0)
            for chunk in T.unroll(D // 16):
                for lane in T.unroll(4):
                    result[wave * G + tid % 16, chunk * 16 + tid // 16 * 4 + lane] = out[wave * G + tid % 16, chunk * 16 + tid // 16 * 4 + lane]
            T.sync_warp()
            for i, d in T.Parallel(M, D):
                storage[i * D + (d // 8 ^ i % (D // 8)) * 8 + d % 8] = result[i, d]
            T.sync_warp()
            for slot in T.unroll(G * D // 512):
                for e in T.vectorized(8):
                    row = (slot * 512 + tid * 8) // D
                    col = tid % (D // 8) * 8 + e
                    Output[b, token, h * G + row, col] = storage[wave * G * D + row * D + (col // 8 ^ row % (D // 8)) * 8 + col % 8]

    return kernel
