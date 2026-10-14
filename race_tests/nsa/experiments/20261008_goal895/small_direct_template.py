@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def native_sparse_attention_small_split(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, natural=True, late=False, width=32, qk_k_pack=2):
    """One wave consumes full K/V blocks directly in their MMA layouts."""
    assert threads == 64 and groups == 16 and (block_size == 16)
    assert dim in (32, 64, 128) and seq_len % block_size == 0
    G, BS, D = (groups, block_size, dim)
    W = width
    assert D % W == 0 and W in (16, 32, 64)
    H, NB = (heads // groups, seq_len // block_size)
    qk, _ = _emitters(T.float16, T.float32, BS, D, qk_k_pack=qk_k_pack)
    _, pv = _emitters(T.float16, T.float32, BS, W)

    @T.prim_func
    def kernel(Q: T.Tensor([batch, seq_len, heads, D], T.float16), K: T.Tensor([batch, seq_len, H, D], T.float16), V: T.Tensor([batch, seq_len, H, D], T.float16), Indices: T.Tensor([batch, seq_len, H, 1], T.int32), Output: T.Tensor([batch, seq_len, heads, D], T.float16)):
        with T.Kernel(seq_len, D // W, batch * H, threads=threads) as (token, output_tile, bh):
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, W], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, W], T.float32)
            result = T.alloc_fragment([G, W], T.float16)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({q: qk.make_mma_load_layout(q, 'A'), k: qk.make_mma_load_layout(k, 'B'), v: pv.make_mma_load_layout(v, 'B'), scores: qk.make_mma_store_layout(scores), prob: pv.make_mma_load_layout(prob, 'A'), out: pv.make_mma_store_layout(out), result: pv.make_mma_store_layout(result), lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            K_blocks = T.reshape(K, [batch, NB, BS, H, D])
            V_blocks = T.reshape(V, [batch, NB, BS, H, D])
            b, h = (bh // H, bh % H)
            tid = T.get_thread_binding()
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            block = Indices[b, token, h, 0]
            T.clear(out)
            if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                for j, d in T.Parallel(BS, D):
                    k[j, d] = K_blocks[b, block, j, h, d]
                for j, d in T.Parallel(BS, W):
                    v[j, d] = V_blocks[b, block, j, h, output_tile * W + d]
                T.clear(scores)
                for ki in T.serial(D // (16 * qk_k_pack)):
                    qk.mma(q, k, scores, ki)
                if scale_log2 > 0:
                    for i, j in T.Parallel(G, BS):
                        if natural:
                            scores[i, j] = T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)) * T.if_then_else(block * BS + j >= 0 and block * BS + j < seq_len and (not is_causal or block * BS + j <= token), T.float32(1.0), T.float32(0.0))
                        else:
                            scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0)) * T.if_then_else(block * BS + j >= 0 and block * BS + j < seq_len and (not is_causal or block * BS + j <= token), T.float32(1.0), T.float32(0.0))
                else:
                    for i, j in T.Parallel(G, BS):
                        if natural:
                            scores[i, j] = T.if_then_else(not is_causal or block * BS + j <= token, T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0) * T.if_then_else(block * BS + j >= 0 and block * BS + j < seq_len and (not is_causal or block * BS + j <= token), T.float32(1.0), T.float32(0.0))
                        else:
                            scores[i, j] = T.if_then_else(not is_causal or block * BS + j <= token, T.exp2(T.min(scores[i, j] * scale_log2, 15.0)), 0.0) * T.if_then_else(block * BS + j >= 0 and block * BS + j < seq_len and (not is_causal or block * BS + j <= token), T.float32(1.0), T.float32(0.0))
                if not late:
                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] = 0.0
                        for j in T.unroll(4):
                            lane_sum[i, lane] += scores[i, lane * 4 + j]
                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                        lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                        lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] *= lane_sum[i, j // 4]
                for lane in T.unroll(4):
                    prob[tid % 16, tid // 16 * 4 + lane] = scores[tid % 16, tid // 16 * 4 + lane]
                pv.mma(prob, v, out, 0)
                if late:
                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] = 0.0
                        for j in T.unroll(4):
                            lane_sum[i, lane] += scores[i, lane * 4 + j]
                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                        lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                        lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    for i, j in T.Parallel(G, W):
                        out[i, j] *= lane_sum[i, j % 16 // 4]
            for chunk in T.unroll(W // 16):
                for lane in T.unroll(4):
                    result[tid % 16, chunk * 16 + tid // 16 * 4 + lane] = out[tid % 16, chunk * 16 + tid // 16 * 4 + lane]
            T.copy(result, Output[b, token, h * G:(h + 1) * G, output_tile * W:(output_tile + 1) * W])
    return kernel
