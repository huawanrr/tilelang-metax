@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def native_sparse_attention_pack_register(batch, seq_len, heads, dim, block_size, threads=128):
    """Pack current K/V with a lossless register transpose in each 64-lane wave."""
    BS, D = block_size, dim
    NW = threads // 64
    NT = BS // 16 * (D // 32)

    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D // 32, BS // 16, 64, 8], T.float16),
        PackedV: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS // 16, D // 32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=threads) as (block, h, b):
            tid = T.get_thread_binding()
            lane, wave = tid % 64, tid // 64
            k_half = T.alloc_local([8], T.float16)
            v_words = T.alloc_local([4], T.uint32)
            v_half = T.Tensor([8], T.float16, data=v_words.data, scope="local")
            for group in T.unroll(T.ceildiv(NT, NW), unroll_factor=1):
                tile = group * NW + wave
                row_tile, col_tile = tile // (D // 32), tile % (D // 32)
                if tile < NT:
                    row = block * BS + row_tile * 16 + lane // 4
                    for e in T.vectorized(8):
                        k_half[e] = T.if_then_else(row < seq_len,
                            K[b, row, h, col_tile * 32 + lane % 4 * 8 + e], T.float16(0))
                    for e in T.vectorized(8):
                        v_half[e] = T.if_then_else(row < seq_len,
                            V[b, row, h, col_tile * 32 + lane % 4 * 8 + e], T.float16(0))
                    for e in T.vectorized(8):
                        PackedK[b, block, h, col_tile, row_tile, lane % 4 * 16 + lane // 4, e] = k_half[e]

                    # Exchange the low halfword bit with lane bit 2.
                    for word in T.unroll(4):
                        own = v_words[word]
                        partner = T.shfl_xor(own, 4, 64, 0xffffffffffffffff)
                        v_words[word] = T.if_then_else((lane & 4) == 0,
                            (own & T.uint32(65535)) | (partner << 16),
                            (partner >> 16) | (own & T.uint32(4294901760)))
                    # Exchange word bit 0 with lane bit 3.
                    for pair in T.unroll(2):
                        lo = v_words[pair * 2]
                        hi = v_words[pair * 2 + 1]
                        partner = T.shfl_xor(T.if_then_else((lane & 8) == 0, hi, lo),
                                             8, 64, 0xffffffffffffffff)
                        v_words[pair * 2] = T.if_then_else((lane & 8) == 0, lo, partner)
                        v_words[pair * 2 + 1] = T.if_then_else((lane & 8) == 0, partner, hi)
                    # Exchange word bit 1 with lane bit 1.
                    for pair in T.unroll(2):
                        lo = v_words[pair]
                        hi = v_words[pair + 2]
                        partner = T.shfl_xor(T.if_then_else((lane & 2) == 0, hi, lo),
                                             2, 64, 0xffffffffffffffff)
                        v_words[pair] = T.if_then_else((lane & 2) == 0, lo, partner)
                        v_words[pair + 2] = T.if_then_else((lane & 2) == 0, partner, hi)
                    dest_lane = (lane & 48) | ((lane & 4) >> 2) | ((lane & 8) >> 2) | ((lane & 2) << 1) | ((lane & 1) << 3)
                    for e in T.vectorized(8):
                        PackedV[b, block, h, row_tile, col_tile, dest_lane, e] = v_half[e]
    return kernel
