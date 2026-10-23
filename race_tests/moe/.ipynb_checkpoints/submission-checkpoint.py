import torch
import tilelang
import tilelang.language as T


_KERNEL_CACHE = {}
_WORKSPACE_CACHE = {}

_WIDE_M = False

_WIDE_M_MIN_BLOCKS = 64

_WIDE_PANEL_MIN_TILES = 32

_STAGE1_BLOCK_K = 64

@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    }
)
def _moe_forward_kernel(
    hidden,
    intermediate,
    num_experts,
    total_padded_tokens,
    total_valid_tokens,
    num_blocks_m,
    block_m,
    tail_rows,
):

    scale = 1.44269504
    dtype = T.float16
    accum_dtype = T.float32

    external_block_m = 128
    sub_blocks_per_external = external_block_m // block_m
    kernel_blocks_m = num_blocks_m * sub_blocks_per_external

    stage1_block_n = 128
    stage1_block_k = _STAGE1_BLOCK_K if num_blocks_m >= 64 else 64
    stage1_num_stages = 0
    stage1_swizzle = 8
    stage1_threads = 256
    stage1_policy = T.GemmWarpPolicy.Square

    stage2_block_n = 128
    stage2_block_k = 64
    stage2_threads = 256
    stage2_num_stages = 0
    stage2_swizzle = 8
    stage2_tail_swizzle = 8
    stage2_policy = T.GemmWarpPolicy.Square
    while stage1_block_n > intermediate and stage1_block_n > 64:
        stage1_block_n //= 2
    while stage1_block_k > hidden and stage1_block_k > 32:
        stage1_block_k //= 2
    while stage2_block_n > hidden and stage2_block_n > 64:
        stage2_block_n //= 2
    while stage2_block_k > intermediate and stage2_block_k > 32:
        stage2_block_k //= 2

    stage2_pair = 2 if hidden % (2 * stage2_block_n) == 0 else 1
    stage1_unroll = 8
    stage2_unroll = 1
    if hidden == 7168 and stage2_pair == 2:
        stage2_swizzle = 32 if num_blocks_m < 64 else 28

    stage1_one_weight_buffer = (
        kernel_blocks_m * ((intermediate + stage1_block_n - 1) // stage1_block_n) >= 256
    )
    wide_m = (
        _WIDE_M
        and block_m == external_block_m
        and num_blocks_m >= _WIDE_M_MIN_BLOCKS
        and stage1_one_weight_buffer
    )
    wide_rows = 2 * external_block_m
    wide_threads = 1024

    stage1_n_tiles = (intermediate + stage1_block_n - 1) // stage1_block_n
    if stage1_n_tiles >= _WIDE_PANEL_MIN_TILES:
        stage1_swizzle = stage1_n_tiles

    tail_rows = tail_rows if block_m == external_block_m else 0
    tail_m = 64

    s1_main_m = wide_rows if wide_m else block_m
    s1_main_threads = wide_threads if wide_m else stage1_threads
    s1_tail_m = tail_m
    s1_tail_on = tail_rows > 0

    input_shape = (total_padded_tokens, hidden)
    intermediate_shape = (total_padded_tokens, intermediate)
    gate_shape = (num_experts, intermediate, hidden)
    up_shape = (num_experts, intermediate, hidden)
    down_shape = (num_experts, hidden, intermediate)

    @T.prim_func
    def kernel(
        stacked_expert_tokens: T.Tensor(input_shape, dtype),
        gate_w: T.Tensor(gate_shape, dtype),
        up_w: T.Tensor(up_shape, dtype),
        down_w: T.Tensor(down_shape, dtype),
        routed_expert_weights: T.Tensor((total_valid_tokens,), T.float32),
        group_sizes: T.Tensor((num_experts,), T.int32),
        group_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_padded_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((num_blocks_m,), T.int32),
        up_logits: T.Tensor(intermediate_shape, dtype),
        out: T.Tensor(input_shape, dtype),
    ):
        with T.Kernel(
            kernel_blocks_m,
            T.ceildiv(intermediate, stage1_block_n),
            threads=s1_main_threads,
        ) as (bx, by):
            input_shared = T.alloc_shared(
                (s1_main_m, stage1_block_k), dtype=dtype
            )
            weight_shared = T.alloc_shared(
                (stage1_block_n, stage1_block_k), dtype=dtype
            )
            if stage1_one_weight_buffer:
                up_weight_shared = weight_shared
            else:
                up_weight_shared = T.alloc_shared(
                    (stage1_block_n, stage1_block_k), dtype=dtype
                )
            gate_local = T.alloc_fragment(
                (s1_main_m, stage1_block_n), dtype=accum_dtype
            )
            up_local = T.alloc_fragment(
                (s1_main_m, stage1_block_n), dtype=accum_dtype
            )
            w_stage = T.alloc_fragment((stage1_block_n, stage1_block_k), dtype=dtype)
            T.annotate_layout({
                input_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(input_shared, vecSize=4),
                weight_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(weight_shared, vecSize=4),
            })
            T.use_swizzle(stage1_swizzle)

            stage1_bx = kernel_blocks_m - 1 - bx if hidden == 2048 else bx
            external_bx = stage1_bx // sub_blocks_per_external
            sub_block_idx = stage1_bx % sub_blocks_per_external
            expert_id = T.min(
                T.max(group_idx_for_bx[external_bx], 0), num_experts - 1
            )
            block_start = (
                external_bx * external_block_m + sub_block_idx * block_m
            )
            group_size = group_sizes[expert_id]
            padded_start = group_padded_offsets[expert_id]
            token_offset = block_start - padded_start
            actual_rows = T.max(
                0, T.min(s1_main_m, group_size - token_offset)
            )

            if wide_m:
                do_main = (
                    (token_offset // external_block_m) % 2 == 0
                    and group_size - token_offset > external_block_m
                )
            else:
                do_main = actual_rows > tail_rows
            if do_main:
                T.clear(gate_local)
                T.clear(up_local)

                for k in T.unroll(
                    T.ceildiv(hidden, stage1_block_k),
                    explicit=False,
                    unroll_factor=stage1_unroll,
                ):
                    T.copy(
                        stacked_expert_tokens[
                            block_start : block_start + s1_main_m,
                            k * stage1_block_k : (k + 1) * stage1_block_k,
                        ],
                        input_shared,
                    )
                    T.copy(
                        gate_w[
                            expert_id,
                            by * stage1_block_n : (by + 1) * stage1_block_n,
                            k * stage1_block_k : (k + 1) * stage1_block_k,
                        ],
                        weight_shared,
                    )
                    if stage1_one_weight_buffer:
                        T.copy(
                            up_w[
                                expert_id,
                                by * stage1_block_n : (by + 1) * stage1_block_n,
                                k * stage1_block_k : (k + 1) * stage1_block_k,
                            ],
                            w_stage,
                        )
                        T.gemm(input_shared, weight_shared, gate_local, transpose_B=True, policy=stage1_policy)
                        T.copy(w_stage, up_weight_shared)
                        T.gemm(input_shared, up_weight_shared, up_local, transpose_B=True, policy=stage1_policy)
                    else:
                        T.copy(
                            up_w[
                                expert_id,
                                by * stage1_block_n : (by + 1) * stage1_block_n,
                                k * stage1_block_k : (k + 1) * stage1_block_k,
                            ],
                            up_weight_shared,
                        )
                        T.gemm(input_shared, weight_shared, gate_local, transpose_B=True, policy=stage1_policy)
                        T.gemm(input_shared, up_weight_shared, up_local, transpose_B=True, policy=stage1_policy)

                if hidden == 2048:
                    for i, j in T.Parallel(s1_main_m, stage1_block_n):
                        if i < actual_rows:
                            up_logits[
                                block_start + i,
                                by * stage1_block_n + j,
                            ] = up_local[i, j] * gate_local[i, j] * (
                                1.0 / (1.0 + T.exp2(-gate_local[i, j] * scale))
                            )
                else:
                    for i, j in T.Parallel(s1_main_m, stage1_block_n):
                        gate_local[i, j] = gate_local[i, j] * (
                            1.0 / (1.0 + T.exp2(-gate_local[i, j] * scale))
                        )
                        up_local[i, j] = up_local[i, j] * gate_local[i, j]
                        if i < actual_rows:
                            up_logits[
                                block_start + i,
                                by * stage1_block_n + j,
                            ] = up_local[i, j]

        if wide_m:
            with T.Kernel(
                num_blocks_m,
                T.ceildiv(intermediate, stage1_block_n),
                threads=stage1_threads,
            ) as (bx, by):
                input_shared = T.alloc_shared(
                    (external_block_m, stage1_block_k), dtype=dtype
                )
                weight_shared = T.alloc_shared(
                    (stage1_block_n, stage1_block_k), dtype=dtype
                )
                if stage1_one_weight_buffer:
                    up_weight_shared = weight_shared
                else:
                    up_weight_shared = T.alloc_shared(
                        (stage1_block_n, stage1_block_k), dtype=dtype
                    )
                gate_local = T.alloc_fragment(
                    (external_block_m, stage1_block_n), dtype=accum_dtype
                )
                up_local = T.alloc_fragment(
                    (external_block_m, stage1_block_n), dtype=accum_dtype
                )
                w_stage = T.alloc_fragment((stage1_block_n, stage1_block_k), dtype=dtype)
                T.annotate_layout({
                    input_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(input_shared, vecSize=4),
                    weight_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(weight_shared, vecSize=4),
                })

                T.use_swizzle(stage1_swizzle)

                external_bx = bx
                expert_id = T.min(
                    T.max(group_idx_for_bx[external_bx], 0), num_experts - 1
                )
                block_start = external_bx * external_block_m
                group_size = group_sizes[expert_id]
                padded_start = group_padded_offsets[expert_id]
                token_offset = block_start - padded_start
                actual_rows = T.max(
                    0, T.min(external_block_m, group_size - token_offset)
                )

                do_mid = (
                    (token_offset // external_block_m) % 2 == 0
                    and group_size - token_offset > tail_rows
                    and group_size - token_offset <= external_block_m
                )
                if do_mid:
                    T.clear(gate_local)
                    T.clear(up_local)

                    for k in T.Pipelined(
                        T.ceildiv(hidden, stage1_block_k),
                        num_stages=stage1_num_stages,
                    ):
                        T.copy(
                            stacked_expert_tokens[
                                block_start : block_start + external_block_m,
                                k * stage1_block_k : (k + 1) * stage1_block_k,
                            ],
                            input_shared,
                        )
                        T.copy(
                            gate_w[
                                expert_id,
                                by * stage1_block_n : (by + 1) * stage1_block_n,
                                k * stage1_block_k : (k + 1) * stage1_block_k,
                            ],
                            weight_shared,
                        )
                        if stage1_one_weight_buffer:
                            T.copy(
                                up_w[
                                    expert_id,
                                    by * stage1_block_n : (by + 1) * stage1_block_n,
                                    k * stage1_block_k : (k + 1) * stage1_block_k,
                                ],
                                w_stage,
                            )
                            T.gemm(
                                input_shared,
                                weight_shared,
                                gate_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )
                            T.copy(w_stage, up_weight_shared)
                            T.gemm(
                                input_shared,
                                up_weight_shared,
                                up_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )
                        else:
                            T.copy(
                                up_w[
                                    expert_id,
                                    by * stage1_block_n : (by + 1) * stage1_block_n,
                                    k * stage1_block_k : (k + 1) * stage1_block_k,
                                ],
                                up_weight_shared,
                            )
                            T.gemm(
                                input_shared,
                                weight_shared,
                                gate_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )
                            T.gemm(
                                input_shared,
                                up_weight_shared,
                                up_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )

                    for i, j in T.Parallel(external_block_m, stage1_block_n):
                        gate_local[i, j] = gate_local[i, j] * (
                            1.0 / (1.0 + T.exp2(-gate_local[i, j] * scale))
                        )
                        up_local[i, j] = up_local[i, j] * gate_local[i, j]
                        if i < actual_rows:
                            up_logits[
                                block_start + i,
                                by * stage1_block_n + j,
                            ] = up_local[i, j]


        if s1_tail_on:
            with T.Kernel(
                num_blocks_m,
                T.ceildiv(intermediate, stage1_block_n),
                threads=stage1_threads,
            ) as (bx, by):
                input_shared = T.alloc_shared(
                    (s1_tail_m, stage1_block_k), dtype=dtype
                )
                weight_shared = T.alloc_shared(
                    (stage1_block_n, stage1_block_k), dtype=dtype
                )
                if stage1_one_weight_buffer:
                    up_weight_shared = weight_shared
                else:
                    up_weight_shared = T.alloc_shared(
                        (stage1_block_n, stage1_block_k), dtype=dtype
                    )
                gate_local = T.alloc_fragment(
                    (s1_tail_m, stage1_block_n), dtype=accum_dtype
                )
                up_local = T.alloc_fragment(
                    (s1_tail_m, stage1_block_n), dtype=accum_dtype
                )
                w_stage = T.alloc_fragment((stage1_block_n, stage1_block_k), dtype=dtype)
                T.annotate_layout({
                    input_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(input_shared, vecSize=4),
                    weight_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(weight_shared, vecSize=4),
                })

                T.use_swizzle(stage1_swizzle)

                external_bx = bx
                expert_id = T.min(
                    T.max(group_idx_for_bx[external_bx], 0), num_experts - 1
                )
                block_start = external_bx * external_block_m
                group_size = group_sizes[expert_id]
                padded_start = group_padded_offsets[expert_id]
                token_offset = block_start - padded_start
                actual_rows = T.max(
                    0, T.min(external_block_m, group_size - token_offset)
                )

                if wide_m:
                    do_tail = (
                        (token_offset // external_block_m) % 2 == 0
                        and actual_rows > 0
                        and group_size - token_offset <= tail_rows
                    )
                else:
                    do_tail = actual_rows > 0 and actual_rows <= tail_rows
                if do_tail:
                    T.clear(gate_local)
                    T.clear(up_local)

                    for k in T.unroll(
                        T.ceildiv(hidden, stage1_block_k),
                        explicit=False,
                        unroll_factor=stage1_unroll,
                    ):
                        T.copy(
                            stacked_expert_tokens[
                                block_start : block_start + s1_tail_m,
                                k * stage1_block_k : (k + 1) * stage1_block_k,
                            ],
                            input_shared,
                        )
                        T.copy(
                            gate_w[
                                expert_id,
                                by * stage1_block_n : (by + 1) * stage1_block_n,
                                k * stage1_block_k : (k + 1) * stage1_block_k,
                            ],
                            weight_shared,
                        )
                        if stage1_one_weight_buffer:
                            T.copy(
                                up_w[
                                    expert_id,
                                    by * stage1_block_n : (by + 1) * stage1_block_n,
                                    k * stage1_block_k : (k + 1) * stage1_block_k,
                                ],
                                w_stage,
                            )
                            T.gemm(
                                input_shared,
                                weight_shared,
                                gate_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )
                            T.copy(w_stage, up_weight_shared)
                            T.gemm(
                                input_shared,
                                up_weight_shared,
                                up_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )
                        else:
                            T.copy(
                                up_w[
                                    expert_id,
                                    by * stage1_block_n : (by + 1) * stage1_block_n,
                                    k * stage1_block_k : (k + 1) * stage1_block_k,
                                ],
                                up_weight_shared,
                            )
                            T.gemm(
                                input_shared,
                                weight_shared,
                                gate_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )
                            T.gemm(
                                input_shared,
                                up_weight_shared,
                                up_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )

                    for i, j in T.Parallel(s1_tail_m, stage1_block_n):
                        gate_local[i, j] = gate_local[i, j] * (
                            1.0 / (1.0 + T.exp2(-gate_local[i, j] * scale))
                        )
                        up_local[i, j] = up_local[i, j] * gate_local[i, j]
                        if i < actual_rows:
                            up_logits[
                                block_start + i,
                                by * stage1_block_n + j,
                            ] = up_local[i, j]

        with T.Kernel(
            kernel_blocks_m,
            T.ceildiv(hidden, stage2_block_n * stage2_pair),
            threads=stage2_threads,
        ) as (bx, by):
            up_tile_shared = T.alloc_shared(
                (block_m, stage2_block_k), dtype=dtype
            )
            down_shared = T.alloc_shared(
                (stage2_block_n, stage2_block_k), dtype=dtype
            )
            out_local = T.alloc_fragment(
                (block_m, stage2_block_n), dtype=accum_dtype
            )
            if stage2_pair == 2:
                out_local2 = T.alloc_fragment(
                    (block_m, stage2_block_n), dtype=accum_dtype
                )
            else:
                out_shared = T.alloc_shared(
                    (block_m, stage2_block_n), dtype=dtype
                )
            d_stage = T.alloc_fragment((stage2_block_n, stage2_block_k), dtype=dtype)
            T.annotate_layout({
                up_tile_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(up_tile_shared, vecSize=4),
                down_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(down_shared, vecSize=4),
            })
            route_dtype = dtype if hidden == 2048 else T.float32
            route_weight_local = T.alloc_fragment((block_m,), dtype=route_dtype)
            T.use_swizzle(stage2_swizzle)

            external_bx = bx // sub_blocks_per_external
            sub_block_idx = bx % sub_blocks_per_external
            expert_id = T.min(
                T.max(group_idx_for_bx[external_bx], 0), num_experts - 1
            )
            block_start = (
                external_bx * external_block_m + sub_block_idx * block_m
            )
            group_size = group_sizes[expert_id]
            raw_start = group_offsets[expert_id]
            padded_start = group_padded_offsets[expert_id]
            token_offset = block_start - padded_start
            actual_rows = T.max(
                0, T.min(block_m, group_size - token_offset)
            )

            if actual_rows > tail_rows:
                T.clear(out_local)
                if stage2_pair == 2:
                    T.clear(out_local2)
                for k in T.unroll(
                    T.ceildiv(intermediate, stage2_block_k),
                    explicit=False,
                    unroll_factor=stage2_unroll,
                ):
                    T.copy(
                        up_logits[
                            block_start : block_start + block_m,
                            k * stage2_block_k : (k + 1) * stage2_block_k,
                        ],
                        up_tile_shared,
                    )
                    T.copy(
                        down_w[
                            expert_id,
                            (by * stage2_pair) * stage2_block_n
                            : (by * stage2_pair + 1) * stage2_block_n,
                            k * stage2_block_k : (k + 1) * stage2_block_k,
                        ],
                        down_shared,
                    )
                    if stage2_pair == 2:
                        T.copy(
                            down_w[
                                expert_id,
                                (by * stage2_pair + 1) * stage2_block_n
                                : (by * stage2_pair + 2) * stage2_block_n,
                                k * stage2_block_k : (k + 1) * stage2_block_k,
                            ],
                            d_stage,
                        )
                    T.gemm(
                        up_tile_shared,
                        down_shared,
                        out_local,
                        transpose_B=True,
                        policy=stage2_policy,
                    )
                    if stage2_pair == 2:
                        T.copy(d_stage, down_shared)
                        T.gemm(
                            up_tile_shared,
                            down_shared,
                            out_local2,
                            transpose_B=True,
                            policy=stage2_policy,
                        )
                if hidden == 2048:
                    for i in T.Parallel(block_m):
                        if i < actual_rows:
                            route_weight_local[i] = T.cast(
                                routed_expert_weights[raw_start + token_offset + i],
                                route_dtype,
                            )
                else:
                    for i in T.Parallel(block_m):
                        route_weight_local[i] = T.if_then_else(
                            i < actual_rows,
                            routed_expert_weights[
                                T.min(
                                    raw_start + token_offset + i,
                                    total_valid_tokens - 1,
                                )
                            ],
                            T.cast(0, T.float32),
                        )

                if stage2_pair == 2:
                    if hidden == 2048:
                        for i, j in T.Parallel(block_m, stage2_block_n):
                            if i < actual_rows:
                                out[
                                    block_start + i,
                                    (by * stage2_pair) * stage2_block_n + j,
                                ] = T.cast(out_local[i, j], dtype) * route_weight_local[i]
                                out[
                                    block_start + i,
                                    (by * stage2_pair + 1) * stage2_block_n + j,
                                ] = T.cast(out_local2[i, j], dtype) * route_weight_local[i]
                    else:
                        for i, j in T.Parallel(block_m, stage2_block_n):
                            if i < actual_rows:
                                out[
                                    block_start + i,
                                    (by * stage2_pair) * stage2_block_n + j,
                                ] = T.cast(
                                    out_local[i, j] * route_weight_local[i], dtype
                                )
                        for i, j in T.Parallel(block_m, stage2_block_n):
                            if i < actual_rows:
                                out[
                                    block_start + i,
                                    (by * stage2_pair + 1) * stage2_block_n + j,
                                ] = T.cast(
                                    out_local2[i, j] * route_weight_local[i], dtype
                                )
                else:
                    for i, j in T.Parallel(block_m, stage2_block_n):
                        out_shared[i, j] = T.cast(
                            out_local[i, j] * route_weight_local[i], dtype
                        )
                    for i, j in T.Parallel(block_m, stage2_block_n):
                        if i < actual_rows:
                            out[
                                block_start + i,
                                by * stage2_block_n + j,
                            ] = out_shared[i, j]
        if tail_rows > 0:
            with T.Kernel(
                num_blocks_m,
                T.ceildiv(hidden, stage2_block_n * stage2_pair),
                threads=stage2_threads,
            ) as (bx, by):
                up_tile_shared = T.alloc_shared(
                    (tail_m, stage2_block_k), dtype=dtype
                )
                down_shared = T.alloc_shared(
                    (stage2_block_n, stage2_block_k), dtype=dtype
                )
                out_local = T.alloc_fragment(
                    (tail_m, stage2_block_n), dtype=accum_dtype
                )
                if stage2_pair == 2:
                    out_local2 = T.alloc_fragment(
                        (tail_m, stage2_block_n), dtype=accum_dtype
                    )
                else:
                    out_shared = T.alloc_shared(
                        (tail_m, stage2_block_n), dtype=dtype
                    )
                d_stage = T.alloc_fragment((stage2_block_n, stage2_block_k), dtype=dtype)
                T.annotate_layout({
                    up_tile_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(up_tile_shared, vecSize=4),
                    down_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(down_shared, vecSize=4),
                })
                route_weight_local = T.alloc_fragment(
                    (tail_m,), dtype=T.float32
                )
                T.use_swizzle(stage2_tail_swizzle)

                external_bx = bx
                expert_id = T.min(
                    T.max(group_idx_for_bx[external_bx], 0), num_experts - 1
                )
                block_start = external_bx * external_block_m
                group_size = group_sizes[expert_id]
                raw_start = group_offsets[expert_id]
                padded_start = group_padded_offsets[expert_id]
                token_offset = block_start - padded_start
                actual_rows = T.max(
                    0, T.min(external_block_m, group_size - token_offset)
                )

                if actual_rows > 0 and actual_rows <= tail_rows:
                    T.clear(out_local)
                    if stage2_pair == 2:
                        T.clear(out_local2)
                    for k in T.unroll(
                        T.ceildiv(intermediate, stage2_block_k),
                        explicit=False,
                        unroll_factor=stage2_unroll,
                    ):
                        T.copy(
                            up_logits[
                                block_start : block_start + tail_m,
                                k * stage2_block_k : (k + 1) * stage2_block_k,
                            ],
                            up_tile_shared,
                        )
                        T.copy(
                            down_w[
                                expert_id,
                                (by * stage2_pair) * stage2_block_n
                                : (by * stage2_pair + 1) * stage2_block_n,
                                k * stage2_block_k : (k + 1) * stage2_block_k,
                            ],
                            down_shared,
                        )
                        if stage2_pair == 2:
                            T.copy(
                                down_w[
                                    expert_id,
                                    (by * stage2_pair + 1) * stage2_block_n
                                    : (by * stage2_pair + 2) * stage2_block_n,
                                    k * stage2_block_k : (k + 1) * stage2_block_k,
                                ],
                                d_stage,
                            )
                        T.gemm(
                            up_tile_shared,
                            down_shared,
                            out_local,
                            transpose_B=True,
                            policy=stage2_policy,
                        )
                        if stage2_pair == 2:
                            T.copy(d_stage, down_shared)
                            T.gemm(
                                up_tile_shared,
                                down_shared,
                                out_local2,
                                transpose_B=True,
                                policy=stage2_policy,
                            )
                    for i in T.Parallel(tail_m):
                        route_weight_local[i] = T.if_then_else(
                            i < actual_rows,
                            routed_expert_weights[
                                T.min(
                                    raw_start + token_offset + i,
                                    total_valid_tokens - 1,
                                )
                            ],
                            T.cast(0, T.float32),
                        )

                    if stage2_pair == 2:
                        for i, j in T.Parallel(tail_m, stage2_block_n):
                            if i < actual_rows:
                                out[
                                    block_start + i,
                                    (by * stage2_pair) * stage2_block_n + j,
                                ] = T.cast(
                                    out_local[i, j] * route_weight_local[i], dtype
                                )
                        for i, j in T.Parallel(tail_m, stage2_block_n):
                            if i < actual_rows:
                                out[
                                    block_start + i,
                                    (by * stage2_pair + 1) * stage2_block_n + j,
                                ] = T.cast(
                                    out_local2[i, j] * route_weight_local[i], dtype
                                )
                    else:
                        for i, j in T.Parallel(tail_m, stage2_block_n):
                            out_shared[i, j] = T.cast(
                                out_local[i, j] * route_weight_local[i], dtype
                            )
                        for i, j in T.Parallel(tail_m, stage2_block_n):
                            if i < actual_rows:
                                out[
                                    block_start + i,
                                    by * stage2_block_n + j,
                                ] = out_shared[i, j]
    return kernel


def _choose_block_m(num_experts, total_valid_tokens, num_blocks_m):
    experts = int(num_experts)
    blocks = int(num_blocks_m)
    second_blocks = blocks - experts
    tail_rows = 64 if (
        blocks >= 64
        and blocks < 2 * experts
        and 4 * second_blocks >= blocks
    ) else 0
    return 128, tail_rows


def _get_kernel(
    hidden,
    intermediate,
    num_experts,
    total_padded_tokens,
    total_valid_tokens,
    num_blocks_m,
    block_m,
    tail_rows,
):
    key = (
        int(hidden),
        int(intermediate),
        int(num_experts),
        int(total_padded_tokens),
        int(total_valid_tokens),
        int(num_blocks_m),
        int(block_m),
        int(tail_rows),
    )
    kernel = _KERNEL_CACHE.get(key)
    if kernel is None:
        kernel = _moe_forward_kernel(*key)
        _KERNEL_CACHE[key] = kernel
    return kernel


def _get_workspace(stacked_expert_tokens, intermediate):
    key = (
        str(stacked_expert_tokens.device),
        int(stacked_expert_tokens.shape[0]),
        int(intermediate),
        str(stacked_expert_tokens.dtype),
    )
    up_logits = _WORKSPACE_CACHE.get(key)
    if up_logits is None:
        _WORKSPACE_CACHE.clear()
        up_logits = torch.empty(
            (int(stacked_expert_tokens.shape[0]), int(intermediate)),
            device=stacked_expert_tokens.device,
            dtype=stacked_expert_tokens.dtype,
        )
        _WORKSPACE_CACHE[key] = up_logits
    return up_logits


def run_kernel(
    stacked_expert_tokens,
    gate_w,
    up_w,
    down_w,
    routed_expert_weights,
    group_sizes,
    group_offsets,
    group_padded_offsets,
    group_idx_for_bx,
    out,
):
    hidden = int(stacked_expert_tokens.shape[1])
    intermediate = int(gate_w.shape[1])
    num_experts = int(gate_w.shape[0])
    total_padded_tokens = int(stacked_expert_tokens.shape[0])
    total_valid_tokens = int(routed_expert_weights.shape[0])
    num_blocks_m = int(group_idx_for_bx.shape[0])
    up_logits = _get_workspace(stacked_expert_tokens, intermediate)

    block_m, tail_rows = _choose_block_m(
        num_experts, total_valid_tokens, num_blocks_m
    )
    kernel = _get_kernel(
        hidden,
        intermediate,
        num_experts,
        total_padded_tokens,
        total_valid_tokens,
        num_blocks_m,
        block_m,
        tail_rows,
    )
    kernel(
        stacked_expert_tokens,
        gate_w,
        up_w,
        down_w,
        routed_expert_weights,
        group_sizes,
        group_offsets,
        group_padded_offsets,
        group_idx_for_bx,
        up_logits,
        out,
    )
