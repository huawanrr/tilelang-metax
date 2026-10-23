@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_s8_wave_pipeline(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2,
    dual_acc=False, prefetch_depth=1,
):
    DEPTH = 2
    ACC = 2
    assert groups == 16 and dim == 64 and block_size == 16
    assert selected_blocks == 8 and threads == 64
    G, BS, S, D = groups, block_size, selected_blocks, dim
    H = heads // G
    GROUPS = S // DEPTH
    q_shape = [batch, seq_len, heads, D]
    k_shape = [batch, T.ceildiv(seq_len, BS), H, D // 32, 1, 64, 8]
    v_shape = [batch, T.ceildiv(seq_len, BS), H, 1, D // 32, 64, 8]
    qk, pv = _emitters("float16", "float32", BS, D)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(k_shape, T.float16),
        V: T.Tensor(v_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, H, S], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(batch * H, 1, seq_len, threads=128) as (bh, by, t):
            b, h = bh // H, bh % H
            tid = T.get_thread_binding()
            lane, role = tid % 64, tid // 64
            qr = T.alloc_local([16], T.float16)
            kr = T.alloc_local([DEPTH * 16], T.float16)
            vr = T.alloc_local([16], T.float16)
            scores = T.alloc_local([4], T.float32)
            probs = T.alloc_local([4], T.float16)
            sums = T.alloc_local([4], T.float32)
            den = T.alloc_local([1], T.float32)
            out = T.alloc_local([16], T.float32)
            out_1 = T.alloc_local([16], T.float32)
            out_2 = T.alloc_local([16], T.float32)
            out_3 = T.alloc_local([16], T.float32)
            oreg = T.alloc_local([16], T.float16)
            indices = T.alloc_local([S], T.int32)
            weights_shared = T.alloc_shared([2, DEPTH, 64, 4], T.float16)
            inv_shared = T.alloc_shared([64], T.float32)
            output_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({
                output_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8),
            })
            for si in T.unroll(S):
                raw_index = BlockIndices[b, t, h, si]
                indices[si] = T.min(T.max(raw_index, -1), T.ceildiv(seq_len, BS)) * BS
            if role == 0:
                for kc in T.unroll(2):
                    for e in T.vectorized(8):
                        qr[kc * 8 + e] = Q[b, t, h * G + lane % 16, kc * 32 + lane // 16 * 8 + e]
                T.clear(sums)
            else:
                T.clear(out)
                T.clear(out_1)
                if ACC == 4:
                    T.clear(out_2)
                    T.clear(out_3)
            for step in T.serial(GROUPS + 1):
                if role == 0 and step < GROUPS:
                    for p in T.unroll(DEPTH):
                        pos = indices[T.min(step * DEPTH + p, S - 1)]
                        if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                            for kc in T.unroll(2):
                                for e in T.vectorized(8):
                                    kr[p * 16 + kc * 8 + e] = K[b, pos // BS, h, kc, 0, lane, e]
                    for p in T.unroll(DEPTH):
                        pos = indices[T.min(step * DEPTH + p, S - 1)]
                        if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                            if is_causal and pos + BS > t + 1:
                                for ce in T.unroll(4):
                                    scores[ce] = T.if_then_else(pos + lane // 16 * 4 + ce <= t, 0, -T.infinity(T.float32))
                            elif (not is_causal) and pos + BS > seq_len:
                                for ce in T.unroll(4):
                                    scores[ce] = T.if_then_else(pos + lane // 16 * 4 + ce < seq_len, 0, -T.infinity(T.float32))
                            else:
                                T.clear(scores)
                            for ki in T.unroll(4):
                                T.tvm_mfma(qk.mma_suffix, "row", "row", "float16x4", "float16x4", "float32x4",
                                    kr.data, p * 4 + ki, qr.data, ki, scores.data, 0, dtype="float32x4")
                            if scale_log2 > 0:
                                for ce in T.unroll(4):
                                    scores[ce] = T.exp(T.min(scores[ce] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                            else:
                                for ce in T.unroll(4):
                                    scores[ce] = T.if_then_else(
                                        pos + lane // 16 * 4 + ce < seq_len and (not is_causal or pos + lane // 16 * 4 + ce <= t),
                                        T.exp(T.min(scores[ce] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                            for ce in T.unroll(4):
                                sums[ce] += scores[ce]
                                probs[ce] = scores[ce]
                        else:
                            T.clear(probs)
                        for ce in T.vectorized(4):
                            weights_shared[step % 2, p, lane, ce] = probs[ce]
                if role == 1 and step > 0:
                    for p in T.unroll(DEPTH):
                        slot = T.max(step - 1, 0) * DEPTH + p
                        pos = indices[T.min(slot, S - 1)]
                        if pos >= 0 and pos < seq_len and (not is_causal or pos <= t):
                            for vc in T.unroll(2):
                                for e in T.vectorized(8):
                                    vr[vc * 8 + e] = V[b, pos // BS, h, 0, vc, lane, e]
                            for ce in T.vectorized(4):
                                probs[ce] = weights_shared[(step - 1) % 2, p, lane, ce]
                            for col in T.unroll(4):
                                if slot % ACC == 0:
                                    T.tvm_mfma(pv.mma_suffix, "row", "row", "float16x4", "float16x4", "float32x4",
                                        vr.data, col, probs.data, 0, out.data, col, dtype="float32x4")
                                elif slot % ACC == 1:
                                    T.tvm_mfma(pv.mma_suffix, "row", "row", "float16x4", "float16x4", "float32x4",
                                        vr.data, col, probs.data, 0, out_1.data, col, dtype="float32x4")
                                elif slot % ACC == 2:
                                    T.tvm_mfma(pv.mma_suffix, "row", "row", "float16x4", "float16x4", "float32x4",
                                        vr.data, col, probs.data, 0, out_2.data, col, dtype="float32x4")
                                else:
                                    T.tvm_mfma(pv.mma_suffix, "row", "row", "float16x4", "float16x4", "float32x4",
                                        vr.data, col, probs.data, 0, out_3.data, col, dtype="float32x4")
                # Completes current writes/reads before next iteration's
                # opposite ring slot is consumed/reused. Both waves arrive.
                T.sync_threads()
            if role == 0:
                den[0] = 0
                for ce in T.unroll(4):
                    den[0] += sums[ce]
                den[0] = den[0] + T.shfl_xor(den[0], 32, 64, 18446744073709551615)
                den[0] = den[0] + T.shfl_xor(den[0], 16, 64, 18446744073709551615)
                den[0] = T.if_then_else(den[0] > 0, 1.0 / den[0], 0.0)
                inv_shared[lane] = den[0]
            T.sync_threads()
            if role == 1:
                den[0] = inv_shared[lane]
                for ce in T.unroll(16):
                    out[ce] += out_1[ce]
                    if ACC == 4:
                        out[ce] += out_2[ce]
                        out[ce] += out_3[ce]
                    out[ce] *= den[0]
                    oreg[ce] = out[ce]
                for cc in T.unroll(4):
                    for ce in T.vectorized(4):
                        output_shared[lane % 16, cc * 16 + lane // 16 * 4 + ce] = oreg[cc * 4 + ce]
                T.sync_warp()
                for oc in T.unroll(2):
                    for e in T.vectorized(8):
                        flat = oc * 512 + lane * 8 + e
                        Output[b, t, h * G + flat // D, flat % D] = output_shared[flat // D, flat % D]
    return kernel
