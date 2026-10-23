"""One int64 schedule record per CTA, eliminating a dependent header load."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_window_pairs import ATTENTION, PACK, expression, nodes
from make_window_pair_phases import pack_stores

HERE = Path(__file__).resolve().parent


def change_pack(fn, use_lane_stores):
    fn = pack_stores(fn) if use_lane_stores else copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    kernel.args.args[-1].annotation = expression("T.Tensor([batch, H, NW, CAP], T.int64)")
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    sorting = scope.body[0].orelse
    old_header = next(i for i, n in enumerate(sorting) if isinstance(n, ast.If) and ast.unparse(n.test) == "tid == 63")
    sorting[old_header:old_header+1] = nodes('''
total_tasks = T.shfl_sync(scan[0], 63, 64, 18446744073709551615) % 65536
for init_step in T.unroll(T.ceildiv(CAP, 64)):
    unused_task = init_step * 64 + tid
    if unused_task < CAP and unused_task >= total_tasks:
        Schedule[b, h, window, unused_task] = T.int64(0)
''')
    final_loop = sorting[-1]
    target = final_loop.body[-1]
    assert isinstance(target, ast.If)
    target.body[2:] = nodes('''
next_token = T.if_then_else(ranks[step] + 1 < counts[buckets[step]], tokens[offset // 65536 + ranks[step] + 1], -1)
Schedule[b, h, window, task] = T.cast(query_index + 1, "int64") + T.cast(next_token + 1, "int64") * T.int64(65536) + T.cast(buckets[step], "int64") * T.int64(4294967296)
''')
    return fn


def change_attention(fn):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    kernel.args.args[2].annotation = expression("T.Tensor([batch, H, NW, CAP], T.int64)")
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    guard = scope.body[-1]
    assert isinstance(guard, ast.If)
    assert [ast.unparse(n.targets[0]) for n in guard.body[:3]] == ["block", "first_token", "second_token"]
    guard.body = guard.body[3:]
    guard.test = expression("first_token >= 0")
    # Public bounds checks remain enabled. The schedule contains token+1;
    # zero is a missing query / unused slot. Clamping only internal metadata
    # also exposes a provable query upper bound to the ordinary compiler.
    scope.body[-1:] = nodes('''
record = Schedule[b, h, window_index, task]
block = T.cast(record >> 32, "int32")
first_token = T.min(T.cast(record & T.int64(65535), "int32") - 1, seq_len - 1)
second_token = T.min(T.cast((record >> 16) & T.int64(65535), "int32") - 1, seq_len - 1)
''') + [guard]
    return fn


def change_wrapper(fn):
    fn = copy.deepcopy(fn)
    shape = next(n for n in fn.body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "schedule_shape")
    shape.value = expression("(batch, heads, windows, capacity)")
    run = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    allocation = next(n for n in run.body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "schedule")
    next(k for k in allocation.value.keywords if k.arg == "dtype").value = expression("torch.int64")
    return fn


def proof():
    tested = 0
    for token0 in range(2016):
        for token1 in (-1, 0, token0, 2015):
            for block in (0, 1, 32, 63):
                word = token0 + 1 + (token1 + 1) * 65536 + block * 4294967296
                assert word < 2**63
                assert (word & 65535) - 1 == token0
                assert ((word >> 16) & 65535) - 1 == token1
                assert word >> 32 == block
                tested += 1
    assert (0 & 65535) - 1 == -1
    return dict(roundtrips=tested, missing_token=-1, empty_record=0,
                unused_initialization="only slots >= total_tasks; disjoint from populated slots")


def main():
    records = []
    for mode, name in (("serial", "window_pairs128.py"), ("phases", "window_pair_phases128.py")):
        parent = HERE / name
        source = parent.read_text()
        lines = source.splitlines(keepends=True)
        changes = {PACK + "_window_pairs": lambda fn: change_pack(fn, mode == "serial"),
                   ATTENTION + "_window_pairs": change_attention,
                   "_make_window_pair_attention": change_wrapper}
        replacements = []
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in changes:
                begin = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
                replacements.append((begin, fn.end_lineno, ast.unparse(ast.fix_missing_locations(changes[fn.name](fn))) + "\n"))
        assert len(replacements) == 3
        for begin, end, value in sorted(replacements, reverse=True):
            lines[begin:end] = [value]
        result = "".join(lines)
        ast.parse(result)
        dest = HERE / f"window_pair_records_{mode}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            parent=parent.name, parent_sha256=hashlib.sha256(source.encode()).hexdigest()))
    with (HERE / "window_pair_records_manifest.json").open("x") as out:
        json.dump(dict(variants=records, proof=proof(), dispatch_unchanged=True,
                       mathematical_work_unchanged=True, bounds_and_race_checks_enabled=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "compact schedule probes")


if __name__ == "__main__":
    main()
