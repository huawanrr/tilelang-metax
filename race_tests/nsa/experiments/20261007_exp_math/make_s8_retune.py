"""Retune only S8 lookahead/accumulation after removing exp2's slow path."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "exp_folded.py"


def once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def main():
    source = BASE.read_text()
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == "_get_kernel")
    old = "".join(source.splitlines(keepends=True)[node.lineno - 1:node.end_lineno])
    variants = []
    for accumulators, depth in ((1, 1), (1, 2), (1, 4), (2, 2), (2, 4), (4, 2), (4, 4)):
        fn = once(old, "    key = (\n",
                  "    if S == 8 and use_emitter_online and grid >= 4096:\n"
                  f"        prefetch_depth = {depth}\n"
                  f"        dual_acc = {accumulators > 1}\n\n"
                  "    key = (\n")
        fn = once(fn, "            if S == 8 and grid >= 8192:\n",
                  f"            if S == 8 and grid >= {4096 if accumulators == 4 else 2147483647}:\n")
        result = once(source, old, fn)
        ast.parse(result)
        path = HERE / f"s8_exp_a{accumulators}_p{depth}.py"
        with path.open("x") as f:
            f.write(result)
        variants.append(dict(path=str(path), accumulators=accumulators, lookahead=depth,
            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "retune_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), scope="Only S8 grid >=4096; research, not release dispatch.",
        variants=variants), indent=2) + "\n")
    print("Generated", len(variants), "S8 scheduling probes")


if __name__ == "__main__":
    main()
