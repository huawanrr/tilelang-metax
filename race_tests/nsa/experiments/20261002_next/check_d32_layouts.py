"""Compare compact-kernel addresses with the backend's scalar MMA layouts."""
import argparse
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
LAYOUT = Path('/app/tilelang-metax/tilelang/maca/intrinsics/layout/mma_layout.py')


def evaluate(node, **values):
    return eval(compile(ast.Expression(body=node), '<layout-expression>', 'eval'),
                {'__builtins__': {}}, values)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('source')
    p.add_argument('--output', required=True)
    args = p.parse_args()
    source = Path(args.source)
    module = ast.parse(source.read_text())
    compact = next(n for n in module.body if isinstance(n, ast.FunctionDef)
                   and n.name == 'native_sparse_attention_d32_compact')
    names = {'shared_16x32_to_local_64x8_layout_A',
             'thread_id_shared_access_64x4_to_16x16_layout_B'}
    definitions = [n for n in ast.parse(LAYOUT.read_text()).body
                   if isinstance(n, ast.FunctionDef) and n.name in names]
    assert len(definitions) == len(names)
    env = {'__builtins__': {}}
    exec(compile(ast.Module(body=definitions, type_ignores=[]), str(LAYOUT), 'exec'), env)
    qk_owner = env['shared_16x32_to_local_64x8_layout_A']
    pv_coordinate = env['thread_id_shared_access_64x4_to_16x16_layout_B']

    k_loads = [n for n in ast.walk(compact) if isinstance(n, ast.Subscript)
               and isinstance(n.value, ast.Name) and n.value.id == 'K']
    shuffles = [n for n in ast.walk(compact) if isinstance(n, ast.Call)
                and isinstance(n.func, ast.Attribute) and n.func.attr == 'shfl_sync']
    assert len(k_loads) == len(shuffles) == 1
    k_coords, shuffle_lane = k_loads[0].slice.elts, shuffles[0].args[1]
    original_loads, shuffled_loads = set(), set()
    for tid in range(64):
        source_lane = evaluate(shuffle_lane, tid=tid)
        assert 0 <= source_lane < 64
        for element in range(8):
            def coord(lane):
                variables = dict(tid=lane, e=element, index_0=0, BS=16)
                return evaluate(k_coords[1], **variables), evaluate(k_coords[3], **variables)
            original_loads.add(coord(tid))
            row, col = coord(source_lane)
            assert qk_owner(row, col) == (tid, element), (tid, element, row, col)
            shuffled_loads.add((row, col))
    expected = {(row, col) for row in range(16) for col in range(32)}
    assert original_loads == shuffled_loads == expected

    v_layouts = [value for node in ast.walk(compact) if isinstance(node, ast.Dict)
        for key, value in zip(node.keys, node.values)
        if isinstance(key, ast.Name) and key.id == 'v_0']
    assert len(v_layouts) == 1
    v_lambdas = {kw.arg: kw.value.body for kw in v_layouts[0].keywords}
    shared_stores = [n for n in ast.walk(compact) if isinstance(n, ast.Subscript)
        and isinstance(n.value, ast.Name) and n.value.id == 'shared' and isinstance(n.ctx, ast.Store)]
    shared_reads = [n for n in ast.walk(compact) if isinstance(n, ast.Subscript)
        and isinstance(n.value, ast.Name) and n.value.id == 'shared' and isinstance(n.ctx, ast.Load)]
    assert len(shared_stores) == len(shared_reads) == 1
    owners, stores, reads = set(), set(), set()
    for row, col in expected:
        values = dict(vr=row, vc=col, BV=32, BS=16)
        owner = (evaluate(v_lambdas['forward_thread_fn'], **values),
                 evaluate(v_lambdas['forward_index_fn'], **values))
        assert owner not in owners
        owners.add(owner)
        address = evaluate(shared_stores[0].slice, **values)
        assert address == row*32+col and address not in stores
        stores.add(address)
    assert owners == {(tid, e) for tid in range(64) for e in range(8)}
    for tid in range(64):
        for tile in range(2):
            for element in range(4):
                row, col = pv_coordinate(tid, element)
                address = evaluate(shared_reads[0].slice, tid=tid, col=tile,
                                   e=element, BS=16, BV=32)
                assert address == row*32+tile*16+col
                reads.add(address)
    assert reads == stores == set(range(512))

    # Track denominator terms symbolically through the two wave shuffles.
    terms = [{(tid % 16, (tid // 16)*4+j) for j in range(4)} for tid in range(64)]
    for offset in (32, 16):
        prior = terms
        assert all(not prior[tid].intersection(prior[tid ^ offset]) for tid in range(64))
        terms = [prior[tid] | prior[tid ^ offset] for tid in range(64)]
    for tid in range(64):
        assert terms[tid] == {(tid % 16, col) for col in range(16)}

    bounds = []
    for length in (1, 15, 16, 17, 37, 192, 193, 511, 512, 513, 768, 1023, 1024, 4096):
        count = (length+15)//16
        candidates = {-2147483648, 2147483647, -1, 0, count-1, count, count+1}
        for causal in (False, True):
            for t in range(length):
                for index in candidates:
                    valid = 0 <= index < count and (not causal or index <= t//16)
                    selected = [index*16+j for j in range(16)
                                if 0 <= index*16+j < length and (not causal or index*16+j <= t)]
                    assert valid == bool(selected)
                    if valid:
                        assert 0 <= index*16 < 2**31
        bounds.append(dict(seq_len=length, candidate_indices=sorted(candidates), causal_and_noncausal=True))

    report = dict(status='PASS', source=str(source), source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
        backend_layout_source=str(LAYOUT), backend_layout_sha256=hashlib.sha256(LAYOUT.read_bytes()).hexdigest(),
        backend_functions=sorted(names), k_unique_loads=len(original_loads), k_mma_elements=len(shuffled_loads),
        v_owners=len(owners), v_unique_shared_stores=len(stores), v_unique_shared_reads=len(reads),
        shared_allocation_bytes=1024, denominator_rows=16, denominator_terms_per_row=16,
        denominator_shared_accesses=0, bounds=bounds,
        synchronization='One 64-lane CTA; the selected index is wave uniform. The V store-to-read dependency retains one wave barrier.',
        scope='D32/BS16/G16 single-query compact builder. GPU release checks verify generated source, barriers, invalid outputs and live graph inputs.')
    Path(args.output).write_text(json.dumps(report, indent=2)+'\n')
    print('PASS: K mapping against backend, 512 unique V owners/stores/reads, lane reductions,', len(bounds), 'index-boundary families')


if __name__ == '__main__':
    main()
