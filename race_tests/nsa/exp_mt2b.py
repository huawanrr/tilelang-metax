"""Two tokens per CTA on the S==1 path via a UNION KV tile (batched M).

The earlier mt2 attempt ran two independent attention chains in one CTA and
lost +49%: two serialized gemm/barrier chains.  This version batches the two
tokens in the mma M dimension instead: the CTA loads both tokens' K/V blocks
into one [2*BS, BK] tile, runs ONE QK gemm [2G, BK] x [BK, 2BS] and ONE PV
gemm, and masks each row-block to its own 32 key columns (exp2(-inf) = 0
removes the partner's contribution from both the softmax sum and PV).
Grid halves; the per-CTA chain grows only by the wider gemms.
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
def nsa_single_block_mt2b(
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
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    block_indices_shape = [batch, seq_len, head_kv, 1]

    dtype = T.float16
    accum_dtype = T.float32
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    G = groups
    BS = block_size
    R = 2          # tokens per CTA
    NC = R * BS    # union key columns

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, dtype),
        K: T.Tensor(kv_shape, dtype),
        V: T.Tensor(kv_shape, dtype),
        BlockIndices: T.Tensor(block_indices_shape, T.int32),
        Output: T.Tensor(q_shape, dtype),
    ):
        with T.Kernel(
            tilelang.cdiv(seq_len, R),
            1,
            batch * head_kv,
            threads=threads,
        ) as (bx, _, bz):
            KV_shared = T.alloc_shared([NC, BK], dtype)
            Q_shared = T.alloc_shared([R * G, BK], dtype)
            K_reg0 = T.alloc_fragment([BS, BK], dtype)
            K_reg1 = T.alloc_fragment([BS, BK], dtype)
            V_reg0 = T.alloc_fragment([BS, BV], dtype)
            V_reg1 = T.alloc_fragment([BS, BV], dtype)
            acc_s = T.alloc_fragment([R * G, NC], accum_dtype)
            acc_s_cast = T.alloc_fragment([R * G, NC], dtype)
            acc_o = T.alloc_fragment([R * G, BV], accum_dtype)
            scores_sum = T.alloc_fragment([R * G], accum_dtype)
            inv_sum = T.alloc_fragment([R * G], accum_dtype)

            i_b = bz // head_kv
            i_h = bz % head_kv
            t0 = bx * R
            t1 = t0 + 1
            has1 = t1 < seq_len
            t1c = T.if_then_else(has1, t1, seq_len - 1)

            # Block starts for both tokens, clamped so invalid/sentinel
            # entries load an in-range tile that the masks then neutralize.
            i_s0 = BlockIndices[i_b, t0, i_h, 0] * BS
            i_s1 = BlockIndices[i_b, t1c, i_h, 0] * BS
            a0 = _clamped(i_s0, seq_len, BS, t0, is_causal)
            a1 = _clamped(i_s1, seq_len, BS, t1, is_causal)

            # Q rows first (they do not depend on the block indices): rows
            # 0..G-1 belong to token t0, rows G..2G-1 to token t1.
            for r in range(R):
                T.copy(
                    Q[i_b, t0 + r, i_h * G : (i_h + 1) * G, :],
                    Q_shared[r * G : (r + 1) * G, :],
                )

            neg_inf = -T.infinity(accum_dtype)
            T.fill(acc_o, 0)
            T.fill(scores_sum, 0)

            # Stage both blocks' K and V in whole-buffer register tiles,
            # then land them in disjoint halves of the shared tiles.
            T.copy(K[i_b, a0 : a0 + BS, i_h, :], K_reg0)
            T.copy(K[i_b, a1 : a1 + BS, i_h, :], K_reg1)
            T.copy(V[i_b, a0 : a0 + BS, i_h, :], V_reg0)
            T.copy(V[i_b, a1 : a1 + BS, i_h, :], V_reg1)
            T.copy(K_reg0, KV_shared[0 : BS, :])
            T.copy(K_reg1, KV_shared[BS : NC, :])

            # Mask initialization: valid keys of the row's own token only.
            # Token r's 32 columns sit at [r*BS, (r+1)*BS); the partner's
            # columns go -inf so they vanish in exp2 and in PV.
            for r in range(R):
                i_s = i_s0 if r == 0 else i_s1
                t = t0 if r == 0 else t1
                ok = T.if_then_else(
                    i_s >= 0,
                    T.if_then_else(
                        i_s < seq_len,
                        T.if_then_else(is_causal and i_s > t, 0, 1),
                        0,
                    ),
                    0,
                )
                for i, j in T.Parallel(G, NC):
                    if is_causal:
                        own0 = T.if_then_else(
                            j < BS,
                            T.if_then_else(
                                i_s0 + j < seq_len,
                                T.if_then_else(i_s0 + j <= t0, 0.0, neg_inf),
                                neg_inf,
                            ),
                            neg_inf,
                        )
                        own1 = T.if_then_else(
                            j >= BS,
                            T.if_then_else(
                                i_s1 + (j - BS) < seq_len,
                                T.if_then_else(
                                    i_s1 + (j - BS) <= t1, 0.0, neg_inf
                                ),
                                neg_inf,
                            ),
                            neg_inf,
                        )
                    else:
                        own0 = T.if_then_else(
                            j < BS,
                            T.if_then_else(i_s0 + j < seq_len, 0.0, neg_inf),
                            neg_inf,
                        )
                        own1 = T.if_then_else(
                            j >= BS,
                            T.if_then_else(
                                i_s1 + (j - BS) < seq_len, 0.0, neg_inf
                            ),
                            neg_inf,
                        )
                    own = own0 if r == 0 else own1
                    acc_s[r * G + i, j] = T.if_then_else(
                        ok > 0, own, neg_inf
                    )

            T.gemm(
                Q_shared, KV_shared, acc_s,
                transpose_B=True,
                policy=T.GemmWarpPolicy.FullRow,
            )
            for i, j in T.Parallel(R * G, NC):
                acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
            T.copy(acc_s, acc_s_cast)
            T.copy(V_reg0, KV_shared[0 : BS, :])
            T.copy(V_reg1, KV_shared[BS : NC, :])
            T.gemm(
                acc_s_cast, KV_shared, acc_o,
                policy=T.GemmWarpPolicy.FullRow,
            )

            # Row sums and normalization over the row's own columns only
            # (partner columns are exactly zero after exp2).
            T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
            for i in T.Parallel(R * G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0
                )
            for i, j in T.Parallel(R * G, BV):
                acc_o[i, j] *= inv_sum[i]

            for r in range(R):
                if r == 0 or has1:
                    t = t0 if r == 0 else t1
                    T.copy(
                        acc_o[r * G : (r + 1) * G, :],
                        Output[
                            i_b, t,
                            i_h * G : (i_h + 1) * G,
                            0:BV,
                        ],
                    )

    return kernel


def make_mt2b(B, T, H, HQ, D, S, bs, causal, scale=0.1):
    kernel = nsa_single_block_mt2b(
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
        mt2b = make_mt2b(cfg["B"], cfg["T"], cfg["H"], cfg["HQ"], cfg["D"],
                         cfg["S"], cfg["bs"], cfg["causal"])
        ref = opt(q, k, v, idx).float()
        got = mt2b(q, k, v, idx).float()
        err = (ref - got).abs().max().item()
        t_opt = graph_latency(lambda: opt(q, k, v, idx)) * 1e3
        t_mt2b = graph_latency(lambda: mt2b(q, k, v, idx)) * 1e3
        print(f"{name}: opt {t_opt:.1f}us  mt2b {t_mt2b:.1f}us  "
              f"({t_opt/t_mt2b:.2f}x)  max_err {err:.2e}")
