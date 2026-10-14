"""Two query tokens per CTA on the S==1 path, chains interleaved.

Grid-scaling evidence (Sep 19): both weak shapes are linear in CTA count with
no capacity plateau -- oj6 costs ~13.7ns per CTA from grid 1024 to 8192 and
oj12 ~14.2ns.  Halving the CTA count is therefore the one lever the closed
in-kernel list does not cover.  This module keeps the whole two-token body on
one straight line (invalid blocks load through a clamped address and are
masked to -inf, so no per-token branching except the second store), so the
backend can overlap token 1's loads with token 0's compute.
"""
import torch
import tilelang
import tilelang.language as T


def _clamped(i_s, seq_len, BS, i_t, is_causal):
    hi = T.max(seq_len - BS, 0)
    safe = T.if_then_else(i_s < 0, 0, T.if_then_else(i_s > hi, hi, i_s))
    skip = T.if_then_else(i_s < 0, 1, T.if_then_else(i_s >= seq_len, 1, 0))
    if is_causal:
        skip = T.if_then_else(i_s > i_t, 1, skip)
    return T.if_then_else(skip > 0, safe, i_s)


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def nsa_single_block_mt2(
    batch,
    heads,
    seq_len,
    dim,
    is_causal,
    block_size,
    groups,
    scale_log2,
    threads=64,
):
    """S==1, two tokens per CTA.  G rows of Q per token, one KV block each."""

    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    block_indices_shape = [batch, seq_len, head_kv, 1]

    dtype = T.float16
    accum_dtype = T.float32
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    G = groups
    BS = block_size

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, dtype),
        K: T.Tensor(kv_shape, dtype),
        V: T.Tensor(kv_shape, dtype),
        BlockIndices: T.Tensor(block_indices_shape, T.int32),
        Output: T.Tensor(q_shape, dtype),
    ):
        with T.Kernel(
            tilelang.cdiv(seq_len, 2),
            tilelang.cdiv(dim, BV),
            batch * head_kv,
            threads=threads,
        ) as (bx, by, bz):
            KV_shared_0 = T.alloc_shared([BS, BK], dtype)
            KV_shared_1 = T.alloc_shared([BS, BK], dtype)
            Q_reg_0 = T.alloc_fragment([G, BK], dtype)
            Q_reg_1 = T.alloc_fragment([G, BK], dtype)
            K_reg_0 = T.alloc_fragment([BS, BK], dtype)
            V_reg_0 = T.alloc_fragment([BS, BV], dtype)
            K_reg_1 = T.alloc_fragment([BS, BK], dtype)
            V_reg_1 = T.alloc_fragment([BS, BV], dtype)
            acc_s_0 = T.alloc_fragment([G, BS], accum_dtype)
            acc_s_1 = T.alloc_fragment([G, BS], accum_dtype)
            acc_s_cast_0 = T.alloc_fragment([G, BS], dtype)
            acc_s_cast_1 = T.alloc_fragment([G, BS], dtype)
            acc_o_0 = T.alloc_fragment([G, BV], accum_dtype)
            acc_o_1 = T.alloc_fragment([G, BV], accum_dtype)
            scores_sum_0 = T.alloc_fragment([G], accum_dtype)
            scores_sum_1 = T.alloc_fragment([G], accum_dtype)
            inv_sum_0 = T.alloc_fragment([G], accum_dtype)
            inv_sum_1 = T.alloc_fragment([G], accum_dtype)

            i_v = by
            i_bh = bz
            i_b = i_bh // head_kv
            i_h = i_bh % head_kv
            t0 = bx * 2
            t1 = t0 + 1
            has1 = t1 < seq_len
            t1c = T.if_then_else(has1, t1, seq_len - 1)

            # Q loads first: they do not depend on the block indices.  QK
            # consumes the full head dim, so the copy is not split by `by`.
            T.copy(Q[i_b, t0, i_h * G : (i_h + 1) * G, :], Q_reg_0)
            T.copy(Q[i_b, t1c, i_h * G : (i_h + 1) * G, :], Q_reg_1)

            i_s0 = BlockIndices[i_b, t0, i_h, 0] * BS
            i_s1 = BlockIndices[i_b, t1c, i_h, 0] * BS
            a0 = _clamped(i_s0, seq_len, BS, t0, is_causal)
            a1 = _clamped(i_s1, seq_len, BS, t1, is_causal)

            T.fill(acc_o_0, 0)
            T.fill(acc_o_1, 0)
            T.fill(scores_sum_0, 0)
            T.fill(scores_sum_1, 0)

            T.copy(K[i_b, a0 : a0 + BS, i_h, :], K_reg_0)
            T.copy(K[i_b, a1 : a1 + BS, i_h, :], K_reg_1)
            T.copy(V[i_b, a0 : a0 + BS, i_h, i_v * BV : (i_v + 1) * BV], V_reg_0)
            T.copy(V[i_b, a1 : a1 + BS, i_h, i_v * BV : (i_v + 1) * BV], V_reg_1)

            neg_inf = -T.infinity(accum_dtype)
            # Value-level validity per token (nested selects; Python `and`
            # does not work on TileLang scalars).  An invalid block keeps its
            # clamped load but its whole mask row goes -inf, so exp2 gives 0.
            ok0 = T.if_then_else(
                i_s0 >= 0,
                T.if_then_else(
                    i_s0 < seq_len,
                    T.if_then_else(is_causal and i_s0 > t0, 0, 1),
                    0,
                ),
                0,
            )
            ok1 = T.if_then_else(
                i_s1 >= 0,
                T.if_then_else(
                    i_s1 < seq_len,
                    T.if_then_else(is_causal and i_s1 > t1, 0, 1),
                    0,
                ),
                0,
            )
            for i, j in T.Parallel(G, BS):
                if is_causal:
                    m0 = T.if_then_else(i_s0 + j <= t0, 0.0, neg_inf)
                    m1 = T.if_then_else(i_s1 + j <= t1, 0.0, neg_inf)
                else:
                    m0 = T.if_then_else(i_s0 + j < seq_len, 0.0, neg_inf)
                    m1 = T.if_then_else(i_s1 + j < seq_len, 0.0, neg_inf)
                acc_s_0[i, j] = T.if_then_else(ok0 > 0, m0, neg_inf)
                acc_s_1[i, j] = T.if_then_else(ok1 > 0, m1, neg_inf)

            T.copy(K_reg_0, KV_shared_0)
            T.copy(K_reg_1, KV_shared_1)
            T.gemm(Q_reg_0, KV_shared_0, acc_s_0, transpose_B=True,
                   policy=T.GemmWarpPolicy.FullRow)
            T.gemm(Q_reg_1, KV_shared_1, acc_s_1, transpose_B=True,
                   policy=T.GemmWarpPolicy.FullRow)
            for i, j in T.Parallel(G, BS):
                acc_s_0[i, j] = T.exp2(T.min(acc_s_0[i, j] * scale_log2, 15.0))
                acc_s_1[i, j] = T.exp2(T.min(acc_s_1[i, j] * scale_log2, 15.0))
            T.copy(acc_s_0, acc_s_cast_0)
            T.copy(acc_s_1, acc_s_cast_1)
            T.copy(V_reg_0, KV_shared_0)
            T.copy(V_reg_1, KV_shared_1)
            T.gemm(acc_s_cast_0, KV_shared_0, acc_o_0,
                   policy=T.GemmWarpPolicy.FullRow)
            T.gemm(acc_s_cast_1, KV_shared_1, acc_o_1,
                   policy=T.GemmWarpPolicy.FullRow)

            T.reduce_sum(acc_s_0, scores_sum_0, dim=1, clear=True)
            T.reduce_sum(acc_s_1, scores_sum_1, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum_0[i] = T.if_then_else(scores_sum_0[i] > 0,
                                              1.0 / scores_sum_0[i], 0.0)
                inv_sum_1[i] = T.if_then_else(scores_sum_1[i] > 0,
                                              1.0 / scores_sum_1[i], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o_0[i, j] *= inv_sum_0[i]
                acc_o_1[i, j] *= inv_sum_1[i]

            T.copy(
                acc_o_0,
                Output[i_b, t0, i_h * G : (i_h + 1) * G,
                       i_v * BV : (i_v + 1) * BV],
            )
            if has1:
                T.copy(
                    acc_o_1,
                    Output[i_b, t1, i_h * G : (i_h + 1) * G,
                           i_v * BV : (i_v + 1) * BV],
                )

    return kernel


def make_mt2(B, T, H, HQ, D, S, bs, causal, scale=0.1):
    kernel = nsa_single_block_mt2(
        batch=B, heads=HQ, seq_len=T, dim=D, is_causal=causal,
        block_size=bs, groups=HQ // H,
        scale_log2=(D**-0.5 if scale is None else float(scale)) * 1.44269504,
    )

    def run(q, k, v, idx):
        out = torch.empty_like(q)
        kernel(q, k, v, idx.contiguous().to(torch.int32), out)
        return out

    return run


if __name__ == "__main__":
    import nsa
    from bench_oj import graph_latency, make_case

    for name, cfg in (
        ("oj6", dict(B=8, T=1024, H=1, HQ=16, D=128, S=1, bs=32, causal=True)),
        ("c69", dict(B=4, T=1024, H=1, HQ=16, D=128, S=1, bs=32, causal=True)),
    ):
        q, k, v, idx = make_case(cfg)
        kw = dict(batch=cfg["B"], heads=cfg["HQ"], seq_len=cfg["T"], dim=cfg["D"],
                  is_causal=cfg["causal"], scale=0.1, block_size=cfg["bs"],
                  groups=cfg["HQ"] // cfg["H"], selected_blocks=cfg["S"])
        opt = nsa.native_sparse_attention(**kw)
        mt2 = make_mt2(cfg["B"], cfg["T"], cfg["H"], cfg["HQ"], cfg["D"],
                       cfg["S"], cfg["bs"], cfg["causal"])
        ref = opt(q, k, v, idx)
        got = mt2(q, k, v, idx)
        err = (ref.float() - got.float()).abs().max().item()
        t_opt = graph_latency(lambda: opt(q, k, v, idx)) * 1e3
        t_mt2 = graph_latency(lambda: mt2(q, k, v, idx)) * 1e3
        print(f"{name}: opt {t_opt:.1f}us  mt2 {t_mt2:.1f}us  ({t_opt/t_mt2:.2f}x)  max_err {err:.2e}")
