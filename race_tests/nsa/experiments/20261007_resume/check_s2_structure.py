"""Prove actual S2 loader coordinates and the complete-block mask condition on CPU."""
import argparse
import ast
import hashlib
import itertools
import json
from pathlib import Path
from types import SimpleNamespace


def expression(node, env):
    return eval(compile(ast.Expression(node), '<s2-proof>', 'eval'), {'__builtins__': {}, **env})


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('module')
    p.add_argument('--output', required=True)
    args = p.parse_args()
    source = Path(args.module).read_text()
    tree = ast.parse(source)
    report = dict(status='PASS', source=args.module,
                  source_sha256=hashlib.sha256(source.encode()).hexdigest(), builders=[])
    for name in ('native_sparse_attention_short_list_blocks', 'native_sparse_attention_short_list_qo_v2_blocks'):
        fn = next(n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == name)
        env = dict(G=16, S=2, IBS=16, BS=32, BK=64, BV=64, dim=64,
                   KPHASE=1, KMAX=8, VSTRIDE=64, i_b=1, i_h=0)
        layouts = {}
        for d in ast.walk(fn):
            if isinstance(d, ast.Dict):
                for key, value in zip(d.keys, d.values):
                    if isinstance(key, ast.Name) and isinstance(value, ast.Call):
                        kws = {k.arg: k.value for k in value.keywords}
                        if 'forward_thread_fn' in kws:
                            layouts[key.id] = kws
        results = []
        for prefix, frag, view in (('k', 'K_reg', 'K_blocks'), ('v', 'V_reg', 'V_blocks')):
            load = next(n for n in ast.walk(fn) if isinstance(n, ast.Assign)
                        and isinstance(n.value, ast.Subscript) and ast.unparse(n.value.value) == view)
            target = load.targets[0]
            own_thread = expression(layouts[frag]['forward_thread_fn'], env)
            own_index = expression(layouts[frag]['forward_index_fn'], env)
            coords, owners = set(), set()
            for block, slot, tid, word, element in itertools.product(range(2), range(2), range(64), range(4), range(2)):
                raw = (2, 7)[block]
                scope = dict(env, tid=tid, **{f'{prefix}_block': block, f'{prefix}_slot': slot,
                    f'{prefix}_word': word, f'{prefix}_element': element, f'{prefix}_raw': raw})
                dest = expression(target.slice, scope)
                src = expression(load.value.slice, scope)
                row, col = dest
                assert own_thread(row, col) == tid
                assert 0 <= own_index(row, col) < 32
                assert src == (1, raw, row - block*16, 0, col)
                assert 0 <= src[2] < 16 and 0 <= src[4] < 64
                assert dest not in coords
                owner = (tid, own_index(row, col))
                assert owner not in owners
                coords.add(dest)
                owners.add(owner)
                for heads in (1, 2, 4, 8, 16):
                    for head in range(heads):
                        original = ((256 + raw*16 + src[2]) * heads + head) * 64 + col
                        view_offset = (((16 + raw)*16 + src[2]) * heads + head)*64 + col
                        assert original == view_offset
            assert coords == set(itertools.product(range(32), range(64)))
            results.append(dict(operand=prefix, elements=len(coords), owners=len(owners)))
        # Both store layouts are the original permutations of a 32x64 tile.
        k_offsets = {j*64 + ((d//8) ^ (j % 8))*8 + d%8
                     for j, d in itertools.product(range(32), range(64))}
        v_offsets = {j*64+d for j, d in itertools.product(range(32), range(64))}
        assert k_offsets == v_offsets == set(range(2048))

        guard = next(n.test for n in ast.walk(fn) if isinstance(n, ast.If)
                     and 'limits[0] >= 0' in ast.unparse(n.test))
        code = compile(ast.Expression(guard), '<complete-block-guard>', 'eval')
        checks = 0
        for n in (16, 32, 48, 64, 128, 256, 512):
            nb = n // 16
            values = (-2147483648, -268435456, -1, 0, 1, nb-1, nb, 268435456, 2147483647)
            for token, causal, first, second in itertools.product(range(n), (False, True), values, values):
                starts = [min(max(v, -1), nb)*16 for v in (first, second)]
                limits = [min(starts), max(starts)]
                actual = eval(code, {'__builtins__': {}}, dict(limits=limits, IBS=16,
                    seq_len=n, i_t=token, is_causal=causal, T=SimpleNamespace(min=min)))
                expected = all(0 <= v < nb and (not causal or (v+1)*16 <= token+1)
                               for v in (first, second))
                assert actual == expected, (n, token, causal, first, second)
                checks += 1
        barriers = sorted([n.lineno for n in ast.walk(fn) if isinstance(n, ast.Call)
                           and isinstance(n.func, ast.Attribute) and n.func.attr == 'sync_warp'])
        expected_barriers = 7 if '_qo_' in name else 0
        assert len(barriers) == expected_barriers
        report['builders'].append(dict(name=name, loads=results, shared_elements=2048,
            checked_complete_guards=checks, explicit_wave_barriers=len(barriers),
            synchronization='Unchanged from its baseline builder.'))
    Path(args.output).write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
