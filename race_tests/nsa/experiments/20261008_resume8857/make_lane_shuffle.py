"""Use the already-known 64-thread lane number for denominator shuffles."""
import ast
import copy
from pathlib import Path

HERE = Path(__file__).resolve().parent
names = {
    "native_sparse_attention_direct_kv", "native_sparse_attention_tiny_preload",
    "native_sparse_attention_linear_v_blocks_oct8",
    "_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
    "native_sparse_attention_short_list_oct8",
}


class Shuffle(ast.NodeTransformer):
    count = 0

    def visit_Call(self, node):
        node = self.generic_visit(node)
        if ast.unparse(node.func) != "T.shfl_xor":
            return node
        assert len(node.args) == 4
        assert ast.literal_eval(node.args[2]) == 64
        assert ast.literal_eval(node.args[1]) in (16, 32)
        self.count += 1
        node.func = ast.parse("T.shfl_sync", mode="eval").body
        delta = ast.unparse(node.args[1])
        node.args[1] = ast.parse(f"(T.get_thread_binding() % 64) ^ {delta}", mode="eval").body
        return node


for parent_name, destination in (("baseline.py", "lane_shuffle.py"),
                                 ("tiny_qsync.py", "lane_shuffle_qsync.py")):
    base = (HERE / parent_name).read_text()
    source = base
    lines = base.splitlines(keepends=True)
    count = 0
    for node in ast.parse(base).body:
        if not isinstance(node, ast.FunctionDef) or node.name not in names:
            continue
        old = "".join(lines[min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1:node.end_lineno])
        transform = Shuffle()
        changed = transform.visit(copy.deepcopy(node))
        ast.fix_missing_locations(changed)
        expected = 2 if node.name.startswith("_coalesced") else 4
        assert transform.count == expected, (node.name, transform.count)
        count += transform.count
        assert source.count(old) == 1
        source = source.replace(old, ast.unparse(changed) + "\n", 1)
    ast.parse(source)
    with (HERE / destination).open("x") as file:
        file.write(source)
    print(destination, count, "shuffles")
