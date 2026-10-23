
import torch
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter


def _clamped_load_base(i_s, seq_len, BS, i_t, is_causal):
    hi = T.max(seq_len - BS, 0)
    safe = T.if_then_else(i_s < 0, 0, T.if_then_else(i_s > hi, hi, i_s))
    skip = T.if_then_else(i_s < 0, 1, T.if_then_else(i_s >= seq_len, 1, 0))
    if is_causal:
        skip = T.if_then_else(i_s > i_t, 1, skip)
    return T.if_then_else(skip > 0, safe, i_s)


def _paired_pos_sel(j, starts, pair, BS):
    k = pair - 1
    sel = starts[k] + (j - k * BS)
    for k in range(pair - 2, -1, -1):
        sel = T.if_then_else(j < (k + 1) * BS, starts[k] + (j - k * BS), sel)
    return sel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_single_block(
    batch,
    heads,
    seq_len,
    dim,
    is_causal,
    block_size,
    groups,
    scale_log2,
    threads=64,
    kv_reuse=True,
    stage_regs=True,
    o_stage=False,
    q_frag=False,
    nmax=False,
    kv_frag=False,
    min_blocks=0,
    tokens_per_cta=1,
    late_normalize=False,
    q_preload=False,
    q_shared_preload=False,
):

    preload_shared_q = q_shared_preload and not (q_frag or kv_frag)
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    block_indices_shape = [batch, seq_len, head_kv, 1]

    dtype = T.float16
    accum_dtype = T.float32
    block_t = min(128, tilelang.math.next_power_of_2(dim))

    assert tilelang.cdiv(dim, block_t) == 1, (
        "The key dimension can not be larger than 128"
    )

    G = groups
    BS = block_size
    BK = BV = block_t

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, dtype),
        K: T.Tensor(kv_shape, dtype),
        V: T.Tensor(kv_shape, dtype),
        BlockIndices: T.Tensor(block_indices_shape, T.int32),
        Output: T.Tensor(q_shape, dtype),
    ):
        with T.Kernel(
            seq_len,
            tilelang.cdiv(dim, BV),
            batch * head_kv,
            threads=threads,
        ) as (bx, by, bz):
            if min_blocks > 0:


                T.annotate_min_blocks_per_sm(min_blocks)
            if kv_frag or q_frag:


                Q_reg = T.alloc_fragment([G, BK], dtype)
            else:
                Q_shared = T.alloc_shared([G, BK], dtype)
            if kv_frag:


                K_reg = T.alloc_fragment([BS, BK], dtype)
                V_reg = T.alloc_fragment([BS, BV], dtype)
            elif kv_reuse:
                KV_shared = T.alloc_shared([BS, BK], dtype)
            else:
                K_shared = T.alloc_shared([BS, BK], dtype)
                V_shared = T.alloc_shared([BS, BV], dtype)

            acc_s = T.alloc_fragment([G, BS], accum_dtype)
            acc_s_cast = T.alloc_fragment([G, BS], dtype)
            acc_o = T.alloc_fragment([G, BV], accum_dtype)
            if not nmax:
                scores_max = T.alloc_fragment([G], accum_dtype)
            scores_sum = T.alloc_fragment([G], accum_dtype)
            scores_inv_sum = T.alloc_fragment([G], accum_dtype)

            i_t = bx
            i_v = by
            i_bh = bz
            i_b = i_bh // head_kv
            i_h = i_bh % head_kv
            if q_frag and q_preload:
                T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            if preload_shared_q:

                T.copy(Q[i_b, i_t, i_h * G:(i_h+1)*G, :], Q_shared)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS

            T.fill(acc_o, 0)


            T.fill(scores_sum, 0)


            if (
                i_s >= 0
                and i_s < seq_len
                and (not is_causal or i_s <= i_t)
            ):
                if kv_frag:


                    if not (q_frag and q_preload):
                        T.copy(
                            Q[i_b, i_t, i_h * G : (i_h + 1) * G, :],
                            Q_reg,
                        )
                    T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                    T.copy(
                        V[i_b, i_s : i_s + BS, i_h, i_v * BV : (i_v + 1) * BV],
                        V_reg,
                    )
                elif stage_regs:


                    if not q_frag:
                        Q_reg = T.alloc_fragment([G, BK], dtype)
                    K_reg = T.alloc_fragment([BS, BK], dtype)
                    V_reg = T.alloc_fragment([BS, BV], dtype)
                    if not (q_frag and q_preload) and not preload_shared_q:
                        T.copy(
                            Q[i_b, i_t, i_h * G : (i_h + 1) * G, :],
                            Q_reg,
                        )
                    T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                    T.copy(
                        V[i_b, i_s : i_s + BS, i_h, i_v * BV : (i_v + 1) * BV],
                        V_reg,
                    )
                    if not q_frag and not preload_shared_q:
                        T.copy(Q_reg, Q_shared)
                    if kv_reuse:
                        T.copy(K_reg, KV_shared)
                    else:
                        T.copy(K_reg, K_shared)
                        T.copy(V_reg, V_shared)
                else:
                    if q_frag:
                        T.copy(
                            Q[i_b, i_t, i_h * G : (i_h + 1) * G, :],
                            Q_reg,
                        )
                    elif not preload_shared_q:
                        T.copy(
                            Q[i_b, i_t, i_h * G : (i_h + 1) * G, :],
                            Q_shared,
                        )
                    if not kv_reuse:
                        T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_shared)


                        T.copy(
                            V[
                                i_b,
                                i_s : i_s + BS,
                                i_h,
                                i_v * BV : (i_v + 1) * BV,
                            ],
                            V_shared,
                        )
                    else:
                        T.copy(K[i_b, i_s : i_s + BS, i_h, :], KV_shared)

                if is_causal:


                    if i_s + BS <= i_t + 1:
                        T.clear(acc_s)
                    else:
                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.if_then_else(
                                i_s + j <= i_t,
                                0,
                                -T.infinity(accum_dtype),
                            )
                elif i_s + BS <= seq_len:
                    T.clear(acc_s)
                else:


                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len,
                            0,
                            -T.infinity(accum_dtype),
                        )

                q_a = Q_reg if (kv_frag or q_frag) else Q_shared
                if kv_frag:
                    T.gemm(
                        q_a,
                        K_reg,
                        acc_s,
                        transpose_B=True,
                        policy=T.GemmWarpPolicy.FullRow,
                    )
                elif kv_reuse:
                    T.gemm(
                        q_a,
                        KV_shared,
                        acc_s,
                        transpose_B=True,
                        policy=T.GemmWarpPolicy.FullRow,
                    )
                else:
                    T.gemm(
                        q_a,
                        K_shared,
                        acc_s,
                        transpose_B=True,
                        policy=T.GemmWarpPolicy.FullRow,
                    )

                if nmax:


                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.exp2(
                            T.min(acc_s[i, j] * scale_log2, 15.0)
                        )
                else:
                    T.fill(scores_max, -T.infinity(accum_dtype))
                    T.reduce_max(acc_s, scores_max, dim=1, clear=True)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.exp2(
                            (acc_s[i, j] - scores_max[i]) * scale_log2
                        )


                if kv_reuse:
                    if stage_regs:
                        T.copy(V_reg, KV_shared)
                    else:
                        T.copy(
                            V[
                                i_b,
                                i_s : i_s + BS,
                                i_h,
                                i_v * BV : (i_v + 1) * BV,
                            ],
                            KV_shared,
                        )
                if not late_normalize:
                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                    for i in T.Parallel(G):
                        scores_inv_sum[i] = T.if_then_else(
                            scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0,
                        )
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= scores_inv_sum[i]
                T.copy(acc_s, acc_s_cast)

                if kv_frag:
                    T.gemm(
                        acc_s_cast,
                        V_reg,
                        acc_o,
                        policy=T.GemmWarpPolicy.FullRow,
                    )
                elif kv_reuse:
                    T.gemm(
                        acc_s_cast,
                        KV_shared,
                        acc_o,
                        policy=T.GemmWarpPolicy.FullRow,
                    )
                else:
                    T.gemm(
                        acc_s_cast,
                        V_shared,
                        acc_o,
                        policy=T.GemmWarpPolicy.FullRow,
                    )


            if late_normalize:
                if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                for i in T.Parallel(G):
                    scores_inv_sum[i] = T.if_then_else(
                        scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0,
                    )
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] *= scores_inv_sum[i]


            if o_stage:
                O_shared = T.alloc_shared([G, BV], dtype)
                T.copy(acc_o, O_shared)
                T.copy(
                    O_shared,
                    Output[
                        i_b,
                        i_t,
                        i_h * G : (i_h + 1) * G,
                        i_v * BV : (i_v + 1) * BV,
                    ],
                )
            else:
                T.copy(
                    acc_o,
                    Output[
                        i_b,
                        i_t,
                        i_h * G : (i_h + 1) * G,
                        i_v * BV : (i_v + 1) * BV,
                    ],
                )

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_online(
    batch,
    heads,
    seq_len,
    dim,
    is_causal,
    block_size,
    groups,
    selected_blocks,
    scale_log2,
    threads=64,
    num_stages=1,
    o_stage=False,
    stage_regs=True,
    nmax=False,
    kv_frag=False,
    pair=1,
    min_blocks=0,
    q_frag=False,
    online_unroll=2,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    block_indices_shape = [batch, seq_len, head_kv, selected_blocks]

    dtype = T.float16
    accum_dtype = T.float32
    block_t = min(128, tilelang.math.next_power_of_2(dim))

    assert tilelang.cdiv(dim, block_t) == 1, (
        "The key dimension can not be larger than 128"
    )

    S = selected_blocks
    G = groups
    BS = block_size
    BK = BV = block_t

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, dtype),
        K: T.Tensor(kv_shape, dtype),
        V: T.Tensor(kv_shape, dtype),
        BlockIndices: T.Tensor(block_indices_shape, T.int32),
        Output: T.Tensor(q_shape, dtype),
    ):
        with T.Kernel(
            seq_len,
            tilelang.cdiv(dim, BV),
            batch * head_kv,
            threads=threads,
        ) as (bx, by, bz):
            if min_blocks > 0:
                T.annotate_min_blocks_per_sm(min_blocks)


            nc = pair * BS if (stage_regs and pair > 1) else BS

            if q_frag:
                Q_reg = T.alloc_fragment([G, BK], dtype)
            else:
                Q_shared = T.alloc_shared([G, BK], dtype)
            if kv_frag:


                K_reg = T.alloc_fragment([BS, BK], dtype)
                V_reg = T.alloc_fragment([BS, BV], dtype)
            else:
                K_shared = T.alloc_shared([nc, BK], dtype)
                V_shared = T.alloc_shared([nc, BV], dtype)

            acc_s = T.alloc_fragment([G, nc], accum_dtype)
            acc_s_cast = T.alloc_fragment([G, nc], dtype)
            acc_o = T.alloc_fragment([G, BV], accum_dtype)
            if not nmax:
                scores_max = T.alloc_fragment([G], accum_dtype)
                scores_max_prev = T.alloc_fragment([G], accum_dtype)
                scores_scale = T.alloc_fragment([G], accum_dtype)
            scores_sum = T.alloc_fragment([G], accum_dtype)
            scores_inv_sum = T.alloc_fragment([G], accum_dtype)
            logsum = T.alloc_fragment([G], accum_dtype)

            i_t = bx
            i_v = by
            i_bh = bz
            i_b = i_bh // head_kv
            i_h = i_bh % head_kv

            T.copy(
                Q[i_b, i_t, i_h * G : (i_h + 1) * G, :],
                Q_reg if q_frag else Q_shared,
            )
            T.fill(acc_o, 0)
            if nmax:


                sum_acc = T.alloc_fragment([G, nc], accum_dtype)
                T.fill(sum_acc, 0)
            else:
                T.fill(logsum, 0)
                T.fill(scores_max, -T.infinity(accum_dtype))

            if stage_regs and pair > 1:


                neg_inf = -T.infinity(accum_dtype)
                for p in T.serial(S // pair):
                    i_s0 = BlockIndices[i_b, i_t, i_h, p * pair] * BS
                    a0 = _clamped_load_base(i_s0, seq_len, BS, i_t, is_causal)
                    T.copy(K[i_b, a0 : a0 + BS, i_h, :], K_shared[0 : BS, :])
                    T.copy(
                        V[i_b, a0 : a0 + BS, i_h, i_v * BV : (i_v + 1) * BV],
                        V_shared[0 : BS, :],
                    )
                    if pair >= 2:
                        i_s1 = BlockIndices[i_b, i_t, i_h, p * pair + 1] * BS
                        a1 = _clamped_load_base(i_s1, seq_len, BS, i_t, is_causal)
                        T.copy(K[i_b, a1 : a1 + BS, i_h, :], K_shared[BS : 2 * BS, :])
                        T.copy(
                            V[i_b, a1 : a1 + BS, i_h, i_v * BV : (i_v + 1) * BV],
                            V_shared[BS : 2 * BS, :],
                        )
                    if pair >= 3:
                        i_s2 = BlockIndices[i_b, i_t, i_h, p * pair + 2] * BS
                        a2 = _clamped_load_base(i_s2, seq_len, BS, i_t, is_causal)
                        T.copy(K[i_b, a2 : a2 + BS, i_h, :], K_shared[2 * BS : 3 * BS, :])
                        T.copy(
                            V[i_b, a2 : a2 + BS, i_h, i_v * BV : (i_v + 1) * BV],
                            V_shared[2 * BS : 3 * BS, :],
                        )
                    if pair >= 4:
                        i_s3 = BlockIndices[i_b, i_t, i_h, p * pair + 3] * BS
                        a3 = _clamped_load_base(i_s3, seq_len, BS, i_t, is_causal)
                        T.copy(K[i_b, a3 : a3 + BS, i_h, :], K_shared[3 * BS : 4 * BS, :])
                        T.copy(
                            V[i_b, a3 : a3 + BS, i_h, i_v * BV : (i_v + 1) * BV],
                            V_shared[3 * BS : 4 * BS, :],
                        )

                    starts = (
                        (i_s0, i_s1)
                        if pair == 2
                        else (i_s0, i_s1, i_s2)
                        if pair == 3
                        else (i_s0, i_s1, i_s2, i_s3)
                    )
                    for i, j in T.Parallel(G, nc):
                        pos = _paired_pos_sel(j, starts, pair, BS)
                        if is_causal:
                            acc_s[i, j] = T.if_then_else(
                                pos >= 0,
                                T.if_then_else(pos <= i_t, 0.0, neg_inf),
                                neg_inf,
                            )
                        else:
                            acc_s[i, j] = T.if_then_else(
                                pos >= 0,
                                T.if_then_else(pos < seq_len, 0.0, neg_inf),
                                neg_inf,
                            )

                    T.gemm(
                        Q_reg if q_frag else Q_shared,
                        K_shared,
                        acc_s,
                        transpose_B=True,
                        policy=T.GemmWarpPolicy.FullRow,
                    )

                    if nmax:


                        for i, j in T.Parallel(G, nc):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0)
                            )
                        for i, j in T.Parallel(G, nc):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                    else:
                        T.copy(scores_max, scores_max_prev)
                        T.fill(scores_max, -T.infinity(accum_dtype))
                        T.reduce_max(
                            acc_s,
                            scores_max,
                            dim=1,
                            clear=True,
                        )
                        for i in T.Parallel(G):
                            scores_max[i] = T.max(
                                scores_max_prev[i],
                                scores_max[i],
                            )
                            scores_scale[i] = T.exp2(
                                (scores_max_prev[i] - scores_max[i])
                                * scale_log2
                            )
                        for i, j in T.Parallel(G, nc):
                            acc_s[i, j] = T.exp2(
                                (acc_s[i, j] - scores_max[i]) * scale_log2
                            )
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            logsum[i] = (
                                logsum[i] * scores_scale[i] + scores_sum[i]
                            )
                        T.copy(acc_s, acc_s_cast)
                        for i, j in T.Parallel(G, BV):
                            acc_o[i, j] *= scores_scale[i]

                    T.gemm(
                        acc_s_cast,
                        V_shared,
                        acc_o,
                        policy=T.GemmWarpPolicy.FullRow,
                    )
            elif stage_regs:


                if not kv_frag:
                    K_reg = T.alloc_fragment([BS, BK], dtype)
                    V_reg = T.alloc_fragment([BS, BV], dtype)

                for s in T.unroll(S, unroll_factor=online_unroll):
                    i_s = BlockIndices[i_b, i_t, i_h, s] * BS
                    if (
                        i_s >= 0
                        and i_s < seq_len
                        and (not is_causal or i_s <= i_t)
                    ):
                        T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                        T.copy(
                            V[i_b, i_s : i_s + BS, i_h, i_v * BV : (i_v + 1) * BV],
                            V_reg,
                        )
                        if not kv_frag:
                            T.copy(K_reg, K_shared)

                        if is_causal:
                            if i_s + BS <= i_t + 1:
                                T.clear(acc_s)
                            else:
                                for i, j in T.Parallel(G, BS):
                                    acc_s[i, j] = T.if_then_else(
                                        i_s + j <= i_t,
                                        0,
                                        -T.infinity(accum_dtype),
                                    )
                        elif i_s + BS <= seq_len:
                            T.clear(acc_s)
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len,
                                    0,
                                    -T.infinity(accum_dtype),
                                )

                        T.gemm(
                            Q_reg if q_frag else Q_shared,
                            K_reg if kv_frag else K_shared,
                            acc_s,
                            transpose_B=True,
                            policy=T.GemmWarpPolicy.FullRow,
                        )

                        if nmax:


                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp2(
                                    T.min(acc_s[i, j] * scale_log2, 15.0)
                                )
                            for i, j in T.Parallel(G, BS):
                                sum_acc[i, j] += acc_s[i, j]
                            T.copy(acc_s, acc_s_cast)
                        else:
                            T.copy(scores_max, scores_max_prev)
                            T.fill(scores_max, -T.infinity(accum_dtype))
                            T.reduce_max(
                                acc_s,
                                scores_max,
                                dim=1,
                                clear=True,
                            )
                            for i in T.Parallel(G):
                                scores_max[i] = T.max(
                                    scores_max_prev[i],
                                    scores_max[i],
                                )
                                scores_scale[i] = T.exp2(
                                    (scores_max_prev[i] - scores_max[i])
                                    * scale_log2
                                )
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp2(
                                    (acc_s[i, j] - scores_max[i]) * scale_log2
                                )
                            T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                            for i in T.Parallel(G):
                                logsum[i] = (
                                    logsum[i] * scores_scale[i] + scores_sum[i]
                                )
                            T.copy(acc_s, acc_s_cast)
                            for i, j in T.Parallel(G, BV):
                                acc_o[i, j] *= scores_scale[i]

                        if not kv_frag:


                            T.copy(V_reg, V_shared)
                        T.gemm(
                            acc_s_cast,
                            V_reg if kv_frag else V_shared,
                            acc_o,
                            policy=T.GemmWarpPolicy.FullRow,
                        )
            else:
                for s in T.Pipelined(S, num_stages=num_stages):
                    i_s = BlockIndices[i_b, i_t, i_h, s] * BS

                    if (
                        i_s >= 0
                        and i_s < seq_len
                        and (not is_causal or i_s <= i_t)
                    ):
                        T.copy(
                            K[i_b, i_s : i_s + BS, i_h, :],
                            K_shared,
                        )

                        if is_causal:
                            if i_s + BS <= i_t + 1:
                                T.clear(acc_s)
                            else:
                                for i, j in T.Parallel(G, BS):
                                    acc_s[i, j] = T.if_then_else(
                                        i_s + j <= i_t,
                                        0,
                                        -T.infinity(accum_dtype),
                                    )
                        elif i_s + BS <= seq_len:
                            T.clear(acc_s)
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len,
                                    0,
                                    -T.infinity(accum_dtype),
                                )

                        T.gemm(
                            Q_reg if q_frag else Q_shared,
                            K_shared,
                            acc_s,
                            transpose_B=True,
                            policy=T.GemmWarpPolicy.FullRow,
                        )

                        if nmax:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp2(
                                    T.min(acc_s[i, j] * scale_log2, 15.0)
                                )
                            for i, j in T.Parallel(G, BS):
                                sum_acc[i, j] += acc_s[i, j]
                            T.copy(acc_s, acc_s_cast)
                        else:
                            T.copy(scores_max, scores_max_prev)
                            T.fill(scores_max, -T.infinity(accum_dtype))
                            T.reduce_max(
                                acc_s,
                                scores_max,
                                dim=1,
                                clear=True,
                            )
                            for i in T.Parallel(G):
                                scores_max[i] = T.max(
                                    scores_max_prev[i],
                                    scores_max[i],
                                )
                                scores_scale[i] = T.exp2(
                                    (scores_max_prev[i] - scores_max[i])
                                    * scale_log2
                                )
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp2(
                                    (acc_s[i, j] - scores_max[i])
                                    * scale_log2
                                )
                            T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                            for i in T.Parallel(G):
                                logsum[i] = (
                                    logsum[i] * scores_scale[i] + scores_sum[i]
                                )
                            T.copy(acc_s, acc_s_cast)
                            for i, j in T.Parallel(G, BV):
                                acc_o[i, j] *= scores_scale[i]

                        T.copy(
                            V[
                                i_b,
                                i_s : i_s + BS,
                                i_h,
                                i_v * BV : (i_v + 1) * BV,
                            ],
                            V_shared,
                        )
                        T.gemm(
                            acc_s_cast,
                            V_shared,
                            acc_o,
                            policy=T.GemmWarpPolicy.FullRow,
                        )

            if nmax:
                T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
                for i in T.Parallel(G):
                    scores_inv_sum[i] = T.if_then_else(
                        scores_sum[i] > 0,
                        1.0 / scores_sum[i],
                        0.0,
                    )
            else:
                for i in T.Parallel(G):
                    scores_inv_sum[i] = T.if_then_else(
                        logsum[i] > 0,
                        1.0 / logsum[i],
                        0.0,
                    )
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= scores_inv_sum[i]


            if o_stage:
                O_shared = T.alloc_shared([G, BV], dtype)
                T.copy(acc_o, O_shared)
                T.copy(
                    O_shared,
                    Output[
                        i_b,
                        i_t,
                        i_h * G : (i_h + 1) * G,
                        i_v * BV : (i_v + 1) * BV,
                    ],
                )
            else:
                T.copy(
                    acc_o,
                    Output[
                        i_b,
                        i_t,
                        i_h * G : (i_h + 1) * G,
                        i_v * BV : (i_v + 1) * BV,
                    ],
                )

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_online_emitter(batch, heads, seq_len, dim, is_causal, block_size, groups, selected_blocks, scale_log2, threads=64, online_unroll=2):
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            K_shared = T.alloc_shared([BS, BK], T.float16)
            V_shared = T.alloc_shared([BS, BV], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            sum_acc = T.alloc_fragment([G, BS], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)
            T.annotate_layout({Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), K_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(K_shared, vecSize=8), V_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(V_shared, vecSize=8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)})
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                _raw_block_before_scale = BlockIndices[i_b, i_t, i_h, si]
                indices[si] = T.if_then_else(_raw_block_before_scale >= 0 and _raw_block_before_scale < (seq_len + BS - 1) // BS, _raw_block_before_scale, -1) * BS
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            T.fill(sum_acc, 0)
            kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            neg_inf = -T.infinity(T.float32)
            for s in T.unroll(S, unroll_factor=online_unroll):
                i_s = indices[s]
                if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                    T.copy(K[i_b, i_s:i_s + BS, i_h, :], K_reg)
                    T.copy(V[i_b, i_s:i_s + BS, i_h, i_v * BV:(i_v + 1) * BV], V_reg)
                    T.copy(K_reg, K_shared)
                    if is_causal and i_s + BS > i_t + 1:
                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.if_then_else(i_s + j <= i_t, 0, neg_inf)
                    elif not is_causal and i_s + BS > seq_len:
                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.if_then_else(i_s + j < seq_len, 0, neg_inf)
                    else:
                        T.clear(acc_s)
                    for ki in T.serial(qk_steps):
                        qk.ldmatrix_b(kb, K_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)
                    T.copy(V_reg, V_shared)
                    if scale_log2 > 0:
                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                    else:
                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.if_then_else(
                                i_s + j < seq_len and (not is_causal or i_s + j <= i_t),
                                T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0)), 0.0)
                    for i, j in T.Parallel(G, BS):
                        sum_acc[i, j] += acc_s[i, j]
                    T.copy(acc_s, acc_s_cast)
                    for ki in T.serial(pv_steps):
                        pv.ldmatrix_b(vb, V_shared, ki)
                        pv.mma(acc_s_cast, vb, acc_o, ki)
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= inv_sum[i]
            T.copy(acc_o, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
    return kernel


def _emitters(dtype, accum, block_size, block_t, qk_k_pack=2):


    qk = TensorCoreIntrinEmitter(
        a_dtype=dtype, b_dtype=dtype, accum_dtype=accum,
        a_transposed=False, b_transposed=True,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=block_size, chunk=block_t,
        k_pack=qk_k_pack,
    )


    pv = TensorCoreIntrinEmitter(
        a_dtype=dtype, b_dtype=dtype, accum_dtype=accum,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=block_t, chunk=block_size,
        k_pack=1,
    )
    return qk, pv


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_single_block_emitter(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)


            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    KV_shared, vecSize=8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if kv_split:
                _layout[V_shared] = (
                    tilelang.maca.intrinsics.make_mma_swizzle_layout(
                        V_shared, vecSize=8))
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                if not direct_k:
                    T.copy(K_reg, KV_shared)
                if kv_split:


                    T.copy(V_reg, V_shared)

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)


                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_online_packed(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False, prefetch_depth=1,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]
    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(packed_k_shape, T.float16),
        V: T.Tensor(packed_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            K_reg1 = T.alloc_fragment([BS, BK], T.float16)
            K_reg2 = T.alloc_fragment([BS, BK], T.float16)
            K_reg3 = T.alloc_fragment([BS, BK], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            acc_o_alt = T.alloc_fragment([G, BV], T.float32)
            sum_acc = T.alloc_fragment([G, BS], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)

            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                V_reg: pv.make_mma_load_layout(V_reg, "B"),
                K_reg: qk.make_mma_load_layout(K_reg, "B"),
                K_reg1: qk.make_mma_load_layout(K_reg1, "B"),
                K_reg2: qk.make_mma_load_layout(K_reg2, "B"),
                K_reg3: qk.make_mma_load_layout(K_reg3, "B"),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
                acc_o_alt: pv.make_mma_store_layout(acc_o_alt),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv

            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            if dual_acc:
                T.fill(acc_o_alt, 0)
            T.fill(sum_acc, 0)

            neg_inf = -T.infinity(T.float32)
            if prefetch_depth == 1:
                for s in T.unroll(S, unroll_factor=online_unroll):
                    i_s = indices[s]
                    if (i_s >= 0 and i_s < seq_len
                            and (not is_causal or i_s <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and s % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)

            else:
                for group in T.serial(T.ceildiv(S, prefetch_depth)):
                    i_s0 = indices[T.min(group * prefetch_depth + 0, S - 1)]
                    i_s1 = indices[T.min(group * prefetch_depth + 1, S - 1)]
                    i_s2 = indices[T.min(group * prefetch_depth + 2, S - 1)]
                    i_s3 = indices[T.min(group * prefetch_depth + 3, S - 1)]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s0 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg1[j, d] = K[i_b, i_s1 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg2[j, d] = K[i_b, i_s2 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg3[j, d] = K[i_b, i_s3 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s0 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s0 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s0 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 0) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s1 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s1 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s1 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg1, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 1) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s2 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s2 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s2 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg2, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 2) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s3 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s3 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s3 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg3, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 3) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)

            if dual_acc:
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] += acc_o_alt[i, j]
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= inv_sum[i]

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit
def native_sparse_attention_pack_kv(batch, seq_len, heads, dim, block_size):
    BS, D = block_size, dim
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D//32, BS//16, 64, 8], T.float16),
        Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS//16, D//32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=128) as (bs, h, b):
            ktile = T.alloc_fragment([BS, D], T.float16)
            T.copy(K[b, bs * BS : (bs + 1) * BS, h, :], ktile)
            for j, d in T.Parallel(BS, D):
                PackedK[b, bs, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8] = ktile[j, d]
            tile = T.alloc_fragment([BS, D], T.float16)
            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], tile)
            for j, d in T.Parallel(BS, D):
                Packed[b, bs, h, j // 16, d // 32,
                       (j % 16 // 4) * 16 + d % 16,
                       (d % 32 // 16) * 4 + j % 4] = tile[j, d]
    return kernel


def _make_packed_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    blocks = (seq_len + block_size - 1) // block_size
    k_shape = (batch, blocks, heads, dim // 32, block_size // 16, 64, 8)
    v_shape = (batch, blocks, heads, block_size // 16, dim // 32, 64, 8)

    def run(q, k, v, indices, output):
        packed_k = torch.empty(k_shape, device=k.device, dtype=k.dtype)
        packed_v = torch.empty(v_shape, device=v.device, dtype=v.dtype)
        pack(k, v, packed_k, packed_v)
        attention(q, packed_k, packed_v, indices, output)

    return run


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_online_packed_batch_minor(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False, prefetch_depth=1,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]
    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(packed_k_shape, T.float16),
        V: T.Tensor(packed_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            K_reg1 = T.alloc_fragment([BS, BK], T.float16)
            K_reg2 = T.alloc_fragment([BS, BK], T.float16)
            K_reg3 = T.alloc_fragment([BS, BK], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            acc_o_alt = T.alloc_fragment([G, BV], T.float32)
            sum_acc = T.alloc_fragment([G, BS], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)

            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                V_reg: pv.make_mma_load_layout(V_reg, "B"),
                K_reg: qk.make_mma_load_layout(K_reg, "B"),
                K_reg1: qk.make_mma_load_layout(K_reg1, "B"),
                K_reg2: qk.make_mma_load_layout(K_reg2, "B"),
                K_reg3: qk.make_mma_load_layout(K_reg3, "B"),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
                acc_o_alt: pv.make_mma_store_layout(acc_o_alt),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv

            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            if dual_acc:
                T.fill(acc_o_alt, 0)
            T.fill(sum_acc, 0)

            neg_inf = -T.infinity(T.float32)
            if prefetch_depth == 1:
                for s in T.unroll(S, unroll_factor=online_unroll):
                    i_s = indices[s]
                    if (i_s >= 0 and i_s < seq_len
                            and (not is_causal or i_s <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and s % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)

            else:
                for group in T.serial(T.ceildiv(S, prefetch_depth)):
                    i_s0 = indices[T.min(group * prefetch_depth + 0, S - 1)]
                    i_s1 = indices[T.min(group * prefetch_depth + 1, S - 1)]
                    i_s2 = indices[T.min(group * prefetch_depth + 2, S - 1)]
                    i_s3 = indices[T.min(group * prefetch_depth + 3, S - 1)]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s0 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg1[j, d] = K[i_b, i_s1 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg2[j, d] = K[i_b, i_s2 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg3[j, d] = K[i_b, i_s3 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s0 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s0 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s0 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 0) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s1 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s1 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s1 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg1, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 1) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s2 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s2 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s2 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg2, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 2) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s3 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s3 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s3 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg3, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 3) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)

            if dual_acc:
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] += acc_o_alt[i, j]
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= inv_sum[i]

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_online_packed_quad_batch_minor(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False, prefetch_depth=1,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]
    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(packed_k_shape, T.float16),
        V: T.Tensor(packed_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            K_reg1 = T.alloc_fragment([BS, BK], T.float16)
            K_reg2 = T.alloc_fragment([BS, BK], T.float16)
            K_reg3 = T.alloc_fragment([BS, BK], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            acc_o_1 = T.alloc_fragment([G, BV], T.float32)
            acc_o_2 = T.alloc_fragment([G, BV], T.float32)
            acc_o_3 = T.alloc_fragment([G, BV], T.float32)
            sum_acc = T.alloc_fragment([G, BS], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)

            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                V_reg: pv.make_mma_load_layout(V_reg, "B"),
                K_reg: qk.make_mma_load_layout(K_reg, "B"),
                K_reg1: qk.make_mma_load_layout(K_reg1, "B"),
                K_reg2: qk.make_mma_load_layout(K_reg2, "B"),
                K_reg3: qk.make_mma_load_layout(K_reg3, "B"),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
                acc_o_1: pv.make_mma_store_layout(acc_o_1),
                acc_o_2: pv.make_mma_store_layout(acc_o_2),
                acc_o_3: pv.make_mma_store_layout(acc_o_3),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv

            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            T.fill(acc_o_1, 0)
            T.fill(acc_o_2, 0)
            T.fill(acc_o_3, 0)
            T.fill(sum_acc, 0)

            neg_inf = -T.infinity(T.float32)
            if prefetch_depth == 1:
                for s in T.unroll(S, unroll_factor=online_unroll):
                    i_s = indices[s]
                    if (i_s >= 0 and i_s < seq_len
                            and (not is_causal or i_s <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if s % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif s % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif s % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)

            else:
                for group in T.serial(T.ceildiv(S, prefetch_depth)):
                    i_s0 = indices[T.min(group * prefetch_depth + 0, S - 1)]
                    i_s1 = indices[T.min(group * prefetch_depth + 1, S - 1)]
                    i_s2 = indices[T.min(group * prefetch_depth + 2, S - 1)]
                    i_s3 = indices[T.min(group * prefetch_depth + 3, S - 1)]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s0 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg1[j, d] = K[i_b, i_s1 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg2[j, d] = K[i_b, i_s2 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg3[j, d] = K[i_b, i_s3 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s0 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s0 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s0 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 0) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 0) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 0) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s1 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s1 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s1 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg1, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 1) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 1) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 1) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s2 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s2 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s2 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg2, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 2) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 2) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 2) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s3 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s3 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s3 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg3, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 3) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 3) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 3) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)

            for i, j in T.Parallel(G, BV):
                acc_o[i, j] += acc_o_1[i, j]
                acc_o[i, j] += acc_o_2[i, j]
                acc_o[i, j] += acc_o_3[i, j]
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= inv_sum[i]

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_single_block_pv32(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VW = min(32, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)


            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    KV_shared, vecSize=8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if kv_split:
                _layout[V_shared] = (
                    tilelang.maca.intrinsics.make_mma_swizzle_layout(
                        V_shared, vecSize=8))
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                if not direct_k:
                    T.copy(K_reg, KV_shared)
                if kv_split:


                    T.copy(V_reg, V_shared)

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)


                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)

            vb = T.alloc_local(
                [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                    for ki in T.serial(pv_steps):
                        pv.ldmatrix_b(vb, V_shared[0:BS, vo * VW:(vo + 1) * VW], ki)
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                T.copy(acc_o, Output[
                    i_b, i_t, i_h * G : (i_h + 1) * G,
                    i_v * BV + vo * VW : i_v * BV + (vo + 1) * VW])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_d32_shuffle(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            tid = T.get_thread_binding()
            ks_raw = T.alloc_local([8], T.float16)
            ks_w0 = T.Tensor([4], T.uint32, data=ks_raw.data, scope="local")
            ks_w1 = T.alloc_local([4], T.uint32)
            ks_mma = T.Tensor([8], T.float16, data=ks_w1.data, scope="local")
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)


            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS, BK], lambda j, d: (j, d)),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if kv_split:
                _layout[V_shared] = (
                    tilelang.maca.intrinsics.make_mma_swizzle_layout(
                        V_shared, vecSize=8))
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                for slot in T.unroll(1):
                    for e in T.vectorized(8):
                        linear = (((slot * 8 + e) // 1) % 2) * 1 + (((slot * 8 + e) // 2) % 2) * 2 + (((slot * 8 + e) // 4) % 2) * 4 + ((tid // 1) % 2) * 8 + ((tid // 2) % 2) * 16 + ((tid // 4) % 2) * 32 + ((tid // 8) % 2) * 64 + ((tid // 16) % 2) * 128 + ((tid // 32) % 2) * 256
                        ks_raw[slot * 8 + e] = T.if_then_else(i_s + linear // 32 < seq_len,
                            K[i_b, i_s + linear // 32, i_h, linear % 32], T.float16(0))
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                ks_w1[0] = T.shfl_sync(ks_w0[0], ((tid // 16) % 2) * 1 + ((tid // 32) % 2) * 2 + ((tid // 1) % 2) * 4 + ((tid // 2) % 2) * 8 + ((tid // 4) % 2) * 16 + ((tid // 8) % 2) * 32, 64, 0xffffffffffffffff)
                ks_w1[1] = T.shfl_sync(ks_w0[1], ((tid // 16) % 2) * 1 + ((tid // 32) % 2) * 2 + ((tid // 1) % 2) * 4 + ((tid // 2) % 2) * 8 + ((tid // 4) % 2) * 16 + ((tid // 8) % 2) * 32, 64, 0xffffffffffffffff)
                ks_w1[2] = T.shfl_sync(ks_w0[2], ((tid // 16) % 2) * 1 + ((tid // 32) % 2) * 2 + ((tid // 1) % 2) * 4 + ((tid // 2) % 2) * 8 + ((tid // 4) % 2) * 16 + ((tid // 8) % 2) * 32, 64, 0xffffffffffffffff)
                ks_w1[3] = T.shfl_sync(ks_w0[3], ((tid // 16) % 2) * 1 + ((tid // 32) % 2) * 2 + ((tid // 1) % 2) * 4 + ((tid // 2) % 2) * 8 + ((tid // 4) % 2) * 16 + ((tid // 8) % 2) * 32, 64, 0xffffffffffffffff)
                if kv_split:


                    T.copy(V_reg, V_shared)

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.unroll(qk_steps):
                    for e in T.vectorized(BS // 16 * 8):
                        kb[e] = ks_mma[ki * (BS // 16 * 8) + e]
                    qk.mma(Q_reg, kb, acc_s, ki)


                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_single_vec16(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK, qk_k_pack=2)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)


            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    KV_shared, vecSize=16),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if kv_split:
                _layout[V_shared] = (
                    tilelang.maca.intrinsics.make_mma_swizzle_layout(
                        V_shared, vecSize=16))
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                if not direct_k:
                    T.copy(K_reg, KV_shared)
                if kv_split:


                    T.copy(V_reg, V_shared)

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)


                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_single_linear_v(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)


                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_mid_shared_q(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: (i * BK + d) // 8 % 64,
                    forward_index_fn=lambda i, d: (i * BK + d) // 512 * 8 + d % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                T.copy(Q_stage, Q_shared)
                T.copy(Q_shared, Q_reg)
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)


                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_single_block_emitter_wave(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16 and not kv_split
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)


            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    KV_shared, vecSize=8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if kv_split:
                _layout[V_shared] = (
                    tilelang.maca.intrinsics.make_mma_swizzle_layout(
                        V_shared, vecSize=8))
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                if not direct_k:
                    T.copy(K_reg, KV_shared)
                if kv_split:


                    T.copy(V_reg, V_shared)

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)

                if not direct_k:
                    T.sync_warp()


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)

                if not direct_k:
                    T.sync_warp()


                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_single_vec16_wave(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16 and not kv_split
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK, qk_k_pack=2)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)


            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    KV_shared, vecSize=16),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if kv_split:
                _layout[V_shared] = (
                    tilelang.maca.intrinsics.make_mma_swizzle_layout(
                        V_shared, vecSize=16))
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                if not direct_k:
                    T.copy(K_reg, KV_shared)
                if kv_split:


                    T.copy(V_reg, V_shared)

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)

                if not direct_k:
                    T.sync_warp()


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)

                if not direct_k:
                    T.sync_warp()


                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_single_linear_v_wave(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16 and not kv_split
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)

                if not direct_k:
                    T.sync_warp()


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)

                if not direct_k:
                    T.sync_warp()


                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_d32_shuffle_wave(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16 and not kv_split
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            tid = T.get_thread_binding()
            ks_raw = T.alloc_local([8], T.float16)
            ks_w0 = T.Tensor([4], T.uint32, data=ks_raw.data, scope="local")
            ks_w1 = T.alloc_local([4], T.uint32)
            ks_mma = T.Tensor([8], T.float16, data=ks_w1.data, scope="local")
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)


            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS, BK], lambda j, d: (j, d)),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if kv_split:
                _layout[V_shared] = (
                    tilelang.maca.intrinsics.make_mma_swizzle_layout(
                        V_shared, vecSize=8))
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                for slot in T.unroll(1):
                    for e in T.vectorized(8):
                        linear = (((slot * 8 + e) // 1) % 2) * 1 + (((slot * 8 + e) // 2) % 2) * 2 + (((slot * 8 + e) // 4) % 2) * 4 + ((tid // 1) % 2) * 8 + ((tid // 2) % 2) * 16 + ((tid // 4) % 2) * 32 + ((tid // 8) % 2) * 64 + ((tid // 16) % 2) * 128 + ((tid // 32) % 2) * 256
                        ks_raw[slot * 8 + e] = T.if_then_else(i_s + linear // 32 < seq_len,
                            K[i_b, i_s + linear // 32, i_h, linear % 32], T.float16(0))
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                ks_w1[0] = T.shfl_sync(ks_w0[0], ((tid // 16) % 2) * 1 + ((tid // 32) % 2) * 2 + ((tid // 1) % 2) * 4 + ((tid // 2) % 2) * 8 + ((tid // 4) % 2) * 16 + ((tid // 8) % 2) * 32, 64, 0xffffffffffffffff)
                ks_w1[1] = T.shfl_sync(ks_w0[1], ((tid // 16) % 2) * 1 + ((tid // 32) % 2) * 2 + ((tid // 1) % 2) * 4 + ((tid // 2) % 2) * 8 + ((tid // 4) % 2) * 16 + ((tid // 8) % 2) * 32, 64, 0xffffffffffffffff)
                ks_w1[2] = T.shfl_sync(ks_w0[2], ((tid // 16) % 2) * 1 + ((tid // 32) % 2) * 2 + ((tid // 1) % 2) * 4 + ((tid // 2) % 2) * 8 + ((tid // 4) % 2) * 16 + ((tid // 8) % 2) * 32, 64, 0xffffffffffffffff)
                ks_w1[3] = T.shfl_sync(ks_w0[3], ((tid // 16) % 2) * 1 + ((tid // 32) % 2) * 2 + ((tid // 1) % 2) * 4 + ((tid // 2) % 2) * 8 + ((tid // 4) % 2) * 16 + ((tid // 8) % 2) * 32, 64, 0xffffffffffffffff)
                if kv_split:


                    T.copy(V_reg, V_shared)

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.unroll(qk_steps):
                    for e in T.vectorized(BS // 16 * 8):
                        kb[e] = ks_mma[ki * (BS // 16 * 8) + e]
                    qk.mma(Q_reg, kb, acc_s, ki)


                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_mid_shared_q_wave(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16 and not kv_split
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: (i * BK + d) // 8 % 64,
                    forward_index_fn=lambda i, d: (i * BK + d) // 512 * 8 + d % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                T.copy(Q_stage, Q_shared)
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)

                T.sync_warp()
                T.copy(Q_shared, Q_reg)


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)

                if not direct_k:
                    T.sync_warp()


                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_shared_q_reuse(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16 and not kv_split and not direct_k
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: (i * BK + d) // 8 % 64,
                    forward_index_fn=lambda i, d: (i * BK + d) // 512 * 8 + d % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)

                T.sync_warp()


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)

                T.sync_warp()


                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def native_sparse_attention_short_list(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, selected_blocks, threads=64, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, IBS, S = (groups, block_size, selected_blocks)
    BS = IBS * S
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, S], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)
            starts = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                _raw_block_before_scale = BlockIndices[i_b, i_t, i_h, si]
                starts[si] = T.if_then_else(_raw_block_before_scale >= 0 and _raw_block_before_scale < (seq_len + IBS - 1) // IBS, _raw_block_before_scale, -1) * IBS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if T.bool(True):
                for j, d in T.Parallel(BS, BK):
                    kpos = _paired_pos_sel(j, starts, S, IBS)
                    K_reg[j, d] = T.if_then_else(kpos >= 0 and kpos < seq_len and (d < dim), K[i_b, kpos, i_h, d], T.float16(0))
                for j, d in T.Parallel(BS, BV):
                    vpos = _paired_pos_sel(j, starts, S, IBS)
                    V_reg[j, d] = T.if_then_else(vpos >= 0 and vpos < seq_len and (d < dim), V[i_b, vpos, i_h, d], T.float16(0))
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    pos = _paired_pos_sel(j, starts, S, IBS)
                    acc_s[i, j] = T.if_then_else(pos >= 0 and pos < seq_len and (not is_causal or pos <= i_t), T.float32(0), -T.infinity(T.float32))
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                T.copy(acc_s, acc_s_cast)
                vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)
                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
            T.copy(acc_o, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_pv32_sync(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, wave_sync=True,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16
    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    VW = min(32, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)

                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)

                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()


                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()

            vb = T.alloc_local(
                [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[row * BK + col]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                T.copy(acc_o, Output[
                    i_b, i_t, i_h * G : (i_h + 1) * G,
                    i_v * BV + vo * VW : i_v * BV + (vo + 1) * VW])

    return kernel

_KERNEL_CACHE = {}


def _coalesced_qo_prim(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, wave_sync=True, q_vec=8, pv_width=128,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16
    assert dim in (64, 128) and block_size in (16, 32)
    assert q_vec in (4, 8) and pv_width in (64, 128)
    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    VW = min(pv_width, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            O_reg = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_reg: T.Fragment([G, BV],
                forward_thread_fn=lambda i, d: i + (d % 16 // 4) * 16,
                forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: (i * BK + d) // q_vec % 64,
                    forward_index_fn=lambda i, d: (i * BK + d) // (64 * q_vec) * q_vec + d % q_vec),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                if is_causal and i_s + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and i_s + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            i_s + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)

                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)

                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()


                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()

            vb = T.alloc_local(
                [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[row * BK + col]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                for i, d in T.Parallel(G, VW):
                    O_reg[i, vo * VW + d] = acc_o[i, d]


            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])

    return kernel

@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_coalesced_qo(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, q_vec=8, pv_width=128,
):
    return _coalesced_qo_prim(
        batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
        threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)

@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_single_packed_qo(batch, heads, seq_len, dim, is_causal, block_size,
                     groups, scale_log2, threads=64, width=32, late=False):
    assert groups == 16 and threads == 64 and dim in (64, 128) and block_size in (16, 32)
    G, BS, D = groups, block_size, dim
    H = heads // groups
    W = min(width, D)
    NB = tilelang.cdiv(seq_len, BS)
    qk, _ = _emitters(T.float16, T.float32, BS, D)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=W, chunk=BS, k_pack=1)
    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            q_shared = T.alloc_shared([G, D], T.float16)
            output_reg = T.alloc_fragment([G, D], T.float16)
            T.annotate_layout({
                q_stage: T.Fragment([G, D],
                    forward_thread_fn=lambda qi, qd: (qi * D + qd) // 8 % 64,
                    forward_index_fn=lambda qi, qd: (qi * D + qd) // 512 * 8 + qd % 8),
                q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8),
                output_reg: T.Fragment([G, D],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
            })
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, W], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, W], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'A'),
                k: qk.make_mma_load_layout(k, 'B'),
                v: pv.make_mma_load_layout(v, 'B'),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
            })
            b, h = bh // H, bh % H
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
            block = Indices[b, token, h, 0]
            start = block * BS
            valid = block >= 0 and block < NB and (not is_causal or start <= token)
            if valid:
                for j, d in T.Parallel(BS, D):
                    k[j, d] = K[b, block, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8]
                for j, d in T.Parallel(BS, W):
                    v[j, d] = V[b, block, h, j // 16, d // 32,
                        (j % 16 // 4) * 16 + d % 16,
                        (d % 32 // 16) * 4 + j % 4]
                T.copy(q_stage, q_shared)
                T.sync_warp()
                T.copy(q_shared, q)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.if_then_else(
                        start + j < seq_len and (not is_causal or start + j <= token),
                        0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                if not late:
                    T.reduce_sum(scores, denom, dim=1, clear=True)
                    for i in T.Parallel(G):
                        inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] *= inv[i]
                T.copy(scores, prob)
            for vo in T.unroll(D // W):
                T.clear(out)
                if valid:
                    if vo > 0:
                        for j, d in T.Parallel(BS, W):
                            v[j, d] = V[b, block, h, j // 16, vo * (W // 32) + d // 32,
                                (j % 16 // 4) * 16 + d % 16,
                                (d % 32 // 16) * 4 + j % 4]
                    for ki in T.serial(BS // 16):
                        pv.mma(prob, v, out, ki)
                    if late:
                        if vo == 0:
                            T.reduce_sum(scores, denom, dim=1, clear=True)
                            for i in T.Parallel(G):
                                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                        for i, j in T.Parallel(G, W):
                            out[i, j] *= inv[i]
                for oi, od in T.Parallel(G, W):
                    output_reg[oi, vo * W + od] = out[oi, od]
            output_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({output_shared:
                tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)})
            T.sync_warp()
            T.copy(output_reg, output_shared)
            T.sync_warp()
            T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])
    return kernel


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_single_packed_qo_v2(batch, heads, seq_len, dim, is_causal, block_size,
                     groups, scale_log2, threads=64, width=32, late=False):
    assert groups == 16 and threads == 64 and dim in (64, 128) and block_size in (16, 32)
    G, BS, D = groups, block_size, dim
    H = heads // groups
    W = min(width, D)
    NB = tilelang.cdiv(seq_len, BS)
    qk, _ = _emitters(T.float16, T.float32, BS, D)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=W, chunk=BS, k_pack=1)
    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            q_shared = T.alloc_shared([G, D], T.float16)
            output_reg = T.alloc_fragment([G, D], T.float16)
            T.annotate_layout({
                q_stage: T.Fragment([G, D],
                    forward_thread_fn=lambda qi, qd: (qi * D + qd) // 4 % 64,
                    forward_index_fn=lambda qi, qd: (qi * D + qd) // 256 * 4 + qd % 4),
                q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8),
                output_reg: T.Fragment([G, D],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
            })
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, W], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, W], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'A'),
                k: qk.make_mma_load_layout(k, 'B'),
                v: pv.make_mma_load_layout(v, 'B'),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
            })
            b, h = bh // H, bh % H
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
            block = Indices[b, token, h, 0]
            start = block * BS
            valid = block >= 0 and block < NB and (not is_causal or start <= token)
            if valid:
                for j, d in T.Parallel(BS, D):
                    k[j, d] = K[b, block, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8]
                T.copy(q_stage, q_shared)
                T.sync_warp()
                T.copy(q_shared, q)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.if_then_else(
                        start + j < seq_len and (not is_causal or start + j <= token),
                        0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
                for j, d in T.Parallel(BS, W):
                    v[j, d] = V[b, block, h, j // 16, d // 32,
                        (j % 16 // 4) * 16 + d % 16,
                        (d % 32 // 16) * 4 + j % 4]
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                if not late:
                    T.reduce_sum(scores, denom, dim=1, clear=True)
                    for i in T.Parallel(G):
                        inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] *= inv[i]
                T.copy(scores, prob)
            for vo in T.unroll(D // W):
                T.clear(out)
                if valid:
                    if vo > 0:
                        for j, d in T.Parallel(BS, W):
                            v[j, d] = V[b, block, h, j // 16, vo * (W // 32) + d // 32,
                                (j % 16 // 4) * 16 + d % 16,
                                (d % 32 // 16) * 4 + j % 4]
                    for ki in T.serial(BS // 16):
                        pv.mma(prob, v, out, ki)
                    if late:
                        if vo == 0:
                            T.reduce_sum(scores, denom, dim=1, clear=True)
                            for i in T.Parallel(G):
                                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                        for i, j in T.Parallel(G, W):
                            out[i, j] *= inv[i]
                for oi, od in T.Parallel(G, W):
                    output_reg[oi, vo * W + od] = out[oi, od]
            output_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({output_shared:
                tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)})
            T.sync_warp()
            T.copy(output_reg, output_shared)
            T.sync_warp()
            T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])
    return kernel


@tilelang.jit
def native_sparse_attention_pack_kv_bs32_direct(batch, seq_len, heads, dim, block_size):
    BS, D = block_size, dim
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D//32, BS//16, 64, 8], T.float16),
        Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS//16, D//32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=128) as (bs, h, b):
            packed_v = T.alloc_fragment([BS, D], T.float16)
            T.annotate_layout({packed_v: T.Fragment([BS, D],
                forward_thread_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                    + (pj % 16 // 4) * 16 + pd % 16) % 128),
                forward_index_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                    + (pj % 16 // 4) * 16 + pd % 16) // 128 * 8
                    + (pd % 32 // 16) * 4 + pj % 4))})
            ktile = T.alloc_fragment([BS, D], T.float16)
            T.copy(K[b, bs * BS : (bs + 1) * BS, h, :], ktile)
            for j, d in T.Parallel(BS, D):
                PackedK[b, bs, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8] = ktile[j, d]
            tile = T.alloc_fragment([BS, D], T.float16)
            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], packed_v)
            for j, d in T.Parallel(BS, D):
                Packed[b, bs, h, j // 16, d // 32,
                       (j % 16 // 4) * 16 + d % 16,
                       (d % 32 // 16) * 4 + j % 4] = packed_v[j, d]
    return kernel


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_pack_kv_bs32_shared(batch, seq_len, heads, dim, block_size):
    BS, D = block_size, dim
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D//32, BS//16, 64, 8], T.float16),
        Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS//16, D//32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=256) as (bs, h, b):
            packed_v = T.alloc_fragment([BS, D], T.float16)
            T.annotate_layout({packed_v: T.Fragment([BS, D],
                forward_thread_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                    + (pj % 16 // 4) * 16 + pd % 16) % 256),
                forward_index_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                    + (pj % 16 // 4) * 16 + pd % 16) // 256 * 8
                    + (pd % 32 // 16) * 4 + pj % 4))})
            v_shared = T.alloc_shared([BS, D], T.float16)
            T.annotate_layout({v_shared:
                tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=4)})
            ktile = T.alloc_fragment([BS, D], T.float16)
            T.copy(K[b, bs * BS : (bs + 1) * BS, h, :], ktile)
            for j, d in T.Parallel(BS, D):
                PackedK[b, bs, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8] = ktile[j, d]
            tile = T.alloc_fragment([BS, D], T.float16)
            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], tile)
            T.copy(tile, v_shared)
            T.sync_threads()
            T.copy(v_shared, packed_v)
            for j, d in T.Parallel(BS, D):
                Packed[b, bs, h, j // 16, d // 32,
                       (j % 16 // 4) * 16 + d % 16,
                       (d % 32 // 16) * 4 + j % 4] = packed_v[j, d]
    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_short_list_qo_v2(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    selected_blocks, threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16 and not direct_k and not kv_split
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, IBS, S = groups, block_size, selected_blocks
    BS = IBS * S
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, S], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            T.annotate_layout({
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda qi, qd: (qi * BK + qd) // 8 % 64,
                    forward_index_fn=lambda qi, qd: (qi * BK + qd) // 512 * 8 + qd % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
            })
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)
            starts = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                starts[si] = T.min(T.max(BlockIndices[i_b, i_t, i_h, si], -1), T.ceildiv(seq_len, IBS)) * IBS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if T.bool(True):
                for j, d in T.Parallel(BS, BK):
                    kpos = _paired_pos_sel(j, starts, S, IBS)
                    K_reg[j, d] = T.if_then_else(kpos >= 0 and kpos < seq_len and d < dim,
                        K[i_b, kpos, i_h, d], T.float16(0))
                for j, d in T.Parallel(BS, BV):
                    vpos = _paired_pos_sel(j, starts, S, IBS)
                    V_reg[j, d] = T.if_then_else(vpos >= 0 and vpos < seq_len and d < dim,
                        V[i_b, vpos, i_h, d], T.float16(0))
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                for i, j in T.Parallel(G, BS):
                    pos = _paired_pos_sel(j, starts, S, IBS)
                    acc_s[i, j] = T.if_then_else(
                        pos >= 0 and pos < seq_len and (not is_causal or pos <= i_t),
                        T.float32(0), -T.infinity(T.float32))


                T.sync_warp()
                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)


                T.sync_warp()
                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: T.Fragment([G, BV],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            T.copy(acc_o, O_reg)
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_online_packed_batch_minor_o_v2(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False, prefetch_depth=1,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]
    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(packed_k_shape, T.float16),
        V: T.Tensor(packed_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            K_reg1 = T.alloc_fragment([BS, BK], T.float16)
            K_reg2 = T.alloc_fragment([BS, BK], T.float16)
            K_reg3 = T.alloc_fragment([BS, BK], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            acc_o_alt = T.alloc_fragment([G, BV], T.float32)
            sum_acc = T.alloc_fragment([G, BS], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)

            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                V_reg: pv.make_mma_load_layout(V_reg, "B"),
                K_reg: qk.make_mma_load_layout(K_reg, "B"),
                K_reg1: qk.make_mma_load_layout(K_reg1, "B"),
                K_reg2: qk.make_mma_load_layout(K_reg2, "B"),
                K_reg3: qk.make_mma_load_layout(K_reg3, "B"),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
                acc_o_alt: pv.make_mma_store_layout(acc_o_alt),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv

            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            if dual_acc:
                T.fill(acc_o_alt, 0)
            T.fill(sum_acc, 0)

            neg_inf = -T.infinity(T.float32)
            if prefetch_depth == 1:
                for s in T.unroll(S, unroll_factor=online_unroll):
                    i_s = indices[s]
                    if (i_s >= 0 and i_s < seq_len
                            and (not is_causal or i_s <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and s % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)

            else:
                for group in T.serial(T.ceildiv(S, prefetch_depth)):
                    i_s0 = indices[T.min(group * prefetch_depth + 0, S - 1)]
                    i_s1 = indices[T.min(group * prefetch_depth + 1, S - 1)]
                    i_s2 = indices[T.min(group * prefetch_depth + 2, S - 1)]
                    i_s3 = indices[T.min(group * prefetch_depth + 3, S - 1)]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s0 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg1[j, d] = K[i_b, i_s1 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg2[j, d] = K[i_b, i_s2 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg3[j, d] = K[i_b, i_s3 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s0 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s0 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s0 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 0) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s1 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s1 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s1 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg1, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 1) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s2 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s2 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s2 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg2, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 2) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s3 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s3 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s3 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg3, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 3) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)

            if dual_acc:
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] += acc_o_alt[i, j]
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= inv_sum[i]

            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: T.Fragment([G, BV],
                    forward_thread_fn=lambda oi, od: oi + (od % 16 // 4) * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            T.copy(acc_o, O_reg)
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_online_packed_quad_batch_minor_o_v2(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False, prefetch_depth=1,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]
    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(packed_k_shape, T.float16),
        V: T.Tensor(packed_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            K_reg1 = T.alloc_fragment([BS, BK], T.float16)
            K_reg2 = T.alloc_fragment([BS, BK], T.float16)
            K_reg3 = T.alloc_fragment([BS, BK], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            acc_o_1 = T.alloc_fragment([G, BV], T.float32)
            acc_o_2 = T.alloc_fragment([G, BV], T.float32)
            acc_o_3 = T.alloc_fragment([G, BV], T.float32)
            sum_acc = T.alloc_fragment([G, BS], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)

            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                V_reg: pv.make_mma_load_layout(V_reg, "B"),
                K_reg: qk.make_mma_load_layout(K_reg, "B"),
                K_reg1: qk.make_mma_load_layout(K_reg1, "B"),
                K_reg2: qk.make_mma_load_layout(K_reg2, "B"),
                K_reg3: qk.make_mma_load_layout(K_reg3, "B"),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
                acc_o_1: pv.make_mma_store_layout(acc_o_1),
                acc_o_2: pv.make_mma_store_layout(acc_o_2),
                acc_o_3: pv.make_mma_store_layout(acc_o_3),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv

            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            T.fill(acc_o_1, 0)
            T.fill(acc_o_2, 0)
            T.fill(acc_o_3, 0)
            T.fill(sum_acc, 0)

            neg_inf = -T.infinity(T.float32)
            if prefetch_depth == 1:
                for s in T.unroll(S, unroll_factor=online_unroll):
                    i_s = indices[s]
                    if (i_s >= 0 and i_s < seq_len
                            and (not is_causal or i_s <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if s % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif s % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif s % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)

            else:
                for group in T.serial(T.ceildiv(S, prefetch_depth)):
                    i_s0 = indices[T.min(group * prefetch_depth + 0, S - 1)]
                    i_s1 = indices[T.min(group * prefetch_depth + 1, S - 1)]
                    i_s2 = indices[T.min(group * prefetch_depth + 2, S - 1)]
                    i_s3 = indices[T.min(group * prefetch_depth + 3, S - 1)]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s0 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg1[j, d] = K[i_b, i_s1 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg2[j, d] = K[i_b, i_s2 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg3[j, d] = K[i_b, i_s3 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s0 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s0 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s0 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 0) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 0) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 0) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s1 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s1 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s1 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg1, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 1) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 1) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 1) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s2 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s2 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s2 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg2, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 2) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 2) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 2) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s3 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s3 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s3 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg3, acc_s, ki)

                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(
                                T.min(acc_s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        T.copy(acc_s, acc_s_cast)
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 3) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 3) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 3) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)

            for i, j in T.Parallel(G, BV):
                acc_o[i, j] += acc_o_1[i, j]
                acc_o[i, j] += acc_o_2[i, j]
                acc_o[i, j] += acc_o_3[i, j]
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= inv_sum[i]

            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: T.Fragment([G, BV],
                    forward_thread_fn=lambda oi, od: oi + (od % 16 // 4) * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            T.copy(acc_o, O_reg)
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def native_sparse_attention_single_block_emitter_index_guard(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)
            V_shared = T.alloc_shared([BS, BV], T.float16) if kv_split else KV_shared
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(KV_shared, vecSize=8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if kv_split:
                _layout[V_shared] = tilelang.maca.intrinsics.make_mma_swizzle_layout(V_shared, vecSize=8)
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _selected_start_0 = _selected_block * BS
                T.copy(K[i_b, _selected_start_0:_selected_start_0 + BS, i_h, :], K_reg)
                T.copy(V[i_b, _selected_start_0:_selected_start_0 + BS, i_h, i_v * BV:(i_v + 1) * BV], V_reg)
                if not direct_k:
                    T.copy(K_reg, KV_shared)
                if kv_split:
                    T.copy(V_reg, V_shared)
                if is_causal and _selected_start_0 + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_selected_start_0 + j <= i_t, 0, -T.infinity(T.float32))
                elif not is_causal and _selected_start_0 + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_selected_start_0 + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)
                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                T.copy(acc_s, acc_s_cast)
                vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)
                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
            T.copy(acc_o, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
    return kernel


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_single_block_emitter_wave_index_guard(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert threads == 64 and groups == 16 and (not kv_split)
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)
            V_shared = T.alloc_shared([BS, BV], T.float16) if kv_split else KV_shared
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(KV_shared, vecSize=8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if kv_split:
                _layout[V_shared] = tilelang.maca.intrinsics.make_mma_swizzle_layout(V_shared, vecSize=8)
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _selected_start_0 = _selected_block * BS
                T.copy(K[i_b, _selected_start_0:_selected_start_0 + BS, i_h, :], K_reg)
                T.copy(V[i_b, _selected_start_0:_selected_start_0 + BS, i_h, i_v * BV:(i_v + 1) * BV], V_reg)
                if not direct_k:
                    T.copy(K_reg, KV_shared)
                if kv_split:
                    T.copy(V_reg, V_shared)
                if is_causal and _selected_start_0 + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_selected_start_0 + j <= i_t, 0, -T.infinity(T.float32))
                elif not is_causal and _selected_start_0 + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_selected_start_0 + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)
                if not direct_k:
                    T.sync_warp()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)
                if not direct_k:
                    T.sync_warp()
                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)
                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
            T.copy(acc_o, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
    return kernel


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_d32_shuffle_wave_index_guard(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert threads == 64 and groups == 16 and (not kv_split)
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            tid = T.get_thread_binding()
            ks_raw = T.alloc_local([8], T.float16)
            ks_w0 = T.Tensor([4], T.uint32, data=ks_raw.data, scope='local')
            ks_w1 = T.alloc_local([4], T.uint32)
            ks_mma = T.Tensor([8], T.float16, data=ks_w1.data, scope='local')
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)
            V_shared = T.alloc_shared([BS, BV], T.float16) if kv_split else KV_shared
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS, BK], lambda j, d: (j, d)), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if kv_split:
                _layout[V_shared] = tilelang.maca.intrinsics.make_mma_swizzle_layout(V_shared, vecSize=8)
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _selected_start_0 = _selected_block * BS
                for slot in T.unroll(1):
                    for e in T.vectorized(8):
                        linear = (slot * 8 + e) // 1 % 2 * 1 + (slot * 8 + e) // 2 % 2 * 2 + (slot * 8 + e) // 4 % 2 * 4 + tid // 1 % 2 * 8 + tid // 2 % 2 * 16 + tid // 4 % 2 * 32 + tid // 8 % 2 * 64 + tid // 16 % 2 * 128 + tid // 32 % 2 * 256
                        ks_raw[slot * 8 + e] = T.if_then_else(_selected_start_0 + linear // 32 < seq_len, K[i_b, _selected_start_0 + linear // 32, i_h, linear % 32], T.float16(0))
                T.copy(V[i_b, _selected_start_0:_selected_start_0 + BS, i_h, i_v * BV:(i_v + 1) * BV], V_reg)
                ks_w1[0] = T.shfl_sync(ks_w0[0], tid // 16 % 2 * 1 + tid // 32 % 2 * 2 + tid // 1 % 2 * 4 + tid // 2 % 2 * 8 + tid // 4 % 2 * 16 + tid // 8 % 2 * 32, 64, 18446744073709551615)
                ks_w1[1] = T.shfl_sync(ks_w0[1], tid // 16 % 2 * 1 + tid // 32 % 2 * 2 + tid // 1 % 2 * 4 + tid // 2 % 2 * 8 + tid // 4 % 2 * 16 + tid // 8 % 2 * 32, 64, 18446744073709551615)
                ks_w1[2] = T.shfl_sync(ks_w0[2], tid // 16 % 2 * 1 + tid // 32 % 2 * 2 + tid // 1 % 2 * 4 + tid // 2 % 2 * 8 + tid // 4 % 2 * 16 + tid // 8 % 2 * 32, 64, 18446744073709551615)
                ks_w1[3] = T.shfl_sync(ks_w0[3], tid // 16 % 2 * 1 + tid // 32 % 2 * 2 + tid // 1 % 2 * 4 + tid // 2 % 2 * 8 + tid // 4 % 2 * 16 + tid // 8 % 2 * 32, 64, 18446744073709551615)
                if kv_split:
                    T.copy(V_reg, V_shared)
                if is_causal and _selected_start_0 + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_selected_start_0 + j <= i_t, 0, -T.infinity(T.float32))
                elif not is_causal and _selected_start_0 + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_selected_start_0 + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.unroll(qk_steps):
                    for e in T.vectorized(BS // 16 * 8):
                        kb[e] = ks_mma[ki * (BS // 16 * 8) + e]
                    qk.mma(Q_reg, kb, acc_s, ki)
                if not kv_split:
                    T.copy(V_reg, KV_shared)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)
                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
            T.copy(acc_o, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
    return kernel


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_d32_compact(batch, heads, seq_len, dim, is_causal,
        block_size, groups, scale_log2, threads=64):
    assert dim == 32 and block_size == 16 and groups == 16 and threads == 64
    G, BS, BK, BV = 16, 16, 32, 32
    H = heads // G
    NB = T.ceildiv(seq_len, BS)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, dim], T.float16),
        K: T.Tensor([batch, seq_len, H, dim], T.float16),
        V: T.Tensor([batch, seq_len, H, dim], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, dim], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, 1), batch * H, threads=64) as (bx, bh):
            tid = T.get_thread_binding()
            b, h = bh // H, bh % H
            shared = T.alloc_shared([1 * BS * BV], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, BV], T.float32)
            sums = T.alloc_fragment([G, 4], T.float32)
            vb = T.alloc_local([8], T.float16)
            T.annotate_layout({
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, "A"),
                out: pv.make_mma_store_layout(out),
                sums: T.Fragment([G, 4], forward_thread_fn=lambda sm, sl: sm + sl * 16,
                                 forward_index_fn=lambda sm, sl: 0),
            })

            q_0 = T.alloc_fragment([G, BK], T.float16)
            v_0 = T.alloc_fragment([BS, BV], T.float16)
            raw_0 = T.alloc_local([8], T.float16)
            words_0 = T.Tensor([4], T.uint32, data=raw_0.data, scope="local")
            shuffled_0 = T.alloc_local([4], T.uint32)
            mma_k_0 = T.Tensor([8], T.float16, data=shuffled_0.data, scope="local")
            T.annotate_layout({
                q_0: qk.make_mma_load_layout(q_0, "A"),
                v_0: T.Fragment([BS, BV],
                    forward_thread_fn=lambda vr, vc: (vr * BV + vc) // 8 % 64,
                    forward_index_fn=lambda vr, vc: (vr * BV + vc) // 512 * 8 + vc % 8),
            })


            t_0 = bx * 1 + 0
            T.copy(Q[b, t_0, h * G:(h + 1) * G, :], q_0)
            index_0 = T.if_then_else(t_0 < seq_len, Indices[b, t_0, h, 0], -1)
            valid_0 = (t_0 < seq_len and index_0 >= 0 and index_0 < NB
                         and (not is_causal or index_0 <= t_0 // BS))
            T.clear(out)
            if valid_0:
                for e in T.vectorized(8):
                    raw_0[e] = T.if_then_else((index_0 * BS) + tid // 4 < seq_len,
                        K[b, (index_0 * BS) + tid // 4, h, tid % 4 * 8 + e], T.float16(0))
                T.copy(V[b, (index_0 * BS):(index_0 * BS) + BS, h, :], v_0)

                for word in T.unroll(4):
                    shuffled_0[word] = T.shfl_sync(words_0[word],
                        tid % 16 * 4 + tid // 16, 64, 0xffffffffffffffff)
                if is_causal and (index_0 * BS) + BS > t_0 + 1:
                    for m, n in T.Parallel(G, BS):
                        scores[m, n] = T.if_then_else((index_0 * BS) + n <= t_0,
                            0, -T.infinity(T.float32))
                elif not is_causal and (index_0 * BS) + BS > seq_len:
                    for m, n in T.Parallel(G, BS):
                        scores[m, n] = T.if_then_else((index_0 * BS) + n < seq_len,
                            0, -T.infinity(T.float32))
                else:
                    T.clear(scores)
                qk.mma(q_0, mma_k_0, scores, 0)


                for vr, vc in T.Parallel(BS, BV):
                    shared[(0 * BS + vr) * BV + vc] = v_0[vr, vc]
                for m, n in T.Parallel(G, BS):
                    scores[m, n] = T.exp2(T.min(scores[m, n] * scale_log2, 15.0))
                for m, lane in T.Parallel(G, 4):
                    sums[m, lane] = 0
                    for j in T.unroll(4):
                        sums[m, lane] += scores[m, lane * 4 + j]
                for m, lane in T.Parallel(G, 4):
                    sums[m, lane] += T.shfl_xor(sums[m, lane], 32, 64, 0xffffffffffffffff)
                    sums[m, lane] += T.shfl_xor(sums[m, lane], 16, 64, 0xffffffffffffffff)
                    sums[m, lane] = T.if_then_else(sums[m, lane] > 0, 1.0 / sums[m, lane], 0.0)
                for m, n in T.Parallel(G, BS):
                    scores[m, n] *= sums[m, n // 4]
                T.copy(scores, prob)
                T.sync_warp()
                for col in T.serial(BV // 16):
                    for e in T.serial(4):
                        vb[col * 4 + e] = shared[
                            (0 * BS + tid // 16 * 4 + e) * BV + col * 16 + tid % 16]
                pv.mma(prob, vb, out, 0)
            T.copy(out, Output[b, t_0, h * G:(h + 1) * G, :])

    return kernel


def _coalesced_block_loads_prim(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, wave_sync=True, q_vec=8, pv_width=128, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert block_size == 16 and seq_len % block_size == 0
    assert threads == 64 and groups == 16
    assert dim in (64, 128) and block_size in (16, 32)
    assert q_vec in (4, 8) and pv_width in (64, 128)
    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    VW = min(pv_width, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])
            _start_buffer_0 = T.alloc_local([1], T.int32)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            O_reg = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_reg: T.Fragment([G, BV], forward_thread_fn=lambda i, d: i + d % 16 // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_stage: T.Fragment([G, BK], forward_thread_fn=lambda i, d: (i * BK + d) // q_vec % 64, forward_index_fn=lambda i, d: (i * BK + d) // (64 * q_vec) * q_vec + d % q_vec), Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8), Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_stage)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _start_buffer_0[0] = _selected_block * BS
                for k_slot in T.unroll(BS * BK // 512):
                    for k_pair in T.unroll(4):
                        for k_element in T.vectorized(2):
                            K_reg[(k_slot * 512 + tid * 8) // BK, tid % (BK // 8) * 8 + k_pair * 2 + k_element] = K_blocks[i_b, _selected_block, (k_slot * 512 + tid * 8) // BK, i_h, tid % (BK // 8) * 8 + k_pair * 2 + k_element]
                for v_slot in T.unroll(BS * BV // 512):
                    for v_pair in T.unroll(4):
                        for v_element in T.vectorized(2):
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_pair * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, tid % (BV // 8) * 8 + v_pair * 2 + v_element]
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                if is_causal and _start_buffer_0[0] + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j <= i_t, 0, -T.infinity(T.float32))
                elif not is_causal and _start_buffer_0[0] + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                T.copy(acc_s, acc_s_cast)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[row * BK + col]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                for i, d in T.Parallel(G, VW):
                    O_reg[i, vo * VW + d] = acc_o[i, d]
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])
    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_coalesced_blocks(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, q_vec=8, pv_width=128,
):
    return _coalesced_block_loads_prim(
        batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
        threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_shared_q_blocks(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64,
    late_normalize=False,
    kv_split=False,
    direct_k=False,
    lane_reduce=False,
):

    assert threads == 64 and groups == 16 and not kv_split and not direct_k
    assert dim == 64 and block_size == 16 and seq_len % block_size == 0
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):


            _start_buffer_0 = T.alloc_local([1], T.int32)
            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)


            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)


            _layout = {
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: (i * BK + d) // 8 % 64,
                    forward_index_fn=lambda i, d: (i * BK + d) // 512 * 8 + d % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            }
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
            T.annotate_layout(_layout)

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv


            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)

            if _selected_block >= 0 and _selected_block < seq_len // BS and (not is_causal or _selected_block <= i_t // BS):
                _start_buffer_0[0] = _selected_block * BS
                for k_slot in T.unroll(BS * BK // 512):
                    for k_word in T.unroll(4):
                        for k_element in T.vectorized(2):
                            K_reg[(k_slot * 512 + tid * 8) // BK, tid % (BK // 8) * 8 + k_word * 2 + k_element] = K_blocks[i_b, _selected_block, (k_slot * 512 + tid * 8) // BK, i_h, tid % (BK // 8) * 8 + k_word * 2 + k_element]
                for v_slot in T.unroll(BS * BV // 512):
                    for v_word in T.unroll(4):
                        for v_element in T.vectorized(2):
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_word * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, tid % (BV // 8) * 8 + v_word * 2 + v_element]
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]

                if is_causal and _start_buffer_0[0] + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            _start_buffer_0[0] + j <= i_t, 0, -T.infinity(T.float32))
                elif (not is_causal) and _start_buffer_0[0] + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(
                            _start_buffer_0[0] + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)

                T.sync_warp()


                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + (((ki * 32 + tid // 16 * 8 + e) // 8) ^ (((j * 16 + tid % 16) // KPHASE) % KMAX)) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)

                T.sync_warp()


                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
                T.copy(acc_s, acc_s_cast)
                T.sync_warp()
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)


                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                                1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(
                                scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_online_packed_batch_minor_o_v2_mathcast(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False, prefetch_depth=1,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]
    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(packed_k_shape, T.float16),
        V: T.Tensor(packed_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            K_reg1 = T.alloc_fragment([BS, BK], T.float16)
            K_reg2 = T.alloc_fragment([BS, BK], T.float16)
            K_reg3 = T.alloc_fragment([BS, BK], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            acc_o_alt = T.alloc_fragment([G, BV], T.float32)
            sum_acc = T.alloc_fragment([G, BS], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)

            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                V_reg: pv.make_mma_load_layout(V_reg, "B"),
                K_reg: qk.make_mma_load_layout(K_reg, "B"),
                K_reg1: qk.make_mma_load_layout(K_reg1, "B"),
                K_reg2: qk.make_mma_load_layout(K_reg2, "B"),
                K_reg3: qk.make_mma_load_layout(K_reg3, "B"),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
                acc_o_alt: pv.make_mma_store_layout(acc_o_alt),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv

            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                raw_index = BlockIndices[i_b, i_t, i_h, si]
                indices[si] = T.min(T.max(raw_index, -1), T.ceildiv(seq_len, BS)) * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            if dual_acc:
                T.fill(acc_o_alt, 0)
            T.fill(sum_acc, 0)

            neg_inf = -T.infinity(T.float32)
            if prefetch_depth == 1:
                for s in T.unroll(S, unroll_factor=online_unroll):
                    i_s = indices[s]
                    if (i_s >= 0 and i_s < seq_len
                            and (not is_causal or i_s <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s + j < seq_len and (not is_causal or i_s + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if dual_acc and s % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)

            else:
                for group in T.serial(T.ceildiv(S, prefetch_depth)):
                    i_s0 = indices[T.min(group * prefetch_depth + 0, S - 1)]
                    i_s1 = indices[T.min(group * prefetch_depth + 1, S - 1)]
                    i_s2 = indices[T.min(group * prefetch_depth + 2, S - 1)]
                    i_s3 = indices[T.min(group * prefetch_depth + 3, S - 1)]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s0 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg1[j, d] = K[i_b, i_s1 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg2[j, d] = K[i_b, i_s2 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg3[j, d] = K[i_b, i_s3 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s0 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s0 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s0 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s0 + j < seq_len and (not is_causal or i_s0 + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 0) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s1 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s1 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s1 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg1, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s1 + j < seq_len and (not is_causal or i_s1 + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 1) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s2 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s2 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s2 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg2, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s2 + j < seq_len and (not is_causal or i_s2 + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 2) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s3 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s3 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s3 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg3, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s3 + j < seq_len and (not is_causal or i_s3 + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if dual_acc and (group * prefetch_depth + 3) % 2 != 0:
                                pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)

            if dual_acc:
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] += acc_o_alt[i, j]
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= inv_sum[i]

            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: T.Fragment([G, BV],
                    forward_thread_fn=lambda oi, od: oi + (od % 16 // 4) * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            for cast_chunk in T.unroll(BV // 16):
                for cast_lane in T.unroll(4):
                    O_reg[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_o[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False, prefetch_depth=1,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]
    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(packed_k_shape, T.float16),
        V: T.Tensor(packed_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            K_reg1 = T.alloc_fragment([BS, BK], T.float16)
            K_reg2 = T.alloc_fragment([BS, BK], T.float16)
            K_reg3 = T.alloc_fragment([BS, BK], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            acc_o_1 = T.alloc_fragment([G, BV], T.float32)
            acc_o_2 = T.alloc_fragment([G, BV], T.float32)
            acc_o_3 = T.alloc_fragment([G, BV], T.float32)
            sum_acc = T.alloc_fragment([G, BS], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)

            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                V_reg: pv.make_mma_load_layout(V_reg, "B"),
                K_reg: qk.make_mma_load_layout(K_reg, "B"),
                K_reg1: qk.make_mma_load_layout(K_reg1, "B"),
                K_reg2: qk.make_mma_load_layout(K_reg2, "B"),
                K_reg3: qk.make_mma_load_layout(K_reg3, "B"),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
                acc_o_1: pv.make_mma_store_layout(acc_o_1),
                acc_o_2: pv.make_mma_store_layout(acc_o_2),
                acc_o_3: pv.make_mma_store_layout(acc_o_3),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv

            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                raw_index = BlockIndices[i_b, i_t, i_h, si]
                indices[si] = T.min(T.max(raw_index, -1), T.ceildiv(seq_len, BS)) * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            T.fill(acc_o_1, 0)
            T.fill(acc_o_2, 0)
            T.fill(acc_o_3, 0)
            T.fill(sum_acc, 0)

            neg_inf = -T.infinity(T.float32)
            if prefetch_depth == 1:
                for s in T.unroll(S, unroll_factor=online_unroll):
                    i_s = indices[s]
                    if (i_s >= 0 and i_s < seq_len
                            and (not is_causal or i_s <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s + j < seq_len and (not is_causal or i_s + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if s % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif s % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif s % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)

            else:
                for group in T.serial(T.ceildiv(S, prefetch_depth)):
                    i_s0 = indices[T.min(group * prefetch_depth + 0, S - 1)]
                    i_s1 = indices[T.min(group * prefetch_depth + 1, S - 1)]
                    i_s2 = indices[T.min(group * prefetch_depth + 2, S - 1)]
                    i_s3 = indices[T.min(group * prefetch_depth + 3, S - 1)]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg[j, d] = K[i_b, i_s0 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg1[j, d] = K[i_b, i_s1 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg2[j, d] = K[i_b, i_s2 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BK):
                            K_reg3[j, d] = K[i_b, i_s3 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S and i_s0 >= 0 and i_s0 < seq_len
                            and (not is_causal or i_s0 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s0 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s0 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s0 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s0 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s0 + j < seq_len and (not is_causal or i_s0 + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 0) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 0) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 0) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 1 and group * prefetch_depth + 1 < S and i_s1 >= 0 and i_s1 < seq_len
                            and (not is_causal or i_s1 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s1 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s1 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s1 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s1 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg1, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s1 + j < seq_len and (not is_causal or i_s1 + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 1) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 1) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 1) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 2 and group * prefetch_depth + 2 < S and i_s2 >= 0 and i_s2 < seq_len
                            and (not is_causal or i_s2 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s2 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s2 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s2 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s2 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg2, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s2 + j < seq_len and (not is_causal or i_s2 + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 2) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 2) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 2) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)
                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S and i_s3 >= 0 and i_s3 < seq_len
                            and (not is_causal or i_s3 <= i_t)):
                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s3 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]

                        if is_causal and i_s3 + BS > i_t + 1:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j <= i_t, 0, neg_inf)
                        elif (not is_causal) and i_s3 + BS > seq_len:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(
                                    i_s3 + j < seq_len, 0, neg_inf)
                        else:
                            T.clear(acc_s)

                        for ki in T.serial(qk_steps):
                            qk.mma(Q_reg, K_reg3, acc_s, ki)

                        if scale_log2 > 0:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            for i, j in T.Parallel(G, BS):
                                acc_s[i, j] = T.if_then_else(i_s3 + j < seq_len and (not is_causal or i_s3 + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        for i, j in T.Parallel(G, BS):
                            sum_acc[i, j] += acc_s[i, j]
                        for cast_chunk in T.unroll(BS // 16):
                            for cast_lane in T.unroll(4):
                                acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                        for ki in T.serial(pv_steps):
                            if (group * prefetch_depth + 3) % 4 == 0:
                                pv.mma(acc_s_cast, V_reg, acc_o, ki)
                            elif (group * prefetch_depth + 3) % 4 == 1:
                                pv.mma(acc_s_cast, V_reg, acc_o_1, ki)
                            elif (group * prefetch_depth + 3) % 4 == 2:
                                pv.mma(acc_s_cast, V_reg, acc_o_2, ki)
                            else:
                                pv.mma(acc_s_cast, V_reg, acc_o_3, ki)

            for i, j in T.Parallel(G, BV):
                acc_o[i, j] += acc_o_1[i, j]
                acc_o[i, j] += acc_o_2[i, j]
                acc_o[i, j] += acc_o_3[i, j]
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= inv_sum[i]

            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: T.Fragment([G, BV],
                    forward_thread_fn=lambda oi, od: oi + (od % 16 // 4) * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            for cast_chunk in T.unroll(BV // 16):
                for cast_lane in T.unroll(4):
                    O_reg[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_o[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_single_packed_qo_v2_mathcast(batch, heads, seq_len, dim, is_causal, block_size,
                     groups, scale_log2, threads=64, width=32, late=False):
    assert groups == 16 and threads == 64 and dim in (64, 128) and block_size in (16, 32)
    G, BS, D = groups, block_size, dim
    H = heads // groups
    W = min(width, D)
    NB = tilelang.cdiv(seq_len, BS)
    qk, _ = _emitters(T.float16, T.float32, BS, D)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=W, chunk=BS, k_pack=1)
    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),
        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            q_shared = T.alloc_shared([G, D], T.float16)
            output_reg = T.alloc_fragment([G, D], T.float16)
            T.annotate_layout({
                q_stage: T.Fragment([G, D],
                    forward_thread_fn=lambda qi, qd: (qi * D + qd) // 4 % 64,
                    forward_index_fn=lambda qi, qd: (qi * D + qd) // 256 * 4 + qd % 4),
                q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8),
                output_reg: T.Fragment([G, D],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
            })
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, W], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, W], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'A'),
                k: qk.make_mma_load_layout(k, 'B'),
                v: pv.make_mma_load_layout(v, 'B'),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
            })
            b, h = bh // H, bh % H
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
            block = Indices[b, token, h, 0]
            start = block * BS
            valid = block >= 0 and block < NB and (not is_causal or start <= token)
            if valid:
                for j, d in T.Parallel(BS, D):
                    k[j, d] = K[b, block, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8]
                T.copy(q_stage, q_shared)
                T.sync_warp()
                T.copy(q_shared, q)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.if_then_else(
                        start + j < seq_len and (not is_causal or start + j <= token),
                        0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
                for j, d in T.Parallel(BS, W):
                    v[j, d] = V[b, block, h, j // 16, d // 32,
                        (j % 16 // 4) * 16 + d % 16,
                        (d % 32 // 16) * 4 + j % 4]
                if scale_log2 > 0:
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                else:
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] = T.if_then_else(start + j < seq_len and (not is_causal or start + j <= token), T.exp2(T.min(scores[i, j] * scale_log2, 15.0)), 0.0)
                if not late:
                    T.reduce_sum(scores, denom, dim=1, clear=True)
                    for i in T.Parallel(G):
                        inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] *= inv[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        prob[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = scores[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            for vo in T.unroll(D // W):
                T.clear(out)
                if valid:
                    if vo > 0:
                        for j, d in T.Parallel(BS, W):
                            v[j, d] = V[b, block, h, j // 16, vo * (W // 32) + d // 32,
                                (j % 16 // 4) * 16 + d % 16,
                                (d % 32 // 16) * 4 + j % 4]
                    for ki in T.serial(BS // 16):
                        pv.mma(prob, v, out, ki)
                    if late:
                        if vo == 0:
                            T.reduce_sum(scores, denom, dim=1, clear=True)
                            for i in T.Parallel(G):
                                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                        for i, j in T.Parallel(G, W):
                            out[i, j] *= inv[i]
                for cast_chunk in T.unroll(W // 16):
                    for cast_lane in T.unroll(4):
                        output_reg[T.get_thread_binding() % 16, vo * W + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = out[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            output_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({output_shared:
                tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)})
            T.sync_warp()
            T.copy(output_reg, output_shared)
            T.sync_warp()
            T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])
    return kernel


def _coalesced_block_loads_prim_mathcast(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, wave_sync=True, q_vec=8, pv_width=128, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert block_size == 16 and seq_len % block_size == 0
    assert threads == 64 and groups == 16
    assert dim in (64, 128) and block_size in (16, 32)
    assert q_vec in (4, 8) and pv_width in (64, 128)
    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    VW = min(pv_width, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])
            _start_buffer_0 = T.alloc_local([1], T.int32)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            O_reg = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_reg: T.Fragment([G, BV], forward_thread_fn=lambda i, d: i + d % 16 // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_stage: T.Fragment([G, BK], forward_thread_fn=lambda i, d: (i * BK + d) // q_vec % 64, forward_index_fn=lambda i, d: (i * BK + d) // (64 * q_vec) * q_vec + d % q_vec), Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8), Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_stage)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _start_buffer_0[0] = _selected_block * BS
                for k_slot in T.unroll(BS * BK // 512):
                    for k_pair in T.unroll(4):
                        for k_element in T.vectorized(2):
                            K_reg[(k_slot * 512 + tid * 8) // BK, tid % (BK // 8) * 8 + k_pair * 2 + k_element] = K_blocks[i_b, _selected_block, (k_slot * 512 + tid * 8) // BK, i_h, tid % (BK // 8) * 8 + k_pair * 2 + k_element]
                for v_slot in T.unroll(BS * BV // 512):
                    for v_pair in T.unroll(4):
                        for v_element in T.vectorized(2):
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_pair * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, tid % (BV // 8) * 8 + v_pair * 2 + v_element]
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                if is_causal and _start_buffer_0[0] + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j <= i_t, 0, -T.infinity(T.float32))
                elif not is_causal and _start_buffer_0[0] + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                if scale_log2 > 0:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                else:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j < seq_len and (not is_causal or _start_buffer_0[0] + j <= i_t), T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0)), 0.0)
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[row * BK + col]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                for cast_chunk in T.unroll(VW // 16):
                    for cast_lane in T.unroll(4):
                        O_reg[T.get_thread_binding() % 16, vo * VW + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_o[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])
    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_coalesced_blocks_mathcast(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, q_vec=8, pv_width=128,
):
    return _coalesced_block_loads_prim_mathcast(
        batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
        threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def native_sparse_attention_direct_kv(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, natural=True, late=False):
    assert threads == 64 and groups == 16 and (block_size == 16)
    assert dim in (32, 64, 128) and seq_len % block_size == 0
    G, BS, D = (groups, block_size, dim)
    H, NB = (heads // groups, seq_len // block_size)
    qk, pv = _emitters(T.float16, T.float32, BS, D)

    @T.prim_func
    def kernel(Q: T.Tensor([batch, seq_len, heads, D], T.float16), K: T.Tensor([batch, seq_len, H, D], T.float16), V: T.Tensor([batch, seq_len, H, D], T.float16), Indices: T.Tensor([batch, seq_len, H, 1], T.int32), Output: T.Tensor([batch, seq_len, heads, D], T.float16)):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            result = T.alloc_fragment([G, D], T.float16)
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
                for j, d in T.Parallel(BS, D):
                    v[j, d] = V_blocks[b, block, j, h, d]
                T.clear(scores)
                for ki in T.serial(D // 32):
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
                    for i, j in T.Parallel(G, D):
                        out[i, j] *= lane_sum[i, j % 16 // 4]
            for chunk in T.unroll(D // 16):
                for lane in T.unroll(4):
                    result[tid % 16, chunk * 16 + tid // 16 * 4 + lane] = out[tid % 16, chunk * 16 + tid // 16 * 4 + lane]
            T.copy(result, Output[b, token, h * G:(h + 1) * G, :])
    return kernel

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_linear_v_blocks_oct8(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert threads == 64 and groups == 16 and (not kv_split)
    assert dim == 128 and block_size == 16 and (seq_len % block_size == 0) and (not direct_k)
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            _start_buffer_0 = T.alloc_local([1], T.int32)
            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < seq_len // BS and (not is_causal or _selected_block <= i_t // BS):
                _start_buffer_0[0] = _selected_block * BS
                for k_slot in T.unroll(BS * BK // 512):
                    for k_word in T.unroll(4):
                        for k_element in T.vectorized(2):
                            K_reg[(k_slot * 512 + tid * 8) // BK, tid % (BK // 8) * 8 + k_word * 2 + k_element] = K_blocks[i_b, _selected_block, (k_slot * 512 + tid * 8) // BK, i_h, tid % (BK // 8) * 8 + k_word * 2 + k_element]
                for v_slot in T.unroll(BS * BV // 512):
                    for v_word in T.unroll(4):
                        for v_element in T.vectorized(2):
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_word * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, tid % (BV // 8) * 8 + v_word * 2 + v_element]
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                if is_causal and _start_buffer_0[0] + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j <= i_t, 0, -T.infinity(T.float32))
                elif not is_causal and _start_buffer_0[0] + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)
                if not direct_k:
                    T.sync_warp()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                if not direct_k:
                    T.sync_warp()
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    if scale_log2 > 0:
                        acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                    else:
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j >= 0 and _start_buffer_0[0] + j < seq_len and (not is_causal or _start_buffer_0[0] + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                T.sync_warp()
                vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)
                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
            O_cast = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_cast: pv.make_mma_store_layout(O_cast)})
            for output_chunk in T.unroll(BV // 16):
                for output_lane in T.unroll(4):
                    O_cast[T.get_thread_binding() % 16, output_chunk * 16 + T.get_thread_binding() // 16 * 4 + output_lane] = acc_o[T.get_thread_binding() % 16, output_chunk * 16 + T.get_thread_binding() // 16 * 4 + output_lane]
            T.copy(O_cast, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
    return kernel

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def native_sparse_attention_short_list_oct8(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, selected_blocks, threads=64, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, IBS, S = (groups, block_size, selected_blocks)
    BS = IBS * S
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, S], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)
            starts = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                _raw_block = BlockIndices[i_b, i_t, i_h, si]
                starts[si] = T.if_then_else(_raw_block >= 0 and _raw_block < (seq_len + IBS - 1) // IBS, _raw_block, -1) * IBS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if T.bool(True):
                for j, d in T.Parallel(BS, BK):
                    kpos = _paired_pos_sel(j, starts, S, IBS)
                    K_reg[j, d] = T.if_then_else(kpos >= 0 and kpos < seq_len and (d < dim), K[i_b, kpos, i_h, d], T.float16(0))
                for j, d in T.Parallel(BS, BV):
                    vpos = _paired_pos_sel(j, starts, S, IBS)
                    V_reg[j, d] = T.if_then_else(vpos >= 0 and vpos < seq_len and (d < dim), V[i_b, vpos, i_h, d], T.float16(0))
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                T.clear(acc_s)
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    if scale_log2 > 0:
                        acc_s[i, j] = T.if_then_else(_paired_pos_sel(j, starts, S, IBS) >= 0 and _paired_pos_sel(j, starts, S, IBS) < seq_len and (not is_causal or _paired_pos_sel(j, starts, S, IBS) <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), T.float32(0.0))
                    else:
                        acc_s[i, j] = T.if_then_else(_paired_pos_sel(j, starts, S, IBS) >= 0 and _paired_pos_sel(j, starts, S, IBS) < seq_len and (not is_causal or _paired_pos_sel(j, starts, S, IBS) <= i_t), T.if_then_else(_paired_pos_sel(j, starts, S, IBS) >= 0 and _paired_pos_sel(j, starts, S, IBS) < seq_len and (not is_causal or _paired_pos_sel(j, starts, S, IBS) <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0), T.float32(0.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)
                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
            O_cast = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_cast: pv.make_mma_store_layout(O_cast)})
            for output_chunk in T.unroll(BV // 16):
                for output_lane in T.unroll(4):
                    O_cast[T.get_thread_binding() % 16, output_chunk * 16 + T.get_thread_binding() // 16 * 4 + output_lane] = acc_o[T.get_thread_binding() % 16, output_chunk * 16 + T.get_thread_binding() // 16 * 4 + output_lane]
            T.copy(O_cast, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
    return kernel

@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_staged_sparse_blocks(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64,
):
    assert groups == 16 and threads == 64 and dim == 64 and block_size == 16
    assert seq_len % block_size == 0
    G, BS, D, S = groups, block_size, dim, selected_blocks
    H, NB = heads // groups, seq_len // block_size
    qk, pv = _emitters(T.float16, T.float32, BS, D)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, seq_len, H, D], T.float16),
        V: T.Tensor([batch, seq_len, H, D], T.float16),
        Indices: T.Tensor([batch, seq_len, H, S], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            k_shared = T.alloc_shared([BS, D], T.float16)
            v_shared = T.alloc_shared([BS, D], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            result = T.alloc_fragment([G, D], T.float16)
            partial_sum = T.alloc_fragment([G, BS], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({
                q: qk.make_mma_load_layout(q, 'A'),
                k: T.Fragment([BS, D],
                    forward_thread_fn=lambda j, d: (j * D + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * D + d) // 512 * 8 + d % 8),
                v: T.Fragment([BS, D],
                    forward_thread_fn=lambda j, d: (j * D + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * D + d) // 512 * 8 + d % 8),
                k_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(k_shared, vecSize=8),
                v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=8),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
                result: pv.make_mma_store_layout(result),
                partial_sum: qk.make_mma_store_layout(partial_sum),
            })
            K_blocks = T.reshape(K, [batch, NB, BS, H, D])
            V_blocks = T.reshape(V, [batch, NB, BS, H, D])
            blocks = T.alloc_local([S], T.int32)
            kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            b, h = bh // H, bh % H
            tid = T.get_thread_binding()
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            for s in T.unroll(S):
                blocks[s] = Indices[b, token, h, s]
            first_block = blocks[0]
            if first_block >= 0 and first_block < NB and (not is_causal or first_block <= token // BS):
                for slot in T.unroll(BS * D // 512):
                    for word in T.unroll(4):
                        for element in T.vectorized(2):
                            k[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = K_blocks[b, first_block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                for slot in T.unroll(BS * D // 512):
                    for word in T.unroll(4):
                        for element in T.vectorized(2):
                            v[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = V_blocks[b, first_block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
            T.clear(out)
            T.clear(partial_sum)
            for s in T.unroll(S, unroll_factor=2):
                block = blocks[s]
                if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                    T.copy(k, k_shared)
                    if is_causal and block * BS + BS > token + 1:
                        for i, j in T.Parallel(G, BS):
                            scores[i, j] = T.if_then_else(block * BS + j <= token, 0.0, -T.infinity(T.float32))
                    else:
                        T.clear(scores)
                    T.sync_warp()
                    for ki in T.serial(D // 32):
                        qk.ldmatrix_b(kb, k_shared, ki)
                        qk.mma(q, kb, scores, ki)
                    T.copy(v, v_shared)
                    for i, j in T.Parallel(G, BS):
                        if scale_log2 > 0:
                            scores[i, j] = T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            scores[i, j] = T.if_then_else(not is_causal or block * BS + j <= token,
                                T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        partial_sum[i, j] += scores[i, j]
                    for lane in T.unroll(4):
                        prob[tid % 16, tid // 16 * 4 + lane] = scores[tid % 16, tid // 16 * 4 + lane]
                    T.sync_warp()
                if s + 1 < S:
                    next_block = blocks[s + 1]
                    if next_block >= 0 and next_block < NB and (not is_causal or next_block <= token // BS):
                        for slot in T.unroll(BS * D // 512):
                            for word in T.unroll(4):
                                for element in T.vectorized(2):
                                    k[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = K_blocks[b, next_block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                        for slot in T.unroll(BS * D // 512):
                            for word in T.unroll(4):
                                for element in T.vectorized(2):
                                    v[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = V_blocks[b, next_block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                    pv.ldmatrix_b(vb, v_shared, 0)
                    pv.mma(prob, vb, out, 0)
            T.reduce_sum(partial_sum, denom, dim=1, clear=True)
            for i in T.Parallel(G):
                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
            for i, j in T.Parallel(G, D):
                out[i, j] *= inv[i]
            for chunk in T.unroll(D // 16):
                for lane in T.unroll(4):
                    result[tid % 16, chunk * 16 + tid // 16 * 4 + lane] = out[tid % 16, chunk * 16 + tid // 16 * 4 + lane]
            T.sync_warp()
            T.copy(result, k_shared)
            T.sync_warp()
            T.copy(k_shared, Output[b, token, h * G:(h + 1) * G, :])

    return kernel


def _coalesced_block_loads_prim_oct8(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, wave_sync=True, q_vec=8, pv_width=128, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert block_size == 16 and seq_len % block_size == 0
    assert threads == 64 and groups == 16
    assert dim in (64, 128) and block_size in (16, 32)
    assert q_vec in (4, 8) and pv_width in (64, 128)
    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    VW = min(pv_width, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])
            _start_buffer_0 = T.alloc_local([1], T.int32)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            O_reg = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_reg: T.Fragment([G, BV], forward_thread_fn=lambda i, d: i + d % 16 // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_stage: T.Fragment([G, BK], forward_thread_fn=lambda i, d: (i * BK + d) // q_vec % 64, forward_index_fn=lambda i, d: (i * BK + d) // (64 * q_vec) * q_vec + d % q_vec), Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8), Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_stage)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _start_buffer_0[0] = _selected_block * BS
                for k_slot in T.unroll(BS * BK // 512):
                    for k_pair in T.unroll(4):
                        for k_element in T.vectorized(2):
                            K_reg[(k_slot * 512 + tid * 8) // BK, tid % (BK // 8) * 8 + k_pair * 2 + k_element] = K_blocks[i_b, _selected_block, (k_slot * 512 + tid * 8) // BK, i_h, tid % (BK // 8) * 8 + k_pair * 2 + k_element]
                for v_slot in T.unroll(BS * BV // 512):
                    for v_pair in T.unroll(4):
                        for v_element in T.vectorized(2):
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_pair * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, tid % (BV // 8) * 8 + v_pair * 2 + v_element]
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                T.clear(acc_s)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                if scale_log2 > 0:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j < seq_len and (not is_causal or _start_buffer_0[0] + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), T.float32(0.0))
                else:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j < seq_len and (not is_causal or _start_buffer_0[0] + j <= i_t), T.if_then_else(_start_buffer_0[0] + j < seq_len and (not is_causal or _start_buffer_0[0] + j <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0), T.float32(0.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
                            lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
                            lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[row * BK + col]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                for cast_chunk in T.unroll(VW // 16):
                    for cast_lane in T.unroll(4):
                        O_reg[T.get_thread_binding() % 16, vo * VW + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_o[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])
    return kernel


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
    },
)
def native_sparse_attention_coalesced_blocks_oct8(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, q_vec=8, pv_width=128,
):
    return _coalesced_block_loads_prim_oct8(
        batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
        threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def native_sparse_attention_q_preload(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, natural=True, late=False):
    assert threads == 64 and groups == 16 and (block_size == 16)
    assert dim in (32, 64, 128) and seq_len % block_size == 0
    G, BS, D = (groups, block_size, dim)
    H, NB = (heads // groups, seq_len // block_size)
    qk, pv = _emitters(T.float16, T.float32, BS, D)

    @T.prim_func
    def kernel(Q: T.Tensor([batch, seq_len, heads, D], T.float16), K: T.Tensor([batch, seq_len, H, D], T.float16), V: T.Tensor([batch, seq_len, H, D], T.float16), Indices: T.Tensor([batch, seq_len, H, 1], T.int32), Output: T.Tensor([batch, seq_len, heads, D], T.float16)):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            result = T.alloc_fragment([G, D], T.float16)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({q: qk.make_mma_load_layout(q, 'A'), k: qk.make_mma_load_layout(k, 'B'), v: pv.make_mma_load_layout(v, 'B'), scores: qk.make_mma_store_layout(scores), prob: pv.make_mma_load_layout(prob, 'A'), out: pv.make_mma_store_layout(out), result: pv.make_mma_store_layout(result), lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            K_blocks = T.reshape(K, [batch, NB, BS, H, D])
            V_blocks = T.reshape(V, [batch, NB, BS, H, D])
            b, h = (bh // H, bh % H)
            tid = T.get_thread_binding()
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            T.sync_warp()
            block = Indices[b, token, h, 0]
            T.clear(out)
            if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                for j, d in T.Parallel(BS, D):
                    k[j, d] = K_blocks[b, block, j, h, d]
                for j, d in T.Parallel(BS, D):
                    v[j, d] = V_blocks[b, block, j, h, d]
                T.clear(scores)
                for ki in T.serial(D // 32):
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
                    for i, j in T.Parallel(G, D):
                        out[i, j] *= lane_sum[i, j % 16 // 4]
            for chunk in T.unroll(D // 16):
                for lane in T.unroll(4):
                    result[tid % 16, chunk * 16 + tid // 16 * 4 + lane] = out[tid % 16, chunk * 16 + tid // 16 * 4 + lane]
            T.copy(result, Output[b, token, h * G:(h + 1) * G, :])
    return kernel


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_pack_kv_bs32_tiles(batch, seq_len, heads, dim, block_size):
    assert dim == 128 and block_size == 32
    BS, D, NT = (block_size, dim, 64)
    BJ, DD = (min(BS, 16), min(D, 64))
    NR, NC = (BS // BJ, D // DD)
    assert BS % BJ == 0 and D % DD == 0 and (BJ % 16 == 0) and (DD % 32 == 0)

    @T.prim_func
    def kernel(K: T.Tensor([batch, seq_len, heads, D], T.float16), V: T.Tensor([batch, seq_len, heads, D], T.float16), PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D // 32, BS // 16, 64, 8], T.float16), Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS // 16, D // 32, 64, 8], T.float16)):
        with T.Kernel(T.ceildiv(seq_len, BS) * NR * NC, heads, batch, threads=NT) as (bx, h, b):
            bs, split = (bx // (NR * NC), bx % (NR * NC))
            jbase, dbase = (split // NC * BJ, split % NC * DD)
            ktile = T.alloc_fragment([BJ, DD], T.float16)
            tile = T.alloc_fragment([BJ, DD], T.float16)
            packed_k = T.alloc_fragment([BJ, DD], T.float16)
            packed_v = T.alloc_fragment([BJ, DD], T.float16)
            k_shared = T.alloc_shared([BJ, DD], T.float16)
            v_shared = T.alloc_shared([BJ, DD], T.float16)
            T.annotate_layout({packed_k: T.Fragment([BJ, DD], forward_thread_fn=lambda kj, kd: ((kd // 32 * (BJ // 16) + kj // 16) * 64 + kd % 32 // 8 * 16 + kj % 16) % NT, forward_index_fn=lambda kj, kd: ((kd // 32 * (BJ // 16) + kj // 16) * 64 + kd % 32 // 8 * 16 + kj % 16) // NT * 8 + kd % 8), packed_v: T.Fragment([BJ, DD], forward_thread_fn=lambda pj, pd: ((pj // 16 * (DD // 32) + pd // 32) * 64 + pj % 16 // 4 * 16 + pd % 16) % NT, forward_index_fn=lambda pj, pd: ((pj // 16 * (DD // 32) + pd // 32) * 64 + pj % 16 // 4 * 16 + pd % 16) // NT * 8 + pd % 32 // 16 * 4 + pj % 4), k_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(k_shared, vecSize=8), v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=4)})
            T.copy(K[b, bs * BS + jbase:bs * BS + jbase + BJ, h, dbase:dbase + DD], ktile)
            T.copy(V[b, bs * BS + jbase:bs * BS + jbase + BJ, h, dbase:dbase + DD], tile)
            T.copy(ktile, k_shared)
            T.copy(tile, v_shared)
            T.sync_warp()
            T.copy(k_shared, packed_k)
            T.copy(v_shared, packed_v)
            for j, d in T.Parallel(BJ, DD):
                PackedK[b, bs, h, (dbase + d) // 32, (jbase + j) // 16, (dbase + d) % 32 // 8 * 16 + (jbase + j) % 16, (dbase + d) % 8] = packed_k[j, d]
            for j, d in T.Parallel(BJ, DD):
                Packed[b, bs, h, (jbase + j) // 16, (dbase + d) // 32, (jbase + j) % 16 // 4 * 16 + (dbase + d) % 16, (dbase + d) % 32 // 16 * 4 + (jbase + j) % 4] = packed_v[j, d]
    return kernel

def _coalesced_block_loads_prim_fp32_sum(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, wave_sync=True, q_vec=8, pv_width=128, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert block_size == 16 and seq_len % block_size == 0
    assert threads == 64 and groups == 16
    assert dim in (64, 128) and block_size in (16, 32)
    assert q_vec in (4, 8) and pv_width in (64, 128)
    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    VW = min(pv_width, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)
    wsum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32", a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            wsum_unit = T.alloc_local([1], T.float32)
            wsum_output = T.alloc_fragment([G, 16], T.float32)
            T.annotate_layout({wsum_output: wsum.make_mma_store_layout(wsum_output)})
            T.fill(wsum_unit, 1.0)
            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])
            _start_buffer_0 = T.alloc_local([1], T.int32)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            O_reg = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_reg: T.Fragment([G, BV], forward_thread_fn=lambda i, d: i + d % 16 // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_stage: T.Fragment([G, BK], forward_thread_fn=lambda i, d: (i * BK + d) // q_vec % 64, forward_index_fn=lambda i, d: (i * BK + d) // (64 * q_vec) * q_vec + d % q_vec), Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8), Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_stage)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _start_buffer_0[0] = _selected_block * BS
                for k_slot in T.unroll(BS * BK // 512):
                    for k_pair in T.unroll(4):
                        for k_element in T.vectorized(2):
                            K_reg[(k_slot * 512 + tid * 8) // BK, tid % (BK // 8) * 8 + k_pair * 2 + k_element] = K_blocks[i_b, _selected_block, (k_slot * 512 + tid * 8) // BK, i_h, tid % (BK // 8) * 8 + k_pair * 2 + k_element]
                for v_slot in T.unroll(BS * BV // 512):
                    for v_pair in T.unroll(4):
                        for v_element in T.vectorized(2):
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_pair * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, tid % (BV // 8) * 8 + v_pair * 2 + v_element]
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                if is_causal and _start_buffer_0[0] + BS > i_t + 1:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j <= i_t, 0, -T.infinity(T.float32))
                elif not is_causal and _start_buffer_0[0] + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j < seq_len, 0, -T.infinity(T.float32))
                else:
                    T.clear(acc_s)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                if scale_log2 > 0:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                else:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(_start_buffer_0[0] + j < seq_len and (not is_causal or _start_buffer_0[0] + j <= i_t), T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0)), 0.0)
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        T.clear(wsum_output)
                        wsum.mma(lane_sum, wsum_unit, wsum_output, 0)
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = T.if_then_else(wsum_output[i, lane * 4] > 0, 1.0 / wsum_output[i, lane * 4], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[row * BK + col]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                for cast_chunk in T.unroll(VW // 16):
                    for cast_lane in T.unroll(4):
                        O_reg[T.get_thread_binding() % 16, vo * VW + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_o[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])
    return kernel

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_coalesced_blocks_fp32_sum(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, q_vec=8, pv_width=128):
    return _coalesced_block_loads_prim_fp32_sum(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)

def _coalesced_block_loads_prim_fp32_mask(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, wave_sync=True, q_vec=8, pv_width=128, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert block_size == 16 and seq_len % block_size == 0
    assert threads == 64 and groups == 16
    assert dim in (64, 128) and block_size in (16, 32)
    assert q_vec in (4, 8) and pv_width in (64, 128)
    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    VW = min(pv_width, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)
    wsum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32", a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            wsum_unit = T.alloc_local([1], T.float32)
            wsum_output = T.alloc_fragment([G, 16], T.float32)
            T.annotate_layout({wsum_output: wsum.make_mma_store_layout(wsum_output)})
            T.fill(wsum_unit, 1.0)
            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])
            _start_buffer_0 = T.alloc_local([1], T.int32)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            O_reg = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_reg: T.Fragment([G, BV], forward_thread_fn=lambda i, d: i + d % 16 // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_stage: T.Fragment([G, BK], forward_thread_fn=lambda i, d: (i * BK + d) // q_vec % 64, forward_index_fn=lambda i, d: (i * BK + d) // (64 * q_vec) * q_vec + d % q_vec), Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8), Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_stage)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _start_buffer_0[0] = _selected_block * BS
                for k_slot in T.unroll(BS * BK // 512):
                    for k_pair in T.unroll(4):
                        for k_element in T.vectorized(2):
                            K_reg[(k_slot * 512 + tid * 8) // BK, tid % (BK // 8) * 8 + k_pair * 2 + k_element] = K_blocks[i_b, _selected_block, (k_slot * 512 + tid * 8) // BK, i_h, tid % (BK // 8) * 8 + k_pair * 2 + k_element]
                for v_slot in T.unroll(BS * BV // 512):
                    for v_pair in T.unroll(4):
                        for v_element in T.vectorized(2):
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_pair * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, tid % (BV // 8) * 8 + v_pair * 2 + v_element]
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                T.clear(acc_s)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                if is_causal and _selected_block == i_t // BS:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(j <= i_t % BS, acc_s[i, j], T.float32(0.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        T.clear(wsum_output)
                        wsum.mma(lane_sum, wsum_unit, wsum_output, 0)
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = T.if_then_else(wsum_output[i, lane * 4] > 0, 1.0 / wsum_output[i, lane * 4], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[row * BK + col]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                for cast_chunk in T.unroll(VW // 16):
                    for cast_lane in T.unroll(4):
                        O_reg[T.get_thread_binding() % 16, vo * VW + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_o[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])
    return kernel

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_coalesced_blocks_fp32_mask(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, q_vec=8, pv_width=128):
    return _coalesced_block_loads_prim_fp32_mask(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def native_sparse_attention_q_preload_vfirst(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, natural=True, late=False):
    assert threads == 64 and groups == 16 and (block_size == 16)
    assert dim in (32, 64, 128) and seq_len % block_size == 0
    G, BS, D = (groups, block_size, dim)
    H, NB = (heads // groups, seq_len // block_size)
    qk, pv = _emitters(T.float16, T.float32, BS, D)
    tiny_sum = TensorCoreIntrinEmitter(a_dtype='float32', b_dtype='float32', accum_dtype='float32', a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)

    @T.prim_func
    def kernel(Q: T.Tensor([batch, seq_len, heads, D], T.float16), K: T.Tensor([batch, seq_len, H, D], T.float16), V: T.Tensor([batch, seq_len, H, D], T.float16), Indices: T.Tensor([batch, seq_len, H, 1], T.int32), Output: T.Tensor([batch, seq_len, heads, D], T.float16)):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            tiny_sum_one = T.alloc_local([1], T.float32)
            tiny_sum_out = T.alloc_fragment([G, 16], T.float32)
            T.annotate_layout({tiny_sum_out: tiny_sum.make_mma_store_layout(tiny_sum_out)})
            T.fill(tiny_sum_one, 1.0)
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            result = T.alloc_fragment([G, D], T.float16)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({q: qk.make_mma_load_layout(q, 'A'), k: qk.make_mma_load_layout(k, 'B'), v: pv.make_mma_load_layout(v, 'B'), scores: qk.make_mma_store_layout(scores), prob: pv.make_mma_load_layout(prob, 'A'), out: pv.make_mma_store_layout(out), result: pv.make_mma_store_layout(result), lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            K_blocks = T.reshape(K, [batch, NB, BS, H, D])
            V_blocks = T.reshape(V, [batch, NB, BS, H, D])
            b, h = (bh // H, bh % H)
            tid = T.get_thread_binding()
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            T.sync_warp()
            block = Indices[b, token, h, 0]
            T.clear(out)
            if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                for j, d in T.Parallel(BS, D):
                    v[j, d] = V_blocks[b, block, j, h, d]
                for j, d in T.Parallel(BS, D):
                    k[j, d] = K_blocks[b, block, j, h, d]
                T.clear(scores)
                for ki in T.serial(D // 32):
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
                    T.clear(tiny_sum_out)
                    tiny_sum.mma(lane_sum, tiny_sum_one, tiny_sum_out, 0)
                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] = T.if_then_else(tiny_sum_out[i, lane * 4] > 0, T.exp(-T.log(tiny_sum_out[i, lane * 4])), 0.0)
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
                    T.clear(tiny_sum_out)
                    tiny_sum.mma(lane_sum, tiny_sum_one, tiny_sum_out, 0)
                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] = T.if_then_else(tiny_sum_out[i, lane * 4] > 0, T.exp(-T.log(tiny_sum_out[i, lane * 4])), 0.0)
                    for i, j in T.Parallel(G, D):
                        out[i, j] *= lane_sum[i, j % 16 // 4]
            for chunk in T.unroll(D // 16):
                for lane in T.unroll(4):
                    result[tid % 16, chunk * 16 + tid // 16 * 4 + lane] = out[tid % 16, chunk * 16 + tid // 16 * 4 + lane]
            T.copy(result, Output[b, token, h * G:(h + 1) * G, :])
    return kernel

def _coalesced_block_loads_prim_boundary_v8(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, wave_sync=True, q_vec=8, pv_width=128, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    assert block_size == 16 and seq_len % block_size == 0
    assert threads == 64 and groups == 16
    assert dim in (64, 128) and block_size in (16, 32)
    assert q_vec in (4, 8) and pv_width in (64, 128)
    late_normalize = False
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    VW = min(pv_width, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)
    wsum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32", a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            wsum_unit = T.alloc_local([1], T.float32)
            wsum_output = T.alloc_fragment([G, 16], T.float32)
            T.annotate_layout({wsum_output: wsum.make_mma_store_layout(wsum_output)})
            T.fill(wsum_unit, 1.0)
            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])
            _start_buffer_0 = T.alloc_local([1], T.int32)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, VW], T.float32)
            O_reg = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_reg: T.Fragment([G, BV], forward_thread_fn=lambda i, d: i + d % 16 // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_stage: T.Fragment([G, BK], forward_thread_fn=lambda i, d: (i * BK + d) // q_vec % 64, forward_index_fn=lambda i, d: (i * BK + d) // (64 * q_vec) * q_vec + d % q_vec), Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8), Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_stage)
            _selected_block = BlockIndices[i_b, i_t, i_h, 0]
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                _start_buffer_0[0] = _selected_block * BS
                for k_slot in T.unroll(BS * BK // 512):
                    for k_pair in T.unroll(4):
                        for k_element in T.vectorized(2):
                            K_reg[(k_slot * 512 + tid * 8) // BK, tid % (BK // 8) * 8 + k_pair * 2 + k_element] = K_blocks[i_b, _selected_block, (k_slot * 512 + tid * 8) // BK, i_h, tid % (BK // 8) * 8 + k_pair * 2 + k_element]
                for v_slot in T.unroll(BS * BV // 512):
                    for v_pair in T.unroll(4):
                        for v_element in T.vectorized(2):
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_pair * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, tid % (BV // 8) * 8 + v_pair * 2 + v_element]
                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                T.clear(acc_s)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                if is_causal and _selected_block == i_t // BS:
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.if_then_else(j <= i_t % BS, acc_s[i, j], T.float32(0.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        T.clear(wsum_output)
                        wsum.mma(lane_sum, wsum_unit, wsum_output, 0)
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = T.if_then_else(wsum_output[i, lane * 4] > 0, 1.0 / wsum_output[i, lane * 4], 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if _selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS and (not is_causal or _selected_block <= i_t // BS):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[row * BK + col]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                for cast_chunk in T.unroll(VW // 16):
                    for cast_lane in T.unroll(4):
                        O_reg[T.get_thread_binding() % 16, vo * VW + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_o[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])
    return kernel

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_coalesced_blocks_boundary_v8(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, q_vec=8, pv_width=128):
    return _coalesced_block_loads_prim_boundary_v8(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)

def _short_reciprocal_trial(value):
    initial = T.reinterpret("float32", T.uint32(2129859011) - T.reinterpret("uint32", value))
    return initial * (2.0 - value * initial)

def _small_newton2(value):
    y = T.reinterpret("float32", T.uint32(2129859011) - T.reinterpret("uint32", value))
    y = y * (2.0 - value * y)
    y = y * (2.0 - value * y)
    return y

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_single_packed_qo_v2_mathcast_block_joint(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, width=32, late=False):
    assert groups == 16 and threads == 64 and (dim in (64, 128)) and (block_size in (16, 32))
    G, BS, D = (groups, block_size, dim)
    H = heads // groups
    W = min(width, D)
    NB = tilelang.cdiv(seq_len, BS)
    qk, _ = _emitters(T.float16, T.float32, BS, D)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=W, chunk=BS, k_pack=1)
    D = dim
    BS = block_size
    H = heads // groups
    NB = T.ceildiv(seq_len, BS)

    @T.prim_func
    def kernel(Q: T.Tensor([batch, seq_len, heads, D], T.float16), PackedKV: T.Tensor([batch, NB, H, 2, D // 32 * (BS // 16), 64, 8], T.float16), Indices: T.Tensor([batch, seq_len, H, 1], T.int32), Output: T.Tensor([batch, seq_len, heads, D], T.float16)):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            q_shared = T.alloc_shared([G, D], T.float16)
            output_reg = T.alloc_fragment([G, D], T.float16)
            T.annotate_layout({q_stage: T.Fragment([G, D], forward_thread_fn=lambda qi, qd: (qi * D + qd) // 4 % 64, forward_index_fn=lambda qi, qd: (qi * D + qd) // 256 * 4 + qd % 4), q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8), output_reg: T.Fragment([G, D], forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16, forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4)})
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, W], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, W], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({q: qk.make_mma_load_layout(q, 'A'), k: qk.make_mma_load_layout(k, 'B'), v: pv.make_mma_load_layout(v, 'B'), scores: qk.make_mma_store_layout(scores), prob: pv.make_mma_load_layout(prob, 'A'), out: pv.make_mma_store_layout(out)})
            b, h = (bh // H, bh % H)
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
            block = Indices[b, token, h, 0]
            start = block * BS
            valid = block >= 0 and block < NB and (not is_causal or start <= token)
            if valid:
                for j, d in T.Parallel(BS, D):
                    k[j, d] = PackedKV[b, block, h, 0, d // 32 * (BS // 16) + j // 16, d % 32 // 8 * 16 + j % 16, d % 8]
                T.copy(q_stage, q_shared)
                T.sync_warp()
                T.copy(q_shared, q)
                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.if_then_else(start + j < seq_len and (not is_causal or start + j <= token), 0.0, -T.infinity(T.float32))
                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
                for j, d in T.Parallel(BS, W):
                    v[j, d] = PackedKV[b, block, h, 1, j // 16 * (D // 32) + d // 32, j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]
                if scale_log2 > 0:
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
                else:
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] = T.if_then_else(start + j < seq_len and (not is_causal or start + j <= token), T.exp2(T.min(scores[i, j] * scale_log2, 15.0)), 0.0)
                if not late:
                    T.reduce_sum(scores, denom, dim=1, clear=True)
                    for i in T.Parallel(G):
                        inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] *= inv[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        prob[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = scores[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                for vo in T.unroll(D // W):
                    T.clear(out)
                    if vo > 0:
                        for j, d in T.Parallel(BS, W):
                            v[j, d] = PackedKV[b, block, h, 1, j // 16 * (D // 32) + (vo * (W // 32) + d // 32), j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]
                    for ki in T.serial(BS // 16):
                        pv.mma(prob, v, out, ki)
                    if late:
                        if vo == 0:
                            T.reduce_sum(scores, denom, dim=1, clear=True)
                            for i in T.Parallel(G):
                                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                        for i, j in T.Parallel(G, W):
                            out[i, j] *= inv[i]
                    for cast_chunk in T.unroll(W // 16):
                        for cast_lane in T.unroll(4):
                            output_reg[T.get_thread_binding() % 16, vo * W + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = out[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
            else:
                T.clear(output_reg)
            output_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({output_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)})
            T.sync_warp()
            T.copy(output_reg, output_shared)
            T.sync_warp()
            T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])
    return kernel


@tilelang.jit
def native_sparse_attention_pack_kv_bs32_direct_block_joint(batch, seq_len, heads, dim, block_size):
    BS, D = (block_size, dim)
    D = dim
    BS = block_size
    H = heads
    NB = T.ceildiv(seq_len, BS)

    @T.prim_func
    def kernel(K: T.Tensor([batch, seq_len, heads, D], T.float16), V: T.Tensor([batch, seq_len, heads, D], T.float16), PackedKV: T.Tensor([batch, NB, H, 2, D // 32 * (BS // 16), 64, 8], T.float16)):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=128) as (bs, h, b):
            packed_v = T.alloc_fragment([BS, D], T.float16)
            T.annotate_layout({packed_v: T.Fragment([BS, D], forward_thread_fn=lambda pj, pd: ((pj // 16 * (D // 32) + pd // 32) * 64 + pj % 16 // 4 * 16 + pd % 16) % 128, forward_index_fn=lambda pj, pd: ((pj // 16 * (D // 32) + pd // 32) * 64 + pj % 16 // 4 * 16 + pd % 16) // 128 * 8 + pd % 32 // 16 * 4 + pj % 4)})
            ktile = T.alloc_fragment([BS, D], T.float16)
            T.copy(K[b, bs * BS:(bs + 1) * BS, h, :], ktile)
            for j, d in T.Parallel(BS, D):
                PackedKV[b, bs, h, 0, d // 32 * (BS // 16) + j // 16, d % 32 // 8 * 16 + j % 16, d % 8] = ktile[j, d]
            tile = T.alloc_fragment([BS, D], T.float16)
            T.copy(V[b, bs * BS:(bs + 1) * BS, h, :], packed_v)
            for j, d in T.Parallel(BS, D):
                PackedKV[b, bs, h, 1, j // 16 * (D // 32) + d // 32, j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4] = packed_v[j, d]
    return kernel


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_pack_kv_bs32_shared_block_joint(batch, seq_len, heads, dim, block_size):
    BS, D = (block_size, dim)
    D = dim
    BS = block_size
    H = heads
    NB = T.ceildiv(seq_len, BS)

    @T.prim_func
    def kernel(K: T.Tensor([batch, seq_len, heads, D], T.float16), V: T.Tensor([batch, seq_len, heads, D], T.float16), PackedKV: T.Tensor([batch, NB, H, 2, D // 32 * (BS // 16), 64, 8], T.float16)):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=256) as (bs, h, b):
            packed_v = T.alloc_fragment([BS, D], T.float16)
            T.annotate_layout({packed_v: T.Fragment([BS, D], forward_thread_fn=lambda pj, pd: ((pj // 16 * (D // 32) + pd // 32) * 64 + pj % 16 // 4 * 16 + pd % 16) % 256, forward_index_fn=lambda pj, pd: ((pj // 16 * (D // 32) + pd // 32) * 64 + pj % 16 // 4 * 16 + pd % 16) // 256 * 8 + pd % 32 // 16 * 4 + pj % 4)})
            v_shared = T.alloc_shared([BS, D], T.float16)
            T.annotate_layout({v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=4)})
            ktile = T.alloc_fragment([BS, D], T.float16)
            T.copy(K[b, bs * BS:(bs + 1) * BS, h, :], ktile)
            for j, d in T.Parallel(BS, D):
                PackedKV[b, bs, h, 0, d // 32 * (BS // 16) + j // 16, d % 32 // 8 * 16 + j % 16, d % 8] = ktile[j, d]
            tile = T.alloc_fragment([BS, D], T.float16)
            T.copy(V[b, bs * BS:(bs + 1) * BS, h, :], tile)
            T.copy(tile, v_shared)
            T.sync_threads()
            T.copy(v_shared, packed_v)
            for j, d in T.Parallel(BS, D):
                PackedKV[b, bs, h, 1, j // 16 * (D // 32) + d // 32, j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4] = packed_v[j, d]
    return kernel


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_pack_kv_bs32_tiles_block_joint(batch, seq_len, heads, dim, block_size):
    assert dim == 128 and block_size == 32
    BS, D, NT = (block_size, dim, 64)
    BJ, DD = (min(BS, 16), min(D, 64))
    NR, NC = (BS // BJ, D // DD)
    assert BS % BJ == 0 and D % DD == 0 and (BJ % 16 == 0) and (DD % 32 == 0)
    D = dim
    BS = block_size
    H = heads
    NB = T.ceildiv(seq_len, BS)

    @T.prim_func
    def kernel(K: T.Tensor([batch, seq_len, heads, D], T.float16), V: T.Tensor([batch, seq_len, heads, D], T.float16), PackedKV: T.Tensor([batch, NB, H, 2, D // 32 * (BS // 16), 64, 8], T.float16)):
        with T.Kernel(T.ceildiv(seq_len, BS) * NR * NC, heads, batch, threads=NT) as (bx, h, b):
            bs, split = (bx // (NR * NC), bx % (NR * NC))
            jbase, dbase = (split // NC * BJ, split % NC * DD)
            ktile = T.alloc_fragment([BJ, DD], T.float16)
            tile = T.alloc_fragment([BJ, DD], T.float16)
            packed_k = T.alloc_fragment([BJ, DD], T.float16)
            packed_v = T.alloc_fragment([BJ, DD], T.float16)
            k_shared = T.alloc_shared([BJ, DD], T.float16)
            v_shared = T.alloc_shared([BJ, DD], T.float16)
            T.annotate_layout({packed_k: T.Fragment([BJ, DD], forward_thread_fn=lambda kj, kd: ((kd // 32 * (BJ // 16) + kj // 16) * 64 + kd % 32 // 8 * 16 + kj % 16) % NT, forward_index_fn=lambda kj, kd: ((kd // 32 * (BJ // 16) + kj // 16) * 64 + kd % 32 // 8 * 16 + kj % 16) // NT * 8 + kd % 8), packed_v: T.Fragment([BJ, DD], forward_thread_fn=lambda pj, pd: ((pj // 16 * (DD // 32) + pd // 32) * 64 + pj % 16 // 4 * 16 + pd % 16) % NT, forward_index_fn=lambda pj, pd: ((pj // 16 * (DD // 32) + pd // 32) * 64 + pj % 16 // 4 * 16 + pd % 16) // NT * 8 + pd % 32 // 16 * 4 + pj % 4), k_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(k_shared, vecSize=8), v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=4)})
            T.copy(K[b, bs * BS + jbase:bs * BS + jbase + BJ, h, dbase:dbase + DD], ktile)
            T.copy(V[b, bs * BS + jbase:bs * BS + jbase + BJ, h, dbase:dbase + DD], tile)
            T.copy(ktile, k_shared)
            T.copy(tile, v_shared)
            T.sync_warp()
            T.copy(k_shared, packed_k)
            T.copy(v_shared, packed_v)
            for j, d in T.Parallel(BJ, DD):
                PackedKV[b, bs, h, 0, (dbase + d) // 32 * (BS // 16) + (jbase + j) // 16, (dbase + d) % 32 // 8 * 16 + (jbase + j) % 16, (dbase + d) % 8] = packed_k[j, d]
            for j, d in T.Parallel(BJ, DD):
                PackedKV[b, bs, h, 1, (jbase + j) // 16 * (D // 32) + (dbase + d) // 32, (jbase + j) % 16 // 4 * 16 + (dbase + d) % 16, (dbase + d) % 32 // 16 * 4 + (jbase + j) % 4] = packed_v[j, d]
    return kernel


def _make_block_joint_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    shape = (batch, (seq_len + block_size - 1) // block_size, heads, 2,
             (dim // 32) * (block_size // 16), 64, 8)
    def run(Q, K, V, BlockIndices, Output):
        packed = torch.empty(shape, dtype=Q.dtype, device=Q.device)
        pack(K, V, packed)
        attention(Q, packed, BlockIndices, Output)
    return run


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def native_sparse_attention_short_list_oct8_sum_v11(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, selected_blocks, threads=64, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False):
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, IBS, S = (groups, block_size, selected_blocks)
    BS = IBS * S
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)
    short_sum = TensorCoreIntrinEmitter(a_dtype='float32', b_dtype='float32', accum_dtype='float32', a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)

    @T.prim_func
    def kernel(Q: T.Tensor(q_shape, T.float16), K: T.Tensor(kv_shape, T.float16), V: T.Tensor(kv_shape, T.float16), BlockIndices: T.Tensor([batch, seq_len, head_kv, S], T.int32), Output: T.Tensor(q_shape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (bx, by, bz):
            short_sum_one = T.alloc_local([1], T.float32)
            short_sum_out = T.alloc_fragment([G, 16], T.float32)
            T.annotate_layout({short_sum_out: short_sum.make_mma_store_layout(short_sum_out)})
            T.fill(short_sum_one, 1.0)
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)
            V_shared = KV_shared
            tid = T.get_thread_binding()
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)
            _layout = {Q_reg: qk.make_mma_load_layout(Q_reg, 'A'), KV_shared: T.Layout([BS * VSTRIDE], lambda i: i), K_reg: T.Fragment([BS, BK], forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8), V_reg: T.Fragment([BS, BV], forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64, forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8), acc_s: qk.make_mma_store_layout(acc_s), acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A'), acc_o: pv.make_mma_store_layout(acc_o)}
            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, 'B')
            T.annotate_layout(_layout)
            i_t, i_v, i_bh = (bx, by, bz)
            i_b, i_h = (i_bh // head_kv, i_bh % head_kv)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)
            starts = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                _raw_block = BlockIndices[i_b, i_t, i_h, si]
                starts[si] = T.if_then_else(_raw_block >= 0 and _raw_block < (seq_len + IBS - 1) // IBS, _raw_block, -1) * IBS
            T.fill(acc_o, 0)
            if not lane_reduce:
                T.fill(scores_sum, 0)
            if T.bool(True):
                for j, d in T.Parallel(BS, BK):
                    kpos = _paired_pos_sel(j, starts, S, IBS)
                    K_reg[j, d] = T.if_then_else(kpos >= 0 and kpos < seq_len and (d < dim), K[i_b, kpos, i_h, d], T.float16(0))
                for j, d in T.Parallel(BS, BV):
                    vpos = _paired_pos_sel(j, starts, S, IBS)
                    V_reg[j, d] = T.if_then_else(vpos >= 0 and vpos < seq_len and (d < dim), V[i_b, vpos, i_h, d], T.float16(0))
                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
                T.clear(acc_s)
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    if direct_k:
                        qk.mma(Q_reg, K_reg, acc_s, ki)
                    else:
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(8):
                                kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK + ((ki * 32 + tid // 16 * 8 + e) // 8 ^ (j * 16 + tid % 16) // KPHASE % KMAX) * 8 + (ki * 32 + tid // 16 * 8 + e) % 8]
                        qk.mma(Q_reg, kb, acc_s, ki)
                for j, d in T.Parallel(BS, BV):
                    KV_shared[j * BK + d] = V_reg[j, d]
                for i, j in T.Parallel(G, BS):
                    if scale_log2 > 0:
                        acc_s[i, j] = T.if_then_else(_paired_pos_sel(j, starts, S, IBS) >= 0 and _paired_pos_sel(j, starts, S, IBS) < seq_len and (not is_causal or _paired_pos_sel(j, starts, S, IBS) <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), T.float32(0.0))
                    else:
                        acc_s[i, j] = T.if_then_else(_paired_pos_sel(j, starts, S, IBS) >= 0 and _paired_pos_sel(j, starts, S, IBS) < seq_len and (not is_causal or _paired_pos_sel(j, starts, S, IBS) <= i_t), T.if_then_else(_paired_pos_sel(j, starts, S, IBS) >= 0 and _paired_pos_sel(j, starts, S, IBS) < seq_len and (not is_causal or _paired_pos_sel(j, starts, S, IBS) <= i_t), T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0), T.float32(0.0))
                if not late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        T.clear(short_sum_out)
                        short_sum.mma(lane_sum, short_sum_one, short_sum_out, 0)
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = T.if_then_else(short_sum_out[i, lane * 4] > 0, _short_reciprocal_trial(short_sum_out[i, lane * 4]), 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, _short_reciprocal_trial(scores_sum[i]), 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
                for cast_chunk in T.unroll(BS // 16):
                    for cast_lane in T.unroll(4):
                        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
                vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(BV // 16):
                        for e in T.serial(4):
                            vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]
                    pv.mma(acc_s_cast, vb, acc_o, ki)
                if late_normalize:
                    if lane_reduce:
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = 0
                            for k in T.unroll(BS // 16):
                                for j in T.unroll(4):
                                    lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                        T.clear(short_sum_out)
                        short_sum.mma(lane_sum, short_sum_one, short_sum_out, 0)
                        for i, lane in T.Parallel(G, 4):
                            lane_sum[i, lane] = T.if_then_else(short_sum_out[i, lane * 4] > 0, _short_reciprocal_trial(short_sum_out[i, lane * 4]), 0.0)
                    else:
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(G):
                            scores_inv_sum[i] = T.if_then_else(scores_sum[i] > 0, _short_reciprocal_trial(scores_sum[i]), 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i]
            O_cast = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_cast: pv.make_mma_store_layout(O_cast)})
            for output_chunk in T.unroll(BV // 16):
                for output_lane in T.unroll(4):
                    O_cast[T.get_thread_binding() % 16, output_chunk * 16 + T.get_thread_binding() // 16 * 4 + output_lane] = acc_o[T.get_thread_binding() % 16, output_chunk * 16 + T.get_thread_binding() // 16 * 4 + output_lane]
            T.copy(O_cast, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
    return kernel

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_staged_sparse_blocks_sum_v11(batch, heads, seq_len, dim, is_causal, block_size, groups, selected_blocks, scale_log2, threads=64):
    assert groups == 16 and threads == 64 and (dim == 64) and (block_size == 16)
    assert seq_len % block_size == 0
    G, BS, D, S = (groups, block_size, dim, selected_blocks)
    H, NB = (heads // groups, seq_len // block_size)
    qk, pv = _emitters(T.float16, T.float32, BS, D)
    short_sum = TensorCoreIntrinEmitter(a_dtype='float32', b_dtype='float32', accum_dtype='float32', a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)

    @T.prim_func
    def kernel(Q: T.Tensor([batch, seq_len, heads, D], T.float16), K: T.Tensor([batch, seq_len, H, D], T.float16), V: T.Tensor([batch, seq_len, H, D], T.float16), Indices: T.Tensor([batch, seq_len, H, S], T.int32), Output: T.Tensor([batch, seq_len, heads, D], T.float16)):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            short_sum_one = T.alloc_local([1], T.float32)
            short_sum_out = T.alloc_fragment([G, 16], T.float32)
            T.annotate_layout({short_sum_out: short_sum.make_mma_store_layout(short_sum_out)})
            T.fill(short_sum_one, 1.0)
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            k_shared = T.alloc_shared([BS, D], T.float16)
            v_shared = T.alloc_shared([BS, D], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            result = T.alloc_fragment([G, D], T.float16)
            partial_sum = T.alloc_fragment([G, BS], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({q: qk.make_mma_load_layout(q, 'A'), k: T.Fragment([BS, D], forward_thread_fn=lambda j, d: (j * D + d) // 8 % 64, forward_index_fn=lambda j, d: (j * D + d) // 512 * 8 + d % 8), v: T.Fragment([BS, D], forward_thread_fn=lambda j, d: (j * D + d) // 8 % 64, forward_index_fn=lambda j, d: (j * D + d) // 512 * 8 + d % 8), k_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(k_shared, vecSize=8), v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=8), scores: qk.make_mma_store_layout(scores), prob: pv.make_mma_load_layout(prob, 'A'), out: pv.make_mma_store_layout(out), result: pv.make_mma_store_layout(result), partial_sum: qk.make_mma_store_layout(partial_sum)})
            K_blocks = T.reshape(K, [batch, NB, BS, H, D])
            V_blocks = T.reshape(V, [batch, NB, BS, H, D])
            blocks = T.alloc_local([S], T.int32)
            kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            b, h = (bh // H, bh % H)
            tid = T.get_thread_binding()
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            for s in T.unroll(S):
                blocks[s] = Indices[b, token, h, s]
            first_block = blocks[0]
            if first_block >= 0 and first_block < NB and (not is_causal or first_block <= token // BS):
                for slot in T.unroll(BS * D // 512):
                    for word in T.unroll(4):
                        for element in T.vectorized(2):
                            k[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = K_blocks[b, first_block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                for slot in T.unroll(BS * D // 512):
                    for word in T.unroll(4):
                        for element in T.vectorized(2):
                            v[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = V_blocks[b, first_block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
            T.clear(out)
            T.clear(partial_sum)
            for s in T.unroll(S, unroll_factor=2):
                block = blocks[s]
                if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                    T.copy(k, k_shared)
                    if is_causal and block * BS + BS > token + 1:
                        for i, j in T.Parallel(G, BS):
                            scores[i, j] = T.if_then_else(block * BS + j <= token, 0.0, -T.infinity(T.float32))
                    else:
                        T.clear(scores)
                    T.sync_warp()
                    for ki in T.serial(D // 32):
                        qk.ldmatrix_b(kb, k_shared, ki)
                        qk.mma(q, kb, scores, ki)
                    T.copy(v, v_shared)
                    for i, j in T.Parallel(G, BS):
                        if scale_log2 > 0:
                            scores[i, j] = T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                        else:
                            scores[i, j] = T.if_then_else(not is_causal or block * BS + j <= token, T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                        partial_sum[i, j] += scores[i, j]
                    for lane in T.unroll(4):
                        prob[tid % 16, tid // 16 * 4 + lane] = scores[tid % 16, tid // 16 * 4 + lane]
                    T.sync_warp()
                if s + 1 < S:
                    next_block = blocks[s + 1]
                    if next_block >= 0 and next_block < NB and (not is_causal or next_block <= token // BS):
                        for slot in T.unroll(BS * D // 512):
                            for word in T.unroll(4):
                                for element in T.vectorized(2):
                                    k[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = K_blocks[b, next_block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                        for slot in T.unroll(BS * D // 512):
                            for word in T.unroll(4):
                                for element in T.vectorized(2):
                                    v[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = V_blocks[b, next_block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                    pv.ldmatrix_b(vb, v_shared, 0)
                    pv.mma(prob, vb, out, 0)
            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda si, sj: si + sj * 16, forward_index_fn=lambda si, sj: 0)})
            for i, lane in T.Parallel(G, 4):
                lane_sum[i, lane] = 0.0
                for j in T.unroll(4):
                    lane_sum[i, lane] += partial_sum[i, lane * 4 + j]
            T.clear(short_sum_out)
            short_sum.mma(lane_sum, short_sum_one, short_sum_out, 0)
            for i, lane in T.Parallel(G, 4):
                lane_sum[i, lane] = T.if_then_else(short_sum_out[i, lane * 4] > 0, _short_reciprocal_trial(short_sum_out[i, lane * 4]), 0.0)
            for i, j in T.Parallel(G, D):
                out[i, j] *= lane_sum[i, j % 16 // 4]
            for chunk in T.unroll(D // 16):
                for lane in T.unroll(4):
                    result[tid % 16, chunk * 16 + tid // 16 * 4 + lane] = out[tid % 16, chunk * 16 + tid // 16 * 4 + lane]
            T.sync_warp()
            T.copy(result, k_shared)
            T.sync_warp()
            T.copy(k_shared, Output[b, token, h * G:(h + 1) * G, :])
    return kernel

def _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None, threads=64, num_stages=1, kv_reuse=True, stage_regs=True, o_stage=False, q_frag=None, nmax=True, kv_frag=False, pair=None, min_blocks=0, q_frag_online=None, online_unroll=2, late_normalize=None, q_preload=None, kv_split=False):
    entry_key = ('raw_arguments', B, seq_len, H, HQ, D, S, block_size, int(bool(is_causal)), None if scale is None else float(scale), threads, num_stages, kv_reuse, stage_regs, o_stage, q_frag, nmax, kv_frag, pair, min_blocks, q_frag_online, online_unroll, late_normalize, q_preload, kv_split)
    entry_kernel = _KERNEL_CACHE.get(entry_key)
    if entry_kernel is not None:
        return entry_kernel
    mathcast_defaults = threads == 64 and num_stages == 1 and kv_reuse and stage_regs and (not o_stage) and (q_frag is None) and nmax and (not kv_frag) and (pair is None) and (min_blocks == 0) and (q_frag_online is None) and (online_unroll == 2) and (late_normalize is None) and (q_preload is None) and (not kv_split)
    if q_frag is None:
        q_frag = S > 1 or block_size == 32
    if S > 1 and q_frag_online is not None:
        q_frag = q_frag_online
    if late_normalize is None:
        _bv = min(128, tilelang.math.next_power_of_2(D))
        _grid = seq_len * ((D + _bv - 1) // _bv) * B * H
        late_normalize = D == 128 and block_size == 32 and (_grid >= 2048)
    if q_preload is None:
        q_preload = True
    if kv_frag or not stage_regs:
        pair_resolved = 1
    elif pair is None:
        pair_resolved = 1
    else:
        pair_resolved = pair
    groups = HQ // H
    grid = B * H * seq_len
    direct_k = S == 1 and groups == 16 and (block_size == 16) and (D == 32 and grid <= 512 or (D == 64 and grid <= 256) or (D == 128 and grid <= 128))
    q_shared_preload = S == 1 and D == 64 and (block_size == 16) and (groups == 16) and (threads == 64) and (256 < grid <= 1024) and stage_regs and q_preload and (not q_frag) and (not kv_frag)
    scale_log2 = (D ** (-0.5) if scale is None else float(scale)) * 1.44269504
    use_emitter = S == 1 and groups == 16 and (not kv_frag) and (threads == 64) and (not (D == 64 and block_size == 16) or direct_k)
    use_emitter_online = S > 1 and D == 64 and (block_size == 16) and (groups == 16) and (not kv_frag) and (threads == 64)
    dual_acc = S == 8 and use_emitter_online and (grid >= 4096)
    lane_reduce = use_emitter and (direct_k or late_normalize or (D == 32 and block_size == 16 and (grid <= 1024)))
    prefetch_depth = 1
    if S == 8 and use_emitter_online:
        if grid <= 512 or 2048 <= grid < 4096:
            prefetch_depth = 2
        elif grid >= 4096:
            prefetch_depth = 4
    d32_shuffle = S == 1 and use_emitter and (D == 32) and (block_size == 16) and (grid >= 1024) and (not kv_split)
    direct_vec16 = S == 1 and use_emitter and (D == 128) and (block_size == 16) and direct_k and (not kv_split)
    linear_v = S == 1 and use_emitter and (not kv_split) and (grid <= 2048) and (D == 128 and block_size == 16 and (not direct_k) or (D == 64 and (block_size >= 32 or direct_k)))
    pv32_trial = S == 1 and use_emitter and (D == 128) and (block_size == 32) and (grid >= 4096) and late_normalize and (not kv_split)
    mid_shared_q = S == 1 and D == 64 and (block_size == 16) and (groups == 16) and (threads == 64) and (not kv_frag) and (not kv_split) and (1536 < grid <= 2560) and kv_reuse and stage_regs and q_preload and (not q_frag) and nmax and (not o_stage) and (min_blocks == 0)
    wave_single = S == 1 and use_emitter and (not kv_split) and (D == 32 and block_size == 16 and (grid <= 192 or 512 <= grid <= 4096) or (D == 64 and (block_size == 16 and direct_k or (block_size in (32, 64) and grid <= 2048))) or (D == 128 and block_size == 16 and (grid <= 2048)))
    wave_q_defaults = S == 1 and D == 64 and (block_size == 16) and (groups == 16) and (threads == 64) and (not kv_frag) and (not kv_split) and kv_reuse and stage_regs and q_preload and (not q_frag) and nmax and (not o_stage) and (min_blocks == 0)
    wave_q_reuse = wave_q_defaults and 256 < grid <= 2048
    wave_q_parallel = wave_q_defaults and 2560 < grid <= 4096
    pv32_sync = S == 1 and use_emitter and (D == 128) and (block_size == 32) and (not kv_split) and (grid >= 128)
    joined_short = use_emitter_online and block_size == 16 and (seq_len >= 64) and (S == 2 or (S == 4 and seq_len >= 128 and (grid <= 384)))
    qo_defaults = S == 1 and groups == 16 and (threads == 64) and stage_regs and kv_reuse and q_preload and nmax and (not o_stage) and (not kv_frag) and (not kv_split) and (min_blocks == 0) and (q_frag == (block_size == 32))
    packed_qo = qo_defaults and D == 128 and (block_size == 32) and (grid >= 1024) and True
    coalesced_qo = qo_defaults and (not packed_qo) and (D == 64 and block_size == 16 and (grid >= 2304) or (D == 128 and block_size == 16 and (grid >= 1280)) or (D == 128 and block_size == 32 and (grid >= 1024)))
    qo_narrow = coalesced_qo and D == 128 and (block_size == 32) and (grid < 2048)
    qo_four = qo_narrow or (coalesced_qo and D == 128 and (block_size == 32) and (H > 1))
    qo_ilp = coalesced_qo and D == 128 and (block_size == 32) and (grid >= 2048) and (H == 1) and False
    packed_direct = packed_qo and H == 1 and (seq_len >= 64) and (grid < 4096)
    update_defaults = threads == 64 and groups == 16 and stage_regs and kv_reuse and q_preload and nmax and (not o_stage) and (not kv_frag) and (not kv_split) and (min_blocks == 0) and (pair_resolved == 1) and (num_stages == 1) and (online_unroll == 2) and q_frag and (not late_normalize)
    short_wave_v2 = joined_short and S == 2 and update_defaults and (grid >= 3072)
    short_qo_v2 = short_wave_v2 and grid >= 3072
    s8_output_v2 = S == 8 and use_emitter_online and update_defaults and (grid >= 4096)
    d32_defaults = S == 1 and D == 32 and (block_size == 16) and (groups == 16) and (threads == 64) and stage_regs and kv_reuse and q_preload and nmax and (not o_stage) and (not kv_frag) and (not kv_split) and (not q_frag) and (min_blocks == 0) and (pair_resolved == 1) and (num_stages == 1) and (online_unroll == 2) and (not late_normalize)
    d32_index_guard = d32_defaults and (grid <= 512 and True or (1024 <= grid <= 4096 and H <= 1))
    d32_compact = d32_defaults and 512 < grid < 1024
    coalesced_blocks = coalesced_qo and block_size == 16 and (seq_len % block_size == 0) and (D != 64 or seq_len >= 128) and (pair_resolved == 1) and (num_stages == 1) and (online_unroll == 2) and (not late_normalize)
    shared_q_blocks = wave_q_reuse and H == 1 and (seq_len % block_size == 0) and (pair_resolved == 1) and (num_stages == 1) and (online_unroll == 2) and (not late_normalize)
    mathcast_s8 = mathcast_defaults and s8_output_v2
    mathcast_single = mathcast_defaults and packed_qo
    mathcast_blocks = mathcast_defaults and coalesced_blocks
    oct8_single = mathcast_defaults and groups == 16 and (S == 1) and (block_size == 16)
    oct8_complete = oct8_single and seq_len % block_size == 0
    oct8_direct = oct8_complete and (D == 32 and grid <= 192 or (D == 64 and grid <= 256 and (grid <= 128 or seq_len >= 128)))
    oct8_linear = oct8_complete and D == 128 and (H == 1) and (128 < grid < 768)
    oct8_coalesced = oct8_complete and D == 64 and (seq_len >= 128) and (512 <= grid < 2304)
    oct8_short = mathcast_defaults and groups == 16 and (D == 64) and (block_size == 16) and (S == 2) and (seq_len >= 64) and (grid <= 1024)
    oct8_s4 = mathcast_defaults and groups == 16 and (D == 64) and (block_size == 16) and (S == 4) and (seq_len >= 128) and (768 <= grid <= 1536)
    oct8_staged = mathcast_defaults and groups == 16 and (D == 64) and (S == 4) and (block_size == 16) and (seq_len >= 128) and (seq_len % block_size == 0) and (H <= 2) and (grid <= 4096)
    preload_direct = oct8_direct and (D != 32 or (seq_len >= 64 and grid <= 64 and is_causal)) or (oct8_complete and D == 128 and (grid <= 128))
    tiled_pack = mathcast_single and (not packed_direct) and (B * H * ((seq_len + block_size - 1) // block_size) <= 256)
    fp32_large = mathcast_blocks and (D == 128 or is_causal)
    fp32_multih = oct8_coalesced and H >= 2 and is_causal and (grid < 2048)
    tiny_vfirst = preload_direct and D == 32
    key = (B, seq_len, H, HQ, D, S, block_size, int(bool(is_causal)), scale_log2, threads, num_stages, kv_reuse, stage_regs, o_stage, q_frag, nmax, kv_frag, pair_resolved, min_blocks, q_frag_online, online_unroll, late_normalize, q_preload, use_emitter, use_emitter_online, kv_split, direct_k, q_shared_preload, dual_acc, lane_reduce, prefetch_depth, d32_shuffle, direct_vec16, linear_v, pv32_trial, mid_shared_q, wave_single, wave_q_reuse, wave_q_parallel, pv32_sync, joined_short, coalesced_qo, qo_narrow, qo_four, qo_ilp, packed_qo, packed_direct, short_wave_v2, short_qo_v2, s8_output_v2, d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks, mathcast_s8, mathcast_single, mathcast_blocks, oct8_direct, oct8_linear, oct8_coalesced, oct8_short, oct8_s4, oct8_staged, preload_direct, tiled_pack, fp32_large, fp32_multih, tiny_vfirst)
    kernel = _KERNEL_CACHE.get(key)
    if kernel is None:
        common = dict(batch=B, heads=HQ, seq_len=seq_len, dim=D, is_causal=bool(is_causal), block_size=block_size, groups=groups, scale_log2=scale_log2, threads=threads)
        if preload_direct:
            kernel = (native_sparse_attention_q_preload_vfirst if tiny_vfirst else native_sparse_attention_q_preload)(natural=True, late=D == 32, **common)
        elif oct8_direct:
            kernel = native_sparse_attention_direct_kv(natural=True, late=D == 32, **common)
        elif oct8_linear:
            kernel = native_sparse_attention_linear_v_blocks_oct8(late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif oct8_coalesced:
            kernel = (native_sparse_attention_coalesced_blocks_fp32_mask if fp32_multih else native_sparse_attention_coalesced_blocks_oct8)(q_vec=8, pv_width=128, **common)
        elif oct8_short:
            kernel = (native_sparse_attention_short_list_oct8_sum_v11 if H == 1 else native_sparse_attention_short_list_oct8)(selected_blocks=S, late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif oct8_staged:
            kernel = (native_sparse_attention_staged_sparse_blocks_sum_v11 if H == 1 and is_causal and (seq_len <= 1024) and (grid <= 1024) else native_sparse_attention_staged_sparse_blocks)(selected_blocks=S, **common)
        elif oct8_s4:
            attention = native_sparse_attention_online_packed_batch_minor_o_v2_mathcast(selected_blocks=S, online_unroll=2, dual_acc=False, prefetch_depth=1, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif d32_compact:
            kernel = native_sparse_attention_d32_compact(**common)
        elif d32_index_guard:
            if direct_k:
                d32_builder = native_sparse_attention_single_block_emitter_wave_index_guard if wave_single else native_sparse_attention_single_block_emitter_index_guard
            else:
                d32_builder = native_sparse_attention_d32_shuffle_wave_index_guard
            kernel = d32_builder(late_normalize=late_normalize, lane_reduce=True, kv_split=False, direct_k=direct_k, **common)
        elif packed_qo:
            packed_builder = (native_sparse_attention_single_packed_qo_v2_mathcast_block_joint if mathcast_single and grid >= 4096 else native_sparse_attention_single_packed_qo_v2_mathcast) if mathcast_single else native_sparse_attention_single_packed_qo_v2
            attention = packed_builder(width=128, late=False, **common)
            pack_builder = (native_sparse_attention_pack_kv_bs32_tiles_block_joint if mathcast_single and grid >= 4096 else native_sparse_attention_pack_kv_bs32_tiles) if tiled_pack else (native_sparse_attention_pack_kv_bs32_direct_block_joint if mathcast_single and grid >= 4096 else native_sparse_attention_pack_kv_bs32_direct) if packed_direct else native_sparse_attention_pack_kv_bs32_shared_block_joint if mathcast_single and grid >= 4096 else native_sparse_attention_pack_kv_bs32_shared
            pack = pack_builder(B, seq_len, H, D, block_size)
            kernel = (_make_block_joint_attention if mathcast_single and grid >= 4096 else _make_packed_attention)(pack, attention, B, seq_len, H, D, block_size)
        elif coalesced_qo:
            builder = native_sparse_attention_coalesced_blocks if coalesced_blocks else native_sparse_attention_coalesced_qo
            if mathcast_blocks:
                builder = (native_sparse_attention_coalesced_blocks_fp32_sum if D == 128 else native_sparse_attention_coalesced_blocks_boundary_v8) if fp32_large else native_sparse_attention_coalesced_blocks_mathcast
            kernel = builder(q_vec=4 if qo_four else 8, pv_width=64 if qo_narrow else 128, **common)
        elif joined_short:
            short_builder = native_sparse_attention_short_list_qo_v2 if short_qo_v2 else native_sparse_attention_short_list
            kernel = short_builder(selected_blocks=S, late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif pv32_sync:
            kernel = native_sparse_attention_pv32_sync(wave_sync=grid >= 2048, late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif wave_q_reuse:
            builder = native_sparse_attention_shared_q_blocks if shared_q_blocks else native_sparse_attention_shared_q_reuse
            kernel = builder(late_normalize=late_normalize, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif wave_q_parallel:
            kernel = native_sparse_attention_mid_shared_q_wave(late_normalize=late_normalize, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif wave_single:
            if d32_shuffle:
                kernel = native_sparse_attention_d32_shuffle_wave(late_normalize=late_normalize, lane_reduce=True, kv_split=False, direct_k=False, **common)
            elif direct_vec16:
                kernel = native_sparse_attention_single_vec16_wave(late_normalize=late_normalize, lane_reduce=True, kv_split=False, direct_k=direct_k, **common)
            elif linear_v:
                kernel = native_sparse_attention_single_linear_v_wave(late_normalize=late_normalize, lane_reduce=True, kv_split=False, direct_k=direct_k, **common)
            else:
                kernel = native_sparse_attention_single_block_emitter_wave(late_normalize=late_normalize, lane_reduce=True, kv_split=False, direct_k=direct_k, **common)
        elif d32_shuffle:
            kernel = native_sparse_attention_d32_shuffle(late_normalize=late_normalize, kv_split=False, direct_k=False, lane_reduce=True, **common)
        elif direct_vec16:
            kernel = native_sparse_attention_single_vec16(late_normalize=late_normalize, kv_split=False, direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif linear_v:
            kernel = native_sparse_attention_single_linear_v(late_normalize=late_normalize, kv_split=False, direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif pv32_trial:
            kernel = native_sparse_attention_single_block_pv32(late_normalize=late_normalize, kv_split=False, direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif mid_shared_q:
            kernel = native_sparse_attention_mid_shared_q(late_normalize=late_normalize, kv_split=False, direct_k=False, lane_reduce=False, **common)
        elif S == 1 and use_emitter:
            kernel = native_sparse_attention_single_block_emitter(late_normalize=late_normalize, kv_split=kv_split, direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif S >= 8 and use_emitter_online:
            if S == 8 and grid >= 8192:
                online_builder = native_sparse_attention_online_packed_quad_batch_minor_o_v2 if s8_output_v2 else native_sparse_attention_online_packed_quad_batch_minor
                if mathcast_s8:
                    online_builder = native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast
                attention = online_builder(selected_blocks=S, online_unroll=online_unroll, dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)
            elif S == 8 and grid >= 4096:
                online_builder = native_sparse_attention_online_packed_batch_minor_o_v2 if s8_output_v2 else native_sparse_attention_online_packed_batch_minor
                if mathcast_s8:
                    online_builder = native_sparse_attention_online_packed_batch_minor_o_v2_mathcast
                attention = online_builder(selected_blocks=S, online_unroll=online_unroll, dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)
            else:
                attention = native_sparse_attention_online_packed(selected_blocks=S, online_unroll=online_unroll, dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif S > 1 and use_emitter_online:
            kernel = native_sparse_attention_online_emitter(selected_blocks=S, online_unroll=online_unroll, **common)
        elif S == 1:
            kernel = native_sparse_attention_single_block(kv_reuse=kv_reuse, stage_regs=stage_regs, o_stage=o_stage, q_frag=q_frag, nmax=nmax, kv_frag=kv_frag, min_blocks=min_blocks, late_normalize=late_normalize, q_preload=q_preload, q_shared_preload=q_shared_preload, **common)
        else:
            kernel = native_sparse_attention_online(selected_blocks=S, num_stages=num_stages, o_stage=o_stage, stage_regs=stage_regs, nmax=nmax, kv_frag=kv_frag, pair=pair_resolved, min_blocks=min_blocks, q_frag=q_frag, online_unroll=online_unroll, **common)
        _KERNEL_CACHE[key] = kernel
    _KERNEL_CACHE[entry_key] = kernel
    return kernel


def _as_int32(tensor):


    if tensor.dtype != torch.int32:
        tensor = tensor.to(torch.int32)
    if not tensor.is_contiguous():
        tensor = tensor.contiguous()
    return tensor


def native_sparse_attention(
    batch,
    heads,
    seq_len,
    dim,
    is_causal,
    scale=None,
    block_size=64,
    groups=1,
    selected_blocks=16,
    threads=64,
    num_stages=1,
    kv_reuse=True,
    stage_regs=True,
    o_stage=False,
    q_frag=None,
    nmax=True,
    kv_frag=False,
    pair=None,
    min_blocks=0,
    q_frag_online=None,
    online_unroll=2,
    late_normalize=None,
    q_preload=None,
    kv_split=False,
):
    kernel = _get_kernel(
        batch,
        seq_len,
        heads // groups,
        heads,
        dim,
        selected_blocks,
        block_size,
        is_causal,
        scale,
        threads=threads,
        num_stages=num_stages,
        kv_reuse=kv_reuse,
        stage_regs=stage_regs,
        o_stage=o_stage,
        q_frag=q_frag,
        nmax=nmax,
        kv_frag=kv_frag,
        pair=pair,
        min_blocks=min_blocks,
        q_frag_online=q_frag_online,
        online_unroll=online_unroll,
        late_normalize=late_normalize,
        q_preload=q_preload,
        kv_split=kv_split,
    )

    try:
        kernel = kernel.torch_function or kernel
    except AttributeError:
        pass

    def run(Q, K, V, BlockIndices):
        output = torch.empty_like(Q)
        if BlockIndices.dtype != torch.int32:
            BlockIndices = BlockIndices.to(torch.int32)
        if not BlockIndices.is_contiguous():
            BlockIndices = BlockIndices.contiguous()
        kernel(Q, K, V, BlockIndices, output)
        return output

    return run


def run_kernel(q, k, v, block_indices, output, B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None):
    scale_value = None if scale is None else float(scale)
    key = ('public_default_arguments', B, seq_len, H, HQ, D, S, block_size, is_causal, scale_value)
    try:
        kernel = _KERNEL_CACHE.get(key)
    except TypeError:
        kernel = None
    if kernel is None:
        B, seq_len, H, HQ, D, S, block_size = int(B), int(seq_len), int(H), int(HQ), int(D), int(S), int(block_size)
        is_causal = bool(is_causal)
        key = ('public_default_arguments', B, seq_len, H, HQ, D, S, block_size, is_causal, scale_value)
        kernel = _KERNEL_CACHE.get(key)
        if kernel is None:
            kernel = _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale_value)
            try:
                kernel = kernel.torch_function or kernel
            except AttributeError:
                pass
            _KERNEL_CACHE[key] = kernel
    if block_indices.dtype != torch.int32:
        block_indices = block_indices.to(torch.int32)
    if not block_indices.is_contiguous():
        block_indices = block_indices.contiguous()
    kernel(q, k, v, block_indices, output)
