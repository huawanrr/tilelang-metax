import torch
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics import make_mma_swizzle_layout

# Sweepable config (module-level so sweep.py can override before first JIT).
_CFG = dict(
    kv_path='fragK',     # 'shared' | 'regs' | 'fragK'
    softmax='max',       # 'max' | 'nmax'
    stages=0,            # T.Pipelined num_stages
    threads=128,
    policy='FullRow',    # QK/PV gemm warp policy for frag path
    target_ctas=104,
    assign='interleaved',# 'interleaved' | 'contiguous' kv-block assignment
    block_n=32,
    probe='full',        # timing-only body stripping, do not ship
    fused=False,         # pack Q|Q_pe and KV|K_pe into one K=576 gemm
    hoist_mask=False,    # guard the tail-mask loop behind a full-block check
    clear_acc=False,     # clear_accum=True on the first QK gemm
    maxless_merge=False, # merge weights without the max shift (bounded lse)
    tpart=False,         # transposed output_partial + uint4 merge loads
    prefetch=False,      # cross-iteration KV register prefetch
    pv='scalar',         # 'scalar' | 'tr' (T.transpose) | 'man' (manual loop)
    pv_swz=0,            # if nonzero, annotate KV_T with swizzle vecSize=pv_swz
    atomic_merge=False,  # accumulate partials with global fp32 atomics + epilogue
    qk_split=1,          # split the main QK gemm into N K-chunks (ILP probe)
)


