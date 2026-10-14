"""Compare transposed dot products and output stores with the fixed next source."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
template = (HERE / 'template.py').read_text()
for late in (False, True):
    source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + template + '\n\n_KERNEL_CACHE = {}', 1)
    a = source.index('def _get_kernel(')
    host = source[a:].replace('''        if S == 1 and use_emitter:
''', f'''        if S == 1 and groups == 16 and D == 128 and block_size == 32 and threads == 64:
            kernel = single_transposed(B, seq_len, H, D, block_size, is_causal, scale_log2, late={late})
        elif S == 1 and use_emitter:
''', 1)
    source = source[:a] + host
    ast.parse(source)
    name = 'transposed_' + ('late' if late else 'early') + '.py'
    (HERE / name).write_text(source)
    print(name)
