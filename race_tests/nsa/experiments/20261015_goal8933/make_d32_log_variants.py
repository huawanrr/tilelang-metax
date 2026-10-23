"""Check reduction and normalization dependencies of the small D32 log signal."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_q_preload_vfirst"


class LogReciprocal(ast.NodeTransformer):
    def visit_Call(self, node):
        node = self.generic_visit(node)
        if isinstance(node.func, ast.Name) and node.func.id == "_small_newton2":
            assert len(node.args) == 1
            return ast.parse("T.exp(-T.log(" + ast.unparse(node.args[0]) + "))",
                             mode="eval").body
        return node


class SumMMA(ast.NodeTransformer):
    count = 0

    def visit_For(self, node):
        node = self.generic_visit(node)
        shuffles = [item for item in node.body
                    if isinstance(item, ast.AugAssign)
                    and isinstance(item.value, ast.Call)
                    and ast.unparse(item.value.func) == "T.shfl_xor"]
        if len(shuffles) != 2:
            return node
        self.count += 1
        node.body = ast.parse("""
lane_sum[i, lane] = T.if_then_else(tiny_sum_out[i, lane * 4] > 0,
                                  T.exp(-T.log(tiny_sum_out[i, lane * 4])), 0.0)
""").body
        return ast.parse("T.clear(tiny_sum_out)\ntiny_sum.mma(lane_sum, tiny_sum_one, tiny_sum_out, 0)").body + [node]


def transformed(original, mma, early):
    node = copy.deepcopy(original)
    node.decorator_list = []
    node = LogReciprocal().visit(node)
    if mma:
        transform = SumMMA()
        node = transform.visit(node)
        assert transform.count == 2
        kernel = next(item for item in node.body if isinstance(item, ast.FunctionDef))
        scope = next(item for item in kernel.body if isinstance(item, ast.With))
        pos = node.body.index(kernel)
        node.body[pos:pos] = ast.parse("""
tiny_sum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32",
    a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1,
    warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)
""").body
        scope.body[:0] = ast.parse("""
tiny_sum_one = T.alloc_local([1], T.float32)
tiny_sum_out = T.alloc_fragment([G, 16], T.float32)
T.annotate_layout({tiny_sum_out: tiny_sum.make_mma_store_layout(tiny_sum_out)})
T.fill(tiny_sum_one, 1.0)
""").body
    if early:
        node.body[:0] = ast.parse("late = False").body
    return ast.unparse(ast.fix_missing_locations(node))


def main():
    source = (HERE / "baseline.py").read_text()
    tree = ast.parse(source)
    functions = {fn.name: fn for fn in tree.body if isinstance(fn, ast.FunctionDef)}
    old = functions[NAME]
    old_text = ast.get_source_segment(source, old)
    rows = []
    for mma, early in ((False, False), (True, False), (False, True), (True, True)):
        revised = source.replace(old_text, transformed(old, mma, early), 1)
        result = {fn.name: fn for fn in ast.parse(revised).body if isinstance(fn, ast.FunctionDef)}
        assert {name for name in functions if ast.dump(functions[name]) != ast.dump(result[name])} == {NAME}
        compile(revised, NAME, "exec")
        path = HERE / f"d32_log_m{int(mma)}_e{int(early)}.py"
        with path.open("x") as file:
            file.write(revised)
        rows.append(dict(file=path.name, mma=mma, early=early,
                         sha256=hashlib.sha256(revised.encode()).hexdigest()))
    with (HERE / "d32_log_manifest.json").open("x") as file:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       changed_function=NAME, variants=rows,
                       reason="Follow up replicated log reciprocal signal; check interaction with FP32 MMA reduction and earlier normalization.",
                       unchanged="All other functions, public dispatch, packing, masks, checked adapters and synchronization."), file, indent=2)
        file.write("\n")
    print("Generated four D32 log/reduction/normalization probes")


if __name__ == "__main__":
    main()
