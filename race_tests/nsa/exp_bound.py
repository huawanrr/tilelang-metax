"""Discriminate traffic-bound vs chain-bound for the S==1 kernel.

Variant `noV` skips the V load and the PV gemm: -8KB/CTA traffic (-33%) with
an almost unchanged dependency chain.  If the wall time drops ~proportionally
the kernel is bandwidth-bound; if it barely moves it is chain-bound.
Variant `pad` adds a register-only FMA chain: +chain, +0 traffic.
"""
import sys

import tilelang
import tilelang.language as T

sys.path.insert(0, "/data/tilelang-metax/race_tests/nsa")


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def probe_kernel(batch, heads, seq_len, dim, is_causal, block_size, groups,
                 scale_log2, mode="full", threads=64):
    head_kv = heads // groups
    q_shape = [batch, seq_len, heads, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    bi_shape = [batch, seq_len, head_kv, 1]
    dtype = T.float16
    accum = T.float32
    BK = BV = min(128, tilelang.math.next_power_of_2(dim))
    G = groups
    BS = block_size

    @T.prim_func
    def k(Q: T.Tensor(q_shape, dtype), K: T.Tensor(kv_shape, dtype),
          V: T.Tensor(kv_shape, dtype), BI: T.Tensor(bi_shape, T.int32),
          Out: T.Tensor(q_shape, dtype)):
        with T.Kernel(seq_len, 1, batch * head_kv, threads=threads) as (bx, _, bz):
            Q_reg = T.alloc_fragment([G, BK], dtype)
            K_reg = T.alloc_fragment([BS, BK], dtype)
            V_reg = T.alloc_fragment([BS, BV], dtype)
            KV_shared = T.alloc_shared([BS, BK], dtype)
            acc_s = T.alloc_fragment([G, BS], accum)
            acc_s_cast = T.alloc_fragment([G, BS], dtype)
            acc_o = T.alloc_fragment([G, BV], accum)
            scores_sum = T.alloc_fragment([G], accum)
            if mode == "pad":
                pad1 = T.alloc_fragment([G, BV], accum)
            i_t = bx
            i_b = bz // head_kv
            i_h = bz % head_kv
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)
            i_s = BI[i_b, i_t, i_h, 0] * BS
            T.fill(acc_o, 0)
            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                if mode != "noV":
                    T.copy(V[i_b, i_s : i_s + BS, i_h, :], V_reg)
                T.copy(K_reg, KV_shared)
                T.clear(acc_s)
                T.gemm(Q_reg, KV_shared, acc_s, transpose_B=True,
                       policy=T.GemmWarpPolicy.FullRow)
                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                T.copy(acc_s, acc_s_cast)
                if mode == "noV":
                    # Reuse K as the PV operand: no V traffic, no second load.
                    T.gemm(acc_s_cast, KV_shared, acc_o,
                           policy=T.GemmWarpPolicy.FullRow)
                else:
                    T.copy(V_reg, KV_shared)
                    T.gemm(acc_s_cast, KV_shared, acc_o,
                           policy=T.GemmWarpPolicy.FullRow)
                T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
            if mode == "pad":
                T.fill(pad1, 1.0)
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] = acc_o[i, j] * 1.0000001 + pad1[i, j]
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] = acc_o[i, j] * 1.0000002 + pad1[i, j]
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] = acc_o[i, j] * 1.0000003 + pad1[i, j]
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] = acc_o[i, j] * 0.5
            T.copy(acc_o, Out[i_b, i_t, i_h * G : (i_h + 1) * G, :])

    return k


if __name__ == "__main__":
    import torch
    from bench_oj import graph_latency, make_case

    cfg = dict(B=8, T=1024, H=1, HQ=16, D=128, S=1, bs=32, causal=True)
    q, k_, v, idx = make_case(cfg)
    outs = {m: torch.empty_like(q) for m in ("full", "noV", "pad")}
    for m in ("full", "noV", "pad"):
        kern = probe_kernel(batch=8, heads=16, seq_len=1024, dim=128,
                            is_causal=True, block_size=32, groups=16,
                            scale_log2=0.144269504, mode=m)
        us = graph_latency(lambda: kern(q, k_, v, idx, outs[m])) * 1e3
        print(f"mode={m:>4}: {us:7.1f}us")
