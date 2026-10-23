import tilelang
import tilelang.language as T


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    }
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
):
    # exp(x) = exp2(log2(e) * x).  Keeping the online-softmax state in
    # unscaled score space avoids an extra conversion around the GEMMs.
    scale = float(softmax_scale * 1.44269504)
    dtype = T.float16
    accum_dtype = T.float32
    kv_group_num = heads // kv_head_num
    valid_block_h = min(block_H, kv_group_num)
    total_kv_blocks = (seqlen_kv + block_N - 1) // block_N
    blocks_per_split = (total_kv_blocks + num_split - 1) // num_split

    assert kv_head_num == 1, "kv_head_num must be 1"
    assert heads % valid_block_h == 0, "heads must be divisible by block_H"

    @T.prim_func
    def main_split(
        Q: T.Tensor([batch, heads, dim], dtype),
        Q_pe: T.Tensor([batch, heads, pe_dim], dtype),
        KV: T.Tensor([batch, seqlen_kv, kv_head_num, dim], dtype),
        K_pe: T.Tensor([batch, seqlen_kv, kv_head_num, pe_dim], dtype),
        Output: T.Tensor([batch, heads, dim], dtype),
    ):
        # LSE needs FP32 when multiple partial softmax results are merged.
        glse = T.alloc_global([batch, heads, num_split], accum_dtype)
        output_partial = T.alloc_global(
            [batch, heads, num_split, dim], dtype
        )

        with T.Kernel(
            batch,
            heads // valid_block_h,
            num_split,
            # MetaX's MMA layout inference rejects the 16x512 output
            # fragment with eight warps on some TileLang-MetaX builds.
            # Four warps matches the known-good no-split kernel layout.
            threads=128,
        ) as (bid, hid, split_id):
            Q_shared = T.alloc_shared([block_H, dim], dtype)
            Q_pe_shared = T.alloc_shared([block_H, pe_dim], dtype)
            KV_shared = T.alloc_shared([block_N, dim], dtype)
            K_pe_shared = T.alloc_shared([block_N, pe_dim], dtype)
            S_shared = T.alloc_shared([block_H, block_N], dtype)

            acc_s = T.alloc_fragment([block_H, block_N], accum_dtype)
            acc_o = T.alloc_fragment([block_H, dim], accum_dtype)
            scores_max = T.alloc_fragment([block_H], accum_dtype)
            scores_max_prev = T.alloc_fragment([block_H], accum_dtype)
            scores_scale = T.alloc_fragment([block_H], accum_dtype)
            scores_sum = T.alloc_fragment([block_H], accum_dtype)
            softmax_l = T.alloc_fragment([block_H], accum_dtype)

            cur_kv_head = hid // (kv_group_num // block_H)

            T.use_swizzle(10)
            T.copy(
                Q[
                    bid,
                    hid * valid_block_h : (hid + 1) * valid_block_h,
                    :,
                ],
                Q_shared,
            )
            T.copy(
                Q_pe[
                    bid,
                    hid * valid_block_h : (hid + 1) * valid_block_h,
                    :,
                ],
                Q_pe_shared,
            )
            T.fill(acc_o, 0)
            T.fill(softmax_l, 0)
            T.fill(scores_max, -T.infinity(accum_dtype))

            # Online softmax, fused with P @ V.  This is the MLA equivalent
            # of the tutorial softmax: m, l and O are rescaled whenever a
            # new block changes the running maximum.
            # The C500 exposes 64 KiB shared memory per kernel.  Multi-stage
            # buffering pushes this kernel above that limit, so keep a single
            # KV tile live.  Sequence-level split-K supplies parallelism.
            for k in T.Pipelined(blocks_per_split, num_stages=0):
                # Interleave blocks between splits instead of assigning a
                # ceil-divided contiguous range.  With num_split <= the
                # number of blocks this guarantees that every split owns at
                # least one block, including non-divisible context lengths.
                # CTAs with the same k also read neighbouring KV blocks.
                kv_block_id = k * num_split + split_id

                if kv_block_id < total_kv_blocks:
                    kv_start = kv_block_id * block_N
                    kv_end = kv_start + block_N

                    T.copy(
                        KV[bid, kv_start:kv_end, cur_kv_head, :],
                        KV_shared,
                    )
                    T.copy(
                        K_pe[bid, kv_start:kv_end, cur_kv_head, :],
                        K_pe_shared,
                    )

                    T.clear(acc_s)
                    T.gemm(
                        Q_shared,
                        KV_shared,
                        acc_s,
                        transpose_B=True,
                        policy=T.GemmWarpPolicy.FullCol,
                    )
                    T.gemm(
                        Q_pe_shared,
                        K_pe_shared,
                        acc_s,
                        transpose_B=True,
                        policy=T.GemmWarpPolicy.FullCol,
                    )

                    # Mask a partial final KV block before max/sum reduction.
                    for i, j in T.Parallel(block_H, block_N):
                        if kv_start + j >= seqlen_kv:
                            acc_s[i, j] = -T.infinity(accum_dtype)

                    T.copy(scores_max, scores_max_prev)
                    T.fill(scores_max, -T.infinity(accum_dtype))
                    T.reduce_max(acc_s, scores_max, dim=1, clear=False)

                    for i in T.Parallel(block_H):
                        scores_max[i] = T.max(
                            scores_max[i], scores_max_prev[i]
                        )
                        scores_scale[i] = T.exp2(
                            (scores_max_prev[i] - scores_max[i]) * scale
                        )

                    for i, j in T.Parallel(block_H, block_N):
                        acc_s[i, j] = T.exp2(
                            (acc_s[i, j] - scores_max[i]) * scale
                        )

                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)

                    # Cast through shared memory, matching the known-good
                    # no-split PV GEMM layout on the MetaX backend.
                    T.copy(acc_s, S_shared)

                    for i in T.Parallel(block_H):
                        softmax_l[i] = (
                            softmax_l[i] * scores_scale[i] + scores_sum[i]
                        )
                    for i, j in T.Parallel(block_H, dim):
                        acc_o[i, j] *= scores_scale[i]

                    T.gemm(
                        S_shared,
                        KV_shared,
                        acc_o,
                        policy=T.GemmWarpPolicy.FullCol,
                    )

            for i, j in T.Parallel(block_H, dim):
                acc_o[i, j] /= softmax_l[i]
            for i in T.Parallel(block_H):
                # Base-2 LSE is sufficient; the merge kernel only uses
                # differences between LSE values.
                softmax_l[i] = (
                    T.log2(softmax_l[i]) + scores_max[i] * scale
                )

            T.copy(
                softmax_l,
                glse[
                    bid,
                    hid * valid_block_h : (hid + 1) * valid_block_h,
                    split_id,
                ],
            )
            # Direct fragment-to-global store avoids a 16 KiB O_shared tile.
            for i, j in T.Parallel(block_H, dim):
                output_partial[
                    bid,
                    hid * valid_block_h + i,
                    split_id,
                    j,
                ] = acc_o[i, j]

        with T.Kernel(heads, batch, T.ceildiv(dim, 128), threads=128) as (hid, bid, did):
            split_lse = T.alloc_fragment([num_split], accum_dtype)
            max_lse = T.alloc_fragment([1], accum_dtype)
            weight_sum = T.alloc_fragment([1], accum_dtype)
            weighted_o = T.alloc_fragment([num_split, 128], accum_dtype)
            output_accum = T.alloc_fragment([128], accum_dtype)
            T.annotate_layout({
                split_lse: T.Fragment([num_split], forward_thread_fn=lambda s, r: (s % min(4, num_split)) * 32 + r, forward_index_fn=lambda s: s // min(4, num_split), replicate=128 // min(4, num_split)),
                weighted_o: T.Fragment([num_split, 128], forward_thread_fn=lambda s, d: (s % min(4, num_split)) * 32 + d % 32, forward_index_fn=lambda s, d: (s // min(4, num_split)) * 4 + d // 32),
            })

            for k in T.Parallel(num_split):
                split_lse[k] = glse[bid, hid, k]
            T.reduce_max(split_lse, max_lse, dim=0)
            for k in T.Parallel(num_split):
                split_lse[k] = T.exp2(split_lse[k] - max_lse[0])
            T.reduce_sum(split_lse, weight_sum, dim=0)
            for k, i in T.Parallel(num_split, 128):
                weighted_o[k, i] = output_partial[bid, hid, k, did * 128 + i] * split_lse[k]
            T.reduce_sum(weighted_o, output_accum, dim=0)
            for i in T.Parallel(128):
                Output[bid, hid, did * 128 + i] = output_accum[i] / weight_sum[0]

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
            threads=128,
        ) as (hid, bid):
            Q_shared = T.alloc_shared([block_H, dim], dtype)
            Q_pe_shared = T.alloc_shared([block_H, pe_dim], dtype)
            KV_shared = T.alloc_shared([block_N, dim], dtype)
            K_pe_shared = T.alloc_shared([block_N, pe_dim], dtype)
            S_shared = T.alloc_shared([block_H, block_N], dtype)

            acc_s = T.alloc_fragment([block_H, block_N], accum_dtype)
            acc_o = T.alloc_fragment([block_H, dim], accum_dtype)
            scores_max = T.alloc_fragment([block_H], accum_dtype)
            scores_max_prev = T.alloc_fragment([block_H], accum_dtype)
            scores_scale = T.alloc_fragment([block_H], accum_dtype)
            scores_sum = T.alloc_fragment([block_H], accum_dtype)
            softmax_l = T.alloc_fragment([block_H], accum_dtype)

            cur_kv_head = hid // (kv_group_num // block_H)

            T.use_swizzle(10)
            T.copy(
                Q[
                    bid,
                    hid * valid_block_h : (hid + 1) * valid_block_h,
                    :,
                ],
                Q_shared,
            )
            T.copy(
                Q_pe[
                    bid,
                    hid * valid_block_h : (hid + 1) * valid_block_h,
                    :,
                ],
                Q_pe_shared,
            )
            T.fill(acc_o, 0)
            T.fill(softmax_l, 0)
            T.fill(scores_max, -T.infinity(accum_dtype))

            for k in T.Pipelined(total_kv_blocks, num_stages=0):
                kv_start = k * block_N
                kv_end = kv_start + block_N

                T.copy(
                    KV[bid, kv_start:kv_end, cur_kv_head, :],
                    KV_shared,
                )
                T.copy(
                    K_pe[bid, kv_start:kv_end, cur_kv_head, :],
                    K_pe_shared,
                )

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

                T.copy(scores_max, scores_max_prev)
                T.fill(scores_max, -T.infinity(accum_dtype))
                T.reduce_max(acc_s, scores_max, dim=1, clear=False)

                for i in T.Parallel(block_H):
                    scores_max[i] = T.max(
                        scores_max[i], scores_max_prev[i]
                    )
                    scores_scale[i] = T.exp2(
                        (scores_max_prev[i] - scores_max[i]) * scale
                    )

                for i, j in T.Parallel(block_H, block_N):
                    acc_s[i, j] = T.exp2(
                        (acc_s[i, j] - scores_max[i]) * scale
                    )

                T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                T.copy(acc_s, S_shared)

                for i in T.Parallel(block_H):
                    softmax_l[i] = (
                        softmax_l[i] * scores_scale[i] + scores_sum[i]
                    )
                for i, j in T.Parallel(block_H, dim):
                    acc_o[i, j] *= scores_scale[i]

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

    if num_split > 1:
        return main_split
    return main_no_split


_KERNEL_CACHE = {}


def _select_num_split(batch, kv_ctx, block_n):
    """Choose enough sequence splits to cure the small-batch CTA shortage.

    The current kernel keeps all 16 heads together to maximize KV reuse, so
    without split-K its main grid contains only ``batch`` CTAs.  We target
    roughly 32 CTAs while leaving at least four KV tiles in each split.
    """

    total_blocks = (int(kv_ctx) + int(block_n) - 1) // int(block_n)
    target_ctas = 256
    desired = (target_ctas + int(batch) - 1) // int(batch)
    # Allow one KV tile per split.  For batch=1 this exposes up to 64 main
    # CTAs without changing the shared-memory footprint of each CTA.
    max_by_work = max(1, total_blocks)
    limit = min(256, desired, max_by_work, total_blocks)

    # Powers of two keep the generated kernels simple and cover the supplied
    # power-of-two context lengths.  The kernel itself also handles tails.
    for candidate in (256, 128, 64, 32, 16, 8, 4, 2):
        if candidate <= limit:
            return candidate
    return 1


def _get_kernel(batch, heads, kv_heads, kv_ctx, dim, pe_dim):
    # block_N=32 fits the 512-D KV tile plus the 16-head output accumulator
    # without the shared-memory pressure of a 64-token tile.
    block_n = 32
    block_h = min(16, heads // kv_heads)
    num_split = _select_num_split(batch, kv_ctx, block_n)
    softmax_scale = (dim + pe_dim) ** -0.5

    key = (
        int(batch),
        int(heads),
        int(kv_heads),
        int(kv_ctx),
        int(dim),
        int(pe_dim),
        int(block_n),
        int(block_h),
        int(num_split),
    )
    kernel = _KERNEL_CACHE.get(key)
    if kernel is None:
        kernel = flashattn(
            int(batch),
            int(heads),
            int(kv_heads),
            int(kv_ctx),
            int(dim),
            int(pe_dim),
            int(block_n),
            int(block_h),
            int(num_split),
            float(softmax_scale),
        )
        _KERNEL_CACHE[key] = kernel
    return kernel


def run_kernel(
    q,
    q_pe,
    kv,
    k_pe,
    output,
    batch,
    heads,
    kv_heads,
    kv_ctx,
    dim,
    pe_dim,
):
    kernel = _get_kernel(
        int(batch),
        int(heads),
        int(kv_heads),
        int(kv_ctx),
        int(dim),
        int(pe_dim),
    )
    kernel(q, q_pe, kv, k_pe, output)




