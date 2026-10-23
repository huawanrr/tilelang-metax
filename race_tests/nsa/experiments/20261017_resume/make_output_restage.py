"""Decouple shared read width from the final global store width.

The PV fragment has four contiguous halves per lane. Swizzle-4 supports that
store, but shared-to-global T.copy then also limits global vectorization to
four. An explicit coalesced register tile allows eight-half global stores.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def transform(original, swizzle):
    fn = copy.deepcopy(original)
    fn.decorator_list = []
    packed = "single_packed" in fn.name
    shared = "output_shared" if packed else "O_shared"
    width = "D" if packed else "BV"
    source = ast.unparse(fn)
    old = f"make_mma_swizzle_layout({shared}, vecSize=8)"
    assert source.count(old) == 1
    source = source.replace(old, f"make_mma_swizzle_layout({shared}, vecSize={swizzle})")
    fn = ast.parse(source).body[0]
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    final = scope.body[-1]
    assert isinstance(final, ast.Expr) and ast.unparse(final.value.func) == "T.copy"
    assert ast.unparse(final.value.args[0]) == shared
    coalesced = ast.parse(f"""
output_coalesced = T.alloc_fragment([G, {width}], T.float16)
T.annotate_layout({{output_coalesced: T.Fragment([G, {width}],
    forward_thread_fn=lambda rg, rd: (rg * {width} + rd) // 8 % 64,
    forward_index_fn=lambda rg, rd: (rg * {width} + rd) // 512 * 8 + rd % 8)}})
T.copy({shared}, output_coalesced)
""").body
    final.value.args[0] = ast.Name(id="output_coalesced", ctx=ast.Load())
    scope.body[-1:] = coalesced + [final]
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    funcs = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for vec in (4, 8):
        result = source
        for name in sorted(NAMES):
            fn = funcs[name]
            result = result.replace(ast.get_source_segment(source, fn), transform(fn, vec), 1)
        ast.parse(result)
        path = HERE / f"output_restage_s{vec}_g8.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, shared_swizzle=vec, global_half_width=8,
                            sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE / "output_restage_manifest.json").write_text(json.dumps(dict(
        parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        changed_functions=sorted(NAMES), arithmetic_unchanged=True,
        barriers_unchanged=True, packing_and_dispatch_unchanged=True), indent=2) + "\n")
    print("Generated", len(records), "shared/global output transfer probes")


if __name__ == "__main__":
    main()
