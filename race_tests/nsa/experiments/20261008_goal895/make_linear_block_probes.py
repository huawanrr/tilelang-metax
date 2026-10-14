"""Combine guarded D128 block loads with the new conversion sequences."""
import ast
from pathlib import Path

from make_cast_probes import Convert

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()
OLD = (ROOT.parent / '20261003_d128_v1/nsa.py').read_text()
NAME = 'native_sparse_attention_linear_v_blocks'

for label, probability, output, exponent in (
    ('control', False, False, False),
    ('output', False, True, False),
    ('both', True, True, False),
    ('exp', True, True, True),
):
    fn = next(n for n in ast.parse(OLD).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
    fn = Convert(probability, output, exponent).visit(fn)
    ast.fix_missing_locations(fn)
    source = BASE.replace('def _get_kernel(', ast.unparse(fn) + '\n\ndef _get_kernel(', 1)
    branch = '''        if mathcast_defaults and groups == 16 and S == 1 and D == 128 and block_size == 16 and seq_len % block_size == 0 and 128 < grid < 1280:
            kernel = native_sparse_attention_linear_v_blocks(
                late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif d32_compact:
'''
    assert source.count('        if d32_compact:\n') == 1
    source = source.replace('        if d32_compact:\n', branch)
    ast.parse(source)
    (ROOT / f'd128_blocks_{label}.py').write_text(source)
    print(label)
