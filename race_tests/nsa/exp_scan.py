"""Scan-gather S==1 kernel: one CTA per (token-chunk, block), K/V loaded once.

Evidence (Sep 19): the S==1 family is bandwidth-bound -- time/CTA scales with
per-CTA traffic at a constant ~1.6-1.8 TB/s (D/bs sweep), with no capacity
plateau down to grid 1024.  The current kernel re-reads the selected 16 KB
K/V tile once per token; this kernel assigns one CTA to (chunk of W tokens,
block): it reads the chunk's W block-indices, and loads the block's K/V tile
only if at least one token selected it (or the token is invalid and this is
block 0, which owns zero-writes).  Every token is processed exactly once:
valid tokens by their selected block's CTA, invalid/sentinel tokens by block
0's CTA, all producing the same math as the per-token kernel.
"""
import torch
import tilelang
import tilelang.language as T


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def nsa_single_block_scan(
    batch,
    heads,
    seq_len,
    dim,
    is_causal,
    block_size,
    groups,
    scale_log2,
    chunk=64,
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
    NB = tilelang.cdiv(seq_len, BS)
    W = chunk

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, dtype),
        K: T.Tensor(kv_shape, dtype),
        V: T.Tensor(kv_shape, dtype),
        BlockIndices: T.Tensor(block_indices_shape, T.int32),
        Output: T.Tensor(q_shape, dtype),
    ):
        with T.Kernel(
            tilelang.cdiv(seq_len, W),
            NB,
            batch * head_kv,
            threads=threads,
        ) as (bx, by, bz):
            K_shared = T.alloc_shared([BS, BK], dtype)
            V_shared = T.alloc_shared([BS, BV], dtype)
            key_shared = T.alloc_shared([W], T.int32)
            Q_reg = T.alloc_fragment([G, BK], dtype)
            acc_s = T.alloc_fragment([G, BS], accum_dtype)
            acc_s_cast = T.alloc_fragment([G, BS], dtype)
            acc_o = T.alloc_fragment([G, BV], accum_dtype)
            scores_sum = T.alloc_fragment([G], accum_dtype)
            inv_sum = T.alloc_fragment([G], accum_dtype)
            n_match = T.alloc_local((1,), T.int32)

            i_b = bz // head_kv
            i_h = bz % head_kv
            blk = by
            s = blk * BS
            t0 = bx * W

            # Chunk keys, clamped in-range so the last partial chunk cannot
            # read past the tensor; clamped entries never match any block.
            for j in T.Parallel(W):
                key_shared[j] = BlockIndices[
                    i_b, T.min(t0 + j, seq_len - 1), i_h, 0
                ]

            n_match[0] = 0
            for j in T.serial(W):
                if t0 + j < seq_len:
                    raw = key_shared[j]
                    is_inv = T.if_then_else(
                        raw < 0, 1, T.if_then_else(raw >= NB, 1, 0)
                    )
                    mine = T.if_then_else(
                        raw == blk, 1, T.if_then_else(blk == 0, is_inv, 0)
                    )
                    n_match[0] += mine

            if n_match[0] > 0:
                T.copy(K[i_b, s : s + BS, i_h, :], K_shared)
                T.copy(V[i_b, s : s + BS, i_h, :], V_shared)
                T.fill(acc_o, 0)

                for j in T.serial(W):
                    if t0 + j < seq_len:
                        raw = key_shared[j]
                        is_inv = T.if_then_else(
                            raw < 0, 1, T.if_then_else(raw >= NB, 1, 0)
                        )
                        mine = T.if_then_else(
                            raw == blk, 1, T.if_then_else(blk == 0, is_inv, 0)
                        )
                        if mine > 0:
                            t = t0 + j
                            if is_inv > 0:
                                # Invalid/sentinel token: zeros, no attention.
                                T.fill(acc_o, 0)
                            else:
                                T.copy(
                                    Q[i_b, t, i_h * G : (i_h + 1) * G, :],
                                    Q_reg,
                                )
                                neg_inf = -T.infinity(accum_dtype)
                                for i, jj in T.Parallel(G, BS):
                                    if is_causal:
                                        m = T.if_then_else(
                                            s + jj < seq_len,
                                            T.if_then_else(
                                                s + jj <= t, 0.0, neg_inf
                                            ),
                                            neg_inf,
                                        )
                                    else:
                                        m = T.if_then_else(
                                            s + jj < seq_len, 0.0, neg_inf
                                        )
                                    acc_s[i, jj] = m
                                T.gemm(
                                    Q_reg, K_shared, acc_s,
                                    transpose_B=True,
                                    policy=T.GemmWarpPolicy.FullRow,
                                )
                                for i, jj in T.Parallel(G, BS):
                                    acc_s[i, jj] = T.exp2(
                                        T.min(acc_s[i, jj] * scale_log2, 15.0)
                                    )
                                T.copy(acc_s, acc_s_cast)
                                T.gemm(
                                    acc_s_cast, V_shared, acc_o,
                                    policy=T.GemmWarpPolicy.FullRow,
                                )
                                T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                                for i in T.Parallel(G):
                                    inv_sum[i] = T.if_then_else(
                                        scores_sum[i] > 0,
                                        1.0 / scores_sum[i],
                                        0.0,
                                    )
                                for i, jj in T.Parallel(G, BV):
                                    acc_o[i, jj] *= inv_sum[i]
                            T.copy(
                                acc_o,
                                Output[
                                    i_b, t,
                                    i_h * G : (i_h + 1) * G,
                                    0:BV,
                                ],
                            )
                            T.fill(acc_o, 0)

    return kernel


