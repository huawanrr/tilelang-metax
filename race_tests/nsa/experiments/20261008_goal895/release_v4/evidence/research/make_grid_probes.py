"""Change only CTA traversal of the current large single-block kernels."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()
TARGETS = {
    '_coalesced_block_loads_prim_mathcast',
    'native_sparse_attention_single_packed_qo_v2_mathcast',
}


def make(mode, group):
    source_lines = BASE.splitlines(keepends=True)
    edits = []
    for fn in ast.parse(BASE).body:
        if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
            continue
        start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
        end = fn.end_lineno
        prim = next(n for n in fn.body if isinstance(n, ast.FunctionDef) and n.name == 'kernel')
        with_node = prim.body[0]
        assert isinstance(with_node, ast.With)
        launch = ast.parse('with T.Kernel(seq_len * batch * (heads // groups), threads=threads) as (flat,):\n    pass').body[0]
        setup = ast.parse(f'order_group = {group} if seq_len % {group} == 0 else 1').body
        if mode == 'batch':
            setup += ast.parse('''
ordered_token = flat // (order_group * (batch * (heads // groups))) * order_group + flat % order_group
ordered_bh = flat // order_group % (batch * (heads // groups))
''').body
        elif mode == 'stripe':
            setup += ast.parse('''
ordered_token = (flat % seq_len) % order_group * (seq_len // order_group) + (flat % seq_len) // order_group
ordered_bh = flat // seq_len
''').body
        else:
            setup += ast.parse('''
ordered_token = seq_len - 1 - flat % seq_len
ordered_bh = flat // seq_len
''').body
        if fn.name.startswith('_coalesced'):
            setup += ast.parse('bx, by, bz = ordered_token, 0, ordered_bh').body
        else:
            setup += ast.parse('token, bh = ordered_token, ordered_bh').body
        launch.body = setup + with_node.body
        prim.body[0] = launch
        ast.fix_missing_locations(fn)
        edits.append((start, end, ast.unparse(fn) + '\n'))
    assert len(edits) == 2
    for start, end, value in reversed(edits):
        source_lines[start:end] = [value]
    source = ''.join(source_lines)
    ast.parse(source)
    name = f'grid_{mode}_{group}'
    (ROOT / (name + '.py')).write_text(source)
    print(name)


for group in (1, 4, 16, 64):
    make('batch', group)
for group in (4, 16):
    make('stripe', group)
make('reverse', 1)
