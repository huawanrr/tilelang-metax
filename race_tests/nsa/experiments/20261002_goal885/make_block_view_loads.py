"""Avoid aggregate uint4 copies while preserving the eight-value lane layout."""
import ast
import hashlib
import json
from pathlib import Path

from make_register_qk import function, once


HERE = Path(__file__).resolve().parent
BASE = HERE / "coalesced_block_view_local.py"


def main():
    source = BASE.read_text()
    original = function(source, "_coalesced_block_view_prim")
    records = []
    for label, pairs in (("scalar_loads", False), ("pair_loads", True)):
        part = original
        for name, cols, tile in (("K", "BK", "K_reg"), ("V", "BV", "V_reg")):
            columns = ":" if name == "K" else "i_v * BV:(i_v + 1) * BV"
            old = f"                T.copy({name}_blocks[i_b, _selected_block, :, i_h, {columns}], {tile})"
            prefix = name.lower()
            row = f"({prefix}_slot * 512 + tid * 8) // {cols}"
            col = f"tid % ({cols} // 8) * 8 + {prefix}_element"
            line = f"{tile}[{row}, {col}] = {name}_blocks[i_b, _selected_block, {row}, i_h, {col}]"
            if pairs:
                line = line.replace(f"{prefix}_element", f"{prefix}_pair * 2 + {prefix}_element")
                new = f"""                for {prefix}_slot in T.unroll(BS * {cols} // 512):
                    for {prefix}_pair in T.unroll(4):
                        for {prefix}_element in T.vectorized(2):
                            {line}"""
            else:
                new = f"""                for {prefix}_slot in T.unroll(BS * {cols} // 512):
                    for {prefix}_element in T.serial(8):
                        {line}"""
            part = once(part, old, new)
        result = once(source, original, part)
        ast.parse(result)
        path = HERE / f"coalesced_block_view_{label}.py"
        assert not path.exists(), path
        path.write_text(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            elements_per_load=2 if pairs else 1))
        print(path.name)
    (HERE / "block_view_loads_assembly.json").write_text(json.dumps(dict(
        baseline=BASE.name, baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records,
        hypothesis="LLVM diagnostic eliminates both K_reg/V_reg private allocations after scalarizing global reads; this tests the equivalent TileLang source"),
        indent=2) + "\n")


if __name__ == "__main__":
    main()
