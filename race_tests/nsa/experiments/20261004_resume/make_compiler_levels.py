"""Test optimization/vectorization choices through TileLang's public flags API."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"


def with_flags(source, flags):
    tree = ast.parse(source)
    offsets = []
    total = 0
    for line in source.splitlines(keepends=True):
        offsets.append(total)
        total += len(line)
    edits = []
    for function in tree.body:
        if not isinstance(function, ast.FunctionDef):
            continue
        for decorator in function.decorator_list:
            call = decorator if isinstance(decorator, ast.Call) else None
            target = call.func if call else decorator
            if not (isinstance(target, ast.Attribute) and isinstance(target.value, ast.Name)
                    and target.value.id == "tilelang" and target.attr == "jit"):
                continue
            if call:
                assert not any(k.arg == "compile_flags" for k in call.keywords)
                at = offsets[target.end_lineno - 1] + target.end_col_offset + 1
                edits.append((at, f"compile_flags={flags!r}, "))
            else:
                at = offsets[decorator.end_lineno - 1] + decorator.end_col_offset
                edits.append((at, f"(compile_flags={flags!r})"))
    for at, text in sorted(edits, reverse=True):
        source = source[:at] + text + source[at:]
    # The function bodies and every existing pass configuration must be identical.
    updated = ast.parse(source)
    for node in ast.walk(updated):
        if (isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute)
                and node.func.attr == "jit"):
            node.keywords = [k for k in node.keywords if k.arg != "compile_flags"]
    for function in updated.body:
        if isinstance(function, ast.FunctionDef):
            function.decorator_list = [d.func if isinstance(d, ast.Call) and not d.args and not d.keywords
                                       else d for d in function.decorator_list]
    assert ast.dump(tree) == ast.dump(updated)
    return source


def main():
    source = BASE.read_text()
    records = []
    for name, flags in (("compiler_o2", ["-O2"]),
                        ("compiler_no_slp", ["-fno-slp-vectorize"]),
                        ("compiler_o2_no_slp", ["-O2", "-fno-slp-vectorize"])):
        result = with_flags(source, flags)
        path = HERE / (name + ".py")
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path.relative_to(ROOT)), flags=flags,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    with (HERE / "compiler_levels_assembly.json").open("x") as f:
        f.write(json.dumps(dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
                               variants=records, unchanged_bodies=True, unchanged_tilelang_pass_configs=True,
                               hypothesis="Check whether SLP vectorization or O3 transformations increase register live ranges or memory instruction dependencies",
                               backend_changes=False), indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
