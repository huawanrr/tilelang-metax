"""Revisit constant-one MMA denominators on the current scalar-cast paths.

Both matrix products consume the same FP16 probability, so the denominator
matches the numerator's weights. No additional global storage or launch.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261008_resume8871/candidate_v6.py"
SOURCE = BASE.read_text()


def once(text, old, new):
    assert text.count(old) == 1, (old[:100], text.count(old))
    return text.replace(old, new)


def emitter():
    return """    psum = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=16, chunk=BS, k_pack=1)
"""


def small(fn, position):
    fn = once(fn, "    @T.prim_func\n", emitter() + "\n    @T.prim_func\n")
    fn = once(fn, "            lane_sum = T.alloc_fragment([G, 4], T.float32)\n", """            den = T.alloc_fragment([G, 16], T.float32)
            unit = T.alloc_local([4], T.float16)
            T.annotate_layout({den: psum.make_mma_store_layout(den)})
""")
    fn = once(fn, ", lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda i, j: i + j * 16, forward_index_fn=lambda i, j: 0)", "")
    a = fn.index("                if not late:\n")
    b = fn.index("                for lane in T.unroll(4):\n", a)
    fn = fn[:a] + fn[b:]
    a = fn.index("                if late:\n")
    b = fn.index("            for chunk in T.unroll(D // 16):\n", a)
    fn = fn[:a] + """                for i, j in T.Parallel(G, D):
                    value = den[i, j % 16 // 4 * 4]
                    out[i, j] *= T.if_then_else(value > 0, 1.0 / value, 0.0)
""" + fn[b:]
    fn = once(fn, "                T.clear(scores)\n", "                T.clear(scores)\n                T.clear(den)\n                T.fill(unit, 1)\n")
    call = "                pv.mma(prob, v, out, 0)\n"
    extra = "                psum.mma(prob, unit, den, 0)\n"
    fn = once(fn, call, extra + call if position == "before" else call + extra)
    assert "lane_sum" not in fn
    return fn


def middle(fn, position):
    fn = once(fn, "    @T.prim_func\n", emitter() + "\n    @T.prim_func\n")
    a = fn.index("            lane_sum = T.alloc_fragment")
    b = fn.index("            _layout = ", a)
    fn = fn[:a] + """            den = T.alloc_fragment([G, 16], T.float32)
            unit = T.alloc_local([4], T.float16)
            T.annotate_layout({den: psum.make_mma_store_layout(den)})
""" + fn[b:]
    fn = once(fn, "            if not lane_reduce:\n                T.fill(scores_sum, 0)\n", "            T.clear(den)\n            T.fill(unit, 1)\n")
    a = fn.index("                if not late_normalize:\n")
    b = fn.index("                for cast_chunk in T.unroll(BS // 16):\n", a)
    fn = fn[:a] + fn[b:]
    call = "                        pv.mma(acc_s_cast, vb, acc_o, ki)\n"
    extra = "                        psum.mma(acc_s_cast, unit, den, ki)\n"
    fn = once(fn, call, extra + call if position == "before" else call + extra)
    fn = once(fn, "                for cast_chunk in T.unroll(VW // 16):\n", """                for i, j in T.Parallel(G, VW):
                    value = den[i, j % 16 // 4 * 4]
                    acc_o[i, j] *= T.if_then_else(value > 0, 1.0 / value, 0.0)
                for cast_chunk in T.unroll(VW // 16):
""")
    assert "lane_sum" not in fn and "scores_sum" not in fn
    return fn


def main():
    names = {"native_sparse_attention_q_preload": small,
             "native_sparse_attention_direct_kv": small,
             "_coalesced_block_loads_prim_oct8": middle}
    lines = SOURCE.splitlines(keepends=True)
    reports = []
    for position in ("before", "after"):
        source = SOURCE
        for node in ast.parse(SOURCE).body:
            if isinstance(node, ast.FunctionDef) and node.name in names:
                part = "".join(lines[node.lineno - 1:node.end_lineno])
                source = once(source, part, names[node.name](part, position))
        ast.parse(source)
        target = HERE / f"tensor_denom_{position}.py"
        with target.open("x") as handle:
            handle.write(source)
        reports.append(dict(path=str(target), sha256=hashlib.sha256(target.read_bytes()).hexdigest(),
                            edited_builders=list(names), position=position))
    (HERE / "tensor_denom_manifest.json").write_text(json.dumps(dict(
        base=str(BASE), base_sha256=hashlib.sha256(SOURCE.encode()).hexdigest(),
        candidates=reports, status="research; requires reference and performance checks"), indent=2) + "\n")


if __name__ == "__main__":
    main()
