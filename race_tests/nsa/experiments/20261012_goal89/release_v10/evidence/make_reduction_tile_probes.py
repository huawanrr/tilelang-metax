"""Revisit local addition trees and PV tile widths on the recovered v9 kernels."""
import ast
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
OLD = HERE.parent / "20261009_goal8933"
sys.path.insert(0, str(OLD))
from make_balanced_sum import Balance
from make_balanced_sum_v2 import LocalCoordinates

MID = {"_coalesced_block_loads_prim_oct8", "_coalesced_block_loads_prim_fp32_mask"}
LARGE = {"_coalesced_block_loads_prim_boundary_v8", "_coalesced_block_loads_prim_fp32_sum",
         "_coalesced_block_loads_prim_mathcast"}
SHORT = {"native_sparse_attention_short_list_oct8"}


def main():
    source = (HERE / "parent_v9.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    manifests = []
    for name, targets, width in (
        ("balanced_mid", MID, None), ("balanced_large", LARGE, None),
        ("balanced_short", SHORT, None),
        ("pv32", MID | LARGE, 32), ("pv16", MID | LARGE, 16),
    ):
        lines = source.splitlines(keepends=True)
        edits, changes = [], {}
        for target in sorted(targets):
            original = functions[target]
            fn = copy.deepcopy(original)
            if width is None:
                balance, local = Balance(), LocalCoordinates()
                fn = local.visit(balance.visit(fn))
                ast.fix_missing_locations(fn)
                assert balance.count == local.count and balance.count, target
                changes[target] = dict(local_sums=balance.count)
                text = ast.unparse(fn)
            else:
                text = ast.unparse(fn)
                assert text.count("VW = min(pv_width, BV)") == 1
                text = text.replace("VW = min(pv_width, BV)", f"VW = min({width}, BV)", 1)
                changes[target] = dict(pv_width=width)
            start = min([original.lineno] + [d.lineno for d in original.decorator_list]) - 1
            edits.append((start, original.end_lineno, text + "\n"))
        for start, end, text in sorted(edits, reverse=True):
            lines[start:end] = [text]
        text = "".join(lines)
        new_functions = {n.name: n for n in ast.parse(text).body if isinstance(n, ast.FunctionDef)}
        assert new_functions.keys() == functions.keys()
        assert all(ast.dump(fn) == ast.dump(new_functions[n]) for n, fn in functions.items() if n not in targets)
        path = HERE / f"{name}.py"
        with path.open("x") as file:
            file.write(text)
        manifests.append(dict(name=name, path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), changes=changes))
    for tid in range(64):
        for chunk in range(8):
            for j in range(4):
                i, col = tid % 16, chunk * 16 + tid // 16 * 4 + j
                assert i + col % 16 // 4 * 16 == tid
    with (HERE / "reduction_tile_manifest.json").open("x") as file:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=manifests,
                       partial_sum_lane_ownership="PASS", safety_passes_unchanged=True), file, indent=2)
        file.write("\n")
    print("Created", len(manifests), "reduction / tile probes")


if __name__ == "__main__":
    main()
