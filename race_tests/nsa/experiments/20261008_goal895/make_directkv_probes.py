import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()
TEMPLATE = (ROOT / 'directkv_template.py').read_text()

for natural in (False, True):
    for late in (False, True):
        source = BASE.replace('def _get_kernel(', TEMPLATE + '\n\ndef _get_kernel(', 1)
        branch = f'''        if mathcast_defaults and groups == 16 and S == 1 and D in (32, 64, 128) and block_size == 16 and seq_len % block_size == 0 and grid <= 2048:
            kernel = native_sparse_attention_direct_kv(natural={natural}, late={late}, **common)
        elif d32_compact:
'''
        assert source.count('        if d32_compact:\n') == 1
        source = source.replace('        if d32_compact:\n', branch)
        ast.parse(source)
        name = f'directkv_e{int(natural)}_late{int(late)}'
        (ROOT / (name + '.py')).write_text(source)
        print(name)
