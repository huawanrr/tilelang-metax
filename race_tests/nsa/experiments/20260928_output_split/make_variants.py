"""Reproducible S1 output-dimension split probes; leave both OJ sources intact."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
(HERE / 'baseline.py').write_text(base)
start = base.index('def native_sparse_attention_single_block_emitter(')
end = base.index('\n\n@tilelang.jit', start)
for width in (32, 64):
    part = base[start:end]
    part = part.replace('    qk, pv = _emitters(T.float16, T.float32, BS, BK)', f'''    BV = {width} if dim == 128 else BV
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BV, chunk=BS, k_pack=1)''')
    part = part.replace('T.copy(V_reg, V_shared)', 'T.copy(V_reg, V_shared[0:BS, 0:BV])')
    part = part.replace('T.copy(V_reg, KV_shared)', 'T.copy(V_reg, KV_shared[0:BS, 0:BV])')
    part = part.replace('pv.ldmatrix_b(vb, V_shared, ki)', 'pv.ldmatrix_b(vb, V_shared[0:BS, 0:BV], ki)')
    result = base[:start] + part + base[end:]
    ast.parse(result)
    (HERE / f'split{width}.py').write_text(result)
