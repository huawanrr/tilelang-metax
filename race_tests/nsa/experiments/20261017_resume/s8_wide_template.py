@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_online_packed_wide_mathcast(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2,
    dual_acc=False, prefetch_depth=1,
):
    PAIR = 2
    ACC = 2
    assert groups == 16 and dim == 64 and block_size == 16
    assert selected_blocks == 8 and threads == 64
    G, BS, S, D = groups, block_size, selected_blocks, dim
    H = heads // G
    N = PAIR * BS
    q_shape = [batch, seq_len, heads, D]
    k_shape = [batch, T.ceildiv(seq_len, BS), H, D // 32, 1, 64, 8]
    v_shape = [batch, T.ceildiv(seq_len, BS), H, 1, D // 32, 64, 8]
    qk, pv = _emitters("float16", "float32", N, D)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(k_shape, T.float16),
        V: T.Tensor(v_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, H, S], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(batch * H, 1, seq_len, threads=threads) as (bh, by, t):
            b, h = bh // H, bh % H
            lane = T.get_thread_binding()
            qr = T.alloc_fragment([G, D], T.float16)
            kr = T.alloc_fragment([N, D], T.float16)
            vr = T.alloc_fragment([N, D], T.float16)
            scores = T.alloc_fragment([G, N], T.float32)
            probs = T.alloc_fragment([G, N], T.float16)
            sums = T.alloc_fragment([G, BS], T.float32)
            den = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            out = T.alloc_fragment([G, D], T.float32)
            out_1 = T.alloc_fragment([G, D], T.float32)
            out_2 = T.alloc_fragment([G, D], T.float32)
            out_3 = T.alloc_fragment([G, D], T.float32)
            indices = T.alloc_local([S], T.int32)
            starts = T.alloc_local([PAIR], T.int32)
            T.annotate_layout({
                qr: qk.make_mma_load_layout(qr, "A"),
                kr: qk.make_mma_load_layout(kr, "B"),
                vr: pv.make_mma_load_layout(vr, "B"),
                scores: qk.make_mma_store_layout(scores),
                probs: pv.make_mma_load_layout(probs, "A"),
                sums: T.Fragment([G, BS],
                    forward_thread_fn=lambda i, j: i + j // 4 * 16,
                    forward_index_fn=lambda i, j: j % 4),
                out: pv.make_mma_store_layout(out),
                out_1: pv.make_mma_store_layout(out_1),
                out_2: pv.make_mma_store_layout(out_2),
                out_3: pv.make_mma_store_layout(out_3),
            })
            for si in T.unroll(S):
                raw_index = BlockIndices[b, t, h, si]
                indices[si] = T.min(T.max(raw_index, -1), T.ceildiv(seq_len, BS)) * BS
            T.copy(Q[b, t, h * G:(h + 1) * G, :], qr)
            T.clear(sums)
            T.clear(out)
            T.clear(out_1)
            if ACC == 4:
                T.clear(out_2)
                T.clear(out_3)
            for group in T.serial(S // PAIR):
                for p in T.unroll(PAIR):
                    starts[p] = indices[group * PAIR + p]
                for kc in T.unroll(D // 32):
                    for p in T.unroll(PAIR):
                        pos = starts[p]
                        if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                            for e in T.vectorized(8):
                                kr[p * BS + lane % 16, kc * 32 + lane // 16 * 8 + e] = K[
                                    b, pos // BS, h, kc, 0, lane, e]
                        else:
                            for e in T.vectorized(8):
                                kr[p * BS + lane % 16, kc * 32 + lane // 16 * 8 + e] = 0
                for p in T.unroll(PAIR):
                    pos = starts[p]
                    if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                        if is_causal and pos + BS > t + 1:
                            for i, j in T.Parallel(G, BS):
                                scores[i, p * BS + j] = T.if_then_else(pos + j <= t, 0, -T.infinity(T.float32))
                        elif (not is_causal) and pos + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                scores[i, p * BS + j] = T.if_then_else(pos + j < seq_len, 0, -T.infinity(T.float32))
                        else:
                            for i, j in T.Parallel(G, BS):
                                scores[i, p * BS + j] = 0
                    else:
                        for i, j in T.Parallel(G, BS):
                            scores[i, p * BS + j] = -T.infinity(T.float32)
                for ki in T.serial(D // 32):
                    qk.mma(qr, kr, scores, ki)
                for p in T.unroll(PAIR):
                    pos = starts[p]
                    if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                        for vc in T.unroll(D // 32):
                            for e in T.vectorized(8):
                                vr[p * BS + lane // 16 * 4 + e % 4, vc * 32 + e // 4 * 16 + lane % 16] = V[
                                    b, pos // BS, h, 0, vc, lane, e]
                    else:
                        for vc in T.unroll(D // 32):
                            for e in T.vectorized(8):
                                vr[p * BS + lane // 16 * 4 + e % 4, vc * 32 + e // 4 * 16 + lane % 16] = 0
                for p in T.unroll(PAIR):
                    pos = starts[p]
                    if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                scores[i, p * BS + j] = T.exp(T.min(scores[i, p * BS + j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                scores[i, p * BS + j] = T.if_then_else(
                                    pos + j < seq_len and (not is_causal or pos + j <= t),
                                    T.exp(T.min(scores[i, p * BS + j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sums[i, j] += scores[i, p * BS + j]
                        for ce in T.unroll(4):
                            probs[lane % 16, p * BS + lane // 16 * 4 + ce] = scores[lane % 16, p * BS + lane // 16 * 4 + ce]
                    else:
                        for ce in T.unroll(4):
                            probs[lane % 16, p * BS + lane // 16 * 4 + ce] = 0
                for p in T.unroll(PAIR):
                    pos = starts[p]
                    if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                        if (group * PAIR + p) % ACC == 0:
                            pv.mma(probs, vr, out, p)
                        elif (group * PAIR + p) % ACC == 1:
                            pv.mma(probs, vr, out_1, p)
                        elif (group * PAIR + p) % ACC == 2:
                            pv.mma(probs, vr, out_2, p)
                        else:
                            pv.mma(probs, vr, out_3, p)
            for i, d in T.Parallel(G, D):
                out[i, d] += out_1[i, d]
                if ACC == 4:
                    out[i, d] += out_2[i, d]
                    out[i, d] += out_3[i, d]
            T.reduce_sum(sums, den, dim=1, clear=True)
            for i in T.Parallel(G):
                inv[i] = T.if_then_else(den[i] > 0, 1.0 / den[i], 0.0)
            for i, d in T.Parallel(G, D):
                out[i, d] *= inv[i]
            O_reg = T.alloc_fragment([G, D], T.float16)
            O_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({
                O_reg: T.Fragment([G, D],
                    forward_thread_fn=lambda i, d: i + (d % 16 // 4) * 16,
                    forward_index_fn=lambda i, d: d // 16 * 4 + d % 4),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            for cc in T.unroll(D // 16):
                for ce in T.unroll(4):
                    O_reg[lane % 16, cc * 16 + lane // 16 * 4 + ce] = out[lane % 16, cc * 16 + lane // 16 * 4 + ce]
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[b, t, h * G:(h + 1) * G, :])
    return kernel
