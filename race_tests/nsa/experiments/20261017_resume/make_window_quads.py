"""Four serial QK/PV queries reuse one K/V pair; one 50-bit schedule word."""
import ast
import copy
import hashlib
import json
import random
from pathlib import Path

from make_window_pairs import ATTENTION, PACK, expression, nodes

HERE = Path(__file__).resolve().parent
PARENT = HERE / "window_pair_shared_phases.py"


def capacity_and_window(fn):
    fn = copy.deepcopy(fn)
    for stmt in fn.body:
        if isinstance(stmt, ast.Assign) and ast.unparse(stmt.targets[0]) == "CAP":
            stmt.value = expression("min(WIN, (WIN + 3 * (NB + 1)) // 4)")
        if isinstance(stmt, ast.Assert) and "WIN in" in ast.unparse(stmt):
            stmt.test = expression(ast.unparse(stmt.test).replace("WIN in (64, 128)", "WIN in (128, 256)"))
    return fn


def pack_quad(fn):
    fn = capacity_and_window(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    sorting = scope.body[0].orelse
    source = "\n".join(ast.unparse(n) for n in sorting)
    source = source.replace("(counts[tid] + 1) // 2", "(counts[tid] + 3) // 4")
    source = source.replace("ranks[step] % 2 == 0", "ranks[step] % 4 == 0")
    source = source.replace("ranks[step] // 2", "ranks[step] // 4")
    sorting = nodes(source)
    emitter = sorting[-1].body[-1]
    assert isinstance(emitter, ast.If)
    emitter.body[2:] = nodes('''
token1 = T.if_then_else(ranks[step] + 1 < counts[buckets[step]], tokens[offset // 65536 + ranks[step] + 1], -1)
token2 = T.if_then_else(ranks[step] + 2 < counts[buckets[step]], tokens[offset // 65536 + ranks[step] + 2], -1)
token3 = T.if_then_else(ranks[step] + 3 < counts[buckets[step]], tokens[offset // 65536 + ranks[step] + 3], -1)
Schedule[b, h, window, task] = T.cast(query_index + 1, "int64") + T.cast(token1 + 1, "int64") * T.int64(2048) + T.cast(token2 + 1, "int64") * T.int64(4194304) + T.cast(token3 + 1, "int64") * T.int64(8589934592) + T.cast(buckets[step], "int64") * T.int64(17592186044416)
''')
    scope.body[0].orelse = sorting
    return fn


def attention_quad(fn):
    fn = capacity_and_window(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    # Extend only the probability bank; Q, scores, K, V, and output retain
    # their original shapes and one query's exact arithmetic at a time.
    class ProbabilityShape(ast.NodeTransformer):
        def visit_List(self, node):
            node = self.generic_visit(node)
            if ast.unparse(node) == "[2, G, BS]":
                node.elts[0] = ast.Constant(value=4)
            return node
    scope = ProbabilityShape().visit(scope)
    old_decode = [i for i, n in enumerate(scope.body) if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) in ("block", "first_token", "second_token")]
    assert len(old_decode) == 3
    begin = min(old_decode)
    scope.body[begin:max(old_decode)+1] = nodes('''
block = T.cast((record >> 44) & T.int64(63), "int32")
query_tokens = T.alloc_local([4], T.int32)
for decode_query in T.unroll(4):
    query_tokens[decode_query] = T.min(T.cast((record >> (decode_query * 11)) & T.int64(2047), "int32") - 1, seq_len - 1)
''')
    guard = scope.body[-1]
    assert isinstance(guard, ast.If)
    guard.test = expression("query_tokens[0] >= 0")
    loops = [n for n in guard.body if isinstance(n, ast.For) and ast.unparse(n.target) == "pair_query"]
    assert len(loops) == 2
    for loop in loops:
        loop.iter = expression("T.unroll(4)")
        loop.body[0].value = expression("query_tokens[pair_query]")
        for stmt in ast.walk(loop):
            if isinstance(stmt, ast.Assign) and ast.unparse(stmt.targets[0]) == "valid":
                # The current-call preparation already rejects future / invalid
                # blocks. The encoded field is six bits and NB is the invalid
                # bin, so this is the complete block-validity test.
                stmt.value = expression("block < NB")
            if isinstance(stmt, ast.If) and ast.unparse(stmt.test) == "pair_query == 1 or second_token < 0":
                stmt.test = expression("pair_query == 3 or query_tokens[T.min(pair_query + 1, 3)] < 0")
    assert "second_token" not in ast.unparse(scope)
    return fn


def wrapper_quad(fn):
    fn = copy.deepcopy(fn)
    stmt = next(n for n in fn.body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "capacity")
    stmt.value = expression("min(window, (window + 3 * (blocks + 1)) // 4)")
    return fn


def dispatch_window(fn, win):
    fn = copy.deepcopy(fn)
    class Window(ast.NodeTransformer):
        def visit_Call(self, node):
            node = self.generic_visit(node)
            if isinstance(node.func, ast.Name):
                if node.func.id == ATTENTION + "_window_pairs":
                    next(k for k in node.keywords if k.arg == "window").value = ast.Constant(win)
                elif node.func.id == PACK + "_window_pairs":
                    assert node.args[-2].value == 128
                    node.args[-2].value = win
                elif node.func.id == "_make_window_pair_attention":
                    assert node.args[-1].value == 128
                    node.args[-1].value = win
            return node
    return Window().visit(fn)


def proof():
    rng = random.Random(616)
    checked = 0
    for n in (1, 31, 32, 33, 63, 64, 65, 127, 128, 129, 255, 256, 257, 511, 512, 513, 1023, 1024, 1985, 2016):
        nb = (n + 31) // 32
        for win in (128, 256):
            cap = min(win, (win + 3 * (nb + 1)) // 4)
            for causal in (False, True):
                patterns = [[0]*n, [nb]*n, [rng.randrange(nb) for _ in range(n)],
                            [rng.choice([-2**31, -1, 0, nb-1, nb, 2**31-1]) for _ in range(n)]]
                for indices in patterns:
                    seen = []
                    for start in range(0, n, win):
                        buckets = [[] for _ in range(64)]
                        order = list(range(start, min(start + win, n)))
                        rng.shuffle(order)
                        for token in order:
                            raw = indices[token]
                            bucket = raw if 0 <= raw < nb and (not causal or raw <= token // 32) else nb
                            buckets[bucket].append(token)
                        counts = [len(x) for x in buckets]
                        words = [cnt*65536 + (cnt+3)//4 for cnt in counts]
                        original = words[:]
                        for bit in range(6):
                            old = words[:]
                            for lane in range(1 << bit, 64):
                                words[lane] += old[lane - (1 << bit)]
                        actual = words[-1] % 65536
                        assert actual <= cap
                        slots = []
                        for bucket, ts in enumerate(buckets):
                            prefix = words[bucket] - original[bucket]
                            assert prefix // 65536 == sum(counts[:bucket])
                            for rank in range(0, len(ts), 4):
                                task = prefix % 65536 + rank // 4
                                slots.append(task)
                                selected = ts[rank:rank+4]
                                seen.extend(selected)
                                fields = selected + [-1] * (4 - len(selected))
                                record = (bucket << 44) + sum((t+1) << (i*11) for i,t in enumerate(fields))
                                assert record < 2**50
                                assert record >> 44 == bucket
                                assert [((record >> (i*11)) & 2047)-1 for i in range(4)] == fields
                        assert sorted(slots) == list(range(actual))
                    assert sorted(seen) == list(range(n))
                    checked += 1
    return dict(pattern_cases=checked, unique_complete_queries=True,
                word_roundtrips=True, invalid_bin_before_multiply=True,
                capacity="min(WIN, floor((WIN + 3*(NB+1))/4))")


def main():
    source = PARENT.read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for win in (128, 256):
        changes = {PACK+"_window_pairs": pack_quad, ATTENTION+"_window_pairs": attention_quad,
                   "_make_window_pair_attention": wrapper_quad,
                   "_get_kernel": lambda fn: dispatch_window(fn, win)}
        lines = source.splitlines(keepends=True)
        replacements = []
        for name, change in changes.items():
            fn = functions[name]
            begin = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            replacements.append((begin, fn.end_lineno, ast.unparse(ast.fix_missing_locations(change(fn))) + "\n"))
        for begin, end, value in sorted(replacements, reverse=True):
            lines[begin:end] = [value]
        result = "".join(lines)
        ast.parse(result)
        dest = HERE / f"window_quads{win}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(path=dest.name, window=win, queries=4, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "window_quads_manifest.json").open("x") as out:
        json.dump(dict(parent=PARENT.name, parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       variants=records, proof=proof(), original_per_query_fp32_order=True,
                       one_shared_tile=True, original_public_interface_and_fallback=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "quad reuse probes")


if __name__ == "__main__":
    main()
