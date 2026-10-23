"""Retain pair reuse but release K before PV; use explicit packed lane stores."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_window_pairs import ATTENTION, PACK, cpu_proof, expression, nodes

HERE = Path(__file__).resolve().parent


def pack_stores(fn):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    guard = scope.body[0]
    assert isinstance(guard, ast.If)
    stores = [n for n in guard.body if isinstance(n, ast.For) and ast.unparse(n.iter) == "T.Parallel(BJ, DD)"]
    assert len(stores) == 2
    start = guard.body.index(stores[0])
    assert guard.body[start:] == stores
    guard.body[start:] = nodes('''
lane = T.get_thread_binding()
for chunk in T.unroll(DD // 32):
    for element in T.vectorized(8):
        PackedKV[b, bs, h, 0, (dbase // 32 + chunk) * (BS // 16) + jbase // 16, lane, element] = packed_k[lane % 16, chunk * 32 + lane // 16 * 8 + element]
for chunk in T.unroll(DD // 32):
    for element in T.vectorized(8):
        PackedKV[b, bs, h, 1, jbase // 16 * (D // 32) + dbase // 32 + chunk, lane, element] = packed_v[lane // 16 * 4 + element % 4, chunk * 32 + element // 4 * 16 + lane % 16]
''')
    return fn


def phase_attention(fn):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body[:0] = nodes('''
pair_prob = T.alloc_fragment([2, G, BS], T.float16)
T.annotate_layout({pair_prob: T.Fragment([2, G, BS], forward_thread_fn=lambda pq, pi, pj: pi + pj % 16 // 4 * 16, forward_index_fn=lambda pq, pi, pj: pq * (BS // 4) + pj // 16 * 4 + pj % 4)})
''')
    schedule_guard = next(n for n in scope.body if isinstance(n, ast.If))
    loop = schedule_guard.body[-1]
    assert isinstance(loop, ast.For) and ast.unparse(loop.target) == "pair_query"
    token_guard = loop.body[-1]
    guard = next(n for n in token_guard.body if isinstance(n, ast.If) and ast.unparse(n.test) == "valid")
    pv_start = next(i for i, n in enumerate(guard.body) if isinstance(n, ast.For) and ast.unparse(n.target) == "vo")
    qk_body, pv_body = guard.body[:pv_start], guard.body[pv_start:]
    # V can be loaded after the final QK, before its exponent/normalization.
    v_load = next(n for n in qk_body if isinstance(n, ast.If) and any(isinstance(v, ast.Assign) and ast.unparse(v.targets[0]).startswith("v[") for v in ast.walk(n)))
    v_load.test = expression("pair_query == 1 or second_token < 0")

    class CacheProb(ast.NodeTransformer):
        def visit_Subscript(self, node):
            node = self.generic_visit(node)
            if isinstance(node.value, ast.Name) and node.value.id == "prob":
                assert isinstance(node.slice, ast.Tuple)
                node.value.id = "pair_prob"
                node.slice.elts.insert(0, ast.Name(id="pair_query", ctx=ast.Load()))
            return node
    qk_body = [CacheProb().visit(n) for n in qk_body]
    qk_body.extend(nodes("T.sync_warp()"))
    qk_guard = ast.If(test=copy.deepcopy(guard.test), body=qk_body, orelse=[])
    first = copy.deepcopy(loop)
    original_prefix = token_guard.body[:token_guard.body.index(guard)]
    first.body[-1].body = copy.deepcopy(original_prefix) + [qk_guard]

    pv_guard = ast.If(test=copy.deepcopy(guard.test), body=nodes('''
for pi, pj in T.Parallel(G, BS):
    prob[pi, pj] = pair_prob[pair_query, pi, pj]
''') + pv_body, orelse=copy.deepcopy(guard.orelse))
    # The only Q read is in the QK phase. Each original output still has the
    # same normalization, MMA order, cast, shared exchange, and global store.
    second_prefix = [copy.deepcopy(n) for n in original_prefix if not ast.unparse(n).startswith("T.copy(Q[")]
    second = copy.deepcopy(loop)
    second.body[-1].body = second_prefix + [pv_guard] + copy.deepcopy(token_guard.body[token_guard.body.index(guard)+1:])
    schedule_guard.body[-1:] = [first, second]
    return fn


def prove_pack():
    seen = [set(), set()]
    for split in range(4):
        jbase, dbase = split // 2 * 16, split % 2 * 64
        for lane in range(64):
            for chunk in range(2):
                for element in range(8):
                    k = (jbase + lane % 16, dbase + chunk * 32 + lane // 16 * 8 + element)
                    v = (jbase + lane // 16 * 4 + element % 4, dbase + chunk * 32 + element // 4 * 16 + lane % 16)
                    for plane, pos in enumerate((k, v)):
                        assert pos not in seen[plane]
                        seen[plane].add(pos)
    expected = {(j, d) for j in range(32) for d in range(128)}
    assert seen[0] == seen[1] == expected
    return "4096 unique elements in each plane; explicit eight-half lane stores"


def main():
    records = []
    for win in (64, 128):
        parent = HERE / f"window_pairs{win}.py"
        source = parent.read_text()
        tree = ast.parse(source)
        changes = {PACK + "_window_pairs": pack_stores, ATTENTION + "_window_pairs": phase_attention}
        replacements = []
        lines = source.splitlines(keepends=True)
        for fn in tree.body:
            if isinstance(fn, ast.FunctionDef) and fn.name in changes:
                begin = min([fn.lineno] + [n.lineno for n in fn.decorator_list]) - 1
                replacements.append((begin, fn.end_lineno, ast.unparse(ast.fix_missing_locations(changes[fn.name](fn))) + "\n"))
        for begin, end, value in sorted(replacements, reverse=True):
            lines[begin:end] = [value]
        result = "".join(lines)
        ast.parse(result)
        dest = HERE / f"window_pair_phases{win}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(path=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(), parent=parent.name,
                            parent_sha256=hashlib.sha256(source.encode()).hexdigest()))
    with (HERE / "window_pair_phases_manifest.json").open("x") as out:
        json.dump(dict(variants=records, schedule_proof=cpu_proof(), packed_store_proof=prove_pack(),
                       changed="QK pair first, PV pair second; exact math and rounding retained"), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "phase pair probes")


if __name__ == "__main__":
    main()
