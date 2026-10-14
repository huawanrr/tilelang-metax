"""Build a limited S8 schedule trial; preserve every original GPU builder."""
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
assert hashlib.sha256(base.encode()).hexdigest() == '311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26'
new = []
for filename, suffix in [('batch_minor.py', 'batch_minor'), ('quad_batch_minor.py', 'quad_batch_minor')]:
    source = (ROOT / 'experiments/20260928_grid_order' / filename).read_text()
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
                and n.name == 'native_sparse_attention_online_packed')
    lines = source.splitlines(keepends=True)
    text = ''.join(lines[node.decorator_list[0].lineno - 1:node.end_lineno])
    text = text.replace('def native_sparse_attention_online_packed(',
                        'def native_sparse_attention_online_packed_' + suffix + '(', 1)
    new.append(text)
source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + '\n\n'.join(new) + '\n\n_KERNEL_CACHE = {}', 1)
a = source.index('def _get_kernel(')
host = source[a:]
old = '''            attention = native_sparse_attention_online_packed(
                selected_blocks=S, online_unroll=online_unroll,
                dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)'''
assert old in host
replacement = '''            if S == 8 and grid >= 8192:
                attention = native_sparse_attention_online_packed_quad_batch_minor(
                    selected_blocks=S, online_unroll=online_unroll,
                    dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)
            elif S == 8 and grid >= 4096:
                attention = native_sparse_attention_online_packed_batch_minor(
                    selected_blocks=S, online_unroll=online_unroll,
                    dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)
            else:
                attention = native_sparse_attention_online_packed(
                    selected_blocks=S, online_unroll=online_unroll,
                    dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)'''
host = host.replace(old, replacement, 1)
source = source[:a] + host
ast.parse(source)
(HERE / 'nsa.py').write_text(source)
print('nsa.py', hashlib.sha256(source.encode()).hexdigest())
