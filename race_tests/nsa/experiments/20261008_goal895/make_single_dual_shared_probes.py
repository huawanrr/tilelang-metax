import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()
TEMPLATE = (ROOT / 'single_dual_shared_template.py').read_text()

for natural, linear in ((False, True), (True, True), (False, False)):
    source = BASE.replace('def _get_kernel(', TEMPLATE + '\n\ndef _get_kernel(', 1)
    branch = f'''        if mathcast_defaults and groups == 16 and S == 1 and D == 64 and block_size == 16 and seq_len % block_size == 0:
            kernel = native_sparse_attention_single_dual_shared(natural={natural}, linear_v={linear}, **common)
        elif d32_compact:
'''
    source = source.replace('        if d32_compact:\n', branch, 1)
    ast.parse(source)
    name = f'single_dual_shared_e{int(natural)}_l{int(linear)}'
    (ROOT / (name + '.py')).write_text(source)
    print(name)
