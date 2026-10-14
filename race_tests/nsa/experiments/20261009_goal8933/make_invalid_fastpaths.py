"""Compare deferred Q loads and direct zero stores for invalid S1 blocks."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = (HERE / "parent.py").read_text()
TARGETS = {"_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
           "native_sparse_attention_single_packed_qo_v2_mathcast"}


def is_qcopy(node):
    return isinstance(node, ast.Expr) and isinstance(node.value, ast.Call) and (
        ast.unparse(node.value.func) == "T.copy" and
        ast.unparse(node.value.args[0]).startswith("Q["))


def transform(function, mode):
    function = copy.deepcopy(function)
    kernel = next(n for n in function.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    body = scope.body
    qi = next(i for i, n in enumerate(body) if is_qcopy(n))
    guard_index = next(i for i, n in enumerate(body) if isinstance(n, ast.If) and (
        "_selected_block >= 0" in ast.unparse(n.test) or ast.unparse(n.test) == "valid"))
    guard = body[guard_index]
    predicate = copy.deepcopy(guard.test)
    qcopy = body[qi]
    packed = "single_packed" in function.name
    if mode == "guard_q":
        guard.body.insert(0, qcopy)
        del body[qi]
    else:
        if packed:
            zero = "for i, d in T.Parallel(G, D):\n    Output[b, token, h * G + i, d] = T.float16(0.0)"
        else:
            zero = "for i, d in T.Parallel(G, BV):\n    Output[i_b, i_t, i_h * G + i, d] = T.float16(0.0)"
        guarded = body[guard_index:]
        if mode == "guard_zero":
            guarded.insert(0, qcopy)
        scope.body = body[:guard_index] + [ast.If(
            test=predicate, body=guarded, orelse=ast.parse(zero).body)]
        if mode == "guard_zero":
            scope.body.remove(qcopy)
    ast.fix_missing_locations(function)
    return ast.unparse(function)


def main():
    original = ast.parse(SOURCE)
    lines = SOURCE.splitlines(keepends=True)
    reports = []
    for mode in ("guard_q", "zero_direct", "guard_zero"):
        changes = []
        for node in original.body:
            if isinstance(node, ast.FunctionDef) and node.name in TARGETS:
                start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
                changes.append((start, node.end_lineno, transform(node, mode) + "\n"))
        assert len(changes) == len(TARGETS)
        result = lines.copy()
        for start, end, value in reversed(changes):
            result[start:end] = [value]
        text = "".join(result)
        ast.parse(text)
        path = HERE / f"invalid_{mode}.py"
        with path.open("x") as output:
            output.write(text)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(text.encode()).hexdigest(),
                            mode=mode, builders=sorted(TARGETS)))
    with (HERE / "invalid_fastpath_manifest.json").open("x") as output:
        json.dump(dict(parent_sha256=hashlib.sha256(SOURCE.encode()).hexdigest(),
                       variants=reports, status="research"), output, indent=2)
        output.write("\n")
    print(json.dumps(reports, indent=2))


if __name__ == "__main__":
    main()
