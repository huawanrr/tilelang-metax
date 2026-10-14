"""Probe compiler residency hints and register allocation through the public JIT API."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/submission.py'
NAMES = {
    'native_sparse_attention_single_packed_qo_v2',
    'native_sparse_attention_online_packed',
    'native_sparse_attention_online_packed_batch_minor_o_v2',
    'native_sparse_attention_online_packed_quad_batch_minor_o_v2',
    'native_sparse_attention_coalesced_blocks',
    'native_sparse_attention_coalesced_qo',
}


def main():
    original = BASE.read_text()
    before = ast.parse(original)
    records = []
    options = [(f'residency_{p}', ['-mllvm', f'--metaxgpu-set-rp={p}'])
               for p in ('streaming', 'persisting', 'noreuse')]
    options += [(f'registers_{n}', ['-mllvm', f'--max-mtreg-number={n}'])
                for n in (64, 56, 96)]
    for name, flags in options:
        lines = original.splitlines(keepends=True)
        for node in before.body:
            if isinstance(node, ast.FunctionDef) and node.name in NAMES:
                decorator = node.decorator_list[0]
                line = decorator.lineno - 1
                assert '@tilelang.jit(' in lines[line]
                lines[line] = lines[line].replace('@tilelang.jit(', f'@tilelang.jit(compile_flags={flags!r}, ', 1)
        source = ''.join(lines)
        tree = ast.parse(source)
        for node in tree.body:
            if isinstance(node, ast.FunctionDef) and node.name in NAMES:
                node.decorator_list[0].keywords = [k for k in node.decorator_list[0].keywords if k.arg != 'compile_flags']
        assert ast.dump(tree) == ast.dump(before)
        path = HERE / f'{name}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, flags=flags, sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'resource_probes_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=records,
        identical_math_layouts_guards_sync_and_dispatch=True, packing_unchanged=True,
        reason='Measure cache eviction hints and register allocation; do not change cache coherency or synchronization.'), indent=2) + '\n')


if __name__ == '__main__':
    main()
