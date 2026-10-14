"""Issue all four safe K preloads before the existing per-block math guards.

Invalid slots read an in-range packed block that is never consumed. All original
math guards and score masks remain, including future and partial blocks.
"""
import ast
import copy
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
names = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


class SafeK(ast.NodeTransformer):
    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        if isinstance(node.value, ast.Name) and node.value.id == "K":
            assert isinstance(node.slice, ast.Tuple)
            index = node.slice.elts[1]
            node.slice.elts[1] = ast.parse(
                f"T.min(T.max({ast.unparse(index)}, 0), T.ceildiv(seq_len, BS) - 1)",
                mode="eval").body
        return node


class Prefetch(ast.NodeTransformer):
    count = 0

    def visit_If(self, node):
        test = ast.unparse(node.test)
        if test.startswith("prefetch_depth >") and len(node.body) == 1:
            body = node.body[0]
            if (isinstance(body, ast.For) and len(body.body) == 1
                and isinstance(body.body[0], ast.Assign)
                and isinstance(body.body[0].targets[0], ast.Subscript)
                and isinstance(body.body[0].targets[0].value, ast.Name)
                and body.body[0].targets[0].value.id.startswith("K_reg")):
                self.count += 1
                full = SafeK().visit(copy.deepcopy(body))
                return ast.If(test=ast.parse("S == 8 and prefetch_depth == 4", mode="eval").body,
                    body=[full], orelse=[node])
        return self.generic_visit(node)


lines = base.splitlines(keepends=True)
source = base
for node in ast.parse(base).body:
    if not isinstance(node, ast.FunctionDef) or node.name not in names:
        continue
    transform = Prefetch()
    updated = transform.visit(copy.deepcopy(node))
    assert transform.count == 4, (node.name, transform.count)
    ast.fix_missing_locations(updated)
    old = "".join(lines[min(d.lineno for d in node.decorator_list) - 1:node.end_lineno])
    assert source.count(old) == 1
    source = source.replace(old, ast.unparse(updated) + "\n", 1)
ast.parse(source)
with (HERE / "s8_safe_prefetch.py").open("x") as file:
    file.write(source)
print("s8_safe_prefetch.py")
