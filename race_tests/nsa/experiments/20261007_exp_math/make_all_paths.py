"""Research the same math substitution across the baseline's existing builders."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/nsa.py"
LN2 = 0.6931471805599453


def main():
    source = BASE.read_text()
    offsets = [0]
    for line in source.splitlines(keepends=True):
        offsets.append(offsets[-1] + len(line))
    calls = [n for n in ast.walk(ast.parse(source))
             if isinstance(n, ast.Call) and isinstance(n.func, ast.Attribute)
             and isinstance(n.func.value, ast.Name) and n.func.value.id == "T"
             and n.func.attr == "exp2"]
    report = dict(baseline=str(BASE), variants=[])
    for mode in ("preserve", "folded"):
        result = source
        edits = []
        for call in calls:
            first = offsets[call.lineno - 1] + call.col_offset
            last = offsets[call.end_lineno - 1] + call.end_col_offset
            arg = call.args[0]
            folded = False
            if (mode == "folded" and isinstance(arg, ast.Call)
                    and isinstance(arg.func, ast.Attribute) and arg.func.attr == "min"
                    and len(arg.args) == 2 and isinstance(arg.args[0], ast.BinOp)
                    and isinstance(arg.args[0].op, ast.Mult)
                    and isinstance(arg.args[0].right, ast.Name)
                    and arg.args[0].right.id == "scale_log2"
                    and isinstance(arg.args[1], ast.Constant)
                    and arg.args[1].value == 15.0):
                score = ast.get_source_segment(source, arg.args[0].left)
                text = f"T.exp(T.min({score} * (scale_log2 * {LN2}), {15 * LN2}))"
                folded = True
            else:
                text = f"T.exp(({ast.get_source_segment(source, arg)}) * {LN2})"
            edits.append((first, last, text, folded))
        for first, last, text, _ in sorted(edits, reverse=True):
            result = result[:first] + text + result[last:]
        ast.parse(result)
        path = HERE / f"all_exp_{mode}.py"
        with path.open("x") as f:
            f.write(result)
        report["variants"].append(dict(path=str(path), expressions=len(edits),
            folded=sum(x[3] for x in edits), sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "all_paths_assembly.json").write_text(json.dumps(report, indent=2) + "\n")
    print("Generated", len(report["variants"]), "probes with", len(calls), "exp2 expressions")


if __name__ == "__main__":
    main()
