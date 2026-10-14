"""Reduce four FP32 lane sums with one 16x16x4 FP32 MMA.

Unlike the earlier FP16-probability denominator experiments, this keeps the
FP32 partial sums and the original normalization point before FP16 casting.
The constant-one right operand repeats each row sum across all output lanes.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = (HERE / "parent.py").read_text()
TARGETS = {"native_sparse_attention_q_preload", "native_sparse_attention_direct_kv",
           "native_sparse_attention_linear_v_blocks_oct8", "native_sparse_attention_short_list_oct8",
           "_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8"}


class SumTransform(ast.NodeTransformer):
    def __init__(self):
        self.count = 0

    def visit_For(self, node):
        node = self.generic_visit(node)
        shuffles = [n for n in node.body if isinstance(n, ast.AugAssign) and
                    isinstance(n.value, ast.Call) and ast.unparse(n.value.func) == "T.shfl_xor"]
        if len(shuffles) != 2:
            return node
        assert len(node.body) == 3
        assert [ast.literal_eval(n.value.args[1]) for n in shuffles] == [32, 16]
        target = shuffles[0].target
        assert isinstance(target, ast.Subscript) and ast.unparse(target.value) == "lane_sum"
        assert ast.unparse(node.target) == "(i, lane)"
        assignment = ast.parse("""
lane_sum[i, lane] = T.if_then_else(wsum_output[i, lane * 4] > 0,
                                 1.0 / wsum_output[i, lane * 4], 0.0)
""").body[0]
        node.body = [assignment]
        self.count += 1
        return ast.parse("T.clear(wsum_output)\nwsum.mma(lane_sum, wsum_unit, wsum_output, 0)").body + [node]


def transform(function):
    function = copy.deepcopy(function)
    rewriter = SumTransform()
    function = rewriter.visit(function)
    assert rewriter.count
    kernel_index = next(i for i, n in enumerate(function.body) if isinstance(n, ast.FunctionDef) and n.name == "kernel")
    setup = ast.parse("""
wsum = TensorCoreIntrinEmitter(a_dtype=T.float32, b_dtype=T.float32,
    accum_dtype=T.float32, a_transposed=False, b_transposed=False,
    block_row_warps=1, block_col_warps=1,
    warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)
""").body
    kernel = function.body[kernel_index]
    function.body[kernel_index:kernel_index] = setup
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body[:0] = ast.parse("""
wsum_unit = T.alloc_local([1], T.float32)
wsum_output = T.alloc_fragment([G, 16], T.float32)
T.annotate_layout({wsum_output: wsum.make_mma_store_layout(wsum_output)})
T.fill(wsum_unit, 1.0)
""").body
    ast.fix_missing_locations(function)
    return ast.unparse(function), rewriter.count


def main(destination="fp32_wave_sum", targets=None):
    selected = TARGETS if targets is None else targets
    lines = SOURCE.splitlines(keepends=True)
    edits, counts = [], {}
    for function in ast.parse(SOURCE).body:
        if isinstance(function, ast.FunctionDef) and function.name in selected:
            start = min([function.lineno] + [d.lineno for d in function.decorator_list]) - 1
            value, count = transform(function)
            edits.append((start, function.end_lineno, value + "\n"))
            counts[function.name] = count
    assert len(edits) == len(selected)
    for start, end, value in reversed(edits):
        lines[start:end] = [value]
    source = "".join(lines)
    ast.parse(source)
    path = HERE / f"{destination}.py"
    with path.open("x") as output:
        output.write(source)
    # For lane t, A[t%16, t//16] is its local FP32 partial sum. B is 1 in
    # every lane, so C[i,j] = sum(A[i,k], k=0..3) for every column j.
    points = [(t % 16, t // 16) for t in range(64)]
    assert len(set(points)) == 64
    assert set(points) == {(i, k) for i in range(16) for k in range(4)}
    for t in range(64):
        row, col = t % 16, t // 16 * 4
        assert row + col // 4 * 16 == t
    with (HERE / f"{destination}_manifest.json").open("x") as output:
        json.dump(dict(path=str(path), sha256=hashlib.sha256(source.encode()).hexdigest(),
                       parent_sha256=hashlib.sha256(SOURCE.encode()).hexdigest(),
                       replaced_reductions=counts, normalization_point_unchanged=True,
                       fp32_partial_sum_input_and_replicated_output_mapping="PASS"), output, indent=2)
        output.write("\n")
    print(path.name, counts)


if __name__ == "__main__":
    main()
