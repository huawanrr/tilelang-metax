"""Accumulate one local denominator per lane, reducing persistent FP32 state."""
import ast
import copy
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
names = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


class LocalSum(ast.NodeTransformer):
    updates = 0
    allocations = 0

    def visit_Assign(self, node):
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Name) and node.targets[0].id == "sum_acc":
            assert ast.unparse(node.value) == "T.alloc_fragment([G, BS], T.float32)"
            self.allocations += 1
            return ast.parse(
                "sum_acc = T.alloc_fragment([G, 4], T.float32)\n"
                "T.annotate_layout({sum_acc: T.Fragment([G, 4], "
                "forward_thread_fn=lambda i, lane: i + lane * 16, "
                "forward_index_fn=lambda i, lane: 0)})\n").body
        return self.generic_visit(node)

    def visit_For(self, node):
        if (ast.unparse(node.iter) == "T.Parallel(G, BS)" and len(node.body) == 1
            and isinstance(node.body[0], ast.AugAssign)
            and ast.unparse(node.body[0].target) == "sum_acc[i, j]"):
            assert ast.unparse(node.body[0].value) == "acc_s[i, j]"
            self.updates += 1
            return ast.parse(
                "for i, lane in T.Parallel(G, 4):\n"
                "    for chunk in T.unroll(BS // 16):\n"
                "        sum_acc[i, lane] += ((acc_s[i, chunk * 16 + lane * 4] + "
                "acc_s[i, chunk * 16 + lane * 4 + 1]) + (acc_s[i, chunk * 16 + lane * 4 + 2] + "
                "acc_s[i, chunk * 16 + lane * 4 + 3]))\n").body[0]
        return self.generic_visit(node)


lines = base.splitlines(keepends=True)
source = base
for node in ast.parse(base).body:
    if not isinstance(node, ast.FunctionDef) or node.name not in names:
        continue
    transform = LocalSum()
    updated = transform.visit(copy.deepcopy(node))
    assert (transform.allocations, transform.updates) == (1, 5)
    ast.fix_missing_locations(updated)
    old = "".join(lines[min(d.lineno for d in node.decorator_list) - 1:node.end_lineno])
    assert source.count(old) == 1
    source = source.replace(old, ast.unparse(updated) + "\n", 1)
ast.parse(source)
with (HERE / "s8_lane_sum.py").open("x") as file:
    file.write(source)
print("s8_lane_sum.py")
