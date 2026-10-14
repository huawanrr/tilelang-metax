"""Use explicit owning-thread reads where parallel inference rejects four maps."""
import ast
import copy
from pathlib import Path

HERE = Path(__file__).resolve().parent
source = (HERE / "s8_lane_sum.py").read_text()
names = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


class ThreadIndex(ast.NodeTransformer):
    def visit_Name(self, node):
        if node.id == "i":
            return ast.parse("T.get_thread_binding() % 16", mode="eval").body
        if node.id == "lane":
            return ast.parse("T.get_thread_binding() // 16", mode="eval").body
        return node


class ScalarSum(ast.NodeTransformer):
    count = 0

    def visit_For(self, node):
        if (ast.unparse(node.iter) == "T.Parallel(G, 4)" and len(node.body) == 1
            and isinstance(node.body[0], ast.For) and "sum_acc[i, lane] +=" in ast.unparse(node)):
            self.count += 1
            return ThreadIndex().visit(copy.deepcopy(node.body[0]))
        return self.generic_visit(node)


tree = ast.parse(source)
lines = source.splitlines(keepends=True)
for node in tree.body:
    if not isinstance(node, ast.FunctionDef) or node.name not in names:
        continue
    old = "".join(lines[min(d.lineno for d in node.decorator_list) - 1:node.end_lineno])
    transform = ScalarSum()
    new = transform.visit(copy.deepcopy(node))
    assert transform.count == 5, (node.name, transform.count)
    ast.fix_missing_locations(new)
    assert source.count(old) == 1
    source = source.replace(old, ast.unparse(new) + "\n", 1)
ast.parse(source)
with (HERE / "s8_lane_sum_scalar.py").open("x") as file:
    file.write(source)
print("s8_lane_sum_scalar.py")
