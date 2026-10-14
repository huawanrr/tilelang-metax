"""Use MMA with a constant-one operand for the packed path's denominator."""
import ast
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
a = base.index('def native_sparse_attention_online_packed(')
b = base.index('\n\n@tilelang.jit', a)
original = base[a:b]
for position in ('before', 'after'):
    part = original
    part = part.replace('    qk_steps = ', '''    psum = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=G, warp_col_tiles=16, chunk=BS, k_pack=1)
    qk_steps = ''', 1)
    part = part.replace('            sum_acc = T.alloc_fragment([G, BS], T.float32)', '''            acc_den = T.alloc_fragment([G, 16], T.float32)
            acc_den_alt = T.alloc_fragment([G, 16], T.float32)
            unit = T.alloc_local([4], T.float16)''', 1)
    part = part.replace('                acc_o_alt: pv.make_mma_store_layout(acc_o_alt),', '''                acc_o_alt: pv.make_mma_store_layout(acc_o_alt),
                acc_den: psum.make_mma_store_layout(acc_den),
                acc_den_alt: psum.make_mma_store_layout(acc_den_alt),''', 1)
    part = part.replace('            T.fill(sum_acc, 0)', '''            T.fill(acc_den, 0)
            if dual_acc:
                T.fill(acc_den_alt, 0)
            T.fill(unit, 1)''', 1)
    part, count = re.subn(r'(?m)^([ \t]*)for i, j in T\.Parallel\(G, BS\):\n\1    sum_acc\[i, j\] \+= acc_s\[i, j\]\n', '', part)
    assert count == 5, count
    for out, den in [('acc_o_alt', 'acc_den_alt'), ('acc_o', 'acc_den')]:
        old = rf'(?m)^([ \t]*)pv\.mma\(acc_s_cast, V_reg, {out}, ki\)$'
        def insert(match):
            indent = match[1]
            extra = indent + f'psum.mma(acc_s_cast, unit, {den}, ki)'
            return (extra + '\n' + match[0]) if position == 'before' else (match[0] + '\n' + extra)
        part, count = re.subn(old, insert, part)
        assert count == 5, (out, count)
    final_a = part.index('            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)')
    final_b = part.index('\n            T.copy(acc_o, Output[', final_a)
    part = part[:final_a] + '''            if dual_acc:
                for i, j in T.Parallel(G, 16):
                    acc_den[i, j] += acc_den_alt[i, j]
            for i, j in T.Parallel(G, BV):
                value = acc_den[i, j % 16 // 4 * 4]
                acc_o[i, j] *= T.if_then_else(value > 0, 1.0 / value, 0.0)
''' + part[final_b:]
    assert 'sum_acc' not in part
    source = base[:a] + part + base[b:]
    ast.parse(source)
    name = f'tensor_sum_{position}.py'
    (HERE / name).write_text(source)
    print(name)
