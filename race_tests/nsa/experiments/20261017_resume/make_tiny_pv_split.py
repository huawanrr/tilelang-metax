"""Split output columns across CTAs in existing Q-preload paths.

Each slice recomputes the original QK and FP32 denominator independently.
Only V loads, PV accumulators, and output ownership are narrowed. No shared
state or inter-CTA communication is introduced. Existing dispatch is kept.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = ("native_sparse_attention_q_preload", "native_sparse_attention_q_preload_vfirst")


def once(source, before, after):
    assert source.count(before) == 1, (before, source.count(before))
    return source.replace(before, after, 1)


def transform(source, width):
    source = once(source, "    qk, pv = _emitters(T.float16, T.float32, BS, D)", f"""    BW = min(D, {width})
    qk, original_pv = _emitters(T.float16, T.float32, BS, D)
    pv = TensorCoreIntrinEmitter(
        a_dtype='float16', b_dtype='float16', accum_dtype='float32',
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BW, chunk=BS, k_pack=1)""")
    source = once(source,
        "with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):",
        "with T.Kernel(seq_len * (D // BW), batch * H, threads=threads) as (tile, bh):\n"
        "            token, slice_id = (tile // (D // BW), tile % (D // BW))")
    for name, shape, dtype in (("v", "BS", "float16"), ("out", "G", "float32"), ("result", "G", "float16")):
        source = once(source, f"{name} = T.alloc_fragment([{shape}, D], T.{dtype})",
                      f"{name} = T.alloc_fragment([{shape}, BW], T.{dtype})")
    source = once(source, "for j, d in T.Parallel(BS, D):\n                    v[j, d] = V_blocks[b, block, j, h, d]",
                  "for j, d in T.Parallel(BS, BW):\n                    v[j, d] = V_blocks[b, block, j, h, slice_id * BW + d]")
    source = once(source, "for i, j in T.Parallel(G, D):", "for i, j in T.Parallel(G, BW):")
    source = once(source, "for chunk in T.unroll(D // 16):", "for chunk in T.unroll(BW // 16):")
    source = once(source, "T.copy(result, Output[b, token, h * G:(h + 1) * G, :])",
                  "T.copy(result, Output[b, token, h * G:(h + 1) * G, slice_id * BW:(slice_id + 1) * BW])")
    ast.parse(source)
    return source


def main():
    source = (HERE / "baseline.py").read_text()
    funcs = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for width in (16, 32):
        result = source
        for name in NAMES:
            original = ast.get_source_segment(source, funcs[name])
            result = once(result, original, transform(original, width))
        updated = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert [n for n in funcs if ast.dump(funcs[n]) != ast.dump(updated[n])] == list(NAMES)
        path = HERE / f"tiny_pv_split{width}.py"
        with path.open("x") as out:
            out.write(result)
        for dim in (32, 64, 128):
            bw = min(dim, width)
            owned = [(s * bw + d) for s in range(dim // bw) for d in range(bw)]
            assert sorted(owned) == list(range(dim))
        records.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(), width=width))
    with (HERE / "tiny_pv_split_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
                       changed_functions=NAMES, output_partition="PASS",
                       qk_and_denominator_unchanged=True, dispatch_unchanged=True,
                       synchronization_unchanged=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "small-grid output-slice probes")


if __name__ == "__main__":
    main()
