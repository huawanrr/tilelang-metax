"""Test load scheduling and a smaller K lookahead without changing S8 arithmetic."""

import ast
import hashlib
import json
from pathlib import Path

from prepare import BASE, FUNCTIONS, HERE


def change(source, name, q_first=False, depth=None, v_first=False):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    fn = "".join(lines[start:node.end_lineno])
    if depth is not None:
        old = "    S = selected_blocks\n"
        assert fn.count(old) == 1
        fn = fn.replace(old, old + f"    prefetch_depth = {depth}\n")
    if q_first:
        old = "            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)\n"
        assert fn.count(old) == 1
        fn = fn.replace(old, "")
        anchor = "            indices = T.alloc_local([S], T.int32)\n"
        assert fn.count(anchor) == 1
        fn = fn.replace(anchor, old + anchor)
    if v_first:
        old = """                        for j, d in T.Parallel(BS, BV):
                            V_reg[j, d] = V[i_b, i_s0 // BS, i_h, j // 16,
                                            d // 32, (j % 16 // 4) * 16 + d % 16,
                                            (d % 32 // 16) * 4 + j % 4]
"""
        assert fn.count(old) == 1
        fn = fn.replace(old, "")
        k0 = """                            K_reg[j, d] = K[i_b, i_s0 // BS, i_h, d // 32,
                                            j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]
"""
        assert fn.count(k0) == 1
        fn = fn.replace(k0, k0 + old)
    return "".join(lines[:start]) + fn + "".join(lines[node.end_lineno:])


def main():
    records = []
    for label, options in (
        ("q_first", dict(q_first=True)),
        ("lookahead2", dict(depth=2)),
        ("lookahead2_q_first", dict(depth=2, q_first=True)),
        ("v_first", dict(v_first=True)),
    ):
        source = BASE.read_text()
        for name in FUNCTIONS:
            source = change(source, name, **options)
        ast.parse(source)
        path = HERE / ("s8_" + label + ".py")
        with path.open("x") as output:
            output.write(source)
        records.append(dict(path=str(path), options=options,
            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    with (HERE / "schedule_assembly.json").open("x") as output:
        output.write(json.dumps(records, indent=2) + "\n")
    print("Prepared", len(records), "independent schedule probes")


if __name__ == "__main__":
    main()
