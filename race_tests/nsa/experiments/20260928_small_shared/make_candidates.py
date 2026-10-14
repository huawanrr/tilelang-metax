"""Reuse a 2/4 KiB shared tile across QK and PV feature slices."""
import ast
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
template = (HERE / 'template.py').read_text()
for width in (32, 64):
    part = template
    a = part.index('                for kt in T.unroll(D // W):')
    b = part.index('                for i, j in T.Parallel(G, BS):', a)
    body = part[a:b].split('\n', 1)[1]
    body = '\n'.join(line[4:] if line.startswith('    ') else line for line in body.split('\n'))
    part = part[:a] + ''.join(re.sub(r'\bkt\b', str(tile), body) for tile in range(128 // width)) + part[b:]
    a = part.index('            for vo in T.unroll(D // W):')
    b = part.index('    return kernel', a)
    body = part[a:b].split('\n', 1)[1]
    body = '\n'.join(line[4:] if line.startswith('    ') else line for line in body.split('\n'))
    part = part[:a] + ''.join(re.sub(r'\bvo\b', str(tile), body) for tile in range(128 // width)) + part[b:]
    source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + part + '\n\n_KERNEL_CACHE = {}', 1)
    a = source.index('def _get_kernel(')
    host = source[a:].replace('''        if S == 1 and use_emitter:
''', f'''        if S == 1 and use_emitter and D == 128 and block_size == 32:
            kernel = single_small_shared(B, seq_len, H, D, block_size, is_causal, scale_log2, width={width})
        elif S == 1 and use_emitter:
''', 1)
    source = source[:a] + host
    ast.parse(source)
    name = f'shared{width}.py'
    (HERE / name).write_text(source)
    print(name)
