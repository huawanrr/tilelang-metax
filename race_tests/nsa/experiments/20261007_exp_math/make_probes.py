"""Compare supported TileLang exponential operations without backend changes."""
import ast
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"
FUNCTIONS = (
    "native_sparse_attention_online_packed",
    "native_sparse_attention_online_packed_batch_minor_o_v2",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2",
    "native_sparse_attention_single_packed_qo_v2",
)


def main():
    source = BASE.read_text()
    tree = ast.parse(source)
    lines = source.splitlines(keepends=True)
    functions = {n.name: n for n in tree.body if isinstance(n, ast.FunctionDef)}
    expression = re.compile(
        r"T\.exp2\(\s*T\.min\((acc_s|scores)\[i, j\] \* scale_log2, 15\.0\)\)"
    )
    variants = []
    for mode in ("exp_preserve", "exp_folded", "fast_exp_preserve"):
        result = source
        changes = []
        for name in FUNCTIONS:
            node = functions[name]
            first = min([node.lineno] + [n.lineno for n in node.decorator_list]) - 1
            old = "".join(lines[first:node.end_lineno])

            def replace(match):
                score = match[1] + "[i, j]"
                if mode == "exp_folded":
                    return (f"T.exp(T.min({score} * (scale_log2 * 0.6931471805599453), "
                            "10.39720770839918))")
                op = "T.__exp" if mode == "fast_exp_preserve" else "T.exp"
                return f"{op}(T.min({score} * scale_log2, 15.0) * 0.6931471805599453)"

            new, count = expression.subn(replace, old)
            assert count > 0, name
            assert result.count(old) == 1
            result = result.replace(old, new)
            changes.append(dict(function=name, expressions=count))
        after = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert all(ast.dump(functions[n]) == ast.dump(after[n])
                   for n in functions if n not in FUNCTIONS)
        target = HERE / f"{mode}.py"
        with target.open("x") as f:
            f.write(result)
        variants.append(dict(path=str(target.relative_to(ROOT)), changes=changes,
                             sha256=hashlib.sha256(target.read_bytes()).hexdigest()))
    report = dict(baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
                  variants=variants,
                  scope="Research only; no dispatch, packing, synchronization or backend changes.")
    (HERE / "assembly.json").write_text(json.dumps(report, indent=2) + "\n")
    print("Generated", len(variants), "exponential probes")


if __name__ == "__main__":
    main()
