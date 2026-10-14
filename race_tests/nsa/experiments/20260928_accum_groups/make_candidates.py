"""Compare four/eight independent PV accumulators with the next packed path."""
import ast
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
a = base.index('def native_sparse_attention_online_packed(')
b = base.index('\n\n@tilelang.jit', a)
original = base[a:b]
for count in (4, 8):
    names = ['acc_o'] + [f'acc_o_{i}' for i in range(1, count)]
    part = original.replace('            acc_o_alt = T.alloc_fragment([G, BV], T.float32)',
        '\n'.join(f'            {name} = T.alloc_fragment([G, BV], T.float32)' for name in names[1:]), 1)
    part = part.replace('                acc_o_alt: pv.make_mma_store_layout(acc_o_alt),',
        '\n'.join(f'                {name}: pv.make_mma_store_layout({name}),' for name in names[1:]), 1)
    part = part.replace('''            if dual_acc:
                T.fill(acc_o_alt, 0)''', '\n'.join(f'            T.fill({name}, 0)' for name in names[1:]), 1)
    pattern = (r'(?m)^([ \t]*)if dual_acc and (.*?) % 2 != 0:\n'
               r'\1    pv\.mma\(acc_s_cast, V_reg, acc_o_alt, ki\)\n'
               r'\1else:\n\1    pv\.mma\(acc_s_cast, V_reg, acc_o, ki\)')
    def replace(match):
        indent, index = match[1], match[2]
        lines = []
        for i, name in enumerate(names):
            branch = ('if' if i == 0 else 'elif') + f' {index} % {count} == {i}:' if i < count - 1 else 'else:'
            lines += [indent + branch, indent + f'    pv.mma(acc_s_cast, V_reg, {name}, ki)']
        return '\n'.join(lines)
    part, matches = re.subn(pattern, replace, part)
    assert matches == 5, matches
    part = part.replace('''            if dual_acc:
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] += acc_o_alt[i, j]''',
        '            for i, j in T.Parallel(G, BV):\n' + '\n'.join(f'                acc_o[i, j] += {name}[i, j]' for name in names[1:]), 1)
    assert 'acc_o_alt' not in part
    source = base[:a] + part + base[b:]
    ast.parse(source)
    name = f'pv_acc{count}.py'
    (HERE / name).write_text(source)
    print(name)
