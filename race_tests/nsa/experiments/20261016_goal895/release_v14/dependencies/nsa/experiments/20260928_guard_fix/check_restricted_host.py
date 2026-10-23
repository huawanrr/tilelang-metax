"""Exercise submission host dispatch with RestrictedPython's real write guard.

The official triton_sandbox plugin is not installed. This focused harness keeps
TileLang JIT builders in their ordinary DSL environment and compiles all five host
functions with upstream RestrictedPython. Private helper names are consistently
renamed only to accommodate upstream's naming policy; attribute and item writes
are transformed by RestrictedPython, and full_write_guard is not relaxed.
"""
import ast
import builtins
import json
import sys
from pathlib import Path
from types import SimpleNamespace

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, '/tmp/nsa-restrictedpython-8.5')

import torch
from RestrictedPython import compile_restricted
from RestrictedPython.Eval import default_guarded_getiter, default_guarded_getitem
from RestrictedPython.Guards import (
    full_write_guard, guarded_iter_unpack_sequence, guarded_unpack_sequence,
    safe_builtins, safer_getattr,
)
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from verify_nsa import check_case, edge_indices

HOST_NAMES = {'_make_packed_attention', '_get_kernel', '_as_int32',
              'native_sparse_attention', 'run_kernel'}


def normalized(name):
    return 'host' + name if name.startswith('_') else name


class HostNames(ast.NodeTransformer):
    def visit_Name(self, node):
        node.id = normalized(node.id)
        return node

    def visit_FunctionDef(self, node):
        node.name = normalized(node.name)
        return self.generic_visit(node)


def guarded_module(path):
    ordinary = load_module(path)
    tree = ast.parse(Path(path).read_text())
    nodes = [n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name in HOST_NAMES]
    cache = ast.parse('_KERNEL_CACHE = {}').body
    host = ast.fix_missing_locations(HostNames().visit(ast.Module(body=cache + nodes, type_ignores=[])))
    source = ast.unparse(host)
    code = compile_restricted(source, filename=str(path), mode='exec')
    allowed_builtins = dict(safe_builtins)
    for name in ('dict', 'tuple', 'list', 'len', 'min', 'max', 'bool'):
        allowed_builtins[name] = getattr(builtins, name)
    env = {normalized(name): value for name, value in vars(ordinary).items()
           if not name.startswith('__')}
    env.update({
        '__builtins__': allowed_builtins,
        '_write_': full_write_guard,
        '_getattr_': safer_getattr,
        '_getitem_': default_guarded_getitem,
        '_getiter_': default_guarded_getiter,
        '_iter_unpack_sequence_': guarded_iter_unpack_sequence,
        '_unpack_sequence_': guarded_unpack_sequence,
        '_apply_': lambda fn, *args, **kwargs: fn(*args, **kwargs),
    })
    exec(code, env)
    return SimpleNamespace(native_sparse_attention=env['native_sparse_attention'],
                           run_kernel=env['run_kernel'])


def exception_chain(exc):
    messages = []
    while exc is not None:
        messages.append(f'{type(exc).__name__}: {exc}')
        exc = exc.__cause__ or exc.__context__
    return messages


small = dict(B=1, SEQ_LEN=37, H=2, HQ=32, D=64, S=8, block_size=16, is_causal=False)
rejected = []
for path in ('experiments/20260928_guard_fix/rejected_current_submission.py',
             'experiments/20260928_guard_fix/rejected_next_submission.py'):
    module = guarded_module(path)
    q, k, v, idx = make_inputs(small, seed=28)
    try:
        module.run_kernel(q, k, v, idx, torch.empty_like(q), 1, 37, 2, 32, 64, 8, 16, False, None)
    except (TypeError, AttributeError) as exc:
        chain = exception_chain(exc)
        assert any('__guarded_setattr__' in message for message in chain), chain
        rejected.append(dict(module=path, expected_rejection=True, exceptions=chain))
        print('REPRODUCED', path, chain, flush=True)
    else:
        raise AssertionError('Old source must fail under the actual write guard')

rows = []
refresh = []
cases = [small,
    dict(B=4, SEQ_LEN=1024, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
    dict(B=1, SEQ_LEN=256, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
    dict(B=1, SEQ_LEN=37, H=2, HQ=32, D=64, S=2, block_size=16, is_causal=True),
    dict(B=1, SEQ_LEN=37, H=2, HQ=32, D=64, S=4, block_size=16, is_causal=False),
    dict(B=1, SEQ_LEN=64, H=1, HQ=16, D=32, S=1, block_size=16, is_causal=True),
    dict(B=1, SEQ_LEN=1024, H=1, HQ=16, D=64, S=1, block_size=16, is_causal=True),
    dict(B=2, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
]
for path in ('submission.py', 'experiments/20260927_next/submission.py'):
    module = guarded_module(path)
    for case in cases:
        error = check_case(module, case, 28, None, edge_indices if case['SEQ_LEN'] == 37 else None)
        row = dict(module=path, config=case, max_abs_error=error, status='PASS')
        rows.append(row)
        print(row, flush=True)
    q, k, v, idx = make_inputs(small, seed=28)
    idx = edge_indices(idx)
    factory = module.native_sparse_attention(1, 32, 37, 64, False, scale=None,
        block_size=16, groups=16, selected_blocks=8)
    output = torch.empty_like(q)
    for iteration in range(3):
        if iteration:
            nq, nk, nv, _ = make_inputs(small, seed=28 + iteration)
            q.copy_(nq); k.copy_(nk); v.copy_(nv)
        expected = sparse_reference(q, k, v, idx, 16, False, None)
        error = check_output(factory(q, k, v, idx), expected, 'guarded factory refresh')
        module.run_kernel(q, k, v, idx, output, 1, 37, 2, 32, 64, 8, 16, False, None)
        error = max(error, check_output(output, expected, 'guarded run_kernel refresh'))
        refresh.append(dict(module=path, iteration=iteration, max_abs_error=error, status='PASS'))

Path(__file__).with_name('restricted_host.json').write_text(json.dumps(
    dict(restrictedpython='8.5', official_sandbox=False, reproduced=rejected,
         warmups=rows, refresh=refresh), indent=2)+'\n')
print(f'PASS: {len(rejected)} expected rejections, {len(rows)} guarded warmup cases '
      f'and {len(refresh)} refreshes; both interfaces', flush=True)
