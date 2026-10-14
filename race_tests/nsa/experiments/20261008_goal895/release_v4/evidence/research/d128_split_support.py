# Local benchmark support, not a submission.
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter
from probe_support import BASE
_emitters = BASE._emitters
@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True, tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_linear_v_split(batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2, threads=64, late_normalize=False, kv_split=False, direct_k=False, lane_reduce=False, width=64):
    """S==1 fast path: the two T.gemm calls are replaced with direct
    TensorCoreIntrinEmitter macros (QK k_pack=2, PV k_pack=1), skipping
    T.gemm's generic lowering.  Layout match holds for every (D, BS) family;
    adoption is per-family, keyed on measured wins.

    ``late_normalize`` mirrors the T.gemm kernel's flag: cast the raw exp2
    probabilities to fp16 and start the PV mma immediately, then reduce_sum /
    reciprocal / normalize onto ``acc_o`` after PV so the reduction overlaps
    the tensor-core work instead of sitting on the QK->PV dependency chain."""
    assert threads == 64 and groups == 16 and (not kv_split)
    assert dim == 128 and block_size == 16 and (seq_len % block_size == 0) and (not direct_k)
    lane_reduce = True
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    G, BS = (groups, block_size)
    BK = min(128, tilelang.math.next_power_of_2(dim))
    BV = width
    VSTRIDE = max(64, BK) if 'linear' == 'bank' else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BV, chunk=BS, k_pack=1)
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
                            V_reg[(v_slot * 512 + tid * 8) // BV, tid % (BV // 8) * 8 + v_word * 2 + v_element] = V_blocks[i_b, _selected_block, (v_slot * 512 + tid * 8) // BV, i_h, i_v * BV + tid % (BV // 8) * 8 + v_word * 2 + v_element]
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

CACHE={}
def get(width,B,seq_len,H,HQ,D,S,block_size,is_causal,scale=None,**options):
    shape=(B,seq_len,H,HQ,D,S,block_size,is_causal,scale)
    if options or HQ!=H*16 or S!=1 or D!=128 or block_size!=16 or seq_len%16:
        return BASE._get_kernel(*shape,**options)
    key=(width,shape)
    if key not in CACHE:
        CACHE[key]=native_sparse_attention_linear_v_split(batch=B,heads=HQ,seq_len=seq_len,
            dim=D,is_causal=is_causal,block_size=block_size,groups=16,width=width,
            scale_log2=(D**-0.5 if scale is None else float(scale))*1.44269504)
    return CACHE[key]
