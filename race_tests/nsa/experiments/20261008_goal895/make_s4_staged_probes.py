import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()
TEMPLATE = (ROOT / 's4_staged_template.py').read_text()

for reuse, linear in ((False, False), (False, True), (True, False)):
    source = BASE.replace('def _get_kernel(', TEMPLATE + '\n\ndef _get_kernel(', 1)
    branch = f'''        if mathcast_defaults and groups == 16 and S == 4 and D == 64 and block_size == 16 and seq_len % block_size == 0:
            kernel = native_sparse_attention_s4_staged(selected_blocks=S, reuse={reuse}, linear_v={linear}, **common)
        elif d32_compact:
'''
    source = source.replace('        if d32_compact:\n', branch, 1)
    ast.parse(source)
    name = f's4_staged_r{int(reuse)}_linear{int(linear)}'
    (ROOT / (name + '.py')).write_text(source)
    print(name)
