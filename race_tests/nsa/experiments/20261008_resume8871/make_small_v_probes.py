"""Coalesce V loads on the small no-shared-Q/K attention path."""
import ast
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
EXCHANGE = HERE.parent / "20260929_recheck/make_shuffle_candidates.py"
spec = importlib.util.spec_from_file_location("nsa_register_exchange", EXCHANGE)
exchange = importlib.util.module_from_spec(spec)
spec.loader.exec_module(exchange)


def once(s, a, b):
    assert s.count(a) == 1, (a[:120], s.count(a))
    return s.replace(a, b, 1)


def indent(lines, n):
    return "\n".join(" " * n + x for x in lines)


def shared(fn, vec):
    fn = once(fn,
        "tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}",
        "tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True}")
    fn = once(fn, "            v = T.alloc_fragment([BS, D], T.float16)",
        "            v = T.alloc_fragment([BS, D], T.float16)\n"
        "            v_stage = T.alloc_fragment([BS, D], T.float16)\n"
        "            v_shared = T.alloc_shared([BS, D], T.float16)\n"
        "            T.annotate_layout({v_stage: T.Fragment([BS, D],\n"
        "                forward_thread_fn=lambda vj, vd: (vj * D + vd) // 8 % 64,\n"
        "                forward_index_fn=lambda vj, vd: (vj * D + vd) // 512 * 8 + vd % 8),\n"
        + ("                v_shared: T.Layout([BS, D], lambda sj, sd: sj * D + sd)})\n" if vec == 0 else
           f"                v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize={vec})}})\n"))
    fn = once(fn, "                for j, d in T.Parallel(BS, D):\n                    v[j, d] = V_blocks[b, block, j, h, d]",
        "                for v_slot in T.unroll(BS * D // 512):\n"
        "                    for v_word in T.unroll(4):\n"
        "                        for v_element in T.vectorized(2):\n"
        "                            v_stage[(v_slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + v_word * 2 + v_element] = V_blocks[b, block, (v_slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + v_word * 2 + v_element]\n"
        "                T.copy(v_stage, v_shared)")
    fn = once(fn, "                pv.mma(prob, v, out, 0)",
        "                T.sync_warp()\n"
        "                T.copy(v_shared, v)\n"
        "                pv.mma(prob, v, out, 0)")
    return fn


def shuffle(fn, vec):
    allocations, loads, moves = [], [], []
    for d in (32, 64, 128):
        alloc, load, move = exchange.exchange(f"vs{d}", d, 16, vec, "V")
        # Keep the historical independently proven bit permutation. Only
        # substitute the current complete-block view and variable names.
        load = "\n".join(load).replace("i_s + linear //", "block * BS + linear //")
        load = load.replace("V[i_b, block * BS + linear //", "V[b, block * BS + linear //")
        load = load.replace("i_h,", "h,")
        allocations += [f"if D == {d}:"] + ["    " + x for x in alloc]
        loads += [f"if D == {d}:"] + ["    " + x for x in load.splitlines()]
        moves += [f"if D == {d}:"] + ["    " + x for x in move]
        moves += [f"    pv.mma(prob, vs{d}_mma, out, 0)"]
    fn = once(fn, "            v = T.alloc_fragment([BS, D], T.float16)",
        "            v = T.alloc_fragment([BS, D], T.float16)\n" + indent(allocations, 12))
    fn = once(fn, "                for j, d in T.Parallel(BS, D):\n                    v[j, d] = V_blocks[b, block, j, h, d]", indent(loads, 16))
    fn = once(fn, "                pv.mma(prob, v, out, 0)", indent(moves, 16))
    return fn


def main():
    source = BASE.read_text()
    reports = []
    for mode, value in (("v_shared_linear", 0), ("v_shared4", 4), ("v_shuffle2", 2)):
        lines = source.splitlines(keepends=True)
        edits = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in {
                "native_sparse_attention_q_preload", "native_sparse_attention_direct_kv"}:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            original = "".join(lines[start:fn.end_lineno])
            new = shuffle(original, value) if "shuffle" in mode else shared(original, value)
            edits.append((start, fn.end_lineno, new))
        for start, end, new in reversed(edits):
            lines[start:end] = [new]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"small_{mode}.py"
        with path.open("x") as f:
            f.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), mode=mode))
        print(path.name)
    (HERE / "small_v_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        exchange_generator=str(EXCHANGE), exchange_sha256=hashlib.sha256(EXCHANGE.read_bytes()).hexdigest(),
        variants=reports, qk_and_arithmetic_unchanged=True,
        shared_sync="Existing Q fence retained; one extra wave RAW fence before V read"), indent=2) + "\n")


if __name__ == "__main__":
    main()
