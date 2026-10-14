"""Recheck V lifetime on current FP32-denominator/boundary-mask kernels.

The current D64 binary uses 34 mtregs. Partial early V loads may cross a
register-occupancy threshold without postponing all V traffic until after QK.
Every shared memory fence and every load coordinate is preserved.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "_coalesced_block_loads_prim_mathcast",
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_sum",
    "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
}


def transform(fn, mode):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    guard = next(n for n in scope.body if isinstance(n, ast.If) and "_selected_block >= 0" in ast.unparse(n.test))
    load = next(n for n in guard.body if isinstance(n, ast.For) and ast.unparse(n.target) == "v_slot")
    if mode == "half":
        deferred = copy.deepcopy(load)
        load.iter = ast.parse("T.unroll((BS * BV // 512) // 2)", mode="eval").body
        deferred.iter = ast.parse("T.unroll((BS * BV // 512) // 2, BS * BV // 512)", mode="eval").body
    else:
        deferred = load
        guard.body.remove(load)
    if mode == "after_q":
        target = next(n for n in guard.body if ast.unparse(n) == "T.copy(Q_shared, Q_reg)")
    elif mode == "after_kstore":
        target = next(n for n in guard.body if isinstance(n, ast.If) and ast.unparse(n.test) == "not direct_k")
    else:
        assert mode in ("after_qk", "half")
        target = next(n for n in guard.body if isinstance(n, ast.For) and ast.unparse(n.iter) == "T.serial(qk_steps)")
    index = guard.body.index(target) + 1
    guard.body.insert(index, deferred)
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for mode in ("after_q", "after_kstore", "after_qk", "half"):
        result = source
        changed = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in NAMES:
                continue
            original = ast.get_source_segment(source, fn)
            result = result.replace(original, transform(fn, mode), 1)
            changed.append(fn.name)
        assert len(changed) == 5
        ast.parse(result)
        path = HERE / f"v_lifetime_{mode}.py"
        with path.open("x") as file:
            file.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(), mode=mode))
    (HERE / "v_lifetime_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        note="Unchanged bounds, coordinates, math and shared fences; altered global V scheduling only"), indent=2) + "\n")
    print("Generated", len(records), "V lifetime probes", flush=True)


if __name__ == "__main__":
    main()
