"""Reduce the live PV accumulator width within an existing S1 CTA.

The complete QK, normalization, K/V loads and output tile stay unchanged.
Only D64 in the three default coalesced builders is affected; the existing
loop computes all output columns in successive smaller pieces.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
}


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for width in (16, 32):
        result = source
        for name in sorted(NAMES):
            original = ast.get_source_segment(source, functions[name])
            before = "    VW = min(pv_width, BV)\n"
            assert original.count(before) == 1
            revised = original.replace(before, f"    VW = min(pv_width, {width} if dim == 64 else BV)\n")
            assert result.count(original) == 1
            result = result.replace(original, revised, 1)
        updated = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert {n for n in functions if ast.dump(functions[n]) != ast.dump(updated[n])} == NAMES
        path = HERE / f"s1_pv_tile{width}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(file=path.name, width=width, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "s1_pv_tiles_manifest.json").open("x") as out:
        json.dump(dict(status="screening probes", parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       changed_functions=sorted(NAMES), variants=records,
                       public_host_and_dispatch_unchanged=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "S1 accumulator-width probes")


if __name__ == "__main__":
    main()
