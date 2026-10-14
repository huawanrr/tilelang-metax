"""Balance synchronous K/V lookahead on the existing large-grid S8 kernels."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once
from make_small_candidate import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'
BUILDERS = ('native_sparse_attention_online_packed_batch_minor_o_v2',
            'native_sparse_attention_online_packed_quad_batch_minor_o_v2')


def region(source, node):
    return ''.join(source.splitlines(keepends=True)[node.lineno-1:node.end_lineno])


def schedule(fn, depth, values):
    tree = ast.parse(fn)
    changes = []
    for i in range(values):
        variable = f'i_s{i}'
        # The first guard loads K; the second guard loads V and does the math.
        guards = [n for n in ast.walk(tree) if isinstance(n, ast.If)
                  and isinstance(n.body[0], ast.For)
                  and variable in ast.unparse(n.test)
                  and 'prefetch_depth' in ast.unparse(n.test)]
        assert len(guards) == 2, (variable, len(guards))
        guards.sort(key=lambda n: n.lineno)
        k_guard, compute = guards
        v_load = region(fn, compute.body[0])
        assert 'V_reg[j, d] = V[' in v_load
        v_name = 'V_reg' if i == 0 else f'V_reg{i}'
        moved = v_load.replace('V_reg[', v_name + '[')
        k_old = region(fn, k_guard)
        compute_old = region(fn, compute)
        compute_new = replace_once(compute_old, v_load, '')
        compute_new = compute_new.replace('pv.mma(acc_s_cast, V_reg,',
                                           f'pv.mma(acc_s_cast, {v_name},')
        changes += [(k_old, k_old + moved), (compute_old, compute_new)]
    for old, new in changes:
        fn = replace_once(fn, old, new)
    for i in range(1, values):
        fn = replace_once(fn, '            V_reg = T.alloc_fragment([BS, BV], T.float16)\n',
            '            V_reg = T.alloc_fragment([BS, BV], T.float16)\n'
            f'            V_reg{i} = T.alloc_fragment([BS, BV], T.float16)\n')
        fn = replace_once(fn, '                V_reg: pv.make_mma_load_layout(V_reg, "B"),\n',
            '                V_reg: pv.make_mma_load_layout(V_reg, "B"),\n'
            f'                V_reg{i}: pv.make_mma_load_layout(V_reg{i}, "B"),\n')
    fn = replace_once(fn, '    S = selected_blocks\n',
                       f'    S = selected_blocks\n    prefetch_depth = {depth}\n')
    ast.parse(fn)
    return fn


def main():
    baseline = BASE.read_text()
    records = []
    for depth, values in ((2, 2), (4, 2), (4, 4)):
        source = baseline
        for name in BUILDERS:
            old = extract(source, name)
            source = replace_once(source, old, schedule(old, depth, values))
        path = HERE / f's8_k{depth}_v{values}_lookahead.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, k_lookahead=depth, v_lookahead=values,
            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 's8_value_lookahead_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, synchronous_only=True,
        math_and_packing='Unchanged from baseline, including accumulator association.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
