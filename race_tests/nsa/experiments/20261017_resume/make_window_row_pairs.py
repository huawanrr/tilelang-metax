"""Interleave the pair's MMA row tiles without allocating two shared tiles."""
import ast
import hashlib
import json
from pathlib import Path

from make_window_pairs import ATTENTION

HERE = Path(__file__).resolve().parent


def main():
    parent = HERE / "window_pair_shared_phases.py"
    source = parent.read_text()
    template = (HERE / "window_row_pair_template.py").read_text()
    target = ATTENTION + "_window_pairs"
    old = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == target)
    begin = min([old.lineno] + [d.lineno for d in old.decorator_list]) - 1
    lines = source.splitlines(keepends=True)
    original_dispatch = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == "_get_kernel")
    records = []
    for width in (64, 128):
        dispatch = ast.parse(ast.unparse(original_dispatch)).body[0]
        calls = [n for n in ast.walk(dispatch) if isinstance(n, ast.Call) and isinstance(n.func, ast.Name) and n.func.id == target]
        assert len(calls) == 1
        next(k for k in calls[0].keywords if k.arg == "width").value = ast.Constant(width)
        result = "".join(lines[:begin]) + template + "\n\n" + "".join(lines[old.end_lineno:])
        result = result.replace(ast.get_source_segment(source, original_dispatch), ast.unparse(ast.fix_missing_locations(dispatch)), 1)
        ast.parse(result)
        dest = HERE / f"window_row_pairs_w{width}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(path=dest.name, width=width, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "window_row_pairs_manifest.json").open("x") as out:
        json.dump(dict(parent=parent.name, parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
            template_sha256=hashlib.sha256(template.encode()).hexdigest(), variants=records,
            prep_unchanged=True, tensor_rows=32, one_query_shared_tile=True,
            fp32_mma_and_denominator=True,
            dummy_second_query="Zero Q, masked score, zero probability, no global output",
            shared_hazards="A wave fence precedes every reuse, and follows each shared write"), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "interleaved MMA pair probes")


if __name__ == "__main__":
    main()
