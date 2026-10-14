"""Reorder independent selected-block work without changing accumulation order."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'
BUILDERS = ('native_sparse_attention_online_packed_batch_minor_o_v2',
            'native_sparse_attention_online_packed_quad_batch_minor_o_v2')


def replace_once(text, old, new):
    assert text.count(old) == 1, (old[:100], text.count(old))
    return text.replace(old, new, 1)


def region(text, node, decorated=False):
    first = min([node.lineno] + [d.lineno for d in node.decorator_list]) if decorated else node.lineno
    return ''.join(text.splitlines(keepends=True)[first-1:node.end_lineno])


def schedule(fn, group_size, phase, preload_v):
    tree = ast.parse(fn)
    guards = []
    for i in range(4):
        matches = [n for n in ast.walk(tree) if isinstance(n, ast.If)
                   and isinstance(n.body[0], ast.For)
                   and f'i_s{i}' in ast.unparse(n.test)
                   and 'prefetch_depth' in ast.unparse(n.test)]
        matches.sort(key=lambda n: n.lineno)
        assert len(matches) == 2, (i, len(matches))
        guards.append(matches[1])
    old = ''.join(region(fn, g) for g in guards)
    # Each guard consists of V load, mask, QK, exponentials, denominator
    # accumulation, fp16 probability conversion, and PV.
    pieces = []
    for i, guard in enumerate(guards):
        assert len(guard.body) == 7, ast.dump(guard)
        prefix = ''.join(fn.splitlines(keepends=True)[guard.lineno-1:guard.body[0].lineno-1])
        body = [region(fn, node) for node in guard.body]
        assert 'V_reg[j, d]' in body[0] and 'qk.mma' in body[2] and 'pv.mma' in body[6]
        body = [s.replace('acc_s_cast', f'prob_stage{i}').replace('acc_s', f'scores_stage{i}')
                 .replace('V_reg', f'V_stage{i}' if preload_v else 'V_reg') for s in body]
        pieces.append((prefix, body))
    new = ''
    for start in range(0, 4, group_size):
        ids = list(range(start, start + group_size))
        cut = 3 if phase == 'qk' else 6
        for i in ids:
            prefix, body = pieces[i]
            new += prefix + ''.join(body[1:cut])
        if preload_v:
            for i in ids:
                prefix, body = pieces[i]
                new += prefix + body[0]
        for i in ids:
            prefix, body = pieces[i]
            new += prefix + ('' if preload_v else body[0]) + ''.join(body[cut:])
    fn = replace_once(fn, old, new)
    decl = ''
    layouts = ''
    for i in range(4):
        decl += f'            scores_stage{i} = T.alloc_fragment([G, BS], T.float32)\n'
        decl += f'            prob_stage{i} = T.alloc_fragment([G, BS], T.float16)\n'
        layouts += f'                scores_stage{i}: qk.make_mma_store_layout(scores_stage{i}),\n'
        layouts += f'                prob_stage{i}: pv.make_mma_load_layout(prob_stage{i}, "A"),\n'
        if preload_v:
            decl += f'            V_stage{i} = T.alloc_fragment([BS, BV], T.float16)\n'
            layouts += f'                V_stage{i}: pv.make_mma_load_layout(V_stage{i}, "B"),\n'
    fn = replace_once(fn, '            Q_reg = T.alloc_fragment([G, BK], T.float16)\n',
                      decl + '            Q_reg = T.alloc_fragment([G, BK], T.float16)\n')
    fn = replace_once(fn, '                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),\n',
                      layouts + '                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),\n')
    # Validate the original block number before multiplication to avoid int32
    # overflow turning invalid indices into usable addresses.
    fn = replace_once(fn, '                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS',
        '''                raw_index = BlockIndices[i_b, i_t, i_h, si]
                indices[si] = T.if_then_else(raw_index >= 0 and raw_index < T.ceildiv(seq_len, BS),
                                            raw_index * BS, seq_len)''')
    ast.parse(fn)
    return fn


def main():
    baseline = BASE.read_text()
    records = []
    for group, phase, preload_v in ((2, 'qk', False), (4, 'qk', False),
                                    (2, 'prob', False), (4, 'prob', False),
                                    (2, 'prob', True), (4, 'prob', True)):
        source = baseline
        for name in BUILDERS:
            node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
            old = region(source, node, decorated=True)
            source = replace_once(source, old, schedule(old, group, phase, preload_v))
        path = HERE / f's8_schedule_g{group}_{phase}_v{int(preload_v)}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, group=group, phase=phase, preload_v=preload_v,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 's8_schedule_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, note='QK and exponentials separated from PV, with the original FP32 accumulation association.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
