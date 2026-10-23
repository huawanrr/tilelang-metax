"""Confirm the previous Newton signal and test its local dependencies."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {"native_sparse_attention_q_preload_vfirst", "native_sparse_attention_q_preload",
         "native_sparse_attention_direct_kv"}
HELPER = '''def _small_newton2(value):
    y = T.reinterpret("float32", T.uint32(2129859011) - T.reinterpret("uint32", value))
    y = y * (2.0 - value * y)
    y = y * (2.0 - value * y)
    return y

'''


class Reciprocal(ast.NodeTransformer):
    def visit_BinOp(self, n):
        n = self.generic_visit(n)
        if isinstance(n.op, ast.Div) and isinstance(n.left, ast.Constant) and n.left.value == 1.0:
            return ast.Call(func=ast.Name(id="_small_newton2", ctx=ast.Load()), args=[n.right], keywords=[])
        return n


class FP32Sum(ast.NodeTransformer):
    def visit_For(self, n):
        n = self.generic_visit(n)
        shuffles = [s for s in n.body if isinstance(s, ast.AugAssign)
                    and isinstance(s.value, ast.Call) and ast.unparse(s.value.func) == "T.shfl_xor"]
        if len(shuffles) != 2:
            return n
        n.body = ast.parse('''lane_sum[i, lane] = T.if_then_else(
            small_sum_out[i, lane * 4] > 0, 1.0 / small_sum_out[i, lane * 4], 0.0)''').body
        return ast.parse("T.clear(small_sum_out)\nsmall_sum.mma(lane_sum, small_sum_one, small_sum_out, 0)").body + [n]


def transform(fn, mode):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    if mode == "nr2_late":
        fn.body[:0] = ast.parse("late = late or dim == 64").body
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    guard = next(n for n in scope.body if isinstance(n, ast.If) and "block >= 0" in ast.unparse(n.test))
    if "boundary" in mode:
        exp = next(n for n in guard.body if isinstance(n, ast.If) and ast.unparse(n.test) == "scale_log2 > 0")
        pos = guard.body.index(exp)
        guard.body[pos:pos+1] = ast.parse('''
for i, j in T.Parallel(G, BS):
    if natural:
        scores[i, j] = T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
    else:
        scores[i, j] = T.exp2(T.min(scores[i, j] * scale_log2, 15.0))
if is_causal and block == token // BS:
    for i, j in T.Parallel(G, BS):
        scores[i, j] = T.if_then_else(j <= token % BS, scores[i, j], T.float32(0.0))
''').body
    if mode == "nr2_mma":
        fn = FP32Sum().visit(fn)
        at = fn.body.index(kernel)
        fn.body[at:at] = ast.parse('''
small_sum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32",
    a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1,
    warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)
''').body
        scope.body[:0] = ast.parse('''
small_sum_one = T.alloc_local([1], T.float32)
small_sum_out = T.alloc_fragment([G, 16], T.float32)
T.annotate_layout({small_sum_out: small_sum.make_mma_store_layout(small_sum_out)})
T.fill(small_sum_one, 1.0)
''').body
    if mode.startswith("nr2"):
        fn = Reciprocal().visit(fn)
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for mode in ("nr2", "boundary", "nr2_boundary", "nr2_late", "nr2_mma"):
        result = source
        changed = []
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in NAMES:
                result = result.replace(ast.get_source_segment(source, fn), transform(fn, mode), 1)
                changed.append(fn.name)
        assert len(changed) == 3
        if mode.startswith("nr2"):
            at = result.index("def _clamped_load_base(")
            result = result[:at] + HELPER + result[at:]
        ast.parse(result)
        path = HERE / f"small_{mode}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, mode=mode, sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE / "small_math_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        note="Existing small direct/preload builders only; independent reference and denominator accuracy checks required."), indent=2) + "\n")
    cases = json.loads((HERE.parent / "20261013_goal8933/cases.json").read_text())
    for dim in (32, 64, 128):
        for length in (32, 64, 96, 128, 192, 256):
            for causal in (True, False):
                name = f"small_d{dim}_t{length}_c{int(causal)}"
                cases[name] = dict(B=1, SEQ_LEN=length, H=1, HQ=16, D=dim, S=1,
                                   block_size=16, is_causal=causal)
    (HERE / "cases.json").write_text(json.dumps(cases, indent=2) + "\n")
    print("Generated", len(records), "small math variants", flush=True)


if __name__ == "__main__":
    main()
