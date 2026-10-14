"""Retain wide, synchronous Q loads without aggregate-copy private storage."""
import ast
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
names = {"_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8"}
lines = base.splitlines(keepends=True)

for bits in (64, 128):
    width = bits // 16
    source = base
    for node in ast.parse(base).body:
        if not isinstance(node, ast.FunctionDef) or node.name not in names:
            continue
        old = "".join(lines[node.lineno - 1:node.end_lineno])
        copies = re.findall(r"^            T\.copy\(Q\[.*\], Q_stage\)\n", old, re.M)
        assert len(copies) == 1
        linear = f"(q_slot * 64 + tid) * q_vec + q_word * {width}"
        row, col = f"({linear}) // BK", f"({linear}) % BK"
        new_load = ("            for q_slot in T.unroll(G * BK // (64 * q_vec)):\n"
                    f"                for q_word in T.unroll(q_vec // {width}):\n"
                    f"                    q_values = T.ldg{bits}(Q[i_b, i_t, i_h * G + {row}, {col}])\n")
        for pair in range(width // 2):
            new_load += ("                    for q_element in T.unroll(2):\n"
                f"                        Q_stage[{row}, {col} + {pair * 2} + q_element] = "
                f"T.reinterpret(T.float16, T.uint16(T.Shuffle([q_values], [{pair}]) >> (q_element * 16)))\n")
        new_load += "            T.sync_warp()\n"
        new = old.replace(copies[0], new_load)
        assert source.count(old) == 1
        source = source.replace(old, new, 1)
    ast.parse(source)
    with (HERE / f"q_explicit_load{bits}.py").open("x") as file:
        file.write(source)
    print(f"q_explicit_load{bits}.py")
