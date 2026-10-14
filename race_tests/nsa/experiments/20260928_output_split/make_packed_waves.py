"""Group independent packed-attention queries into waves of one CTA."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'baseline.py').read_text()
start = base.index('def native_sparse_attention_online_packed(')
end = base.index('\n\n@tilelang.jit', start)
for waves in (2, 4, 8):
    part = base[start:end]
    part = part.replace('    qk, pv = _emitters(T.float16, T.float32, BS, BK)', f'''    NW = {waves}
    M = NW * G
    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=BK, k_pack=2)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BV, chunk=BS, k_pack=1)''')
    part = part.replace('T.Kernel(seq_len,', 'T.Kernel(T.ceildiv(seq_len, NW),')
    part = part.replace('threads=threads)', 'threads=64 * NW)')
    part = part.replace('T.alloc_fragment([G,', 'T.alloc_fragment([M,')
    part = part.replace('T.alloc_fragment([G]', 'T.alloc_fragment([M]')
    part = part.replace('T.alloc_fragment([BS,', 'T.alloc_fragment([NW, BS,')
    for name in ('K_reg', 'K_reg1', 'K_reg2', 'K_reg3'):
        part = part.replace(f'{name}: qk.make_mma_load_layout({name}, "B")', f'''{name}: T.Fragment([NW, BS, BK],
                    forward_thread_fn=lambda w, j, d: w * 64 + (d % 32 // 8) * 16 + j % 16,
                    forward_index_fn=lambda w, j, d: (d // 32 * (BS // 16) + j // 16) * 8 + d % 8)''')
        part = part.replace(name + '[j, d]', name + '[w, j, d]')
    part = part.replace('V_reg: pv.make_mma_load_layout(V_reg, "B")', '''V_reg: T.Fragment([NW, BS, BV],
                    forward_thread_fn=lambda w, j, d: w * 64 + (j % 16 // 4) * 16 + d % 16,
                    forward_index_fn=lambda w, j, d: (j // 16 * (BV // 32) + d // 32) * 8 + (d % 32 // 16) * 4 + j % 4)''')
    part = part.replace('V_reg[j, d]', 'V_reg[w, j, d]')
    part = part.replace('for j, d in T.Parallel(BS,', 'for w, j, d in T.Parallel(NW, BS,')
    part = part.replace('i_t, i_v, i_bh = bx, by, bz', '''wave = T.get_thread_binding() // 64
            i_t, i_v, i_bh = bx * NW + wave, by, bz''')
    part = part.replace('indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS', '''indices[si] = T.if_then_else(i_t < seq_len,
                    BlockIndices[i_b, i_t, i_h, si] * BS, -BS)''')
    part = part.replace('T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)', '''for m, d in T.Parallel(M, BK):
                Q_reg[m, d] = Q[i_b, bx * NW + m // G, i_h * G + m % G, d]''')
    part = part.replace('T.Parallel(G,', 'T.Parallel(M,').replace('T.Parallel(G)', 'T.Parallel(M)')
    part = part.replace('''            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])''', '''            for m, d in T.Parallel(M, BV):
                Output[i_b, bx * NW + m // G, i_h * G + m % G, i_v * BV + d] = acc_o[m, d]''')
    result = base[:start] + part + base[end:]
    ast.parse(result)
    (HERE / f'packed_waves{waves}.py').write_text(result)
