"""Use FP32 MMA for S8's final lane sum, optionally before output merging."""
import ast
import copy
import hashlib
import json
from pathlib import Path
from make_small_math import HELPER, Reciprocal

HERE = Path(__file__).resolve().parent
NAMES = {"native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
         "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast"}


def change(fn, early, newton):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    pos = fn.body.index(kernel)
    fn.body[pos:pos] = ast.parse('''
s8_sum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32",
    a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1,
    warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)
''').body
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body[:0] = ast.parse('''
s8_one = T.alloc_local([1], T.float32)
s8_total = T.alloc_fragment([G, 16], T.float32)
s8_lane = T.alloc_fragment([G, 4], T.float32)
T.annotate_layout({s8_total: s8_sum.make_mma_store_layout(s8_total),
    s8_lane: T.Fragment([G, 4], forward_thread_fn=lambda si, sj: si + sj * 16,
                       forward_index_fn=lambda si, sj: 0)})
T.fill(s8_one, 1.0)
''').body
    pos = next(i for i,n in enumerate(scope.body) if ast.unparse(n).startswith("T.reduce_sum(sum_acc,"))
    assert all(isinstance(n, ast.For) for n in scope.body[pos+1:pos+3])
    merged = scope.body[pos-1]
    new = ast.parse('''
for i, lane in T.Parallel(G, 4):
    s8_lane[i, lane] = 0.0
    for chunk in T.unroll(BS // 16):
        for j in T.unroll(4):
            s8_lane[i, lane] += sum_acc[i, chunk * 16 + lane * 4 + j]
T.clear(s8_total)
s8_sum.mma(s8_lane, s8_one, s8_total, 0)
for i, lane in T.Parallel(G, 4):
    s8_lane[i, lane] = T.if_then_else(s8_total[i, lane * 4] > 0,
                                     1.0 / s8_total[i, lane * 4], 0.0)
for i, j in T.Parallel(G, BV):
    acc_o[i, j] *= s8_lane[i, j % 16 // 4]
''').body
    if early:
        scope.body[pos-1:pos+3] = new[:-1] + [merged, new[-1]]
    else:
        scope.body[pos:pos+3] = new
    if newton:
        fn = Reciprocal().visit(fn)
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for early, newton in ((False, False), (True, False), (True, True)):
        revised = source
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in NAMES:
                revised = revised.replace(ast.get_source_segment(source, fn), change(fn, early, newton), 1)
        if newton:
            at = revised.index("def _clamped_load_base(")
            revised = revised[:at] + HELPER + revised[at:]
        ast.parse(revised)
        path = HERE / f"s8_sum_e{int(early)}_n{int(newton)}.py"
        with path.open("x") as out:
            out.write(revised)
        records.append(dict(path=path.name, early=early, newton=newton,
            sha256=hashlib.sha256(revised.encode()).hexdigest()))
    with (HERE / "s8_sum_manifest.json").open("x") as out:
        json.dump(dict(variants=records, baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
            scope="Two packed mathcast builders only; unchanged packing and synchronization"), out, indent=2)
        out.write("\n")
    print("Generated three S8 sum probes", flush=True)


if __name__ == "__main__":
    main()
