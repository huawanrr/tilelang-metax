"""Preserve late normalization and overlap its sum with the first PV tile."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'baseline.py').read_text()
start = base.index('def native_sparse_attention_single_block_emitter(')
end = base.index('\n\n@tilelang.jit', start)
original = base[start:end]
norm_start = original.index('                    if lane_reduce:', original.index('                if late_normalize:'))
norm_end = original.index('                    for i, j in T.Parallel(G, BV):', norm_start)
reduce = original[norm_start:norm_end]
for width in (32, 64):
    source = (HERE / f'pv_tiles{width}.py').read_text()
    a = source.index('def native_sparse_attention_single_block_emitter(')
    b = source.index('\n\n@tilelang.jit', a)
    part = source[a:b].replace('    late_normalize = False\n', '', 1)
    key = '                        pv.mma(acc_s_cast, vb, acc_o, ki)\n'
    addition = '''                    if late_normalize:
                        if vo == 0:
'''
    addition += ''.join('        ' + line + '\n' for line in reduce.rstrip().splitlines())
    addition += '''                        for i, j in T.Parallel(G, VW):
                            acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])
'''
    assert part.count(key) == 1
    part = part.replace(key, key + addition)
    result = source[:a] + part + source[b:]
    ast.parse(result)
    (HERE / f'pv_tiles{width}_late.py').write_text(result)
