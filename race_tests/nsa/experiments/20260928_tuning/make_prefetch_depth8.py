"""Probe a fully resident eight-block K window and explicit group unrolling."""
import ast
import re
from pathlib import Path

folder = Path(__file__).resolve().parent
base = (folder / 'baseline.py').read_text()
a = base.index('def native_sparse_attention_online_packed(')
b = base.index('\n\n@tilelang.jit', a)
original = base[a:b]

def unroll(p):
    return p.replace('for group in T.serial(T.ceildiv(S, prefetch_depth)):',
                     'for group in T.unroll(T.ceildiv(S, prefetch_depth)):')

def depth8(p):
    decl = ''.join(f'            K_reg{i} = T.alloc_fragment([BS, BK], T.float16)\n' for i in range(4, 8))
    anno = ''.join(f'                K_reg{i}: qk.make_mma_load_layout(K_reg{i}, "B"),\n' for i in range(4, 8))
    p = p.replace('            acc_s = T.alloc_fragment', decl + '            acc_s = T.alloc_fragment', 1)
    p = p.replace('                acc_s: qk.make_mma_store_layout(acc_s),', anno + '                acc_s: qk.make_mma_store_layout(acc_s),', 1)
    original_index = '                    i_s3 = indices[T.min(group * prefetch_depth + 3, S - 1)]\n'
    p = p.replace(original_index, original_index + ''.join(original_index.replace('i_s3', f'i_s{i}').replace('+ 3,', f'+ {i},') for i in range(4, 8)))
    guard0 = '                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S'
    guard3 = '                    if (prefetch_depth > 3 and group * prefetch_depth + 3 < S'
    lo = p.index(guard3)
    hi = p.index(guard0, lo)
    load = p[lo:hi]
    lo2 = p.index(guard3, hi)
    hi2 = p.index('\n            if dual_acc:', lo2)
    compute = p[lo2:hi2]
    def rename(text, i):
        return text.replace('prefetch_depth > 3', f'prefetch_depth > {i}').replace('prefetch_depth + 3', f'prefetch_depth + {i}').replace('i_s3', f'i_s{i}').replace('K_reg3', f'K_reg{i}')
    p = p[:hi2] + ''.join(rename(compute, i) for i in range(4, 8)) + p[hi2:]
    p = p[:hi] + ''.join(rename(load, i) for i in range(4, 8)) + p[hi:]
    return p

for name, p, eight in [('prefetch_unroll', unroll(original), False),
                        ('prefetch8', depth8(original), True),
                        ('prefetch8_unroll', unroll(depth8(original)), True)]:
    src = base[:a] + p + base[b:]
    if eight:
        old = '''    if S == 8 and use_emitter_online:
        if grid <= 512 or 2048 <= grid < 4096:
            prefetch_depth = 2
        elif grid >= 4096:
            prefetch_depth = 4'''
        assert src.count(old) == 1
        src = src.replace(old, '''    if S == 8 and use_emitter_online:
        prefetch_depth = 8''')
    ast.parse(src)
    (folder / f'{name}.py').write_text(src)
