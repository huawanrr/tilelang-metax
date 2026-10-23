"""Remove comments/docstrings while retaining the exact remaining Python tokens."""
import argparse
import ast
import hashlib
import io
import json
from pathlib import Path
import tokenize


def no_docs(tree):
    for node in ast.walk(tree):
        if isinstance(node, (ast.Module, ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
            if len(node.body) > 1 and isinstance(node.body[0], ast.Expr) and isinstance(node.body[0].value, ast.Constant) and isinstance(node.body[0].value.value, str):
                node.body.pop(0)
    return tree


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source")
    parser.add_argument("output")
    args = parser.parse_args()
    source = Path(args.source).read_text()
    tree = ast.parse(source)
    drop = set()
    for node in ast.walk(tree):
        if isinstance(node, (ast.Module, ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)) and len(node.body) > 1:
            first = node.body[0]
            if isinstance(first, ast.Expr) and isinstance(first.value, ast.Constant) and isinstance(first.value.value, str):
                drop.update(range(first.lineno, first.end_lineno + 1))
    comments = {tok.start[0]: tok.start[1] for tok in tokenize.generate_tokens(io.StringIO(source).readline)
                if tok.type == tokenize.COMMENT}
    lines = []
    blanks = 0
    for index, line in enumerate(source.splitlines(keepends=True), 1):
        if index in drop:
            continue
        if index in comments:
            line = line[:comments[index]].rstrip() + "\n"
        if not line.strip():
            blanks += 1
            if blanks > 2:
                continue
        else:
            blanks = 0
        lines.append(line)
    result = "".join(lines)
    assert ast.dump(no_docs(ast.parse(source))) == ast.dump(ast.parse(result))
    target = Path(args.output)
    with target.open("x") as f:
        f.write(result)
    metadata = dict(source=args.source, output=args.output,
        source_sha256=hashlib.sha256(source.encode()).hexdigest(),
        output_sha256=hashlib.sha256(result.encode()).hexdigest(),
        ast_equal_ignoring_docstrings=True, compiled_equivalence_requires_device_audit=True)
    target.with_suffix(".strip.json").write_text(json.dumps(metadata, indent=2) + "\n")
    print(json.dumps(metadata, indent=2))


if __name__ == "__main__":
    main()