def flashattn(
    batch,
    heads,
    kv_head_num,
    seqlen_kv,
    dim,
    pe_dim,
    block_N,
    block_H,
    num_split,
    softmax_scale,
    kv_path='fragK',
    softmax_mode='max',
    stages=0,
    threads=128,
    policy='FullRow',
    assign='interleaved',
    probe='full',
    fused=False,
    hoist_mask=False,
    clear_acc=False,
    maxless_merge=False,
    tpart=False,
    prefetch=False,
    pv='scalar',
    pv_swz=0,
    atomic_merge=False,
    qk_split=1,
):
    scale = float(softmax_scale * 1.44269504)
    dtype = T.float16
    accum_dtype = T.float32
    kv_group_num = heads // kv_head_num
    valid_block_h = min(block_H, kv_group_num)
    total_kv_blocks = (seqlen_kv + block_N - 1) // block_N
    blocks_per_split = (total_kv_blocks + num_split - 1) // num_split
    gemm_policy = (
        T.GemmWarpPolicy.FullRow if policy == 'FullRow' else T.GemmWarpPolicy.FullCol
    )

    assert kv_head_num == 1, "kv_head_num must be 1"
    assert heads % valid_block_h == 0, "heads must be divisible by block_H"

    accum_shape = [batch, heads, dim + 1] if atomic_merge else [1]

    @T.prim_func
    def main_split(
        Q: T.Tensor([batch, heads, dim], dtype),
        Q_pe: T.Tensor([batch, heads, pe_dim], dtype),
        KV: T.Tensor([batch, seqlen_kv, kv_head_num, dim], dtype),
        K_pe: T.Tensor([batch, seqlen_kv, kv_head_num, pe_dim], dtype),
        Output: T.Tensor([batch, heads, dim], dtype),
        OutAccum: T.Tensor(accum_shape, accum_dtype),
    ):
        if atomic_merge:
            # fp32 accumulators: [.., dim] sums the unnormalized O partials,
            # slot dim sums l.  Zeroed once by the host, re-zeroed by the
            # normalize kernel after every read (steady state).
            pass
        else:
            glse = T.alloc_global([batch, heads, num_split], accum_dtype)
        ns8 = ((num_split + 7) // 8) * 8
        if tpart:
            # Transposed partials [.., dim, ns8]: the merge reads consecutive
            # k values per column, so its loads vectorize to uint4.
            output_partial = T.alloc_global(
                [batch, heads, dim, ns8], dtype
            )
        else:
            output_partial = T.alloc_global(
                [batch, heads, num_split, dim], dtype
            )

        with T.Kernel(
            batch,
            heads // valid_block_h,
            num_split,
            threads=threads,
        ) as (bid, hid, split_id):
            acc_s = T.alloc_fragment([block_H, block_N], accum_dtype)
            scores_sum = T.alloc_fragment([block_H], accum_dtype)
            softmax_l = T.alloc_fragment([block_H], accum_dtype)
            if pv == 'scalar':
                acc_o = T.alloc_fragment([block_H, dim], accum_dtype)
            if softmax_mode != 'nmax':
                scores_scale = T.alloc_fragment([block_H], accum_dtype)

            cur_kv_head = hid // (kv_group_num // block_H)

            T.use_swizzle(10)

            if kv_path == 'fragK':
                if softmax_mode != 'nmax':
                    scores_max = T.alloc_fragment([block_H], accum_dtype)
                    scores_max_prev = T.alloc_fragment([block_H], accum_dtype)
                Q_reg = T.alloc_fragment([block_H, dim], dtype)
                Q_pe_reg = T.alloc_fragment([block_H, pe_dim], dtype)
                KV_reg = T.alloc_fragment([block_N, dim], dtype)
                K_pe_reg = T.alloc_fragment([block_N, pe_dim], dtype)
                KV_shared = T.alloc_shared([block_N, dim], dtype)
                S_shared = T.alloc_shared([block_H, block_N], dtype)

                T.copy(
                    Q[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :],
                    Q_reg,
                )
                T.copy(
                    Q_pe[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :],
                    Q_pe_reg,
                )
                T.fill(acc_o, 0)
                T.fill(softmax_l, 0)
                if softmax_mode != 'nmax':
                    T.fill(scores_max, -T.infinity(accum_dtype))

                for k in T.Pipelined(blocks_per_split, num_stages=stages):
                    if assign == 'contiguous':
                        kv_block_id = split_id * blocks_per_split + k
                    else:
                        kv_block_id = k * num_split + split_id
                    if kv_block_id < total_kv_blocks:
                        kv_start = kv_block_id * block_N
                        kv_end = kv_start + block_N
                        T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_reg)
                        T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], K_pe_reg)
                        # V's shared copy drains while QK + softmax run.
                        T.copy(KV_reg, KV_shared)

                        T.clear(acc_s)
                        T.gemm(Q_reg, KV_reg, acc_s, transpose_B=True, policy=gemm_policy)
                        T.gemm(Q_pe_reg, K_pe_reg, acc_s, transpose_B=True, policy=gemm_policy)

                        if probe != 'mincopy':
                            if hoist_mask and kv_start + block_N <= seqlen_kv:
                                pass
                            else:
                                for i, j in T.Parallel(block_H, block_N):
                                    if kv_start + j >= seqlen_kv:
                                        acc_s[i, j] = -T.infinity(accum_dtype)

                        if softmax_mode == 'nmax' and probe != 'mincopy':
                            for i, j in T.Parallel(block_H, block_N):
                                acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale, 15.0))
                            if probe not in ('nosum', 'nosoftmax', 'mincopy'):
                                # Sum the QUANTIZED fp16 probabilities the PV
                                # gemm consumes, so the denominator cancels
                                # the cast error exactly -- critical for
                                # few-token blocks.
                                acc_h = T.alloc_fragment([block_H, block_N], dtype)
                                T.copy(acc_s, acc_h)
                                T.reduce_sum(acc_h, scores_sum, dim=1, clear=True)
                                for i in T.Parallel(block_H):
                                    softmax_l[i] = softmax_l[i] + scores_sum[i]
                        else:
                            T.copy(scores_max, scores_max_prev)
                            T.fill(scores_max, -T.infinity(accum_dtype))
                            T.reduce_max(acc_s, scores_max, dim=1, clear=False)
                            for i in T.Parallel(block_H):
                                scores_max[i] = T.max(scores_max[i], scores_max_prev[i])
                                scores_scale[i] = T.exp2(
                                    (scores_max_prev[i] - scores_max[i]) * scale
                                )
                            for i, j in T.Parallel(block_H, block_N):
                                acc_s[i, j] = T.exp2(
                                    (acc_s[i, j] - scores_max[i]) * scale
                                )
                            T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                            for i in T.Parallel(block_H):
                                softmax_l[i] = (
                                    softmax_l[i] * scores_scale[i] + scores_sum[i]
                                )
                            for i, j in T.Parallel(block_H, dim):
                                acc_o[i, j] *= scores_scale[i]

                        if probe not in ('nopv', 'nocopy', 'mincopy'):
                            T.copy(acc_s, S_shared)
                            if fused:
                                T.gemm(
                                    S_shared,
                                    KV_shared[:, 0:dim],
                                    acc_o,
                                    policy=T.GemmWarpPolicy.FullCol,
                                )
                            else:
                                T.gemm(
                                    S_shared,
                                    KV_shared,
                                    acc_o,
                                    policy=T.GemmWarpPolicy.FullCol,
                                )
                        if prefetch and has_next:
                            T.copy(KV_next, KV_shared)
                            T.copy(K_pe_next, K_pe_shared)

                for i, j in T.Parallel(block_H, dim):
                    acc_o[i, j] /= softmax_l[i]
                if softmax_mode == 'nmax':
                    for i in T.Parallel(block_H):
                        softmax_l[i] = T.log2(softmax_l[i])
                else:
                    for i in T.Parallel(block_H):
                        softmax_l[i] = T.log2(softmax_l[i]) + scores_max[i] * scale

                T.copy(
                    softmax_l,
                    glse[bid, hid * valid_block_h : (hid + 1) * valid_block_h, split_id],
                )
                if tpart:
                    for i, j in T.Parallel(block_H, dim):
                        output_partial[bid, hid * valid_block_h + i, j, split_id] = acc_o[i, j]
                else:
                    for i, j in T.Parallel(block_H, dim):
                        output_partial[bid, hid * valid_block_h + i, split_id, j] = acc_o[i, j]

            else:
                if softmax_mode != 'nmax':
                    scores_max = T.alloc_fragment([block_H], accum_dtype)
                    scores_max_prev = T.alloc_fragment([block_H], accum_dtype)
                if kv_path == 'shrink':
                    Q_reg = T.alloc_fragment([block_H, dim], dtype)
                    Q_pe_reg = T.alloc_fragment([block_H, pe_dim], dtype)
                    K_pe_reg = T.alloc_fragment([block_N, pe_dim], dtype)
                elif fused:
                    Q_shared = T.alloc_shared([block_H, dim + pe_dim], dtype)
                    KV_shared = T.alloc_shared([block_N, dim + pe_dim], dtype)
                else:
                    Q_shared = T.alloc_shared([block_H, dim], dtype)
                    Q_pe_shared = T.alloc_shared([block_H, pe_dim], dtype)
                    K_pe_shared = T.alloc_shared([block_N, pe_dim], dtype)
                    KV_shared = T.alloc_shared([block_N, dim], dtype)
                S_shared = T.alloc_shared([block_H, block_N], dtype)
                if pv != 'scalar':
                    # Token-contiguous V tile for the vectorized-B PV gemm.
                    # 8 KB chunk fits the ~9 KB left of the 64 KiB window
                    # (Q 16 + Q_pe 2 + KV 32 + K_pe 4 + S 1 KB).
                    pv_chunk = 128 if dim % 128 == 0 else dim
                    KV_T_shared = T.alloc_shared([pv_chunk, block_N], dtype)
                    if pv_swz:
                        # Coarser swizzle granularity keeps 16B groups
                        # contiguous so the transpose stores can merge.
                        T.annotate_layout({
                            KV_T_shared: make_mma_swizzle_layout(
                                KV_T_shared, vecSize=pv_swz),
                        })
                    acc_o0 = T.alloc_fragment([block_H, pv_chunk], accum_dtype)
                    acc_o1 = T.alloc_fragment([block_H, pv_chunk], accum_dtype)
                    acc_o2 = T.alloc_fragment([block_H, pv_chunk], accum_dtype)
                    acc_o3 = T.alloc_fragment([block_H, pv_chunk], accum_dtype)
                    acc_o_pieces = [acc_o0, acc_o1, acc_o2, acc_o3]
                    pv_nchunk = dim // pv_chunk

                if kv_path == 'shrink':
                    T.copy(
                        Q[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :],
                        Q_reg,
                    )
                    T.copy(
                        Q_pe[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :],
                        Q_pe_reg,
                    )
                elif fused:
                    T.copy(
                        Q[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :],
                        Q_shared[:, 0:dim],
                    )
                    T.copy(
                        Q_pe[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :],
                        Q_shared[:, dim:],
                    )
                else:
                    T.copy(
                        Q[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :],
                        Q_shared,
                    )
                    T.copy(
                        Q_pe[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :],
                        Q_pe_shared,
                    )
                if pv == 'scalar':
                    T.fill(acc_o, 0)
                else:
                    T.fill(acc_o0, 0)
                    T.fill(acc_o1, 0)
                    T.fill(acc_o2, 0)
                    T.fill(acc_o3, 0)
                T.fill(softmax_l, 0)
                if softmax_mode != 'nmax':
                    T.fill(scores_max, -T.infinity(accum_dtype))

                if kv_path == 'regs':
                    KV_reg = T.alloc_fragment([block_N, dim], dtype)
                    K_pe_reg = T.alloc_fragment([block_N, pe_dim], dtype)
                if prefetch:
                    # Cross-iteration register prefetch: block k+1's global
                    # loads issue before block k's compute, hiding the DRAM
                    # latency; installing the registers into shared is then
                    # latency-free.
                    KV_next = T.alloc_fragment([block_N, dim], dtype)
                    K_pe_next = T.alloc_fragment([block_N, pe_dim], dtype)
                    k0 = split_id
                    if k0 < total_kv_blocks:
                        T.copy(KV[bid, k0 * block_N : (k0 + 1) * block_N, cur_kv_head, :], KV_shared)
                        T.copy(K_pe[bid, k0 * block_N : (k0 + 1) * block_N, cur_kv_head, :], K_pe_shared)
                    k1 = num_split + split_id
                    if k1 < total_kv_blocks:
                        T.copy(KV[bid, k1 * block_N : (k1 + 1) * block_N, cur_kv_head, :], KV_next)
                        T.copy(K_pe[bid, k1 * block_N : (k1 + 1) * block_N, cur_kv_head, :], K_pe_next)

                for k in T.Pipelined(blocks_per_split, num_stages=stages):
                    if prefetch:
                        kv_block_id = k * num_split + split_id
                        kv_next_id = (k + 1) * num_split + split_id
                        has_next = kv_next_id < total_kv_blocks
                        if has_next:
                            nstart = kv_next_id * block_N
                            T.copy(KV[bid, nstart : nstart + block_N, cur_kv_head, :], KV_next)
                            T.copy(K_pe[bid, nstart : nstart + block_N, cur_kv_head, :], K_pe_next)
                        kv_valid = kv_block_id < total_kv_blocks
                    else:
                        kv_block_id = k * num_split + split_id
                        has_next = False
                        kv_valid = kv_block_id < total_kv_blocks
                    if kv_valid:
                        kv_start = kv_block_id * block_N
                        kv_end = kv_start + block_N

                        if prefetch:
                            pass  # block already installed from registers
                        elif kv_path == 'shrink':
                            T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_shared)
                            T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], K_pe_reg)
                        elif fused:
                            T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_shared[:, 0:dim])
                            T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], KV_shared[:, dim:])
                        elif kv_path == 'regs':
                            T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_reg)
                            T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], K_pe_reg)
                            T.copy(KV_reg, KV_shared)
                            T.copy(K_pe_reg, K_pe_shared)
                        elif probe == 'nocopy' or probe == 'noload':
                            if probe == 'noload':
                                T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], K_pe_shared)
                        else:
                            T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_shared)
                            T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], K_pe_shared)

                        if not clear_acc:
                            T.clear(acc_s)
                        if probe not in ('noqk', 'mincopy'):
                            if fused:
                                T.gemm(
                                    Q_shared,
                                    KV_shared,
                                    acc_s,
                                    transpose_B=True,
                                    policy=T.GemmWarpPolicy.FullCol,
                                    clear_accum=clear_acc,
                                )
                            elif kv_path == 'shrink':
                                T.gemm(
                                    Q_reg,
                                    KV_shared,
                                    acc_s,
                                    transpose_B=True,
                                    policy=gemm_policy,
                                )
                                T.gemm(
                                    Q_pe_reg,
                                    K_pe_reg,
                                    acc_s,
                                    transpose_B=True,
                                    policy=gemm_policy,
                                )
                            if qk_split == 1:
                                T.gemm(
                                    Q_shared,
                                    KV_shared,
                                    acc_s,
                                    transpose_B=True,
                                    policy=gemm_policy,
                                    clear_accum=clear_acc,
                                )
                            else:
                                qk_step = dim // qk_split
                                if qk_split >= 1:
                                    T.gemm(
                                        Q_shared[:, 0 * qk_step:1 * qk_step],
                                        KV_shared[:, 0 * qk_step:1 * qk_step],
                                        acc_s,
                                        transpose_B=True,
                                        policy=gemm_policy,
                                        clear_accum=True,
                                    )
                                if qk_split >= 2:
                                    T.gemm(
                                        Q_shared[:, 1 * qk_step:2 * qk_step],
                                        KV_shared[:, 1 * qk_step:2 * qk_step],
                                        acc_s,
                                        transpose_B=True,
                                        policy=gemm_policy,
                                        clear_accum=False,
                                    )
                                if qk_split >= 3:
                                    T.gemm(
                                        Q_shared[:, 2 * qk_step:3 * qk_step],
                                        KV_shared[:, 2 * qk_step:3 * qk_step],
                                        acc_s,
                                        transpose_B=True,
                                        policy=gemm_policy,
                                        clear_accum=False,
                                    )
                                if qk_split >= 4:
                                    T.gemm(
                                        Q_shared[:, 3 * qk_step:4 * qk_step],
                                        KV_shared[:, 3 * qk_step:4 * qk_step],
                                        acc_s,
                                        transpose_B=True,
                                        policy=gemm_policy,
                                        clear_accum=False,
                                    )
                            T.gemm(
                                Q_pe_shared,
                                K_pe_shared,
                                acc_s,
                                transpose_B=True,
                                policy=gemm_policy,
                            )

                        if probe != 'mincopy':
                            if hoist_mask and kv_start + block_N <= seqlen_kv:
                                pass
                            else:
                                for i, j in T.Parallel(block_H, block_N):
                                    if kv_start + j >= seqlen_kv:
                                        acc_s[i, j] = -T.infinity(accum_dtype)

                        if softmax_mode == 'nmax' and probe != 'mincopy':
                            for i, j in T.Parallel(block_H, block_N):
                                acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale, 15.0))
                            if probe not in ('nosum', 'nosoftmax', 'mincopy'):
                                # Sum the QUANTIZED fp16 probabilities the PV
                                # gemm consumes, so the denominator cancels
                                # the cast error exactly -- critical for
                                # few-token blocks.
                                acc_h = T.alloc_fragment([block_H, block_N], dtype)
                                T.copy(acc_s, acc_h)
                                T.reduce_sum(acc_h, scores_sum, dim=1, clear=True)
                                for i in T.Parallel(block_H):
                                    softmax_l[i] = softmax_l[i] + scores_sum[i]
                        else:
                            T.copy(scores_max, scores_max_prev)
                            T.fill(scores_max, -T.infinity(accum_dtype))
                            T.reduce_max(acc_s, scores_max, dim=1, clear=False)
                            for i in T.Parallel(block_H):
                                scores_max[i] = T.max(scores_max[i], scores_max_prev[i])
                                scores_scale[i] = T.exp2(
                                    (scores_max_prev[i] - scores_max[i]) * scale
                                )
                            for i, j in T.Parallel(block_H, block_N):
                                acc_s[i, j] = T.exp2(
                                    (acc_s[i, j] - scores_max[i]) * scale
                                )
                            T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                            for i in T.Parallel(block_H):
                                softmax_l[i] = (
                                    softmax_l[i] * scores_scale[i] + scores_sum[i]
                                )
                            if pv == 'scalar':
                                for i, j in T.Parallel(block_H, dim):
                                    acc_o[i, j] *= scores_scale[i]
                            else:
                                for i, j in T.Parallel(block_H, pv_chunk):
                                    acc_o0[i, j] *= scores_scale[i]
                                for i, j in T.Parallel(block_H, pv_chunk):
                                    acc_o1[i, j] *= scores_scale[i]
                                for i, j in T.Parallel(block_H, pv_chunk):
                                    acc_o2[i, j] *= scores_scale[i]
                                for i, j in T.Parallel(block_H, pv_chunk):
                                    acc_o3[i, j] *= scores_scale[i]

                        if probe not in ('nopv', 'nocopy', 'mincopy'):
                            T.copy(acc_s, S_shared)
                            if pv != 'scalar':
                                # Vectorized-B PV: feed the gemm a
                                # token-contiguous (transposed) V chunk,
                                # same call form as the QK gemm.  The B
                                # fragment loads become 8B uint2 instead
                                # of 2B scalars.
                                # Vectorized-B PV: feed each gemm a
                                # token-contiguous (transposed) V chunk,
                                # same call form as the QK gemm, so the B
                                # fragment loads are 8B uint2 instead of
                                # 2B scalars.  Literal unroll: a range()
                                # loop becomes a TIR var, which cannot
                                # pick between Python fragment objects.
                                if pv == 'tr':
                                    T.transpose(
                                        KV_shared[:, 0 * pv_chunk:1 * pv_chunk],
                                        KV_T_shared,
                                    )
                                else:
                                    for i, j in T.Parallel(block_N, pv_chunk):
                                        KV_T_shared[j, i] = KV_shared[i, 0 * pv_chunk + j]
                                T.gemm(
                                    S_shared,
                                    KV_T_shared,
                                    acc_o0,
                                    transpose_B=True,
                                    policy=T.GemmWarpPolicy.FullCol,
                                )
                                if pv == 'tr':
                                    T.transpose(
                                        KV_shared[:, 1 * pv_chunk:2 * pv_chunk],
                                        KV_T_shared,
                                    )
                                else:
                                    for i, j in T.Parallel(block_N, pv_chunk):
                                        KV_T_shared[j, i] = KV_shared[i, 1 * pv_chunk + j]
                                T.gemm(
                                    S_shared,
                                    KV_T_shared,
                                    acc_o1,
                                    transpose_B=True,
                                    policy=T.GemmWarpPolicy.FullCol,
                                )
                                if pv == 'tr':
                                    T.transpose(
                                        KV_shared[:, 2 * pv_chunk:3 * pv_chunk],
                                        KV_T_shared,
                                    )
                                else:
                                    for i, j in T.Parallel(block_N, pv_chunk):
                                        KV_T_shared[j, i] = KV_shared[i, 2 * pv_chunk + j]
                                T.gemm(
                                    S_shared,
                                    KV_T_shared,
                                    acc_o2,
                                    transpose_B=True,
                                    policy=T.GemmWarpPolicy.FullCol,
                                )
                                if pv == 'tr':
                                    T.transpose(
                                        KV_shared[:, 3 * pv_chunk:4 * pv_chunk],
                                        KV_T_shared,
                                    )
                                else:
                                    for i, j in T.Parallel(block_N, pv_chunk):
                                        KV_T_shared[j, i] = KV_shared[i, 3 * pv_chunk + j]
                                T.gemm(
                                    S_shared,
                                    KV_T_shared,
                                    acc_o3,
                                    transpose_B=True,
                                    policy=T.GemmWarpPolicy.FullCol,
                                )
                            elif fused:
                                T.gemm(
                                    S_shared,
                                    KV_shared[:, 0:dim],
                                    acc_o,
                                    policy=T.GemmWarpPolicy.FullCol,
                                )
                            else:
                                T.gemm(
                                    S_shared,
                                    KV_shared,
                                    acc_o,
                                    policy=T.GemmWarpPolicy.FullCol,
                                )
                        if prefetch and has_next:
                            T.copy(KV_next, KV_shared)
                            T.copy(K_pe_next, K_pe_shared)

                if atomic_merge:
                    # Ship the raw partials into the fp32 accumulators; the
                    # normalize kernel divides by the accumulated l.  Scalar
                    # fp32 RMWs -- no vector atomics on MACA.
                    for i, j in T.Parallel(block_H, dim):
                        T.atomic_add(OutAccum[bid, hid * valid_block_h + i, j], acc_o[i, j])
                    for i in T.Parallel(block_H):
                        T.atomic_add(OutAccum[bid, hid * valid_block_h + i, dim], softmax_l[i])
                elif pv == 'scalar':
                    for i, j in T.Parallel(block_H, dim):
                        acc_o[i, j] /= softmax_l[i]
                else:
                    for i, j in T.Parallel(block_H, pv_chunk):
                        acc_o0[i, j] /= softmax_l[i]
                    for i, j in T.Parallel(block_H, pv_chunk):
                        acc_o1[i, j] /= softmax_l[i]
                    for i, j in T.Parallel(block_H, pv_chunk):
                        acc_o2[i, j] /= softmax_l[i]
                    for i, j in T.Parallel(block_H, pv_chunk):
                        acc_o3[i, j] /= softmax_l[i]
                if not atomic_merge:
                    if softmax_mode == 'nmax':
                        for i in T.Parallel(block_H):
                            softmax_l[i] = T.log2(softmax_l[i])
                    else:
                        for i in T.Parallel(block_H):
                            softmax_l[i] = T.log2(softmax_l[i]) + scores_max[i] * scale

                if atomic_merge:
                    pass
                elif not tpart:
                    T.copy(
                        softmax_l,
                        glse[bid, hid * valid_block_h : (hid + 1) * valid_block_h, split_id],
                    )
                if atomic_merge:
                    pass
                elif tpart:
                    for i, j in T.Parallel(block_H, dim):
                        output_partial[bid, hid * valid_block_h + i, j, split_id] = acc_o[i, j]
                elif pv == 'scalar':
                    for i, j in T.Parallel(block_H, dim):
                        output_partial[bid, hid * valid_block_h + i, split_id, j] = acc_o[i, j]
                else:
                    for i, j in T.Parallel(block_H, pv_chunk):
                        output_partial[
                            bid,
                            hid * valid_block_h + i,
                            split_id,
                            0 * pv_chunk + j,
                        ] = acc_o0[i, j]
                    for i, j in T.Parallel(block_H, pv_chunk):
                        output_partial[
                            bid,
                            hid * valid_block_h + i,
                            split_id,
                            1 * pv_chunk + j,
                        ] = acc_o1[i, j]
                    for i, j in T.Parallel(block_H, pv_chunk):
                        output_partial[
                            bid,
                            hid * valid_block_h + i,
                            split_id,
                            2 * pv_chunk + j,
                        ] = acc_o2[i, j]
                    for i, j in T.Parallel(block_H, pv_chunk):
                        output_partial[
                            bid,
                            hid * valid_block_h + i,
                            split_id,
                            3 * pv_chunk + j,
                        ] = acc_o3[i, j]

        if not atomic_merge:
            if tpart:
                # v6: transposed partials -- each thread owns one column and reads
                # its ns8 k-values in uint4 chunks; weights are precomputed in
                # shared once (k >= num_split get weight 0).
                with T.Kernel(heads, batch, T.ceildiv(dim, 128), threads=128) as (hid, bid, did):
                    lse_s = T.alloc_shared([128], accum_dtype)
                    w_s = T.alloc_shared([128], accum_dtype)
                    max_lse = T.alloc_fragment([1], accum_dtype)
                    weight_sum = T.alloc_fragment([1], accum_dtype)
                    pk = T.alloc_fragment([128, 8], dtype)
                    acc_c = T.alloc_fragment([128], accum_dtype)

                    for k in T.Parallel(128):
                        if k < num_split:
                            lse_s[k] = glse[bid, hid, k]
                    T.fill(max_lse, -T.infinity(accum_dtype))
                    for k in range(num_split):
                        max_lse[0] = T.max(max_lse[0], lse_s[k])
                    T.fill(weight_sum, 0)
                    for k in range(num_split):
                        weight_sum[0] = weight_sum[0] + T.exp2(lse_s[k] - max_lse[0])
                    inv_sum = 1.0 / weight_sum[0]
                    for k in T.Parallel(128):
                        if k < num_split:
                            w_s[k] = T.exp2(lse_s[k] - max_lse[0]) * inv_sum
                        else:
                            w_s[k] = 0.0
                    T.fill(acc_c, 0)
                    for j8 in range(ns8 // 8):
                        T.copy(
                            output_partial[bid, hid, did * 128 : (did + 1) * 128, j8 * 8 : (j8 + 1) * 8],
                            pk,
                        )
                        for kk in range(8):
                            w_k = w_s[j8 * 8 + kk]
                            for c in T.Parallel(128):
                                acc_c[c] = acc_c[c] + w_k * pk[c, kk]
                    for c in T.Parallel(128):
                        Output[bid, hid, did * 128 + c] = acc_c[c].astype(T.float16)
            elif num_split >= 2 and (num_split % 4 == 0 or num_split == 2):
                # Fragment merge (v1): needs merge_groups*merge_lanes == 128, so
                # any num_split except 3.  Fastest for large num_split.
                merge_groups = min(4, num_split)
                merge_lanes = 128 // merge_groups
                with T.Kernel(heads, batch, T.ceildiv(dim, 128), threads=128) as (hid, bid, did):
                    split_lse = T.alloc_fragment([num_split], accum_dtype)
                    max_lse = T.alloc_fragment([1], accum_dtype)
                    weight_sum = T.alloc_fragment([1], accum_dtype)
                    weighted_o = T.alloc_fragment([num_split, 128], accum_dtype)
                    output_accum = T.alloc_fragment([128], accum_dtype)
                    T.annotate_layout({
                        split_lse: T.Fragment([num_split], forward_thread_fn=lambda s, r: (s % merge_groups) * merge_lanes + r, forward_index_fn=lambda s: s // merge_groups, replicate=merge_lanes),
                        weighted_o: T.Fragment([num_split, 128], forward_thread_fn=lambda s, d: (s % merge_groups) * merge_lanes + d % merge_lanes, forward_index_fn=lambda s, d: (s // merge_groups) * merge_groups + d // merge_lanes),
                    })
                    for k in T.Parallel(num_split):
                        split_lse[k] = glse[bid, hid, k]
                    if maxless_merge:
                        # lse is bounded (<= ~30) by the exp2 clamp upstream, so
                        # the max shift is a no-op numerically: recover the block
                        # sums directly and let the final division normalize.
                        for k in T.Parallel(num_split):
                            split_lse[k] = T.exp2(split_lse[k])
                    else:
                        T.reduce_max(split_lse, max_lse, dim=0)
                        for k in T.Parallel(num_split):
                            split_lse[k] = T.exp2(split_lse[k] - max_lse[0])
                    T.reduce_sum(split_lse, weight_sum, dim=0)
                    for k, i in T.Parallel(num_split, 128):
                        weighted_o[k, i] = output_partial[bid, hid, k, did * 128 + i] * split_lse[k]
                    T.reduce_sum(weighted_o, output_accum, dim=0)
                    for i in T.Parallel(128):
                        Output[bid, hid, did * 128 + i] = (output_accum[i] / weight_sum[0]).astype(T.float16)
            elif _CFG.get('merge', 'auto') == 'v5':
                # Shared-staged merge: one cooperative global pass loads all
                # partials for this 128-column slice into shared, then each
                # thread reduces its column across splits from shared.
                with T.Kernel(heads, batch, T.ceildiv(dim, 128), threads=128) as (hid, bid, did):
                    p_s = T.alloc_shared([num_split, 128], dtype)
                    lse_s = T.alloc_shared([128], accum_dtype)
                    max_lse = T.alloc_fragment([1], accum_dtype)
                    weight_sum = T.alloc_fragment([1], accum_dtype)
                    acc_m = T.alloc_fragment([128], accum_dtype)

                    for k, i in T.Parallel(num_split, 128):
                        p_s[k, i] = output_partial[bid, hid, k, did * 128 + i]
                    for k in T.Parallel(128):
                        if k < num_split:
                            lse_s[k] = glse[bid, hid, k]
                    T.fill(max_lse, -T.infinity(accum_dtype))
                    for k in range(num_split):
                        max_lse[0] = T.max(max_lse[0], lse_s[k])
                    T.fill(weight_sum, 0)
                    for k in range(num_split):
                        weight_sum[0] = weight_sum[0] + T.exp2(lse_s[k] - max_lse[0])
                    inv_sum = 1.0 / weight_sum[0]
                    T.fill(acc_m, 0)
                    for k in range(num_split):
                        w_k = T.exp2(lse_s[k] - max_lse[0]) * inv_sum
                        for i in T.Parallel(128):
                            acc_m[i] = acc_m[i] + w_k * p_s[k, i]
                    for i in T.Parallel(128):
                        Output[bid, hid, did * 128 + i] = acc_m[i].astype(T.float16)
            else:
                # Shared-memory merge (v4): works for any num_split.  Each thread
                # owns 4 columns; the unrolled k-loop keeps partial loads in flight.
                merge_cols = 512 if dim % 512 == 0 else dim
                with T.Kernel(heads, batch, T.ceildiv(dim, merge_cols), threads=128) as (hid, bid, did):
                    lse_s = T.alloc_shared([128], accum_dtype)
                    max_lse = T.alloc_fragment([1], accum_dtype)
                    weight_sum = T.alloc_fragment([1], accum_dtype)
                    acc_m = T.alloc_fragment([merge_cols], accum_dtype)

                    for k in T.Parallel(128):
                        if k < num_split:
                            lse_s[k] = glse[bid, hid, k]
                    T.fill(max_lse, -T.infinity(accum_dtype))
                    for k in range(num_split):
                        max_lse[0] = T.max(max_lse[0], lse_s[k])
                    T.fill(weight_sum, 0)
                    for k in range(num_split):
                        weight_sum[0] = weight_sum[0] + T.exp2(lse_s[k] - max_lse[0])
                    inv_sum = 1.0 / weight_sum[0]
                    T.fill(acc_m, 0)
                    for k in range(num_split):
                        w_k = T.exp2(lse_s[k] - max_lse[0]) * inv_sum
                        for i in T.Parallel(merge_cols):
                            acc_m[i] = acc_m[i] + w_k * output_partial[bid, hid, k, did * merge_cols + i]
                    for i in T.Parallel(merge_cols):
                        Output[bid, hid, did * merge_cols + i] = acc_m[i].astype(T.float16)

        @T.prim_func
        def main_no_split(
            Q: T.Tensor([batch, heads, dim], dtype),
            Q_pe: T.Tensor([batch, heads, pe_dim], dtype),
            KV: T.Tensor([batch, seqlen_kv, kv_head_num, dim], dtype),
            K_pe: T.Tensor([batch, seqlen_kv, kv_head_num, pe_dim], dtype),
            Output: T.Tensor([batch, heads, dim], dtype),
        ):
            with T.Kernel(
                heads // valid_block_h,
                batch,
                threads=threads,
            ) as (hid, bid):
                if kv_path in ('fragK', 'frag2'):
                    Q_reg = T.alloc_fragment([block_H, dim], dtype)
                    Q_pe_reg = T.alloc_fragment([block_H, pe_dim], dtype)
                    KV_reg = T.alloc_fragment([block_N, dim], dtype)
                    K_pe_reg = T.alloc_fragment([block_N, pe_dim], dtype)
                    KV_shared = T.alloc_shared([block_N, dim], dtype)
                    S_shared = T.alloc_shared([block_H, block_N], dtype)
                else:
                    Q_shared = T.alloc_shared([block_H, dim], dtype)
                    Q_pe_shared = T.alloc_shared([block_H, pe_dim], dtype)
                    KV_shared = T.alloc_shared([block_N, dim], dtype)
                    K_pe_shared = T.alloc_shared([block_N, pe_dim], dtype)
                    S_shared = T.alloc_shared([block_H, block_N], dtype)

                acc_s = T.alloc_fragment([block_H, block_N], accum_dtype)
                acc_o = T.alloc_fragment([block_H, dim], accum_dtype)
                scores_sum = T.alloc_fragment([block_H], accum_dtype)
                softmax_l = T.alloc_fragment([block_H], accum_dtype)
                if softmax_mode != 'nmax':
                    scores_max = T.alloc_fragment([block_H], accum_dtype)
                    scores_max_prev = T.alloc_fragment([block_H], accum_dtype)
                    scores_scale = T.alloc_fragment([block_H], accum_dtype)

                cur_kv_head = hid // (kv_group_num // block_H)

                T.use_swizzle(10)
                if kv_path in ('fragK', 'frag2'):
                    T.copy(Q[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :], Q_reg)
                    T.copy(Q_pe[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :], Q_pe_reg)
                else:
                    T.copy(Q[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :], Q_shared)
                    T.copy(Q_pe[bid, hid * valid_block_h : (hid + 1) * valid_block_h, :], Q_pe_shared)
                T.fill(acc_o, 0)
                T.fill(softmax_l, 0)
                if softmax_mode != 'nmax':
                    T.fill(scores_max, -T.infinity(accum_dtype))

                for k in T.Pipelined(total_kv_blocks, num_stages=stages):
                    kv_start = k * block_N
                    kv_end = kv_start + block_N

                    if kv_path == 'fragK':
                        T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_reg)
                        T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], K_pe_reg)
                        T.copy(KV_reg, KV_shared)
                    elif kv_path == 'frag2':
                        T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_reg)
                        T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], K_pe_reg)
                        T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_shared)
                    else:
                        T.copy(KV[bid, kv_start:kv_end, cur_kv_head, :], KV_shared)
                        T.copy(K_pe[bid, kv_start:kv_end, cur_kv_head, :], K_pe_shared)

                    T.clear(acc_s)
                    if kv_path in ('fragK', 'frag2'):
                        T.gemm(Q_reg, KV_reg, acc_s, transpose_B=True, policy=gemm_policy)
                        T.gemm(Q_pe_reg, K_pe_reg, acc_s, transpose_B=True, policy=gemm_policy)
                    else:
                        T.gemm(
                            Q_shared,
                            KV_shared,
                            acc_s,
                            transpose_B=True,
                            policy=T.GemmWarpPolicy.FullCol,
                            clear_accum=True,
                        )
                        T.gemm(
                            Q_pe_shared,
                            K_pe_shared,
                            acc_s,
                            transpose_B=True,
                            policy=T.GemmWarpPolicy.FullCol,
                        )

                    for i, j in T.Parallel(block_H, block_N):
                        if kv_start + j >= seqlen_kv:
                            acc_s[i, j] = -T.infinity(accum_dtype)

                    if softmax_mode == 'nmax':
                        for i, j in T.Parallel(block_H, block_N):
                            acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale, 15.0))
                        acc_h = T.alloc_fragment([block_H, block_N], dtype)
                        T.copy(acc_s, acc_h)
                        T.reduce_sum(acc_h, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(block_H):
                            softmax_l[i] = softmax_l[i] + scores_sum[i]
                    else:
                        T.copy(scores_max, scores_max_prev)
                        T.fill(scores_max, -T.infinity(accum_dtype))
                        T.reduce_max(acc_s, scores_max, dim=1, clear=False)
                        for i in T.Parallel(block_H):
                            scores_max[i] = T.max(scores_max[i], scores_max_prev[i])
                            scores_scale[i] = T.exp2(
                                (scores_max_prev[i] - scores_max[i]) * scale
                            )
                        for i, j in T.Parallel(block_H, block_N):
                            acc_s[i, j] = T.exp2(
                                (acc_s[i, j] - scores_max[i]) * scale
                            )
                        T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                        for i in T.Parallel(block_H):
                            softmax_l[i] = (
                                softmax_l[i] * scores_scale[i] + scores_sum[i]
                            )
                        for i, j in T.Parallel(block_H, dim):
                            acc_o[i, j] *= scores_scale[i]

                    if kv_path in ('fragK', 'frag2'):
                        T.copy(acc_s, S_shared)
                        T.gemm(
                            S_shared,
                            KV_shared,
                            acc_o,
                            policy=T.GemmWarpPolicy.FullCol,
                        )
                    else:
                        T.copy(acc_s, S_shared)
                        T.gemm(
                            S_shared,
                            KV_shared,
                            acc_o,
                            policy=T.GemmWarpPolicy.FullCol,
                        )

                for i, j in T.Parallel(block_H, dim):
                    acc_o[i, j] /= softmax_l[i]

                for i, j in T.Parallel(block_H, dim):
                    Output[bid, hid * valid_block_h + i, j] = acc_o[i, j]

    if atomic_merge:
        accum_shape_n = [batch, heads, dim + 1]

        @T.prim_func
        def normalize(
            Output: T.Tensor([batch, heads, dim], dtype),
            OutAccum: T.Tensor(accum_shape_n, accum_dtype),
        ):
            with T.Kernel(heads, batch, threads=128) as (hid, bid):
                inv_s = T.alloc_shared([1], accum_dtype)
                # Thread 0 alone converts the accumulated l to a reciprocal
                # and later re-zeros it: its own global reads and writes are
                # program-ordered, and the shared round-trip gives every
                # thread a race-free broadcast read.
                for i in T.Parallel(1):
                    inv_s[0] = 1.0 / OutAccum[bid, hid, dim]
                for j in T.Parallel(dim):
                    Output[bid, hid, j] = (
                        OutAccum[bid, hid, j] * inv_s[0]
                    ).astype(dtype)
                # Self-zeroing keeps the steady state clean across graph
                # replays without any host-side memset.
                for j in T.Parallel(dim):
                    OutAccum[bid, hid, j] = 0.0
                for i in T.Parallel(1):
                    OutAccum[bid, hid, dim] = 0.0

        return main_split, normalize
    if num_split > 1:
        return main_split
    return main_no_split


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    }
)
def flashattn_fused(
    batch,
    heads,
    kv_head_num,
    seqlen_kv,
    dim,
    pe_dim,
    block_N,
    block_H,
    num_split,
    softmax_scale,
    spin=True,
):
    """Single-kernel split-K attention: the last-arriving CTA per batch element
    signals via a zero-seeded counter, every CTA then merges its share of the
    (head, column) units.  Removes the second kernel launch."""
    scale = float(softmax_scale * 1.44269504)
    dtype = T.float16
    accum_dtype = T.float32
    kv_group_num = heads // kv_head_num
    valid_block_h = min(block_H, kv_group_num)
    total_kv_blocks = (seqlen_kv + block_N - 1) // block_N
    blocks_per_split = (total_kv_blocks + num_split - 1) // num_split
    num_stages = 1 if blocks_per_split <= 32 else 0
    merge_cols = 512 if dim % 512 == 0 else dim
    chunks = (dim + merge_cols - 1) // merge_cols
    units = heads * chunks

    @T.prim_func
    def main_fused(
        Q: T.Tensor([batch, heads, dim], dtype),
        Q_pe: T.Tensor([batch, heads, pe_dim], dtype),
        KV: T.Tensor([batch, seqlen_kv, kv_head_num, dim], dtype),
        K_pe: T.Tensor([batch, seqlen_kv, kv_head_num, pe_dim], dtype),
        Output: T.Tensor([batch, heads, dim], dtype),
        Counter: T.Tensor([batch, 2], "int32"),
    ):
        glse = T.alloc_global([batch, heads, num_split], accum_dtype)
        output_partial = T.alloc_global(
            [batch, heads, num_split, dim], dtype
        )
        with T.Kernel(batch, 1, num_split, threads=128) as (bid, hid, split_id):
            Q_shared = T.alloc_shared([block_H, dim], dtype)
            Q_pe_shared = T.alloc_shared([block_H, pe_dim], dtype)
            KV_shared = T.alloc_shared([block_N, dim], dtype)
            K_pe_shared = T.alloc_shared([block_N, pe_dim], dtype)
            S_shared = T.alloc_shared([block_H, block_N], dtype)
            lse_s = T.alloc_shared([128], accum_dtype)
            acc_s = T.alloc_fragment([block_H, block_N], accum_dtype)
            acc_o = T.alloc_fragment([block_H, dim], accum_dtype)
            scores_sum = T.alloc_fragment([block_H], accum_dtype)
            softmax_l = T.alloc_fragment([block_H], accum_dtype)

            cur_kv_head = hid // (kv_group_num // block_H)
            T.use_swizzle(10)
            T.copy(Q[bid, 0 : block_H, :], Q_shared)
            T.copy(Q_pe[bid, 0 : block_H, :], Q_pe_shared)
            T.fill(acc_o, 0)
            T.fill(softmax_l, 0)

            for k in T.Pipelined(blocks_per_split, num_stages=num_stages):
                kv_block_id = k * num_split + split_id
                if kv_block_id < total_kv_blocks:
                    kv_start = kv_block_id * block_N
                    T.copy(KV[bid, kv_start:kv_start + block_N, cur_kv_head, :], KV_shared)
                    T.copy(K_pe[bid, kv_start:kv_start + block_N, cur_kv_head, :], K_pe_shared)
                    T.clear(acc_s)
                    T.gemm(Q_shared, KV_shared, acc_s, transpose_B=True,
                           policy=T.GemmWarpPolicy.FullCol)
                    T.gemm(Q_pe_shared, K_pe_shared, acc_s, transpose_B=True,
                           policy=T.GemmWarpPolicy.FullCol)
                    for i, j in T.Parallel(block_H, block_N):
                        if kv_start + j >= seqlen_kv:
                            acc_s[i, j] = -T.infinity(accum_dtype)
                    for i, j in T.Parallel(block_H, block_N):
                        acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale, 15.0))
                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                    for i in T.Parallel(block_H):
                        softmax_l[i] = softmax_l[i] + scores_sum[i]
                    T.copy(acc_s, S_shared)
                    T.gemm(S_shared, KV_shared, acc_o,
                           policy=T.GemmWarpPolicy.FullCol)

            for i, j in T.Parallel(block_H, dim):
                acc_o[i, j] /= softmax_l[i]
            for i in T.Parallel(block_H):
                softmax_l[i] = T.log2(softmax_l[i])
            T.copy(softmax_l, glse[bid, 0 : block_H, split_id])
            for i, j in T.Parallel(block_H, dim):
                output_partial[bid, i, split_id, j] = acc_o[i, j]

            # ---- arrival barrier: wait for all splits of this batch element
            T.atomic_add(Counter[bid, 0], 1, memory_order="seq_cst")
            if spin:
                while T.atomic_load(Counter[bid, 0], memory_order="seq_cst") < num_split:
                    pass

            # ---- in-kernel merge: units u in [0, units) round-robined by CTA
            for uu in range((units + num_split - 1) // num_split):
                u = split_id + uu * num_split
                if u < units:
                    h = u // chunks
                    did = u % chunks
                    max_lse = T.alloc_fragment([1], accum_dtype)
                    weight_sum = T.alloc_fragment([1], accum_dtype)
                    acc_m = T.alloc_fragment([merge_cols], accum_dtype)
                    for k in T.Parallel(128):
                        if k < num_split:
                            lse_s[k] = glse[bid, h, k]
                    T.fill(max_lse, -T.infinity(accum_dtype))
                    for k in range(num_split):
                        max_lse[0] = T.max(max_lse[0], lse_s[k])
                    T.fill(weight_sum, 0)
                    for k in range(num_split):
                        weight_sum[0] = weight_sum[0] + T.exp2(lse_s[k] - max_lse[0])
                    inv_sum = 1.0 / weight_sum[0]
                    T.fill(acc_m, 0)
                    for k in range(num_split):
                        w_k = T.exp2(lse_s[k] - max_lse[0]) * inv_sum
                        for i in T.Parallel(merge_cols):
                            acc_m[i] = acc_m[i] + w_k * output_partial[bid, h, k, did * merge_cols + i]
                    for i in T.Parallel(merge_cols):
                        Output[bid, h, did * merge_cols + i] = acc_m[i].astype(T.float16)

            # ---- leave: last CTA out resets the counters for the next launch
            lv = T.atomic_add(Counter[bid, 1], 1, memory_order="seq_cst", return_prev=True)
            if lv == num_split - 1:
                T.atomic_store(Counter[bid, 0], 0, memory_order="seq_cst")
                T.atomic_store(Counter[bid, 1], 0, memory_order="seq_cst")

    return main_fused


_KERNEL_CACHE = {}
_COUNTER_CACHE = {}


def _select_num_split(batch, kv_ctx, block_n, target_ctas=104):
    """grid = batch * num_split <= target_ctas; minimize wasted tail iterations.

    Interleaved assignment runs num_split * ceil(total/num_split) guarded
    iterations, so a bad split count wastes whole passes (e.g. 104 splits for
    256 blocks runs 312).  Pick the count with the least overshoot, breaking
    ties toward more parallelism."""
    batch = int(batch)
    total_blocks = (int(kv_ctx) + int(block_n) - 1) // int(block_n)
    # Max parallelism: wall clock is ceil(total/ns) guarded iterations, so
    # take the largest split count that stays inside one wave.  Interleaved
    # assignment gives every split >= 1 block whenever ns <= total.
    return max(1, min(max(1, target_ctas // batch), total_blocks))


_DUMMY = None


def _dummy_accum():
    global _DUMMY
    if _DUMMY is None:
        _DUMMY = torch.zeros(1, device='cuda', dtype=torch.float32)
    return _DUMMY


_PASS_CFG = {
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
}


def _flashattn_pair(*args, **kwargs):
    # flashattn now returns raw PrimFuncs: (main, normalize) for
    # atomic_merge, (main,) otherwise.  Compile here; the unused OutAccum
    # param of the non-atomic main takes a shared 1-element dummy.
    prim = flashattn(*args, **kwargs)
    if isinstance(prim, tuple):
        main, normalize = prim
        return (tilelang.compile(main, pass_configs=_PASS_CFG),
                tilelang.compile(normalize, pass_configs=_PASS_CFG))
    return tilelang.compile(prim, pass_configs=_PASS_CFG), None


def _get_kernel(batch, heads, kv_heads, kv_ctx, dim, pe_dim):
    block_n = int(_CFG.get('block_n', 32))
    block_h = min(16, heads // kv_heads)
    num_split = _select_num_split(batch, kv_ctx, block_n, _CFG.get('target_ctas', 104))
    if _CFG.get('assign', 'interleaved') == 'contiguous':
        # Contiguous ranges leave tail splits empty (no glse written -> garbage
        # merge weights).  Shrink the grid to the splits that own >=1 block.
        total_blocks = (int(kv_ctx) + block_n - 1) // block_n
        bps = (total_blocks + num_split - 1) // num_split
        num_split = max(1, (total_blocks + bps - 1) // bps)
    softmax_scale = (dim + pe_dim) ** -0.5

    # Short inner loops win from the pipeliner's restructure; long ones pay
    # for it.  Derived from the shape only.
    total_blocks = (int(kv_ctx) + block_n - 1) // block_n
    bps = (total_blocks + num_split - 1) // num_split
    stages = 1 if (bps <= 32 and not _CFG.get('fused')) else 0

    key = (
        int(batch), int(heads), int(kv_heads), int(kv_ctx),
        int(dim), int(pe_dim), int(block_n), int(block_h), int(num_split),
    ) + tuple(sorted(_CFG.items()))
    kernel = _KERNEL_CACHE.get(key)
    if kernel is None:
        kernel = _flashattn_pair(
            int(batch), int(heads), int(kv_heads), int(kv_ctx),
            int(dim), int(pe_dim), int(block_n), int(block_h),
            int(num_split), float(softmax_scale),
            kv_path=_CFG.get('kv_path', 'frag'),
            softmax_mode=_CFG.get('softmax', 'max'),
            stages=int(stages),
            threads=int(_CFG.get('threads', 128)),
            policy=_CFG.get('policy', 'FullRow'),
            assign=_CFG.get('assign', 'interleaved'),
            probe=_CFG.get('probe', 'full'),
            fused=bool(_CFG.get('fused', False)),
            hoist_mask=bool(_CFG.get('hoist_mask', False)),
            clear_acc=bool(_CFG.get('clear_acc', False)),
            maxless_merge=bool(_CFG.get('maxless_merge', False)),
            tpart=bool(_CFG.get('tpart', False)),
            prefetch=bool(_CFG.get('prefetch', False)),
            pv=_CFG.get('pv', 'scalar'),
            pv_swz=int(_CFG.get('pv_swz', 0)),
            atomic_merge=bool(_CFG.get('atomic_merge', False)),
            qk_split=int(_CFG.get('qk_split', 1)),
        )
        _KERNEL_CACHE[key] = kernel
    return kernel


_ACCUM_CACHE = {}


def _get_accum(batch, heads, dim):
    # fp32 accumulator shared by the main (atomic adds) and normalize
    # (read + self-zero) kernels.  Zeroed once here; the normalize kernel
    # restores zeros after every use, so no per-call host memset.
    key = (batch, heads, dim)
    acc = _ACCUM_CACHE.get(key)
    if acc is None:
        acc = torch.zeros(batch, heads, dim + 1, device='cuda', dtype=torch.float32)
        _ACCUM_CACHE[key] = acc
    return acc


def run_kernel(
    q, q_pe, kv, k_pe, output,
    batch, heads, kv_heads, kv_ctx, dim, pe_dim,
):
    batch, heads, kv_heads, kv_ctx, dim, pe_dim = (
        int(batch), int(heads), int(kv_heads), int(kv_ctx), int(dim), int(pe_dim))
    if _CFG.get('fuse_merge') and batch * _select_num_split(batch, kv_ctx, 32) <= 104 and num_split_of(batch, kv_ctx) > 1:
        kernel, counter = _get_fused_kernel(batch, heads, kv_heads, kv_ctx, dim, pe_dim)
        kernel(q, q_pe, kv, k_pe, output, counter)
        return
    kernel, normalize = _get_kernel(batch, heads, kv_heads, kv_ctx, dim, pe_dim)
    if normalize is not None:
        accum = _get_accum(batch, heads, dim)
        kernel(q, q_pe, kv, k_pe, output, accum)
        normalize(output, accum)
        return
    kernel(q, q_pe, kv, k_pe, output, _dummy_accum())


def num_split_of(batch, kv_ctx):
    return _select_num_split(batch, kv_ctx, int(_CFG.get('block_n', 32)),
                             _CFG.get('target_ctas', 104))


def _get_fused_kernel(batch, heads, kv_heads, kv_ctx, dim, pe_dim):
    block_n = int(_CFG.get('block_n', 32))
    block_h = min(16, heads // kv_heads)
    num_split = _select_num_split(batch, kv_ctx, block_n, _CFG.get('target_ctas', 104))
    softmax_scale = (dim + pe_dim) ** -0.5
    key = (batch, heads, kv_heads, kv_ctx, dim, pe_dim, block_n, block_h,
           num_split, tuple(sorted(_CFG.items())))
    kernel = _KERNEL_CACHE.get(('fused',) + key)
    if kernel is None:
        kernel = flashattn_fused(
            batch, heads, kv_heads, kv_ctx, dim, pe_dim, block_n, block_h,
            num_split, softmax_scale, spin=bool(_CFG.get('spin', True)),
        )
        _KERNEL_CACHE[('fused',) + key] = kernel
    counter = _COUNTER_CACHE.get((batch, key[-2]))
    if counter is None:
        counter = torch.zeros(batch, 2, device='cuda', dtype=torch.int32)
        _COUNTER_CACHE[(batch, key[-2])] = counter
    return kernel, counter
