"""Explicitly reuse the same Q/output shared tile across pair iterations."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_window_pairs import ATTENTION

HERE = Path(__file__).resolve().parent


def transform(fn):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    index = next(i for i, n in enumerate(scope.body) if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "output_shared")
    assert ast.unparse(scope.body[index]) == "output_shared = T.alloc_shared([G, D], T.float16)"
    assert ast.unparse(scope.body[index+1]) == "T.annotate_layout({output_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)})"
    del scope.body[index:index+2]

    class OneBuffer(ast.NodeTransformer):
        def visit_Name(self, node):
            if node.id == "output_shared":
                node.id = "q_shared"
            return node
    return OneBuffer().visit(fn)


def main():
    records = []
    for mode in ("serial", "phases"):
        parent = HERE / f"window_pair_records_{mode}.py"
        source = parent.read_text()
        fn = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == ATTENTION + "_window_pairs")
        lines = source.splitlines(keepends=True)
        begin = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
        lines[begin:fn.end_lineno] = [ast.unparse(ast.fix_missing_locations(transform(fn))) + "\n"]
        result = "".join(lines)
        ast.parse(result)
        dest = HERE / f"window_pair_shared_{mode}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(path=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            parent=parent.name, parent_sha256=hashlib.sha256(source.encode()).hexdigest()))
    with (HERE / "window_pair_shared_manifest.json").open("x") as out:
        json.dump(dict(variants=records, synchronizations_unchanged=True,
            proof=["The CTA is a single 64-lane wave and all metadata branches are wave-uniform.",
                   "Q shared reads finish before the existing pre-output wave fence.",
                   "Output shared reads finish before the pair's existing trailing wave fence.",
                   "The phased variant also has a wave fence after each QK iteration.",
                   "Both old shared arrays had the same shape, dtype, and vecSize=8 swizzle."],
            index_and_arithmetic_and_dispatch_unchanged=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "single shared tile probes")


if __name__ == "__main__":
    main()
