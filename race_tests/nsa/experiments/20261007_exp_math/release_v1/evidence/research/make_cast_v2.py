"""Scalar RN conversion with explicit 16-column chunks for layout inference.

The initial output conversion's G x (BV/4) inferred layout was rejected as
non-injective. Keep that failed probe; express each MMA 16-column tile as a
G x 4 loop here so each participating lane writes one element per iteration.
"""
import ast
import hashlib
import json
from pathlib import Path
import re

from make_cast_and_flags import BASE, HERE, ONLINE, SINGLE, edit_functions


def copy_scalar(fn, src, dst, ncol):
    pattern = re.compile(r"(?m)^( +)T\.copy\(" + re.escape(src) + r", " + re.escape(dst) + r"\)$")

    def replace(m):
        pad = m[1]
        index = "cast_chunk * 16 + cj * 4 + cast_lane"
        return (pad + f"for cast_chunk in T.unroll({ncol} // 16):\n"
                + pad + "    for cast_lane in T.unroll(4):\n"
                + pad + "        for ci, cj in T.Parallel(G, 4):\n"
                + pad + f"            {dst}[ci, {index}] = {src}[ci, {index}]")

    result, count = pattern.subn(replace, fn)
    assert count, (src, dst)
    return result


def transform(fn, name, output):
    if name in ONLINE:
        fn = copy_scalar(fn, "acc_s", "acc_s_cast", "BS")
        if output and "T.copy(acc_o, O_reg)" in fn:
            fn = copy_scalar(fn, "acc_o", "O_reg", "BV")
    else:
        assert name == SINGLE
        fn = copy_scalar(fn, "scores", "prob", "BS")
        if output:
            old = ("                for oi, od in T.Parallel(G, W):\n"
                   "                    output_reg[oi, vo * W + od] = out[oi, od]")
            new = ("                for cast_chunk in T.unroll(W // 16):\n"
                   "                    for cast_lane in T.unroll(4):\n"
                   "                        for ci, cj in T.Parallel(G, 4):\n"
                   "                            output_reg[ci, vo * W + cast_chunk * 16 + cj * 4 + cast_lane] = out[ci, cast_chunk * 16 + cj * 4 + cast_lane]")
            assert fn.count(old) == 1
            fn = fn.replace(old, new)
    return fn


def main():
    records = []
    for name, base, names, output in (
        ("s8_cast_scalar_v2", HERE / "exp_folded.py", ONLINE, True),
        ("s8_cast_scalar_base_prob", BASE, ONLINE, False),
        ("s8_cast_scalar_base_v2", BASE, ONLINE, True),
        ("packed_cast_scalar_v2", HERE / "exp_folded.py", ONLINE + (SINGLE,), True),
        ("packed_cast_scalar_base_v2", BASE, ONLINE + (SINGLE,), True),
    ):
        result = edit_functions(base.read_text(), names, lambda fn, n: transform(fn, n, output))
        ast.parse(result)
        path = HERE / (name + ".py")
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path), parent=str(base), functions=names,
                            output=output, sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "cast_v2_assembly.json").write_text(json.dumps(dict(variants=records,
        reason="Bound each scalar-conversion loop to one 16-column MMA tile",
        no_backend_changes=True, unchanged_sync=True, unchanged_math=True), indent=2) + "\n")
    print("Generated", len(records), "scalar cast probes")


if __name__ == "__main__":
    main()
