@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: MANUAL,
})
def native_sparse_attention_gemm_probe(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
):
    assert threads == 64 and groups == 16 and dim == 64 and block_size == 16
    H, G, D, BS = heads // groups, groups, dim, block_size

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, seq_len, H, D], T.float16),
        V: T.Tensor([batch, seq_len, H, D], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=64) as (t, bh):
            b, h = bh // H, bh % H
            qr = T.alloc_fragment([G, D], T.float16)
            kr = T.alloc_fragment([BS, D], T.float16)
            vr = T.alloc_fragment([BS, D], T.float16)
            qs = T.alloc_shared([G, D], T.float16)
            kv = T.alloc_shared([BS, D], T.float16)
            score = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            sums = T.alloc_fragment([G], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({
                lane_sum: T.Fragment([G, 4],
                    forward_thread_fn=lambda i, j: i + j * 16,
                    forward_index_fn=lambda i, j: 0),
            })
            if PRELOAD:
                T.copy(Q[b, t, h * G:(h + 1) * G, :], qr)
            pos = Indices[b, t, h, 0] * BS
            T.clear(out)
            if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                if not PRELOAD:
                    T.copy(Q[b, t, h * G:(h + 1) * G, :], qr)
                T.copy(K[b, pos:pos + BS, h, :], kr)
                T.copy(V[b, pos:pos + BS, h, :], vr)
                T.copy(qr, qs)
                T.copy(kr, kv)
                if (is_causal and pos + BS <= t + 1) or (not is_causal and pos + BS <= seq_len):
                    T.clear(score)
                else:
                    for i, j in T.Parallel(G, BS):
                        score[i, j] = T.if_then_else(
                            pos + j < seq_len and (not is_causal or pos + j <= t),
                            T.float32(0), -T.infinity(T.float32))
                if MANUAL:
                    SYNC()
                T.gemm(qs, kv, score, transpose_B=True, policy=T.GemmWarpPolicy.FullRow)
                if MANUAL:
                    SYNC()
                if EARLY_V:
                    T.copy(vr, kv)
                for i, j in T.Parallel(G, BS):
                    score[i, j] = T.exp2(T.min(score[i, j] * scale_log2, 15.0))
                if not EARLY_V:
                    T.copy(vr, kv)
                if LANES:
                    for i, l in T.Parallel(G, 4):
                        lane_sum[i, l] = 0
                        for j in T.unroll(4):
                            lane_sum[i, l] += score[i, l * 4 + j]
                    for i, l in T.Parallel(G, 4):
                        lane_sum[i, l] += T.shfl_xor(lane_sum[i, l], 32, 64, 0xffffffffffffffff)
                        lane_sum[i, l] += T.shfl_xor(lane_sum[i, l], 16, 64, 0xffffffffffffffff)
                        lane_sum[i, l] = T.if_then_else(lane_sum[i, l] > 0, 1.0 / lane_sum[i, l], 0.0)
                    for i, j in T.Parallel(G, BS):
                        score[i, j] *= lane_sum[i, j // 4]
                else:
                    T.reduce_sum(score, sums, dim=1, clear=True)
                    for i in T.Parallel(G):
                        sums[i] = T.if_then_else(sums[i] > 0, 1.0 / sums[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        score[i, j] *= sums[i]
                T.copy(score, prob)
                if MANUAL:
                    SYNC()
                T.gemm(prob, kv, out, policy=T.GemmWarpPolicy.FullRow)
            T.copy(out, Output[b, t, h * G:(h + 1) * G, :])
    return kernel
