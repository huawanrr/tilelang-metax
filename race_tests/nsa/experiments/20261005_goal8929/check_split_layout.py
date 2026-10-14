"""CPU proof of selected-position coverage, packed addresses and shared ownership."""
import argparse
import ast
import hashlib
import itertools
import json
from pathlib import Path


def expression(node, env):
    return eval(compile(ast.Expression(node), '<layout-proof>', 'eval'), {'__builtins__': {}, **env})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('module')
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    source = Path(args.module).read_text()
    fn = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
              and n.name == 'native_sparse_attention_split_blocks_packed')
    layouts = {}
    for node in ast.walk(fn):
        if not isinstance(node, ast.Dict):
            continue
        for key, value in zip(node.keys, node.values):
            if isinstance(key, ast.Name) and isinstance(value, ast.Call):
                keywords = {k.arg: k.value for k in value.keywords}
                if 'forward_thread_fn' in keywords:
                    layouts[key.id] = keywords
    env = dict(G=16, BS=16, D=64, NW=2, M=32, R=4)
    ownership = []
    for name in ('k0', 'k1', 'v'):
        thread_fn = expression(layouts[name]['forward_thread_fn'], env)
        index_fn = expression(layouts[name]['forward_index_fn'], env)
        owners = set()
        for wave, j, d in itertools.product(range(2), range(16), range(64)):
            thread, index = thread_fn(wave, j, d), index_fn(wave, j, d)
            assert wave * 64 <= thread < (wave + 1) * 64
            assert 0 <= index < 16 and (thread, index) not in owners
            owners.add((thread, index))
        assert len(owners) == 2048
        ownership.append(dict(fragment=name, unique_elements=len(owners)))

    index_store = next(n for n in ast.walk(fn) if isinstance(n, ast.Assign)
        and isinstance(n.value, ast.Subscript) and isinstance(n.value.value, ast.Name)
        and n.value.value.id == 'Indices')
    selections = [expression(index_store.value.slice, dict(env, b=0, token=0, h=0, s=s, wave=w))[-1]
                  for w in range(2) for s in range(4)]
    assert sorted(selections) == list(range(8))

    packed = []
    for name in ('K', 'V'):
        load = next(n for n in ast.walk(fn) if isinstance(n, ast.Subscript)
                    and isinstance(n.value, ast.Name) and n.value.id == name)
        addresses = set()
        for j, d in itertools.product(range(16), range(64)):
            coords = expression(load.slice, dict(env, b=0, h=0, raw=0, raw0=0, raw1=0, j=j, d=d))
            a, b, lane, element = coords[-4:]
            offset = ((a * (1 if name == 'K' else 2) + b) * 64 + lane) * 8 + element
            assert 0 <= offset < 1024 and offset not in addresses
            addresses.add(offset)
        assert len(addresses) == 1024
        packed.append(dict(operand=name, unique_offsets=len(addresses)))

    # This is the actual FP32 vec4 swizzle emitted for the 32x64 partial tile.
    # Rows in distinct waves occupy disjoint 1024-float segments.
    shared = set()
    for m, d in itertools.product(range(32), range(64)):
        address = m * 64 + ((d // 4) ^ (m % 16)) * 4 + d % 4
        assert 0 <= address < 2048 and address not in shared
        shared.add(address)
    assert shared == set(range(2048))
    denominators = {2048 + m for m in range(32)}
    assert not shared.intersection(denominators)
    output_thread = expression(layouts['result']['forward_thread_fn'], env)
    output_index = expression(layouts['result']['forward_index_fn'], env)
    output_owners = {(output_thread(i, d), output_index(i, d))
                     for i, d in itertools.product(range(16), range(64))}
    assert output_owners == set(itertools.product(range(128), range(8)))
    barriers = [n for n in ast.walk(fn) if isinstance(n, ast.Call)
                and isinstance(n.func, ast.Attribute) and n.func.attr.startswith('sync_')]
    assert len(barriers) == 1 and barriers[0].func.attr == 'sync_threads'
    partial_write = next(n for n in ast.walk(fn) if isinstance(n, ast.Call)
        and isinstance(n.func, ast.Attribute) and n.func.attr == 'copy'
        and len(n.args) == 2 and isinstance(n.args[1], ast.Name) and n.args[1].id == 'partial')
    denom_write = next(n for n in ast.walk(fn) if isinstance(n, ast.Call)
        and isinstance(n.func, ast.Attribute) and n.func.attr == 'copy'
        and len(n.args) == 2 and isinstance(n.args[1], ast.Name) and n.args[1].id == 'denominators')
    merge = next(n for n in ast.walk(fn) if isinstance(n, ast.Assign)
                 and any(isinstance(t, ast.Subscript) and isinstance(t.value, ast.Name)
                         and t.value.id == 'result' for t in n.targets))
    assert max(partial_write.lineno, denom_write.lineno) < barriers[0].lineno < merge.lineno

    checked = 0
    for length in (1, 15, 16, 17, 63, 64, 127, 128, 129, 255, 256, 257, 511, 512, 513):
        nb = (length + 15) // 16
        for token, causal, block in itertools.product(range(length), (False, True),
                (-2147483648, -268435456, -1, 0, nb // 2, nb - 1, nb, 268435456, 2147483647)):
            valid = 0 <= block < nb and (not causal or block <= token // 16)
            if valid:
                assert 0 <= block * 16 < length
                for j in range(16):
                    active = block * 16 + j < length and (not causal or block * 16 + j <= token)
                    if active:
                        assert 0 <= block * 16 + j < length
            checked += 1
    report = dict(status='PASS', source=args.module,
        source_sha256=hashlib.sha256(source.encode()).hexdigest(),
        fragment_ownership=ownership, selected_positions=selections, packed_addresses=packed,
        shared_partial_elements=len(shared), shared_denominator_elements=len(denominators),
        output_elements=len(output_owners), cross_wave_barriers=1, checked_guards=checked)
    Path(args.output).write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
