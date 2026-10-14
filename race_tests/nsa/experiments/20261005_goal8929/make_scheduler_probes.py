"""Use public JIT flags to test instruction scheduling on current hot kernels."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once
from make_small_candidate import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'
BUILDERS = ('native_sparse_attention_single_packed_qo_v2',
            'native_sparse_attention_online_packed_batch_minor_o_v2',
            'native_sparse_attention_online_packed_quad_batch_minor_o_v2',
            'native_sparse_attention_coalesced_blocks')


def main():
    baseline = BASE.read_text()
    rows = []
    for name, options in (
        ('mma', ['--metaxgpu-mma-sched=true']),
        ('postra', ['--metaxgpu-PostRA-Scheduler=true']),
        ('listall', ['--misched=metaxgpu-listall']),
    ):
        flags = [item for flag in options for item in ('-mllvm', flag)]
        source = baseline
        for builder in BUILDERS:
            old = extract(source, builder)
            new = replace_once(old, '@tilelang.jit(', f'@tilelang.jit(compile_flags={flags!r}, ')
            old_node, new_node = ast.parse(old).body[0], ast.parse(new).body[0]
            assert ast.dump(ast.Module(body=old_node.body, type_ignores=[])) == ast.dump(
                ast.Module(body=new_node.body, type_ignores=[]))
            source = replace_once(source, old, new)
        path = HERE / f'scheduler_{name}.py'
        with path.open('x') as f:
            f.write(source)
        rows.append(dict(path=path.name, flags=flags,
                         sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'scheduler_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=rows, builders=BUILDERS, bodies_and_safety_passes_unchanged=True,
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
