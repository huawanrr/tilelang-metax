"""Probe scalar FP16 conversion and arithmetic flags through public TileLang APIs.

MACA's vector __float22half2_rn calls the explicit-rounding library; the
ordinary scalar half cast uses the existing __FAST_HALF_CVT__ intrinsic.
All sources, mathematical expressions, synchronization and negative results
are kept for comparison. No runtime/header/backend file is changed.
"""
import ast
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"
ONLINE = (
    "native_sparse_attention_online_packed",
    "native_sparse_attention_online_packed_batch_minor_o_v2",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2",
)
SINGLE = "native_sparse_attention_single_packed_qo_v2"


def edit_functions(source, names, transform):
    lines = source.splitlines(keepends=True)
    nodes = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    result = source
    for name in names:
        node = nodes[name]
        begin = min([node.lineno] + [n.lineno for n in node.decorator_list]) - 1
        old = "".join(lines[begin:node.end_lineno])
        new = transform(old, name)
        assert old != new, name
        assert result.count(old) == 1, name
        result = result.replace(old, new)
    after = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
    assert nodes.keys() == after.keys()
    assert all(ast.dump(nodes[n]) == ast.dump(after[n]) for n in nodes if n not in names)
    return result


def scalar_copy(fn, src, dst, ncol):
    pattern = re.compile(r"(?m)^( +)T\.copy\(" + re.escape(src) + r", " + re.escape(dst) + r"\)$")

    def replace(m):
        pad = m[1]
        return (pad + "for cast_lane in T.unroll(4):\n"
                + pad + f"    for ci, cj in T.Parallel(G, {ncol} // 4):\n"
                + pad + f"        {dst}[ci, cj * 4 + cast_lane] = {src}[ci, cj * 4 + cast_lane]")
    result, count = pattern.subn(replace, fn)
    assert count > 0, (src, dst)
    return result


def cast_transform(fn, name, mode, include_output):
    assert name in ONLINE
    if mode == "scalar":
        fn = scalar_copy(fn, "acc_s", "acc_s_cast", "BS")
        if include_output and "T.copy(acc_o, O_reg)" in fn:
            fn = scalar_copy(fn, "acc_o", "O_reg", "BV")
    else:
        assert mode == "width1"
        fn = fn.replace("T.copy(acc_s, acc_s_cast)",
                        "T.copy(acc_s, acc_s_cast, coalesced_width=1)")
        fn = fn.replace("T.copy(acc_o, O_reg)",
                        "T.copy(acc_o, O_reg, coalesced_width=1)")
    return fn


def add_flags(fn, name, flags):
    assert "compile_flags=" not in fn
    assert fn.count("@tilelang.jit(") == 1, name
    return fn.replace("@tilelang.jit(", f"@tilelang.jit(compile_flags={flags!r}, ", 1)


def main():
    folded = (HERE / "exp_folded.py").read_text()
    preserve = (HERE / "exp_preserve.py").read_text()
    baseline = BASE.read_text()
    variants = []

    def save(name, source, parent, description):
        path = HERE / (name + ".py")
        ast.parse(source)
        with path.open("x") as f:
            f.write(source)
        variants.append(dict(path=str(path), parent=str(parent), description=description,
                             sha256=hashlib.sha256(path.read_bytes()).hexdigest()))

    for name, source, parent, mode, output in (
        ("s8_cast_scalar_prob", folded, HERE / "exp_folded.py", "scalar", False),
        ("s8_cast_scalar_all", folded, HERE / "exp_folded.py", "scalar", True),
        ("s8_cast_width1", folded, HERE / "exp_folded.py", "width1", True),
        ("s8_cast_scalar_baseline", baseline, BASE, "scalar", True),
    ):
        save(name, edit_functions(source, ONLINE,
             lambda fn, n: cast_transform(fn, n, mode, output)), parent,
             dict(cast=mode, include_output=output, functions=ONLINE))

    associative = ["-fno-signed-zeros", "-fno-trapping-math", "-fassociative-math"]
    for name, source, parent, flags in (
        ("s8_math_assoc_preserve", preserve, HERE / "exp_preserve.py", associative),
        ("s8_math_assoc_folded", folded, HERE / "exp_folded.py", associative),
        ("s8_math_unsafe_preserve", preserve, HERE / "exp_preserve.py", ["-funsafe-math-optimizations"]),
    ):
        save(name, edit_functions(source, ONLINE + (SINGLE,),
             lambda fn, n: add_flags(fn, n, flags)), parent,
             dict(flags=flags, finite_math_only=False, functions=ONLINE + (SINGLE,)))

    for cap in (80, 88, 96):
        flags = ["-mllvm", f"--max-mtreg-number={cap}"]
        save(f"s8_math_reg{cap}", edit_functions(folded, ONLINE[1:],
             lambda fn, n: add_flags(fn, n, flags)), HERE / "exp_folded.py",
             dict(flags=flags, functions=ONLINE[1:]))

    (HERE / "cast_flags_assembly.json").write_text(json.dumps(dict(
        variants=variants, research_only=True, dispatch_unchanged=True,
        backend_changes=False, rounding="Compare explicit RN library with normal FP16 scalar cast"),
        indent=2) + "\n")
    print("Generated", len(variants), "cast/flag probes")


if __name__ == "__main__":
    main()
