"""Probe explicit one-wave synchronization and coalesced Q/O on current S2.

Only the existing default S2/H1 sum builder changes. Every shared-memory
dependency retains an explicit wave barrier; data-race checks remain enabled.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / "20261016_goal895/release_v14/submission.py"
NAME = "native_sparse_attention_short_list_oct8_sum_v11"


def once(source, before, after):
    assert source.count(before) == 1, (before, source.count(before))
    return source.replace(before, after, 1)


def transform(source, fn, qvec, output_stage):
    body = ast.get_source_segment(source, fn)
    body = once(body, "    head_kv = heads // groups\n",
                "    assert threads == 64 and groups == 16\n    head_kv = heads // groups\n")
    body = once(body, "                kb = T.alloc_local(",
                "                T.sync_warp()\n                kb = T.alloc_local(")
    store_v = "                for j, d in T.Parallel(BS, BV):\n                    KV_shared[j * BK + d] = V_reg[j, d]\n"
    body = once(body, store_v, "                T.sync_warp()\n" + store_v)
    body = once(body, "                vb = T.alloc_local(",
                "                T.sync_warp()\n                vb = T.alloc_local(")
    if qvec:
        alloc = "            Q_reg = T.alloc_fragment([G, BK], T.float16)\n"
        body = once(body, alloc, alloc + f'''            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            T.annotate_layout({{
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda qi, qd: (qi * BK + qd) // {qvec} % 64,
                    forward_index_fn=lambda qi, qd: (qi * BK + qd) // {64*qvec} * {qvec} + qd % {qvec}),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
            }})
''')
        body = once(body, "            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)\n",
                    "            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_stage)\n")
        body = once(body, "                if not direct_k:\n", '''                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:
''')
    if output_stage:
        store = "            T.copy(O_cast, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])\n"
        body = once(body, store, '''            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_cast, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
''')
    new_fn = ast.parse(body).body[0]
    new_fn.decorator_list = copy.deepcopy(fn.decorator_list)
    decorator = new_fn.decorator_list[0]
    configs = next(k.value for k in decorator.keywords if k.arg == "pass_configs")
    configs.keys.append(ast.parse("tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC", mode="eval").body)
    configs.values.append(ast.Constant(value=True))
    return ast.unparse(ast.fix_missing_locations(new_fn)) + "\n"


def main():
    source = PARENT.read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == "d3c4e9f7417069efc0a0189d5754d4f8e765034c848c2219d32e869dd3b22080"
    functions = {fn.name: fn for fn in ast.parse(source).body if isinstance(fn, ast.FunctionDef)}
    fn = functions[NAME]
    lines = source.splitlines(keepends=True)
    start = min(fn.lineno, *(d.lineno for d in fn.decorator_list)) - 1
    original = "".join(lines[start:fn.end_lineno])
    for name in ("baseline.py", "control.py"):
        with (HERE / name).open("x") as out:
            out.write(source)
    rows = []
    for qvec, ostage in ((0, False), (4, False), (8, False), (0, True), (8, True)):
        changed = transform(source, fn, qvec, ostage)
        result = once(source, original, changed)
        new_functions = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert [name for name in functions if ast.dump(functions[name]) != ast.dump(new_functions[name])] == [NAME]
        path = HERE / f"s2_wave_q{qvec}_o{int(ostage)}.py"
        with path.open("x") as out:
            out.write(result)
        rows.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                         q_vector=qvec, coalesced_output=ostage))
    with (HERE / "s2_wave_manifest.json").open("x") as out:
        json.dump(dict(parent=str(PARENT), parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       changed_function=NAME, variants=rows,
                       explicit_shared_dependencies=True, status="screening probes"), out, indent=2)
        out.write("\n")
    cases = json.loads((HERE.parent / "20261016_goal895/short_screen_cases.json").read_text())
    cases["s2_b1_t256_c0"] = dict(cases["oj10"], is_causal=False)
    cases["s2_b1_t1024"] = dict(cases["oj10"], SEQ_LEN=1024)
    with (HERE / "cases.json").open("x") as out:
        json.dump(cases, out, indent=2)
        out.write("\n")
    print("Generated", len(rows), "S2 probes")


if __name__ == "__main__":
    main()
