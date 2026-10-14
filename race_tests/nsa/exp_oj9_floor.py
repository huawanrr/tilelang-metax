"""oj9 floor probe: pure-copy kernel with the same global traffic as the
S==1 attention (Q 2KB + K 2KB + V 2KB read, out 2KB written per token).
If this runs at ~40us the oj9 shape is at the memory wall; if much faster,
the gap is chain/compute and there may be headroom left."""
import sys

sys.path.insert(0, "/data/tilelang-metax/race_tests/nsa")
import torch
import tilelang
import tilelang.language as T
from bench_oj import graph_latency, make_case


@tilelang.jit(
    pass_configs={
        tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    },
)
def copy_probe(batch, seq_len, dim, block_size, threads=64):
    head_kv = 1
    q_shape = [batch, seq_len, 16, dim]
    kv_shape = [batch, seq_len, head_kv, dim]
    BK = min(128, tilelang.math.next_power_of_2(dim))
    BS = block_size

    @T.prim_func
    def kernel(
        Q: T.Tensor(q_shape, T.float16),
        K: T.Tensor(kv_shape, T.float16),
        V: T.Tensor(kv_shape, T.float16),
        BlockIndices: T.Tensor([batch, seq_len, head_kv, 1], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, batch * head_kv, threads=threads) as (bx, bz):
            Q_reg = T.alloc_fragment([16, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BK], T.float16)
            O_shared = T.alloc_shared([16, BK], T.float16)

            i_b = bz // head_kv
            i_s = BlockIndices[i_b, bx, 0, 0] * BS
            # same three global reads as the attention, no mma at all
            T.copy(Q[i_b, bx, 0:16, :], Q_reg)
            T.copy(K[i_b, i_s : i_s + BS, 0, :], K_reg)
            T.copy(V[i_b, i_s : i_s + BS, 0, :], V_reg)
            # write the same output bytes (fold the three reads so the
            # compiler cannot elide them)
            for i, j in T.Parallel(16, BK):
                O_shared[i, j] = (Q_reg[i, j] + K_reg[i % BS, j]
                                  + V_reg[i % BS, j])
            T.copy(O_shared, Output[i_b, bx, 0:16, :])

    return kernel


if __name__ == "__main__":
    scale = 0.1
    for B, TT in ((1, 8192), (8, 1024)):
        cfg = dict(B=B, T=TT, H=1, HQ=16, D=64 if B == 1 else 128,
                   S=1, bs=16 if B == 1 else 32, causal=True)
        D, bs = cfg["D"], cfg["bs"]
        q, k, v, idx = make_case(cfg)
        import nsa
        kern = nsa.native_sparse_attention(batch=B, heads=16, seq_len=TT, dim=D,
            is_causal=True, scale=scale, block_size=bs, groups=16, selected_blocks=1)
        cp = copy_probe(B, TT, D, bs)
        out = torch.empty_like(q)
        cp(q, k, v, idx, out)
        t_attn = graph_latency(lambda: kern(q, k, v, idx)) * 1e3
        t_copy = graph_latency(lambda: cp(q, k, v, idx, out)) * 1e3
        traffic = B * TT * (3 * 16 * D + bs * D) * 2 / 1e6
        print(f"B{B} T{TT} D{D} bs{bs}: attention {t_attn:7.1f}us  pure-copy {t_copy:7.1f}us"
              f"  traffic {traffic:.1f}MB  copy-BW {traffic/t_copy*1000:.2f}TB/s"
              f"  attention/copy {t_attn/t_copy:.2f}x")
