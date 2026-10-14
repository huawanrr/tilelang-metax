"""Test constant-one tensor sums with current packed S1/S8 kernels."""
import ast
import hashlib
import json
from pathlib import Path
import re

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


def online(part, position):
    part = once(part, "    qk_steps = ", emitter() + "    qk_steps = ")
    part = once(part, "            sum_acc = T.alloc_fragment([G, BS], T.float32)", """            acc_den = T.alloc_fragment([G, 16], T.float32)
            unit = T.alloc_local([4], T.float16)
            T.annotate_layout({acc_den: psum.make_mma_store_layout(acc_den)})""")
    part = part.replace("            scores_sum = T.alloc_fragment([G], T.float32)\n", "")
    part = part.replace("            inv_sum = T.alloc_fragment([G], T.float32)\n", "")
    part = once(part, "            T.fill(sum_acc, 0)", "            T.clear(acc_den)\n            T.fill(unit, 1)")
    part, count = re.subn(r"(?m)^([ \t]*)for i, j in T\.Parallel\(G, BS\):\n\1    sum_acc\[i, j\] \+= acc_s\[i, j\]\n", "", part)
    assert count == 5, count
    pattern = r"(?m)^([ \t]*)pv\.mma\(acc_s_cast, V_reg, (acc_o(?:_alt|_[123])?), ki\)$"

    def insert(match):
        extra = match[1] + "psum.mma(acc_s_cast, unit, acc_den, ki)"
        return extra + "\n" + match[0] if position == "before" else match[0] + "\n" + extra

    part, count = re.subn(pattern, insert, part)
    assert count in (10, 20), count
    a = part.index("            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)")
    b = part.index("            O_reg = ", a)
    part = part[:a] + """            for i, j in T.Parallel(G, BV):
                value = acc_den[i, j % 16 // 4 * 4]
                acc_o[i, j] *= T.if_then_else(value > 0, 1.0 / value, 0.0)

""" + part[b:]
    assert "sum_acc" not in part
    return part


def single(part, position):
    part = once(part, "    @T.prim_func\n", emitter() + "\n    @T.prim_func\n")
    part = once(part, "            denom = T.alloc_fragment([G], T.float32)", """            acc_den = T.alloc_fragment([G, 16], T.float32)
            unit = T.alloc_local([4], T.float16)
            T.annotate_layout({acc_den: psum.make_mma_store_layout(acc_den)})""")
    part = part.replace("            inv = T.alloc_fragment([G], T.float32)\n", "")
    part = once(part, "            start = block * BS", "            T.clear(acc_den)\n            T.fill(unit, 1)\n            start = block * BS")
    a = part.index("                if not late:\n")
    b = part.index("                for cast_chunk in T.unroll(BS // 16):", a)
    part = part[:a] + part[b:]
    call = "                        pv.mma(prob, v, out, ki)\n"
    extra = "                        psum.mma(prob, unit, acc_den, ki)\n"
    part = once(part, call, extra + call if position == "before" else call + extra)
    a = part.index("                    if late:\n")
    b = part.index("                for cast_chunk in T.unroll(W // 16):", a)
    part = part[:a] + """                    for i, j in T.Parallel(G, W):
                        value = acc_den[i, j % 16 // 4 * 4]
                        out[i, j] *= T.if_then_else(value > 0, 1.0 / value, 0.0)
""" + part[b:]
    return part


def main():
    names = {"native_sparse_attention_single_packed_qo_v2_mathcast": single,
             "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast": online,
             "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast": online}
    lines = SOURCE.splitlines(keepends=True)
    records = []
    for position in ("before", "after"):
        source = SOURCE
        for node in ast.parse(SOURCE).body:
            if isinstance(node, ast.FunctionDef) and node.name in names:
                old = "".join(lines[node.lineno - 1:node.end_lineno])
                source = once(source, old, names[node.name](old, position))
        ast.parse(source)
        path = HERE / f"packed_tensor_denom_{position}.py"
        with path.open("x") as handle:
            handle.write(source)
        records.append(dict(path=str(path), sha256=hashlib.sha256(source.encode()).hexdigest(),
                            position=position, edited_builders=list(names)))
    (HERE / "packed_tensor_denom_manifest.json").write_text(json.dumps(dict(
        base=str(BASE), base_sha256=hashlib.sha256(SOURCE.encode()).hexdigest(), variants=records,
        status="research; requires independent reference and stable timing"), indent=2) + "\n")


if __name__ == "__main__":
    main()
