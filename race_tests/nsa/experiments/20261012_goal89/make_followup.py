"""Construct neighboring shape families and the pairwise-sum/PV32 combination."""
import ast
import hashlib
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / "20261009_goal8933"))
from make_balanced_sum import Balance
from make_balanced_sum_v2 import LocalCoordinates


def config(b, n, h, causal=True):
    return dict(B=b, SEQ_LEN=n, H=h, HQ=16*h, D=64, S=1, block_size=16, is_causal=causal)


def main():
    cases = {}
    for b, n, h in [(2,512,2), (1,1024,2), (4,256,2), (1,512,4), (2,256,4),
                    (1,256,8), (2,128,8), (1,704,3), (2,352,3), (1,1088,2),
                    (2,544,2), (1,544,4), (1,2048,1), (2,1024,1), (4,512,1)]:
        for causal in (True, False):
            cases[f"pv_b{b}_t{n}_h{h}_c{int(causal)}"] = config(b, n, h, causal)
    for b, n, h in [(1,256,2), (1,384,2), (1,512,2), (1,768,2), (2,256,2),
                    (1,192,3), (1,256,3), (1,384,3), (1,512,3), (1,128,4),
                    (1,256,4), (1,384,4), (1,128,8), (1,192,8)]:
        cases[f"sum_b{b}_t{n}_h{h}"] = config(b, n, h)
    with (HERE / "followup_cases.json").open("x") as file:
        json.dump(cases, file, indent=2)
        file.write("\n")
    source = (HERE / "pv32.py").read_text()
    lines = source.splitlines(keepends=True)
    edits = []
    for fn in ast.parse(source).body:
        if not isinstance(fn, ast.FunctionDef) or fn.name not in {
            "_coalesced_block_loads_prim_oct8", "_coalesced_block_loads_prim_fp32_mask"}:
            continue
        start, end = fn.lineno-1, fn.end_lineno
        balance, local = Balance(), LocalCoordinates()
        fn = local.visit(balance.visit(fn))
        ast.fix_missing_locations(fn)
        assert balance.count == local.count == 1
        edits.append((start, end, ast.unparse(fn)+"\n"))
    assert len(edits) == 2
    for start, end, text in sorted(edits, reverse=True):
        lines[start:end] = [text]
    path = HERE / "pv32_balanced.py"
    with path.open("x") as file:
        file.write("".join(lines))
    with (HERE / "followup_manifest.json").open("x") as file:
        json.dump(dict(cases=len(cases), source_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       combination_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                       purpose="Check PV widths around a general medium multihead region and local sums in the existing FP32-mask region"), file, indent=2)
        file.write("\n")
    print("Prepared", len(cases), "family cases")


if __name__ == "__main__":
    main()
