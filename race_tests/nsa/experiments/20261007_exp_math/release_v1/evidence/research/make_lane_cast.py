"""Convert each lane's actual MMA fragment elements with ordinary FP16 casts.

This uses the existing fragment ownership directly, as existing K/V staging
already does. It avoids an inferred partial T.Parallel layout. The scalar
FP16 cast uses MACA's existing fast conversion; no device helpers are added.
"""
import ast
import hashlib
import json
from pathlib import Path
import re

from make_cast_and_flags import BASE, HERE, ONLINE, SINGLE, edit_functions

COALESCED = "_coalesced_block_loads_prim"


def body(pad, src, dst, ncol, dst_offset=""):
    row = "T.get_thread_binding() % 16"
    col = "cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane"
    return (pad + f"for cast_chunk in T.unroll({ncol} // 16):\n"
            + pad + "    for cast_lane in T.unroll(4):\n"
            + pad + f"        {dst}[{row}, {dst_offset}{col}] = {src}[{row}, {col}]")


def scalar_copy(fn, src, dst, ncol):
    pattern = re.compile(r"(?m)^( +)T\.copy\(" + re.escape(src) + r", " + re.escape(dst) + r"\)$")
    result, count = pattern.subn(lambda m: body(m[1], src, dst, ncol), fn)
    assert count, (src, dst)
    return result


def transform(fn, name, prob, output):
    if name in ONLINE:
        if prob:
            fn = scalar_copy(fn, "acc_s", "acc_s_cast", "BS")
        if output and "T.copy(acc_o, O_reg)" in fn:
            fn = scalar_copy(fn, "acc_o", "O_reg", "BV")
    elif name == SINGLE:
        if prob:
            fn = scalar_copy(fn, "scores", "prob", "BS")
        if output:
            old = ("                for oi, od in T.Parallel(G, W):\n"
                   "                    output_reg[oi, vo * W + od] = out[oi, od]")
            assert fn.count(old) == 1
            fn = fn.replace(old, body(" " * 16, "out", "output_reg", "W", "vo * W + "))
    else:
        assert name == COALESCED
        if prob:
            fn = scalar_copy(fn, "acc_s", "acc_s_cast", "BS")
        if output:
            old = ("                for i, d in T.Parallel(G, VW):\n"
                   "                    O_reg[i, vo * VW + d] = acc_o[i, d]")
            assert fn.count(old) == 1
            fn = fn.replace(old, body(" " * 16, "acc_o", "O_reg", "VW", "vo * VW + "))
    return fn


def main():
    records = []
    for name, parent, prob, output in (
        ("lane_cast_folded", HERE / "exp_folded.py", True, True),
        ("lane_cast_baseline", BASE, True, True),
        ("lane_cast_prob", BASE, True, False),
        ("lane_cast_output", BASE, False, True),
    ):
        names = (ONLINE if prob else ONLINE[1:]) + (SINGLE, COALESCED)
        result = edit_functions(parent.read_text(), names,
            lambda fn, n: transform(fn, n, prob, output))
        ast.parse(result)
        path = HERE / (name + ".py")
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path), parent=str(parent), functions=names,
                            prob=prob, output=output, sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    # Every (row, column) in a 16 x width tile is owned exactly once.
    maps = []
    for width in (16, 32, 64, 128):
        points = [(tid % 16, chunk * 16 + tid // 16 * 4 + element)
                  for tid in range(64) for chunk in range(width // 16) for element in range(4)]
        assert len(points) == len(set(points)) == 16 * width
        assert set(points) == {(i, j) for i in range(16) for j in range(width)}
        maps.append(dict(width=width, elements=len(points), unique_and_complete=True))
    (HERE / "lane_cast_assembly.json").write_text(json.dumps(dict(variants=records,
        maps=maps, unchanged_math=True, unchanged_sync=True, no_backend_changes=True), indent=2) + "\n")
    print("Generated", len(records), "lane scalar-cast probes")


if __name__ == "__main__":
    main()
