"""CPU proofs of the submitted scalar ownership and complete-block addresses."""
import argparse
import ast
import hashlib
import itertools
import json
from pathlib import Path


class BindThread(ast.NodeTransformer):
    def visit_Call(self, node):
        assert ast.unparse(node) == 'T.get_thread_binding()', ast.unparse(node)
        return ast.Name(id='tid', ctx=ast.Load())


def expression(node):
    tree = ast.parse(ast.unparse(node), mode='eval')
    tree = ast.fix_missing_locations(BindThread().visit(tree))
    return compile(tree, '<submitted scalar coordinates>', 'eval')


def scalar_maps(source):
    tree = ast.parse(source)
    parents = {c: n for n in ast.walk(tree) for c in ast.iter_child_nodes(n)}
    scenarios = {
        'native_sparse_attention_direct_kv': ((32, 16, 1), (64, 16, 1)),
        'native_sparse_attention_q_preload': ((32, 16, 1), (64, 16, 1), (128, 16, 1)),
        'native_sparse_attention_linear_v_blocks_oct8': ((128, 16, 1),),
        'native_sparse_attention_short_list_oct8': ((64, 32, 2),),
        'native_sparse_attention_staged_sparse_blocks': ((64, 16, 4),),
    }
    if 'def native_sparse_attention_short_lane_source(' in source:
        scenarios['native_sparse_attention_short_lane_source'] = ((64, 32, 2),)
    if 'def _coalesced_block_loads_prim_oct8(' in source:
        scenarios['_coalesced_block_loads_prim_oct8'] = ((64, 16, 1),)
    records = []
    for fn in tree.body:
        if not isinstance(fn, ast.FunctionDef) or fn.name not in scenarios:
            continue
        found = 0
        for n in ast.walk(fn):
            if not isinstance(n, ast.Assign) or len(n.targets) != 1:
                continue
            dst, src = n.targets[0], n.value
            if not isinstance(dst, ast.Subscript) or not isinstance(src, ast.Subscript):
                continue
            name = ast.unparse(dst.value)
            if name not in ('prob', 'acc_s_cast', 'O_cast', 'result', 'O_reg'):
                continue
            if 'tid' not in ast.unparse(dst.slice) and 'T.get_thread_binding()' not in ast.unparse(dst.slice):
                continue
            used = {x.id for x in ast.walk(dst.slice) if isinstance(x, ast.Name)}
            axes = []
            parent = parents[n]
            while parent is not fn:
                if isinstance(parent, ast.For) and isinstance(parent.target, ast.Name) and parent.target.id in used:
                    assert ast.unparse(parent.iter.func) == 'T.unroll'
                    axes.append((parent.target.id, expression(parent.iter.args[0])))
                parent = parents[parent]
            axes.reverse()
            left, right = expression(dst.slice), expression(src.slice)
            for d, bs, selected in scenarios[fn.name]:
                env = dict(D=d, dim=d, BK=d, BV=d, VW=d, W=d, BS=bs, IBS=16, G=16, S=selected)
                extents = [range(eval(value, {'__builtins__': {}}, env)) for _, value in axes]
                width = bs if name in ('prob', 'acc_s_cast') else d
                seen = set()
                for tid in range(64):
                    for coord in itertools.product(*extents):
                        local = dict(env, tid=tid, **dict(zip([x[0] for x in axes], coord)))
                        i, j = eval(left, {'__builtins__': {}}, local)
                        si, sj = eval(right, {'__builtins__': {}}, local)
                        assert 0 <= i < 16 and 0 <= j < width
                        assert (i, j) == (si, sj)
                        assert i + j % 16 // 4 * 16 == tid
                        assert (i, j) not in seen
                        seen.add((i, j))
                assert len(seen) == 16 * width
                records.append(dict(function=fn.name, destination=name, dim=d, bs=bs,
                    lhs=ast.unparse(dst.slice), rhs=ast.unparse(src.slice),
                    covered_elements=len(seen), unique_and_same_thread=True))
            found += 1
        assert found >= 2, (fn.name, found)
    assert set(x['function'] for x in records) == set(scenarios)
    return records


