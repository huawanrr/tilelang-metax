"""oj12 floor probe: pure-copy kernel with the same global traffic as the
S=8 online attention (Q 2KB + 8x(K 2KB + V 2KB) read, out 2KB written per
token).  bs=16 == the 16 query rows, so the fold needs no integer modulo.
If pure-copy lands near 65us the shape is at its (scattered-2KB-tile)
memory wall and #12 is closed; if it lands near 49us the 25% gap is
overlap inefficiency and cp.async is the only unlock."""
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
def copy_probe(batch, seq_len, dim, block_size, selected=8, threads=64):
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
        BlockIndices: T.Tensor([batch, seq_len, head_kv, selected], T.int32),
        Output: T.Tensor(q_shape, T.float16),
    ):
        with T.Kernel(seq_len, batch * head_kv, threads=threads) as (bx, bz):
            Q_reg = T.alloc_fragment([16, BK], T.float16)
            K_reg = T.alloc_fragment([BS, BK], T.float16)
            V_reg = T.alloc_fragment([BS, BK], T.float16)
            acc = T.alloc_fragment([BS, BK], T.float32)
            O_shared = T.alloc_shared([16, BK], T.float16)

            i_b = bz // head_kv
            T.copy(Q[i_b, bx, 0:16, :], Q_reg)
            for s in T.serial(selected):
                i_s = BlockIndices[i_b, bx, 0, s] * BS
                T.copy(K[i_b, i_s : i_s + BS, 0, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, 0, :], V_reg)
                for i, j in T.Parallel(BS, BK):
                    acc[i, j] += K_reg[i, j] + V_reg[i, j]
            for i, j in T.Parallel(16, BK):
                O_shared[i, j] = Q_reg[i, j] + acc[i, j].astype(T.float16)
            T.copy(O_shared, Output[i_b, bx, 0:16, :])

    return kernel


if __name__ == "__main__":
    scale = 0.1
    B, TT, D, bs, S = 4, 1024, 64, 16, 8
    cfg = dict(B=B, T=TT, H=1, HQ=16, D=D, S=S, bs=bs, causal=True)
    q, k, v, idx = make_case(cfg)
    import nsa

    kern = nsa.native_sparse_attention(
        batch=B, heads=16, seq_len=TT, dim=D, is_causal=True, scale=scale,
        block_size=bs, groups=16, selected_blocks=S)
    cp = copy_probe(B, TT, D, bs, S)
    out = torch.empty_like(q)
    cp(q, k, v, idx, out)
    t_attn = graph_latency(lambda: kern(q, k, v, idx)) * 1e3
    t_copy = graph_latency(lambda: cp(q, k, v, idx, out)) * 1e3
    traffic = B * TT * (2 * 16 * D + 2 * S * bs * D) * 2 / 1e6
    print(f"oj12 B{B} T{TT} D{D} bs{bs} S{S}: attention {t_attn:7.1f}us  "
          f"pure-copy {t_copy:7.1f}us  traffic {traffic:.1f}MB  "
          f"copy-BW {traffic/t_copy*1000:.2f}TB/s  "
          f"attention/copy {t_attn/t_copy:.2f}x  "
          f"3TB/s target {traffic/3.0:.1f}us")
