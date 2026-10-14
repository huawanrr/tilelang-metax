"""Compute and write smaller PV output tiles within the original query CTA."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'baseline.py').read_text()
start = base.index('def native_sparse_attention_single_block_emitter(')
end = base.index('\n\n@tilelang.jit', start)
for width in (16, 32, 64):
    part = base[start:end]
    part = part.replace('    head_kv = heads // groups', '    late_normalize = False\n    head_kv = heads // groups', 1)
    part = part.replace('    qk, pv = _emitters(T.float16, T.float32, BS, BK)', f'''    VW = min({width}, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)''')
    part = part.replace('acc_o = T.alloc_fragment([G, BV]', 'acc_o = T.alloc_fragment([G, VW]')
    a = part.index('                vb = T.alloc_local(')
    b = part.index('\n    return kernel', a)
    part = part[:a] + '''
            vb = T.alloc_local(
                [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                    for ki in T.serial(pv_steps):
                        pv.ldmatrix_b(vb, V_shared[0:BS, vo * VW:(vo + 1) * VW], ki)
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                T.copy(acc_o, Output[
                    i_b, i_t, i_h * G : (i_h + 1) * G,
                    i_v * BV + vo * VW : i_v * BV + (vo + 1) * VW])
''' + part[b:]
    result = base[:start] + part + base[end:]
    ast.parse(result)
    (HERE / f'pv_tiles{width}.py').write_text(result)
