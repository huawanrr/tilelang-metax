"""Add a vector-width combination and batch/head neighbors before confirmation."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_probes import VectorWidth

HERE = Path(__file__).resolve().parent


def main():
    source = (HERE / "large_boundary_exp.py").read_text()
    old = next(n for n in ast.parse(source).body
               if isinstance(n, ast.FunctionDef) and n.name == "_coalesced_block_loads_prim_fp32_sum")
    worker = VectorWidth(4)
    fn = worker.visit(copy.deepcopy(old))
    assert worker.changed == 2
    ast.fix_missing_locations(fn)
    lines = source.splitlines(keepends=True)
    lines[old.lineno - 1:old.end_lineno] = [ast.unparse(fn) + "\n"]
    result = "".join(lines)
    with (HERE / "large_boundary_exp_vec4.py").open("x") as file:
        file.write(result)
    cases = json.loads((HERE / "confirmation_cases.json").read_text())
    groups = json.loads((HERE / "confirmation_groups.json").read_text())
    assert "large_mixed" not in groups
    groups["large_mixed"] = []
    for b, n, h in ((4,768,1),(3,1536,1),(1,6144,1),(1,512,8),(1,1024,4),
                    (1,2048,2),(2,384,3),(2,768,2),(3,1024,2),(1,2560,1),(1,4608,1)):
        name = f"d64_b{b}_t{n}_h{h}_c1"
        cases[name] = dict(B=b, SEQ_LEN=n, H=h, HQ=16*h, D=64, S=1,
                           block_size=16, is_causal=True)
        groups["large_mixed"].append(name)
    for filename, value in (("confirmation_cases.json", cases), ("confirmation_groups.json", groups)):
        (HERE / filename).write_text(json.dumps(value, indent=2) + "\n")
    with (HERE / "large_combination_manifest.json").open("x") as file:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       combined_sha256=hashlib.sha256(result.encode()).hexdigest(),
                       combination="FP32 MMA sum + boundary mask + natural exp + vec4 K/V loads",
                       safety_passes_unchanged=True, synchronization_unchanged=True), file, indent=2)
        file.write("\n")
    print({k: len(v) for k, v in groups.items()})


if __name__ == "__main__":
    main()
