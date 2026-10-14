@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})
def native_sparse_attention_pack_kv_bs32_wave_groups(batch, seq_len, heads, dim, block_size, mode=0):
    """Group independent 16x64 rearrangements into a CTA, retaining wave fences."""
    assert dim == 128 and block_size == 32 and mode in (0, 1, 2)
    WR, WC = ((1, 2), (2, 1), (2, 2))[mode]
    BJ, DD, NT = 16 * WR, 64 * WC, 64 * WR * WC
    BS, D = block_size, dim
    NR, NC = BS // BJ, D // DD

    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D // 32, BS // 16, 64, 8], T.float16),
        Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS // 16, D // 32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS) * NR * NC, heads, batch, threads=NT) as (bx, h, b):
            bs, split = bx // (NR * NC), bx % (NR * NC)
            jbase, dbase = split // NC * BJ, split % NC * DD
            ktile = T.alloc_fragment([BJ, DD], T.float16)
            vtile = T.alloc_fragment([BJ, DD], T.float16)
            pk = T.alloc_fragment([BJ, DD], T.float16)
            pv = T.alloc_fragment([BJ, DD], T.float16)
            ks = T.alloc_shared([BJ, DD], T.float16)
            vs = T.alloc_shared([BJ, DD], T.float16)
            T.annotate_layout({
                ktile: T.Fragment([BJ, DD],
                    forward_thread_fn=lambda j, d: (j // 16 * WC + d // 64) * 64 + (j % 16 * 64 + d % 64) // 8 % 64,
                    forward_index_fn=lambda j, d: (j % 16 * 64 + d % 64) // 512 * 8 + d % 8),
                vtile: T.Fragment([BJ, DD],
                    forward_thread_fn=lambda j, d: (j // 16 * WC + d // 64) * 64 + (j % 16 * 64 + d % 64) // 8 % 64,
                    forward_index_fn=lambda j, d: (j % 16 * 64 + d % 64) // 512 * 8 + d % 8),
                pk: T.Fragment([BJ, DD],
                    forward_thread_fn=lambda j, d: (j // 16 * WC + d // 64) * 64 + d % 32 // 8 * 16 + j % 16,
                    forward_index_fn=lambda j, d: d % 64 // 32 * 8 + d % 8),
                pv: T.Fragment([BJ, DD],
                    forward_thread_fn=lambda j, d: (j // 16 * WC + d // 64) * 64 + j % 16 // 4 * 16 + d % 16,
                    forward_index_fn=lambda j, d: d % 64 // 32 * 8 + d % 32 // 16 * 4 + j % 4),
                ks: T.Layout([BJ, DD], lambda j, d:
                    (j // 16 * WC + d // 64) * 1024 + j % 16 * 64 + (d % 64 // 8 ^ j % 8) * 8 + d % 8),
                vs: T.Layout([BJ, DD], lambda j, d:
                    (j // 16 * WC + d // 64) * 1024 + j % 16 * 64 + (d % 64 // 4 ^ j % 16) * 4 + d % 4),
            })
            T.copy(K[b, bs * BS + jbase:bs * BS + jbase + BJ, h, dbase:dbase + DD], ktile)
            T.copy(V[b, bs * BS + jbase:bs * BS + jbase + BJ, h, dbase:dbase + DD], vtile)
            T.copy(ktile, ks)
            T.copy(vtile, vs)
            T.sync_warp()
            T.copy(ks, pk)
            T.copy(vs, pv)
            for j, d in T.Parallel(BJ, DD):
                PackedK[b, bs, h, (dbase + d) // 32, (jbase + j) // 16,
                        (dbase + d) % 32 // 8 * 16 + (jbase + j) % 16, (dbase + d) % 8] = pk[j, d]
            for j, d in T.Parallel(BJ, DD):
                Packed[b, bs, h, (jbase + j) // 16, (dbase + d) // 32,
                       (jbase + j) % 16 // 4 * 16 + (dbase + d) % 16,
                       (dbase + d) % 32 // 16 * 4 + (jbase + j) % 4] = pv[j, d]
    return kernel
