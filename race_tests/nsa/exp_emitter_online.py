"""Emitter-based S>1 online kernel (the oj12 family: D64, bs16, S=8, G=16).

Same structure as the adopted S==1 emitter, applied per block of the online
loop: QK emitter (k_pack=2) -> exp2 clamp -> deferred sum (nmax) -> PV emitter
(k_pack=1), with the [16, BS] cast layout match verified in
exp_layout_matrix.py.  Loop/validity/normalization logic mirrors nsa.py's
online kernel (stage_regs + nmax + q_frag + unroll).
"""
import torch
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def nsa_online_emitter(
    batch, heads, seq_len, dim, is_causal, block_size, groups,
    selected_blocks, scale_log2, threads=64, online_unroll=2,
):
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    bi_shape = [batch, seq_len, head_kv, selected_blocks]

    G, BS = groups, block_size
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    S = selected_blocks

    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=BK, k_pack=2,
    )
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BK, chunk=BS, k_pack=1,
    )
    qk_steps = qk.chunk // (qk.k_pack * qk.micro_size_k)
    pv_steps = pv.chunk // (pv.k_pack * pv.micro_size_k)

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor(bi_shape, T.int32),
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

            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            T.fill(acc_o, 0)
            T.fill(sum_acc, 0)

            kb = T.alloc_local(
                [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local(
                [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)

            neg_inf = -T.infinity(T.float32)
            for s in T.unroll(S, unroll_factor=online_unroll):
                i_s = BlockIndices[i_b, i_t, i_h, s] * BS
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


if __name__ == "__main__":
    import nsa
    from bench_oj import graph_latency, make_case

    for name, cfg in (
        ("oj12", dict(B=4, T=1024, H=1, HQ=16, D=64, S=8, bs=16, causal=True)),
        ("S4",   dict(B=2, T=512, H=1, HQ=16, D=64, S=4, bs=16, causal=True)),
        ("S2",   dict(B=1, T=256, H=1, HQ=16, D=64, S=2, bs=16, causal=True)),
    ):
        q, k, v, idx = make_case(cfg)
        scale = 0.1
        opt = nsa.native_sparse_attention(batch=cfg["B"], heads=cfg["HQ"],
            seq_len=cfg["T"], dim=cfg["D"], is_causal=cfg["causal"], scale=scale,
            block_size=cfg["bs"], groups=cfg["HQ"] // cfg["H"],
            selected_blocks=cfg["S"])
        emt = nsa_online_emitter(batch=cfg["B"], heads=cfg["HQ"],
            seq_len=cfg["T"], dim=cfg["D"], is_causal=cfg["causal"],
            block_size=cfg["bs"], groups=cfg["HQ"] // cfg["H"],
            selected_blocks=cfg["S"], scale_log2=scale * 1.44269504)
        ref = opt(q, k, v, idx).float()
        out = torch.empty_like(q)
        emt(q, k, v, idx, out)
        err = (ref - out.float()).abs().max().item()
        t_opt = graph_latency(lambda: opt(q, k, v, idx)) * 1e3
        t_emt = graph_latency(lambda: emt(q, k, v, idx, out)) * 1e3
        print(f"{name:>5}: opt {t_opt:7.1f}us  emitter {t_emt:7.1f}us  "
              f"({t_opt/t_emt:.3f}x)  max_err {err:.2e}")