def make_scan(B, T, H, HQ, D, S, bs, causal, scale=0.1, chunk=64):
    kernel = nsa_single_block_scan(
        batch=B, heads=HQ, seq_len=T, dim=D, is_causal=causal,
        block_size=bs, groups=HQ // H,
        scale_log2=(D**-0.5 if scale is None else float(scale)) * 1.44269504,
        chunk=chunk,
    )

    def run(q, k, v, idx):
        out = torch.empty_like(q)
        kernel(q, k, v, idx.contiguous().to(torch.int32), out)
        return out

    return run


if __name__ == "__main__":
    import sys
    import nsa
    from bench_oj import graph_latency, make_case

    chunk = int(sys.argv[1]) if len(sys.argv) > 1 else 64
    for name, cfg in (
        ("oj6", dict(B=8, T=1024, H=1, HQ=16, D=128, S=1, bs=32, causal=True)),
        ("c69", dict(B=4, T=1024, H=1, HQ=16, D=128, S=1, bs=32, causal=True)),
    ):
        q, k, v, idx = make_case(cfg)
        kw = dict(batch=cfg["B"], heads=cfg["HQ"], seq_len=cfg["T"], dim=cfg["D"],
                  is_causal=cfg["causal"], scale=0.1, block_size=cfg["bs"],
                  groups=cfg["HQ"] // cfg["H"], selected_blocks=cfg["S"])
        opt = nsa.native_sparse_attention(**kw)
        scan = make_scan(cfg["B"], cfg["T"], cfg["H"], cfg["HQ"], cfg["D"],
                         cfg["S"], cfg["bs"], cfg["causal"], chunk=chunk)
        ref = opt(q, k, v, idx)
        got = scan(q, k, v, idx)
        err = (ref.float() - got.float()).abs().max().item()
        t_opt = graph_latency(lambda: opt(q, k, v, idx)) * 1e3
        t_scan = graph_latency(lambda: scan(q, k, v, idx)) * 1e3
        print(f"chunk={chunk} {name}: opt {t_opt:.1f}us  scan {t_scan:.1f}us  "
              f"({t_opt/t_scan:.2f}x)  max_err {err:.2e}")
