"""Experimental S==1 MACA MMA emitter kernel.

This is deliberately kept separate from :mod:`nsa`: it targets the dominant
OJ shape (G=16, BS=32, D=128, one wave) and replaces the two ``T.gemm`` calls
with direct ``TensorCoreIntrinEmitter`` macros.  The root agent can import
``native_sparse_attention_single_block_emitter`` for isolated timing and
correctness checks before wiring this path into ``nsa.py``.
"""

import tilelang
import tilelang.language as T

from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter


def _emitters(dtype, accum, qk_k_pack=2):
    # One MACA wave owns the full 16-row M dimension.  QK is 16x32x128;
    # PV is 16x128x32.  k_pack emits several 16-wide MMAs per LDS load.
    qk = TensorCoreIntrinEmitter(
        a_dtype=dtype, b_dtype=dtype, accum_dtype=accum,
        a_transposed=False, b_transposed=True,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=32, chunk=128, k_pack=qk_k_pack,
    )
    # k_pack=1: the A-load layout must equal the QK emitter's C-store layout
    # (both Fragment([16,32], thread _j%16//4*16+_i, idx _j//16*4+_j%4)) or the
    # f32->f16 cast between the two stages hits a layout-infer conflict.
    pv = TensorCoreIntrinEmitter(
        a_dtype=dtype, b_dtype=dtype, accum_dtype=accum,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=128, chunk=32, k_pack=1,
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
    threads=64, qk_k_pack=2,
):
    """Fixed S=1 emitter path (D=128, BS=32, G=16, 64 threads).

    The signature intentionally mirrors the regular single-block builder so it
    can be dropped into ``_get_kernel`` while the experiment is benchmarked.
    """
    assert dim == 128 and block_size == 32 and threads == 64
    head_kv = heads // groups
    G, BS, BK, BV = groups, block_size, 128, 128
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]

    qk, pv = _emitters(T.float16, T.float32, qk_k_pack)
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
            # Global staging remains register-first, matching the shipped S=1
            # kernel.  K/V then reuse one shared tile, with explicit MMA
            # swizzle on the shared operands.
            Q_reg = T.alloc_fragment([G, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BV], T.float16)
            KV_shared = T.alloc_shared([BS, BK], T.float16)
            acc_s = T.alloc_fragment([G, BS], T.float32)
            acc_s_cast = T.alloc_fragment([G, BS], T.float16)
            acc_o = T.alloc_fragment([G, BV], T.float32)
            scores_sum = T.alloc_fragment([G], T.float32)
            scores_inv_sum = T.alloc_fragment([G], T.float32)

            # A fragments need the emitter's k_pack=2 local ordering; C
            # fragments need the MFMA store ordering.  The shared layout is the
            # same XOR swizzle used by T.gemm's MACA lowering.
            T.annotate_layout({
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    KV_shared, vecSize=8),
                acc_s: qk.make_mma_store_layout(acc_s),
                acc_s_cast: pv.make_mma_load_layout(acc_s_cast, "A"),
                acc_o: pv.make_mma_store_layout(acc_o),
            })

            i_t, i_v, i_bh = bx, by, bz
            i_b, i_h = i_bh // head_kv, i_bh % head_kv
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            T.fill(scores_sum, 0)

            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
                T.copy(K_reg, KV_shared)

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

                # QK: Q_reg is already in the emitter's A fragment layout;
                # only K needs ldmatrix loads from the shared tile.
                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
                for ki in T.serial(qk_steps):
                    qk.ldmatrix_b(kb, KV_shared, ki)
                    qk.mma(Q_reg, kb, acc_s, ki)

                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                for i in T.Parallel(G):
                    scores_inv_sum[i] = T.if_then_else(
                        scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] *= scores_inv_sum[i]
                T.copy(acc_s, acc_s_cast)

                # Reuse the K shared allocation for V after QK has consumed it.
                T.copy(V_reg, KV_shared)
                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, KV_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)

            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])

    return kernel

