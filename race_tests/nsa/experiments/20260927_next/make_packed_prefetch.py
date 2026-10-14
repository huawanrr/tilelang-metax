"""Compare synchronous grouped loads on the current packed attention path."""
import ast
import re
from pathlib import Path

root = Path(__file__).resolve().parents[2]
base = (root / 'experiments/20260927_oj_fix/nsa.py').read_text()
# Preserve the historical input snapshot, but omit its rejected host metadata write.
base = base.replace('    def get_kernel_source():\n        return pack.get_kernel_source() + attention.get_kernel_source()\n\n    run.get_kernel_source = get_kernel_source\n', '')
start = base.index('def native_sparse_attention_online_packed(')
end = base.index('\n\n@tilelang.jit', start)
original = base[start:end]
loop_start = original.index('            for s in T.unroll(S, unroll_factor=online_unroll):')
loop_end = original.index('\n            if dual_acc:', loop_start)
loop = original[loop_start:loop_end]
load_start = loop.index('                    for j, d in T.Parallel(BS, BK):')
compute_start = loop.index('                    if is_causal and i_s + BS > i_t + 1:')
loads = loop[load_start:compute_start]
compute = loop[compute_start:]

for depth in (2, 4):
    for mode in ('both', 'k'):
        p = original
        declarations = ''
        annotations = ''
        for slot in range(1, depth):
            for name, dim, emitter in [('K_reg', 'BK', 'qk'), ('V_reg', 'BV', 'pv')]:
                if mode == 'k' and name == 'V_reg':
                    continue
                declarations += f'            {name}{slot} = T.alloc_fragment([BS, {dim}], T.float16)\n'
                annotations += f'                {name}{slot}: {emitter}.make_mma_load_layout({name}{slot}, "B"),\n'
        p = p.replace('            acc_s = T.alloc_fragment', declarations + '            acc_s = T.alloc_fragment', 1)
        p = p.replace('                acc_s: qk.make_mma_store_layout(acc_s),', annotations + '                acc_s: qk.make_mma_store_layout(acc_s),', 1)

        def rename(text, slot):
            names = {'i_s': f'i_s{slot}', 's': f'(group * {depth} + {slot})'}
            if slot:
                names['K_reg'] = f'K_reg{slot}'
                if mode == 'both':
                    names['V_reg'] = f'V_reg{slot}'
            return re.sub(r'\b(' + '|'.join(names) + r')\b', lambda m: names[m.group()], text)

        v_start = loads.index('                    for j, d in T.Parallel(BS, BV):')
        early = loads if mode == 'both' else loads[:v_start]
        late = '' if mode == 'both' else loads[v_start:]
        body = f'            for group in T.serial(T.ceildiv(S, {depth})):\n'
        for slot in range(depth):
            body += f'                i_s{slot} = indices[T.min(group * {depth} + {slot}, S - 1)]\n'
        def guard(slot):
            return (f'                if (group * {depth} + {slot} < S and i_s{slot} >= 0 and i_s{slot} < seq_len\n'
                    f'                        and (not is_causal or i_s{slot} <= i_t)):\n')
        for slot in range(depth):
            body += guard(slot) + rename(early, slot)
        for slot in range(depth):
            body += guard(slot) + rename(late + compute, slot)
        p = p.replace(loop, body.rstrip() + '\n')
        source = base[:start] + p + base[end:]
        ast.parse(source)
        path = Path(__file__).with_name(f'packed_prefetch_{mode}{depth}.py')
        path.write_text(source)
        print(path)

source = Path(__file__).with_name('packed_prefetch_k4.py').read_text()
a = source.index('def native_sparse_attention_online_packed(')
b = source.index('\n\n@tilelang.jit', a)
p = source[a:b].replace('dual_acc=False,', 'dual_acc=False, prefetch_depth=4,', 1)
p = p.replace('T.ceildiv(S, 4)', 'T.ceildiv(S, prefetch_depth)').replace('group * 4', 'group * prefetch_depth')
for slot in range(4):
    p = p.replace(f'if (group * prefetch_depth + {slot} < S',
                  f'if (prefetch_depth > {slot} and group * prefetch_depth + {slot} < S')
Path(__file__).with_name('prefetch_parametric.py').write_text(source[:a] + p + source[b:])
