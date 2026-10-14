@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_grouped_direct(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, output_stage=False,
    early_v=False, joined_blocks=2, batch_minor=False, shared_vec=4,
):
    assert groups == 16 and dim == 64 and block_size == 16 and threads == 64
    G, D, BS, S = groups, dim, block_size, selected_blocks
    H = heads // G
    assert S % joined_blocks == 0
    N = joined_blocks * BS
    NB = tilelang.cdiv(seq_len, BS)
    qk, pv = _emitters(T.float16, T.float32, N, D)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, seq_len, H, D], T.float16),
        V: T.Tensor([batch, seq_len, H, D], T.float16),
        Indices: T.Tensor([batch, seq_len, H, S], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(batch * H if batch_minor else seq_len,
                      seq_len if batch_minor else batch * H, threads=threads) as (bx, by):
            token = by if batch_minor else bx
            bh = bx if batch_minor else by
            b, h = bh // H, bh % H
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([N, D], T.float16)
            v = T.alloc_fragment([N, D], T.float16)
            v_stage = T.alloc_fragment([N, D], T.float16)
            v_shared = T.alloc_shared([N, D], T.float16)
            scores = T.alloc_fragment([G, N], T.float32)
            sums = T.alloc_fragment([G, N], T.float32)
            prob = T.alloc_fragment([G, N], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'A'),
                k: qk.make_mma_load_layout(k, 'B'),
                v: pv.make_mma_load_layout(v, 'B'),
                v_stage: T.Fragment([N, D],
                    forward_thread_fn=lambda vj, vd: (vj * D + vd) // 8 % 64,
                    forward_index_fn=lambda vj, vd: (vj * D + vd) // 512 * 8 + vd % 8),
                v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=shared_vec),
                scores: qk.make_mma_store_layout(scores),
                sums: qk.make_mma_store_layout(sums),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
            })
            indices = T.alloc_local([S], T.int32)
            for s in T.unroll(S):
                indices[s] = Indices[b, token, h, s]
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            T.clear(out)
            T.clear(sums)
            for group in T.serial(S // joined_blocks):
                for j, d in T.Parallel(N, D):
                    raw = indices[group * joined_blocks + j // BS]
                    k[j, d] = T.if_then_else(
                        raw >= 0 and raw < NB and raw * BS + j % BS < seq_len
                        and (not is_causal or raw <= token // BS),
                        K[b, raw * BS + j % BS, h, d],
                        T.float16(0))
                if early_v:
                    for j, d in T.Parallel(N, D):
                        raw = indices[group * joined_blocks + j // BS]
                        v_stage[j, d] = T.if_then_else(
                            raw >= 0 and raw < NB and raw * BS + j % BS < seq_len
                            and (not is_causal or raw <= token // BS),
                            V[b, raw * BS + j % BS, h, d], T.float16(0))
                    T.sync_warp()
                    T.copy(v_stage, v_shared)
                    T.sync_warp()
                    T.copy(v_shared, v)
                for i, j in T.Parallel(G, N):
                    raw = indices[group * joined_blocks + j // BS]
                    scores[i, j] = T.if_then_else(
                        raw >= 0 and raw < NB and raw * BS + j % BS < seq_len
                        and (not is_causal or raw * BS + j % BS <= token),
                        T.float32(0), -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
                if not early_v:
                    for j, d in T.Parallel(N, D):
                        raw = indices[group * joined_blocks + j // BS]
                        v_stage[j, d] = T.if_then_else(
                            raw >= 0 and raw < NB and raw * BS + j % BS < seq_len
                            and (not is_causal or raw <= token // BS),
                            V[b, raw * BS + j % BS, h, d], T.float16(0))
                    T.sync_warp()
                    T.copy(v_stage, v_shared)
                    T.sync_warp()
                    T.copy(v_shared, v)
                for i, j in T.Parallel(G, N):
                    scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                for i, j in T.Parallel(G, N):
                    sums[i, j] += scores[i, j]
                T.copy(scores, prob)
                for ki in T.serial(N // 16):
                    pv.mma(prob, v, out, ki)
            T.reduce_sum(sums, denom, dim=1, clear=True)
            for i in T.Parallel(G):
                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
            for i, d in T.Parallel(G, D):
                out[i, d] *= inv[i]
            if output_stage:
                out_half = T.alloc_fragment([G, D], T.float16)
                shared = T.alloc_shared([G, D], T.float16)
                T.annotate_layout({
                    out_half: pv.make_mma_store_layout(out_half),
                    shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(shared, vecSize=8),
                })
                T.copy(out, out_half)
                T.sync_warp()
                T.copy(out_half, shared)
                T.sync_warp()
                T.copy(shared, Output[b, token, h * G:(h + 1) * G, :])
            else:
                T.copy(out, Output[b, token, h * G:(h + 1) * G, :])
    return kernel
