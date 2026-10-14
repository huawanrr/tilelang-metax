def native_sparse_attention_online_packed(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False, prefetch_depth=1,
):
    """Compute several packed selected blocks in one wider QK/PV tile."""
    PAIR = 2
    G, BS, S = groups, block_size, selected_blocks
    H = heads // groups
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    N = BS * PAIR
    q_shape = [batch, seq_len, heads, dim]
    k_shape = [batch, T.ceildiv(seq_len, BS), H, BK // 32, BS // 16, 64, 8]
    v_shape = [batch, T.ceildiv(seq_len, BS), H, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters(T.float16, T.float32, N, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(k_shape, T.float16),
        V: T.Tensor(v_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, H, S], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, 1, batch * H, threads=threads) as (t, by, bh):
            b, h = bh // H, bh % H
            qr = T.alloc_fragment([G, BK], T.float16)
            kr = T.alloc_fragment([N, BK], T.float16)
            vr = T.alloc_fragment([N, BV], T.float16)
            scores = T.alloc_fragment([G, N], T.float32)
            probs = T.alloc_fragment([G, N], T.float16)
            sums = T.alloc_fragment([G, N], T.float32)
            den = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            out = T.alloc_fragment([G, BV], T.float32)
            indices = T.alloc_local([S], T.int32)
            starts = T.alloc_local([PAIR], T.int32)
            T.annotate_layout({
                qr: qk.make_mma_load_layout(qr, "A"),
                kr: qk.make_mma_load_layout(kr, "B"),
                vr: pv.make_mma_load_layout(vr, "B"),
                scores: qk.make_mma_store_layout(scores),
                probs: pv.make_mma_load_layout(probs, "A"),
                out: pv.make_mma_store_layout(out),
            })
            T.copy(Q[b, t, h * G:(h + 1) * G, :], qr)
            for si in T.unroll(S):
                indices[si] = BlockIndices[b, t, h, si] * BS
            T.clear(out)
            T.clear(sums)
            for group in T.serial(T.ceildiv(S, PAIR)):
                for p in T.unroll(PAIR):
                    starts[p] = T.if_then_else(group * PAIR + p < S,
                        indices[T.min(group * PAIR + p, S - 1)], -BS)
                for j, d in T.Parallel(N, BK):
                    pos = starts[j // BS]
                    kr[j, d] = T.if_then_else(
                        pos >= 0 and pos < seq_len and (not is_causal or pos <= t),
                        K[b, pos // BS, h, d // 32, j % BS // 16,
                          (d % 32 // 8) * 16 + j % 16, d % 8], 0)
                for j, d in T.Parallel(N, BV):
                    pos = starts[j // BS]
                    vr[j, d] = T.if_then_else(
                        pos >= 0 and pos < seq_len and (not is_causal or pos <= t),
                        V[b, pos // BS, h, j % BS // 16, d // 32,
                          (j % 16 // 4) * 16 + d % 16,
                          (d % 32 // 16) * 4 + j % 4], 0)
                for i, j in T.Parallel(G, N):
                    pos = starts[j // BS] + j % BS
                    scores[i, j] = T.if_then_else(
                        pos >= 0 and pos < seq_len and (not is_causal or pos <= t),
                        0, -T.infinity(T.float32))
                for ki in T.serial(qk_steps):
                    qk.mma(qr, kr, scores, ki)
                for i, j in T.Parallel(G, N):
                    scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                    sums[i, j] += scores[i, j]
                T.copy(scores, probs)
                for ki in T.serial(pv_steps):
                    pv.mma(probs, vr, out, ki)
            T.reduce_sum(sums, den, dim=1, clear=True)
            for i in T.Parallel(G):
                inv[i] = T.if_then_else(den[i] > 0, 1.0 / den[i], 0.0)
            for i, d in T.Parallel(G, BV):
                out[i, d] *= inv[i]
            T.copy(out, Output[b, t, h * G:(h + 1) * G, :])
    return kernel
