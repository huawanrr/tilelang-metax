"""Assemble isolated replacements for the packed BS32 attention builder."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/submission.py"


def main():
    original = BASE.read_text()
    lines = original.splitlines(keepends=True)
    node = next(n for n in ast.parse(original).body if isinstance(n, ast.FunctionDef)
                and n.name == "native_sparse_attention_single_packed_qo_v2")
    begin = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    template = (HERE / "bs32_colwaves_template.py").read_text()
    template = template[template.index("@tilelang.jit"):]
    records = []
    for qv in (4, 8):
        for late in (False, True):
            fn = template.replace("QV_TEMPLATE", str(qv)).replace("LATE_TEMPLATE", str(late))
            source = "".join(lines[:begin]) + fn + "".join(lines[node.end_lineno:])
            ast.parse(source)
            path = HERE / f"bs32_colwaves_q{qv}_{'late' if late else 'early'}.py"
            with path.open("x") as f:
                f.write(source)
            records.append(dict(path=path.name, q_vec=qv, late_normalize=late,
                                sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "bs32_colwaves_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        math="Two waves divide QK's 32 keys, share probabilities, then compute disjoint PV output columns.",
        unchanged="Packing and host dispatch are identical to the baseline.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
