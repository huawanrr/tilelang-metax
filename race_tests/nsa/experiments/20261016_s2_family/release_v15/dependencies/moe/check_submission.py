#!/usr/bin/env python3
"""Reject anything the OJ's sandbox would reject, before submitting.

The grader runs the submission through `triton_sandbox`, which walks the module's
top-level AST and raises `LanguageValidationError` on, among other things, a
global assignment whose right-hand side is not a literal:

    Global variable assignment must have literal values on the right side.
    Got: _enable_maca_k_pack(2)

That check is invisible locally -- the file imports and runs fine -- so several
submissions were rejected while the OJ kept reporting the last accepted result,
which is why three "different" kernels all measured 14.1-14.2 ms.  This script
reproduces the rules we know about so the failure shows up here instead.

    python check_submission.py submission.py
"""
import argparse
import ast
import sys


ALLOWED_IMPORT_ROOTS = ("torch", "tilelang")


def _import_problems(mod):
    """Every import in the file, at any nesting depth, must be torch or tilelang.

    The sandbox validates imports statically and per function ("Common validation
    failed for '_k_pack_on': Import 'os' is not allowed"), so putting one inside a
    function or a try/except does not hide it.  Reach library internals with an
    attribute walk instead.
    """
    problems = []
    for node in ast.walk(mod):
        if isinstance(node, ast.Import):
            names = [a.name for a in node.names]
        elif isinstance(node, ast.ImportFrom):
            names = [node.module or ""]
        else:
            continue
        for name in names:
            if name.split(".")[0] not in ALLOWED_IMPORT_ROOTS:
                problems.append(
                    f"line {node.lineno}: import of {name!r} is forbidden "
                    f"(only {', '.join(ALLOWED_IMPORT_ROOTS)})")
    return problems


def check(path):
    src = open(path).read()
    problems = []
    try:
        mod = ast.parse(src)
    except SyntaxError as exc:
        return [f"syntax error: {exc}"]

    problems.extend(_import_problems(mod))

    for node in mod.body:
        line = getattr(node, "lineno", 0)
        if isinstance(node, (ast.Import, ast.ImportFrom, ast.FunctionDef,
                             ast.AsyncFunctionDef, ast.ClassDef)):
            continue
        if isinstance(node, ast.Expr) and isinstance(node.value, ast.Constant):
            continue  # module docstring
        if isinstance(node, ast.Assign):
            try:
                ast.literal_eval(node.value)
            except Exception:
                problems.append(
                    f"line {line}: global assignment is not a literal -> "
                    f"{ast.unparse(node)[:100]}")
            continue
        if isinstance(node, ast.AnnAssign):
            problems.append(f"line {line}: annotated global -> {ast.unparse(node)[:100]}")
            continue
        problems.append(
            f"line {line}: top-level {type(node).__name__} (only imports, defs and "
            f"literal assignments are safe) -> {ast.unparse(node).splitlines()[0][:80]}")

    # `run_kernel` must exist with the exact positional signature and no
    # annotations -- the sandbox restricts access to torch.Tensor, so an
    # annotation can fail at import.
    expected = [
        "stacked_expert_tokens", "gate_w", "up_w", "down_w",
        "routed_expert_weights", "group_sizes", "group_offsets",
        "group_padded_offsets", "group_idx_for_bx", "out",
    ]
    fn = next((n for n in mod.body
               if isinstance(n, ast.FunctionDef) and n.name == "run_kernel"), None)
    if fn is None:
        problems.append("no top-level run_kernel()")
    else:
        names = [a.arg for a in fn.args.args]
        if names != expected:
            problems.append(f"run_kernel signature is {names}, expected {expected}")
        if any(a.annotation is not None for a in fn.args.args) or fn.returns is not None:
            problems.append("run_kernel must carry no type annotations")
    return problems


def main():
    p = argparse.ArgumentParser()
    p.add_argument("paths", nargs="*", default=["submission.py"])
    args = p.parse_args()
    bad = 0
    for path in args.paths or ["submission.py"]:
        problems = check(path)
        if problems:
            bad += 1
            print(f"{path}: {len(problems)} problem(s)")
            for pr in problems:
                print(f"  {pr}")
        else:
            print(f"{path}: OK")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