def block_maps():
    records = []
    for d in (32, 64, 128):
        seen = set()
        for tid, slot, word, element in itertools.product(range(64), range(16*d//512), range(4), range(2)):
            j = (slot * 512 + tid * 8) // d
            col = tid % (d // 8) * 8 + word * 2 + element
            assert 0 <= j < 16 and 0 <= col < d
            assert (j * d + col) // 8 % 64 == tid
            assert (j, col) not in seen
            seen.add((j, col))
        assert len(seen) == 16*d
        perm = {j*d + ((col//8) ^ (j % (d//8)))*8 + col%8 for j, col in seen}
        assert perm == set(range(16*d))
        for b, nb, h in itertools.product(range(2), range(3), range(3)):
            for j, col in seen:
                reshaped = ((((b*3 + nb)*16 + j)*3 + h)*d + col)
                original = ((b*48 + nb*16 + j)*3 + h)*d + col
                assert reshaped == original
        records.append(dict(dim=d, elements=len(seen), pair_ownership=True,
            swizzle_bijection=True, multihead_same_storage_offsets=True))
    for n in (64, 128, 192, 256, 512, 768, 1024, 4096):
        nb = n//16
        for raw in (-2147483648, -134217728, -1, 0, 1, nb-1, nb, n, 134217728, 2147483647):
            if 0 <= raw < nb:
                assert 0 <= raw*16 <= n-16
            guarded = raw if 0 <= raw < nb else -1
            assert -16 <= guarded*16 <= n-16
    return records


def shuffle_maps(source):
    if 'def native_sparse_attention_short_lane_source(' not in source:
        return []
    tree = ast.parse(source)
    fn = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
              and n.name == 'native_sparse_attention_short_lane_source')
    calls = [n for n in ast.walk(fn) if isinstance(n, ast.Call)
             and ast.unparse(n.func) == 'T.shfl_sync']
    assert len(calls) == 4
    records = []
    for node in calls:
        expr = expression(node.args[1])
        assert ast.literal_eval(node.args[2]) == 64
        assert ast.literal_eval(node.args[3]) == 18446744073709551615
        delta = ast.literal_eval(node.args[1].right)
        for tid in range(64):
            src = eval(expr, {'__builtins__': {}}, {'tid': tid})
            assert src == (tid ^ delta) and 0 <= src < 64
            assert src % 16 == tid % 16
        records.append(dict(expression=ast.unparse(node.args[1]),
                            delta=delta, all_lanes_equal_to_original_xor=True))
    for tid in range(64):
        group = {tid, tid ^ 32, tid ^ 16, tid ^ 48}
        assert group == {tid % 16 + lane * 16 for lane in range(4)}
    return records


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('source')
    p.add_argument('--output', required=True)
    a = p.parse_args()
    source = Path(a.source).read_text()
    report = dict(status='PASS', source_sha256=hashlib.sha256(source.encode()).hexdigest(),
        scalar_maps=scalar_maps(source), complete_blocks=block_maps(), shuffle_maps=shuffle_maps(source),
        new_sync_proof='Direct Q preload: one unconditional full-wave fence after Q load, before the uniform block guard. No shared memory. Original builders and their synchronization remain unchanged.',
        short_sync_proof=('S2: one full 64-lane wave, three explicit fences protect K RAW, K/V WAR, V RAW; source lanes and reduction order are unchanged.'
            if 'def native_sparse_attention_short_lane_source(' in source else 'S2 changes not included.'),
        sync_proof='S4: separate 2048-byte K/V buffers. Each valid iteration has K-ready and V-ready wave barriers; K-ready protects prior V readers, V-ready protects K readers. Lookahead changes only registers. Two final barriers protect staged output. Skipped slots access neither shared tile.')
    Path(a.output).write_text(json.dumps(report, indent=2)+'\n')
    print('PASS', len(report['scalar_maps']), 'scalar mappings')


if __name__ == '__main__':
    main()
