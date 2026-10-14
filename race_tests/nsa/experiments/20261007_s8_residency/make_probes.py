"""Explore Q lifetime and vector index loads on the existing large-S8 paths."""
import ast
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / 'experiments/20261002_mid_v1/nsa.py'
FUNCTIONS = ('native_sparse_attention_online_packed_batch_minor_o_v2',
             'native_sparse_attention_online_packed_quad_batch_minor_o_v2')


def once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def transform(fn, method, stage=False, width=0):
    if method == 'indices':
        old = ('            for si in T.unroll(S):\n'
               '                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS\n')
        new = (f'            for packet in T.unroll(S // {width}):\n'
               f'                for element in T.vectorized({width}):\n'
               f'                    indices[packet * {width} + element] = BlockIndices[\n'
               f'                        i_b, i_t, i_h, packet * {width} + element] * BS\n')
        return once(fn, old, new)
    allocation = '            Q_shared = T.alloc_shared([G, BK], T.float16)\n'
    if method == 'slice':
        allocation += '            qa = T.alloc_local([qk.warp_rows * qk.k_pack * qk.local_size_a], T.float16)\n'
    else:
        allocation += '            Q_reg = T.alloc_fragment([G, BK], T.float16)\n'
    if stage:
        allocation += '            Q_stage = T.alloc_fragment([G, BK], T.float16)\n'
    fn = once(fn, '            Q_reg = T.alloc_fragment([G, BK], T.float16)\n', allocation)
    layout = '                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),\n'
    if method == 'full':
        layout += '                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),\n'
    if stage:
        layout += ('                Q_stage: T.Fragment([G, BK],\n'
                   '                    forward_thread_fn=lambda i, d: (i * BK + d) // 8 % 64,\n'
                   '                    forward_index_fn=lambda i, d: (i * BK + d) // 512 * 8 + d % 8),\n')
    fn = once(fn, '                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),\n', layout)
    old = '            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)\n'
    dest = 'Q_stage' if stage else 'Q_shared'
    new = f'            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], {dest})\n'
    if stage:
        new += '            T.copy(Q_stage, Q_shared)\n'
    new += '            T.sync_warp()\n'
    fn = once(fn, old, new)
    pattern = re.compile(r'(?m)^( +)for ki in T.serial\(qk_steps\):\n +qk.mma\(Q_reg, (K_reg[0-3]?), acc_s, ki\)')

    def mma(match):
        indent, keys = match.groups()
        if method == 'slice':
            return (f'{indent}for ki in T.serial(qk_steps):\n'
                    f'{indent}    qk.ldmatrix_a(qa, Q_shared, ki)\n'
                    f'{indent}    qk.mma(qa, {keys}, acc_s, ki)')
        return (f'{indent}T.copy(Q_shared, Q_reg)\n'
                f'{indent}for ki in T.serial(qk_steps):\n'
                f'{indent}    qk.mma(Q_reg, {keys}, acc_s, ki)')

    fn, count = pattern.subn(mma, fn)
    assert count == 5, count
    # Q and O may share storage after the last QK. Retain an explicit WAR wait.
    fn = once(fn, '            T.copy(O_reg, O_shared)\n',
                    '            T.sync_warp()\n            T.copy(O_reg, O_shared)\n')
    return fn


def main():
    source = BASE.read_text()
    lines = source.splitlines(keepends=True)
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    report = dict(baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
                  scope='Existing S8 grid >= 4096 builders only; experiments, not a release.', variants=[])
    variants = [('slice', False, 0), ('slice', True, 0), ('full', False, 0), ('full', True, 0),
                ('indices', False, 4), ('indices', False, 8)]
    for method, stage, width in variants:
        result = source
        for name in FUNCTIONS:
            node = functions[name]
            first = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
            text = ''.join(lines[first:node.end_lineno])
            result = once(result, text, transform(text, method, stage, width))
        after = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert all(ast.dump(functions[n]) == ast.dump(after[n]) for n in functions if n not in FUNCTIONS)
        name = f's8_q_{method}_stage{int(stage)}' if method != 'indices' else f's8_indices_v{width}'
        target = HERE / f'{name}.py'
        with target.open('x') as f:
            f.write(result)
        report['variants'].append(dict(path=str(target.relative_to(ROOT)), method=method,
            stage=stage, index_width=width, sha256=hashlib.sha256(target.read_bytes()).hexdigest()))
    (HERE / 'assembly.json').write_text(json.dumps(report, indent=2) + '\n')
    cases = {}
    for b, n, h in ((4, 1024, 1), (8, 1024, 1), (1, 4096, 1), (1, 1024, 4)):
        cases[f's8_b{b}_t{n}_h{h}_c1'] = dict(B=b, SEQ_LEN=n, H=h, HQ=16*h, D=64, S=8,
                                           block_size=16, is_causal=True)
    (HERE / 'cases.json').write_text(json.dumps(cases, indent=2) + '\n')
    print('Generated', len(variants), 'variants')


if __name__ == '__main__':
    main()
