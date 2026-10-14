"""Apply FP32 lane-sum MMA and/or Newton reciprocal to S2 and S4 only."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_small_math import Reciprocal, HELPER

HERE = Path(__file__).resolve().parent
SHORT = "native_sparse_attention_short_list_oct8"
STAGED = "native_sparse_attention_staged_sparse_blocks"


class Sum(ast.NodeTransformer):
    def visit_For(self, node):
        node = self.generic_visit(node)
        shuffles = [n for n in node.body if isinstance(n, ast.AugAssign) and
                    isinstance(n.value, ast.Call) and ast.unparse(n.value.func) == "T.shfl_xor"]
        if len(shuffles) != 2:
            return node
        node.body = ast.parse('''lane_sum[i, lane] = T.if_then_else(
            short_sum_out[i, lane * 4] > 0, 1.0 / short_sum_out[i, lane * 4], 0.0)''').body
        return ast.parse("T.clear(short_sum_out)\nshort_sum.mma(lane_sum, short_sum_one, short_sum_out, 0)").body + [node]


def transform(fn, mma, newton):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    if mma:
        if fn.name == STAGED:
            at = next(i for i,n in enumerate(scope.body) if ast.unparse(n).startswith("T.reduce_sum(partial_sum,"))
            end = at + 3
            assert isinstance(scope.body[at+1], ast.For) and isinstance(scope.body[at+2], ast.For)
            scope.body[at:end] = ast.parse('''
lane_sum = T.alloc_fragment([G, 4], T.float32)
T.annotate_layout({lane_sum: T.Fragment([G, 4],
    forward_thread_fn=lambda si, sj: si + sj * 16, forward_index_fn=lambda si, sj: 0)})
for i, lane in T.Parallel(G, 4):
    lane_sum[i, lane] = 0.0
    for j in T.unroll(4):
        lane_sum[i, lane] += partial_sum[i, lane * 4 + j]
T.clear(short_sum_out)
short_sum.mma(lane_sum, short_sum_one, short_sum_out, 0)
for i, lane in T.Parallel(G, 4):
    lane_sum[i, lane] = T.if_then_else(short_sum_out[i, lane * 4] > 0,
                                     1.0 / short_sum_out[i, lane * 4], 0.0)
for i, j in T.Parallel(G, D):
    out[i, j] *= lane_sum[i, j % 16 // 4]
''').body
        else:
            assert fn.name == SHORT
            fn = Sum().visit(fn)
        at = fn.body.index(kernel)
        fn.body[at:at] = ast.parse('''
short_sum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32",
    a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1,
    warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)
''').body
        scope.body[:0] = ast.parse('''
short_sum_one = T.alloc_local([1], T.float32)
short_sum_out = T.alloc_fragment([G, 16], T.float32)
T.annotate_layout({short_sum_out: short_sum.make_mma_store_layout(short_sum_out)})
T.fill(short_sum_one, 1.0)
''').body
    if newton:
        fn = Reciprocal().visit(fn)
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for mma, newton in ((True, False), (False, True), (True, True)):
        result = source
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in (SHORT, STAGED):
                result = result.replace(ast.get_source_segment(source, fn), transform(fn, mma, newton), 1)
        if newton:
            at = result.index("def _clamped_load_base(")
            result = result[:at] + HELPER + result[at:]
        ast.parse(result)
        path = HERE / f"short_sum_r2_m{int(mma)}_n{int(newton)}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(), mma=mma, newton=newton))
    (HERE / "short_sum_r2_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        note="Changes only denominator computation. FP32 MMA types are literal strings; no changes to shared layouts or fences."), indent=2) + "\n")
    print("Generated three short denominator variants", flush=True)


if __name__ == "__main__":
    main()
