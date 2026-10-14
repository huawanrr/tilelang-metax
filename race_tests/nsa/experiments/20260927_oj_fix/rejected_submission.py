
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
def native_sparse_attention_online_emitter(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2,
):

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected_blocks], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):
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

            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                K_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    K_shared, vecSize=8),
                V_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    V_shared, vecSize=8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv

            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            T.fill(sum_acc, 0)

            kb = T.alloc_local(
                [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local(
                [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)

            neg_inf = -T.infinity(T.float32)
            for s in T.unroll(S, unroll_factor=online_unroll):
                i_s = indices[s]
                if (i_s >= 0 and i_s < seq_len
                        and (not is_causal or i_s <= i_t)):
                    T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                    T.copy(
                        V[i_b, i_s : i_s + BS, i_h,
                          i_v * BV : (i_v + 1) * BV],
                        V_reg,
                    )
                    T.copy(K_reg, K_shared)

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
                        qk.ldmatrix_b(kb, K_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)

                    T.copy(V_reg, V_shared)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.exp2(
                            T.min(acc_s[i, j] * scale_log2, 15.0))
                    for i, j in T.Parallel(G, BS):
                        sum_acc[i, j] += acc_s[i, j]
                    T.copy(acc_s, acc_s_cast)
                    for ki in T.serial(pv_steps):
                        pv.ldmatrix_b(vb, V_shared, ki)
                        pv.mma(acc_s_cast, vb, acc_o, ki)

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
                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                    for i in T.Parallel(G):
                        scores_inv_sum[i] = T.if_then_else(
                            scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] *= scores_inv_sum[i]
                T.copy(acc_s, acc_s_cast)
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)

                if late_normalize:
                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                    for i in T.Parallel(G):
                        scores_inv_sum[i] = T.if_then_else(
                            scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                    for i, j in T.Parallel(G, BV):
                        acc_o[i, j] *= scores_inv_sum[i]

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
    selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False,
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


class _PackedAttentionKernel:

    def __init__(self, pack, attention, batch, seq_len, heads, dim, block_size):
        self.pack = pack
        self.attention = attention
        blocks = (seq_len + block_size - 1) // block_size
        self.k_shape = (batch, blocks, heads, dim // 32, block_size // 16, 64, 8)
        self.v_shape = (batch, blocks, heads, block_size // 16, dim // 32, 64, 8)

    def __call__(self, q, k, v, indices, output):
        packed_k = torch.empty(self.k_shape, device=k.device, dtype=k.dtype)
        packed_v = torch.empty(self.v_shape, device=v.device, dtype=v.dtype)
        self.pack(k, v, packed_k, packed_v)
        self.attention(q, packed_k, packed_v, indices, output)

    def get_kernel_source(self):
        return self.pack.get_kernel_source() + self.attention.get_kernel_source()


_KERNEL_CACHE = {}


def _get_kernel(
    B,
    seq_len,
    H,
    HQ,
    D,
    S,
    block_size,
    is_causal,
    scale=None,
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
    if q_frag is None:
        q_frag = S > 1 or block_size == 32
    if S > 1 and q_frag_online is not None:
        q_frag = q_frag_online
    if late_normalize is None:
        _bv = min(128, tilelang.math.next_power_of_2(D))
        _grid = seq_len * ((D + _bv - 1) // _bv) * B * H
        late_normalize = D == 128 and block_size == 32 and _grid >= 2048
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
    direct_k = (S == 1 and groups == 16 and block_size == 16 and (
        (D == 32 and grid <= 512) or (D == 64 and grid <= 256)
        or (D == 128 and grid <= 128)))
    q_shared_preload = (S == 1 and D == 64 and block_size == 16
        and groups == 16 and threads == 64 and 256 < grid <= 1024
        and stage_regs and q_preload and not q_frag and not kv_frag)
    scale_log2 = (D**-0.5 if scale is None else float(scale)) * 1.44269504
    use_emitter = (
        S == 1 and groups == 16 and not kv_frag and threads == 64
        and (not (D == 64 and block_size == 16) or direct_k)
    )
    use_emitter_online = (
        S > 1 and D == 64 and block_size == 16 and groups == 16
        and not kv_frag and threads == 64
    )
    dual_acc = S == 8 and use_emitter_online and grid >= 4096
    key = (
        B,
        seq_len,
        H,
        HQ,
        D,
        S,
        block_size,
        int(bool(is_causal)),
        scale_log2,
        threads,
        num_stages,
        kv_reuse,
        stage_regs,
        o_stage,
        q_frag,
        nmax,
        kv_frag,
        pair_resolved,
        min_blocks,
        q_frag_online,
        online_unroll,
        late_normalize,
        q_preload,
        use_emitter,
        use_emitter_online,
        kv_split,
        direct_k,
        q_shared_preload,
        dual_acc,
    )
    kernel = _KERNEL_CACHE.get(key)
    if kernel is None:
        common = dict(
            batch=B,
            heads=HQ,
            seq_len=seq_len,
            dim=D,
            is_causal=bool(is_causal),
            block_size=block_size,
            groups=groups,
            scale_log2=scale_log2,
            threads=threads,
        )
        if S == 1 and use_emitter:
            kernel = native_sparse_attention_single_block_emitter(
                late_normalize=late_normalize, kv_split=kv_split,
                direct_k=direct_k, **common)
        elif S >= 8 and use_emitter_online:
            attention = native_sparse_attention_online_packed(
                selected_blocks=S, online_unroll=online_unroll,
                dual_acc=dual_acc, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _PackedAttentionKernel(
                pack, attention, B, seq_len, H, D, block_size)
        elif S > 1 and use_emitter_online:
            kernel = native_sparse_attention_online_emitter(
                selected_blocks=S, online_unroll=online_unroll, **common)
        elif S == 1:
            kernel = native_sparse_attention_single_block(
                kv_reuse=kv_reuse,
                stage_regs=stage_regs,
                o_stage=o_stage,
                q_frag=q_frag,
                nmax=nmax,
                kv_frag=kv_frag,
                min_blocks=min_blocks,
                late_normalize=late_normalize,
                q_preload=q_preload,
                q_shared_preload=q_shared_preload,
                **common,
            )
        else:
            kernel = native_sparse_attention_online(
                selected_blocks=S,
                num_stages=num_stages,
                o_stage=o_stage,
                stage_regs=stage_regs,
                nmax=nmax,
                kv_frag=kv_frag,
                pair=pair_resolved,
                min_blocks=min_blocks,
                q_frag=q_frag,
                online_unroll=online_unroll,
                **common,
            )
        _KERNEL_CACHE[key] = kernel
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

    def run(Q, K, V, BlockIndices):
        output = torch.empty_like(Q)
        kernel(Q, K, V, _as_int32(BlockIndices), output)
        return output

    return run


def run_kernel(
    q,
    k,
    v,
    block_indices,
    output,
    B,
    seq_len,
    H,
    HQ,
    D,
    S,
    block_size,
    is_causal,
    scale=None,
):
    kernel = _get_kernel(
        int(B),
        int(seq_len),
        int(H),
        int(HQ),
        int(D),
        int(S),
        int(block_size),
        bool(is_causal),
        scale,
    )
    kernel(q, k, v, _as_int32(block_indices), output)
