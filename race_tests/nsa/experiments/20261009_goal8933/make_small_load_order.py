"""Check V-load scheduling on the existing small direct-register kernels."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = (HERE / "parent.py").read_text()
TARGETS = {"native_sparse_attention_q_preload", "native_sparse_attention_direct_kv"}


def transform(function, mode):
    function = copy.deepcopy(function)
    kernel = next(n for n in function.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    valid = next(n for n in scope.body if isinstance(n, ast.If) and "qk.mma(" in ast.unparse(n))
    ki = next(i for i, n in enumerate(valid.body) if isinstance(n, ast.For) and "k[j, d] = K_blocks" in ast.unparse(n))
    vi = next(i for i, n in enumerate(valid.body) if isinstance(n, ast.For) and "v[j, d] = V_blocks" in ast.unparse(n))
    assert vi == ki + 1
    k, v = valid.body[ki:vi+1]
    fence = ast.parse("T.sync_warp()").body
    orders = {"vfirst": [v, k], "kv_fence": [k, v] + fence,
              "vfirst_fence": [v] + fence + [k]}
    valid.body[ki:vi+1] = orders[mode]
    ast.fix_missing_locations(function)
    return ast.unparse(function)


def main():
    records = []
    for mode in ("vfirst", "kv_fence", "vfirst_fence"):
        lines = SOURCE.splitlines(keepends=True)
        edits = []
        for fn in ast.parse(SOURCE).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in TARGETS:
                start = min(d.lineno for d in fn.decorator_list) - 1
                edits.append((start, fn.end_lineno, transform(fn, mode) + "\n"))
        for start, end, value in reversed(edits):
            lines[start:end] = [value]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"small_{mode}.py"
        with path.open("x") as output:
            output.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(), mode=mode))
    with (HERE / "small_load_order_manifest.json").open("x") as output:
        json.dump(dict(parent_sha256=hashlib.sha256(SOURCE.encode()).hexdigest(), variants=records,
                       note="Original Q fence retained; ordinary warp fence added only in two variants; no shared memory"), output, indent=2)
        output.write("\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
