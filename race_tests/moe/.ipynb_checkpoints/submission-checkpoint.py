# MoE submission v19 (stripped; documented source is moe.py)
import torch
import tilelang
import tilelang.language as T


def _reach(root, path):
    obj = root
    for part in path.split("."):
        obj = getattr(obj, part, None)
        if obj is None:
            return None
    return obj


def _enable_maca_k_pack(k_pack=2):
    gemm_mma = _reach(tilelang, "maca.op.gemm.gemm_mma")
    emitter_mod = _reach(tilelang, "maca.intrinsics.macro.mma_macro_generator")
    is_full_region = _reach(tilelang, "utils.language.is_full_region")
    _Simplify = _reach(tilelang, "transform.simplify._Simplify")
    if gemm_mma is None or emitter_mod is None or is_full_region is None or _Simplify is None:
        return False
    GemmMMA = getattr(gemm_mma, "GemmMMA", None)
    GEMM_INST_MMA = getattr(gemm_mma, "GEMM_INST_MMA", None)
    TensorCoreIntrinEmitter = getattr(emitter_mod, "TensorCoreIntrinEmitter", None)
    if GemmMMA is None or GEMM_INST_MMA is None or TensorCoreIntrinEmitter is None:
        return False

    if getattr(GemmMMA, "_k_pack_override", 0) == k_pack:
        return True
    stock_lower = getattr(GemmMMA, "_stock_lower", GemmMMA.lower)

    def make_emitter(self, target, thread_nums, thread_var=None):
        m_warp, n_warp = self.policy.compute_warp_partition(
            self.M, self.N, thread_nums, target, GEMM_INST_MMA
        )
        return TensorCoreIntrinEmitter(
            a_dtype=self.in_dtype,
            b_dtype=self.in_dtype,
            accum_dtype=self.accum_dtype,
            a_transposed=self.trans_A,
            b_transposed=self.trans_B,
            block_row_warps=m_warp,
            block_col_warps=n_warp,
            warp_row_tiles=int(self.M // m_warp),
            warp_col_tiles=int(self.N // n_warp),
            chunk=self.chunk,
            k_pack=k_pack,
            thread_var=thread_var,
        )

    def lower(self, layout_map, target, thread_bounds, thread_var, mbar_phase_expr=None):
        try:
            emitter = self._make_mma_emitter(target, thread_bounds.extent, thread_var=thread_var)
            step = k_pack * emitter.micro_size_k
            if (
                not self.is_gemm_ss()
                or self.mbar is not None
                or emitter.chunk % step != 0
                or not is_full_region(self.CRegion)
            ):
                raise NotImplementedError
            in_dtype = self.in_dtype
            warp_rows, warp_cols = emitter.warp_rows, emitter.warp_cols
            size_a, size_b = emitter.local_size_a, emitter.local_size_b
            steps = emitter.chunk // step
            a_region, b_region, c_buf = self.ARegion, self.BRegion, self.CRegion.buffer
            clear_accum = self.clear_accum

            @T.prim_func
            def _gemm_ssr() -> None:
                a_local = T.alloc_local((warp_rows * k_pack * size_a), in_dtype)
                b_local = T.alloc_local((warp_cols * k_pack * size_b), in_dtype)
                if clear_accum:
                    T.clear(c_buf)
                for ki in T.serial(0, steps):
                    emitter.ldmatrix_a(a_local, a_region, ki)
                    emitter.ldmatrix_b(b_local, b_region, ki)
                    emitter.mma(a_local, b_local, c_buf, ki)

            return _Simplify(_gemm_ssr, inline_let=True)
        except Exception:
            return stock_lower(self, layout_map, target, thread_bounds, thread_var,
                               mbar_phase_expr)

    try:
        GemmMMA._stock_lower = stock_lower
        GemmMMA._make_mma_emitter = make_emitter
        GemmMMA.lower = lower
        GemmMMA._k_pack_override = k_pack
    except Exception:
        return False
    return True


_K_PACK = {}


def _k_pack_on():
    state = _K_PACK.get("on")
    if state is None:
        state = _enable_maca_k_pack(2)
        _K_PACK["on"] = state
    return state


_KERNEL_CACHE = {}
_WORKSPACE_CACHE = {}

_VERSION = "v19"

_TRACE = False
_TRACED = {}


def _trace_once(hidden, intermediate, num_experts, padded, valid, num_blocks_m,
                block_m, group_sizes):
    key = (hidden, intermediate, num_experts, padded, valid, num_blocks_m)
    if key in _TRACED:
        return
    _TRACED[key] = True
    try:
        try:
            sizes = [int(c) for c in group_sizes.detach().to("cpu").tolist()]
            used = [c for c in sizes if c > 0]
            stat = (f"experts_used={len(used)} rows/expert min/mean/max="
                    f"{min(used)}/{sum(used) // len(used)}/{max(used)}"
                    if used else "no rows")
        except Exception as exc:
            stat = f"group_sizes unreadable: {exc}"
        print(f"[moe {_VERSION}] H={hidden} I={intermediate} E={num_experts} "
              f"padded={padded} valid={valid} blocks={num_blocks_m} "
              f"block_m={block_m} k_pack={'on' if _K_PACK.get('on') else 'off'} {stat}",
              flush=True)
    except Exception:
        pass


@tilelang.jit(
    pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}
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
    stage1_block_k = 64
    stage1_num_stages = 0
    stage1_swizzle = 8
    stage1_threads = 512
    stage1_policy = T.GemmWarpPolicy.Square

    stage2_block_n = 128
    stage2_block_k = 64
    stage2_threads = 256
    stage2_num_stages = 0
    stage2_swizzle = 8
    stage2_policy = T.GemmWarpPolicy.Square

    while stage1_block_n > intermediate and stage1_block_n > 64:
        stage1_block_n //= 2
    while stage1_block_k > hidden and stage1_block_k > 32:
        stage1_block_k //= 2
    while stage2_block_n > hidden and stage2_block_n > 64:
        stage2_block_n //= 2
    while stage2_block_k > intermediate and stage2_block_k > 32:
        stage2_block_k //= 2


    stage1_one_weight_buffer = (
        kernel_blocks_m * ((intermediate + stage1_block_n - 1) // stage1_block_n) >= 256
    )

    stage1_n_tiles = (intermediate + stage1_block_n - 1) // stage1_block_n
    if stage1_n_tiles >= 32:
        stage1_swizzle = stage1_n_tiles

    tail_rows = tail_rows if block_m == external_block_m else 0
    tail_m = 64

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
            threads=stage1_threads,
        ) as (bx, by):
            input_shared = T.alloc_shared(
                (block_m, stage1_block_k), dtype=dtype
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
                (block_m, stage1_block_n), dtype=accum_dtype
            )
            up_local = T.alloc_fragment(
                (block_m, stage1_block_n), dtype=accum_dtype
            )

            T.use_swizzle(stage1_swizzle)

            external_bx = bx // sub_blocks_per_external
            sub_block_idx = bx % sub_blocks_per_external
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
                0, T.min(block_m, group_size - token_offset)
            )

            if actual_rows > tail_rows:
                T.clear(gate_local)
                T.clear(up_local)

                for k in T.Pipelined(
                    T.ceildiv(hidden, stage1_block_k),
                    num_stages=stage1_num_stages,
                ):
                    T.copy(
                        stacked_expert_tokens[
                            block_start : block_start + block_m,
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
                        T.gemm(
                            input_shared,
                            weight_shared,
                            gate_local,
                            transpose_B=True,
                            policy=stage1_policy,
                        )
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

                for i, j in T.Parallel(block_m, stage1_block_n):
                    gate_local[i, j] = gate_local[i, j] * (
                        1.0 / (1.0 + T.exp2(-gate_local[i, j] * scale))
                    )
                    up_local[i, j] = up_local[i, j] * gate_local[i, j]
                    if i < actual_rows:
                        up_logits[
                            block_start + i,
                            by * stage1_block_n + j,
                        ] = up_local[i, j]

        if tail_rows > 0:
            with T.Kernel(
                num_blocks_m,
                T.ceildiv(intermediate, stage1_block_n),
                threads=stage1_threads,
            ) as (bx, by):
                input_shared = T.alloc_shared(
                    (tail_m, stage1_block_k), dtype=dtype
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
                    (tail_m, stage1_block_n), dtype=accum_dtype
                )
                up_local = T.alloc_fragment(
                    (tail_m, stage1_block_n), dtype=accum_dtype
                )

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

                if actual_rows > 0 and actual_rows <= tail_rows:
                    T.clear(gate_local)
                    T.clear(up_local)

                    for k in T.Pipelined(
                        T.ceildiv(hidden, stage1_block_k),
                        num_stages=stage1_num_stages,
                    ):
                        T.copy(
                            stacked_expert_tokens[
                                block_start : block_start + tail_m,
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
                            T.gemm(
                                input_shared,
                                weight_shared,
                                gate_local,
                                transpose_B=True,
                                policy=stage1_policy,
                            )
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

                    for i, j in T.Parallel(tail_m, stage1_block_n):
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
            T.ceildiv(hidden, stage2_block_n),
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
            out_shared = T.alloc_shared(
                (block_m, stage2_block_n), dtype=dtype
            )
            route_weight_local = T.alloc_fragment(
                (block_m,), dtype=T.float32
            )
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
                for k in T.Pipelined(
                    T.ceildiv(intermediate, stage2_block_k),
                    num_stages=stage2_num_stages,
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
                            by * stage2_block_n
                            : (by + 1) * stage2_block_n,
                            k * stage2_block_k : (k + 1) * stage2_block_k,
                        ],
                        down_shared,
                    )
                    T.gemm(
                        up_tile_shared,
                        down_shared,
                        out_local,
                        transpose_B=True,
                        policy=stage2_policy,
                    )
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
                T.ceildiv(hidden, stage2_block_n),
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
                out_shared = T.alloc_shared(
                    (tail_m, stage2_block_n), dtype=dtype
                )
                route_weight_local = T.alloc_fragment(
                    (tail_m,), dtype=T.float32
                )
                T.use_swizzle(stage2_swizzle)

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
                    for k in T.Pipelined(
                        T.ceildiv(intermediate, stage2_block_k),
                        num_stages=stage2_num_stages,
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
                                by * stage2_block_n
                                : (by + 1) * stage2_block_n,
                                k * stage2_block_k : (k + 1) * stage2_block_k,
                            ],
                            down_shared,
                        )
                        T.gemm(
                            up_tile_shared,
                            down_shared,
                            out_local,
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


_BLOCK_M_CACHE = {}

_M64_REL_RATE = 0.636


def _choose_block_m(group_sizes, num_experts, total_valid_tokens, num_blocks_m):
    key = (int(num_experts), int(total_valid_tokens), int(group_sizes.shape[0]),
           int(num_blocks_m))
    cached = _BLOCK_M_CACHE.get(key)
    if cached is not None:
        return cached
    result = (128, 0)
    try:
        sizes = [c for c in group_sizes.detach().to("cpu").tolist() if c > 0]
        if sizes:
            rows_128 = sum(-(-c // 128) * 128 for c in sizes)
            rows_64 = sum(-(-c // 64) * 64 for c in sizes)
            block_m = 64 if rows_64 / _M64_REL_RATE < rows_128 else 128
            blocks = 0
            tail = 0
            for c in sizes:
                n = -(-c // 128)
                blocks += n
                if c - 128 * (n - 1) <= 64:
                    tail += 1
            tail_rows = 0
            if block_m == 128 and blocks >= 64 and tail * 4 >= blocks:
                tail_rows = 64
            result = (block_m, tail_rows)
    except Exception:
        pass
    _BLOCK_M_CACHE[key] = result
    return result


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
        _k_pack_on()
        kernel = _moe_forward_kernel(*key)
        _KERNEL_CACHE[key] = kernel
    return kernel


def _get_workspace(stacked_expert_tokens, intermediate):
    key = (
        int(stacked_expert_tokens.device.index or 0),
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
        group_sizes, num_experts, total_valid_tokens, num_blocks_m
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
    if _TRACE:
        _trace_once(
            hidden, intermediate, num_experts, total_padded_tokens,
            total_valid_tokens, num_blocks_m, block_m, group_sizes,
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