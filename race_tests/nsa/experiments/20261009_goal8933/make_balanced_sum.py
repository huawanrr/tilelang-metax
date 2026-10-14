"""Shorten the local four-value FP32 sum dependency chain before the wave reduction."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_fp32_wave_sum import TARGETS

HERE = Path(__file__).resolve().parent


class IndexValue(ast.NodeTransformer):
    def __init__(self, name, value):
        self.name, self.value = name, value

    def visit_Name(self, node):
        return ast.copy_location(ast.Constant(self.value), node) if node.id == self.name else node


class Balance(ast.NodeTransformer):
    def __init__(self):
        self.count = 0

    def visit_For(self, node):
        node = self.generic_visit(node)
        if not (isinstance(node.iter, ast.Call) and ast.unparse(node.iter) == "T.unroll(4)"
                and len(node.body) == 1 and isinstance(node.body[0], ast.AugAssign)):
            return node
        old = node.body[0]
        if not (isinstance(old.target, ast.Subscript)
                and ast.unparse(old.target.value) == "lane_sum"
                and isinstance(old.value, ast.Subscript)
                and ast.unparse(old.value.value) in ("scores", "acc_s")):
            return node
        assert isinstance(node.target, ast.Name) and isinstance(old.op, ast.Add)
        terms = [IndexValue(node.target.id, i).visit(copy.deepcopy(old.value)) for i in range(4)]
        value = ast.BinOp(ast.BinOp(terms[0], ast.Add(), terms[1]), ast.Add(),
                          ast.BinOp(terms[2], ast.Add(), terms[3]))
        self.count += 1
        return ast.copy_location(ast.AugAssign(old.target, ast.Add(), value), node)


def main():
    records = []
    for parent, name in (("parent.py", "balanced_sum"), ("fp32_wave_sum.py", "fp32_balanced_sum")):
        source = (HERE / parent).read_text()
        lines = source.splitlines(keepends=True)
        edits, counts = [], {}
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            worker = Balance()
            rewritten = worker.visit(copy.deepcopy(fn))
            ast.fix_missing_locations(rewritten)
            assert worker.count, fn.name
            counts[fn.name] = worker.count
            edits.append((start, fn.end_lineno, ast.unparse(rewritten) + "\n"))
        assert len(edits) == len(TARGETS)
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"{name}.py"
        with path.open("x") as output:
            output.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(),
            parent=str(HERE / parent), parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
            local_reductions=counts))
    with (HERE / "balanced_sum_manifest.json").open("x") as output:
        json.dump(dict(variants=records, note="Same four FP32 values, pairwise rather than sequential addition; no synchronization or masking change"), output, indent=2)
        output.write("\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
