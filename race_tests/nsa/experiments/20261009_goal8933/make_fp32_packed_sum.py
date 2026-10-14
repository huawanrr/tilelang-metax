"""Use the FP32 lane-sum MMA in the current packed attention builders."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = (HERE / "parent.py").read_text()
TARGETS = {"native_sparse_attention_single_packed_qo_v2_mathcast",
           "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
           "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast"}


class PackedSum(ast.NodeTransformer):
    def __init__(self, denom, inv):
        self.denom, self.inv = denom, inv
        self.count = 0

    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        if isinstance(node.value, ast.Name) and node.value.id in {self.denom, self.inv}:
            node.slice = ast.Constant(0)
        return node

    def visit_Assign(self, node):
        node = self.generic_visit(node)
        if (len(node.targets) == 1 and isinstance(node.targets[0], ast.Name)
                and node.targets[0].id in {self.denom, self.inv}):
            assert ast.unparse(node.value.func) == "T.alloc_fragment"
            node.value.func = ast.parse("T.alloc_local", mode="eval").body
            node.value.args[0] = ast.parse("[1]", mode="eval").body
        return node

    def visit_For(self, node):
        node = self.generic_visit(node)
        if (len(node.body) == 1 and isinstance(node.body[0], ast.Assign)
                and ast.unparse(node.body[0].targets[0]) == f"{self.inv}[0]"):
            assert ast.unparse(node.iter) == "T.Parallel(G)"
            return node.body
        return node

    def visit_Expr(self, node):
        node = self.generic_visit(node)
        if not (isinstance(node.value, ast.Call) and ast.unparse(node.value.func) == "T.reduce_sum"):
            return node
        source, destination = map(ast.unparse, node.value.args[:2])
        assert destination == self.denom
        self.count += 1
        return ast.parse(f"""
for wi, wl in T.Parallel(G, 4):
    wsum_partial[wi, wl] = 0.0
    for wk in T.unroll(BS // 16):
        for we in T.unroll(4):
            wsum_partial[wi, wl] += {source}[wi, wk * 16 + wl * 4 + we]
T.clear(wsum_output)
wsum.mma(wsum_partial, wsum_unit, wsum_output, 0)
{self.denom}[0] = wsum_output[T.get_thread_binding() % 16, T.get_thread_binding() // 16 * 4]
""").body


def transform(function):
    function = copy.deepcopy(function)
    single = "single_" in function.name
    rewriter = PackedSum("denom" if single else "scores_sum", "inv" if single else "inv_sum")
    function = rewriter.visit(function)
    assert rewriter.count == (2 if single else 1)
    index = next(i for i, n in enumerate(function.body) if isinstance(n, ast.FunctionDef) and n.name == "kernel")
    kernel = function.body[index]
    function.body[index:index] = ast.parse("""
wsum = TensorCoreIntrinEmitter(a_dtype=T.float32, b_dtype=T.float32,
    accum_dtype=T.float32, a_transposed=False, b_transposed=False,
    block_row_warps=1, block_col_warps=1,
    warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)
""").body
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body[:0] = ast.parse("""
wsum_unit = T.alloc_local([1], T.float32)
wsum_partial = T.alloc_fragment([G, 4], T.float32)
wsum_output = T.alloc_fragment([G, 16], T.float32)
T.annotate_layout({wsum_partial: wsum.make_mma_load_layout(wsum_partial, 'A'),
                   wsum_output: wsum.make_mma_store_layout(wsum_output)})
T.fill(wsum_unit, 1.0)
""").body
    ast.fix_missing_locations(function)
    return ast.unparse(function)


def main():
    lines = SOURCE.splitlines(keepends=True)
    edits = []
    for fn in ast.parse(SOURCE).body:
        if isinstance(fn, ast.FunctionDef) and fn.name in TARGETS:
            start = min(d.lineno for d in fn.decorator_list) - 1
            edits.append((start, fn.end_lineno, transform(fn) + "\n"))
    assert len(edits) == len(TARGETS)
    for start, end, value in reversed(edits):
        lines[start:end] = [value]
    result = "".join(lines)
    ast.parse(result)
    path = HERE / "fp32_packed_sum.py"
    with path.open("x") as output:
        output.write(result)
    with (HERE / "fp32_packed_sum_manifest.json").open("x") as output:
        json.dump(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(),
                       parent_sha256=hashlib.sha256(SOURCE.encode()).hexdigest(),
                       builders=sorted(TARGETS), input_packing_and_sync_unchanged=True), output, indent=2)
        output.write("\n")
    print(path.name)


if __name__ == "__main__":
    main()
