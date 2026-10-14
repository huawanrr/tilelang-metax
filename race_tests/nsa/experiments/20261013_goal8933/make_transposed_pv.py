"""Transpose only PV, keeping the QK/probability layout and current input packing.

Swapping the MMA operands turns P @ V into V.T @ P.T without moving either
input fragment. The result uses a D x G fragment and writes directly to O.
The earlier transposed-QK experiment also transposed scores through shared;
this probe has no score conversion or additional shared-memory allocation.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def replace_once(text, old, new):
    assert text.count(old) == 1, (old, text.count(old))
    return text.replace(old, new, 1)


def packed(body):
    body = replace_once(body, "a_transposed=False, b_transposed=False,", "a_transposed=True, b_transposed=True,")
    body = replace_once(body, "warp_row_tiles=16, warp_col_tiles=W", "warp_row_tiles=W, warp_col_tiles=16")
    body = replace_once(body, "forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,", "forward_thread_fn=lambda oi, od: od % 16 + oi // 4 * 16,")
    body = replace_once(body, "forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4)", "forward_index_fn=lambda oi, od: od // 16 * 4 + oi % 4)")
    body = replace_once(body, "out = T.alloc_fragment([G, W], T.float32)", "out = T.alloc_fragment([W, G], T.float32)")
    body = replace_once(body, "v: pv.make_mma_load_layout(v, 'B')", "v: pv.make_mma_load_layout(v, 'A')")
    body = replace_once(body, "prob: pv.make_mma_load_layout(prob, 'A')", "prob: pv.make_mma_load_layout(prob, 'B')")
    body = replace_once(body, "pv.mma(prob, v, out, ki)", "pv.mma(v, prob, out, ki)")
    body = replace_once(body, "out[i, j] *= inv[i]", "out[j, i] *= inv[i]")
    old = """            for cast_chunk in T.unroll(W // 16):
                for cast_lane in T.unroll(4):
                    output_reg[T.get_thread_binding() % 16, vo * W + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = out[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
"""
    # The copy resides inside the vo loop and is indented one extra level.
    old = "\n".join("    " + line if line else line for line in old.rstrip("\n").split("\n")) + "\n"
    new = """                for i, d in T.Parallel(G, W):
                    output_reg[i, vo * W + d] = out[d, i]
"""
    body = replace_once(body, old, new)
    start = body.index("            output_shared = T.alloc_shared")
    end = body.index("    return kernel", start)
    body = body[:start] + "            T.copy(output_reg, Output[b, token, h * G:(h + 1) * G, :])\n" + body[end:]
    return body


def coalesced(body):
    body = replace_once(body,
        "pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)",
        "pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32, a_transposed=True, b_transposed=True, block_row_warps=1, block_col_warps=1, warp_row_tiles=VW, warp_col_tiles=16, chunk=BS, k_pack=1)")
    body = replace_once(body, "acc_o = T.alloc_fragment([G, VW], T.float32)", "acc_o = T.alloc_fragment([VW, G], T.float32)")
    body = replace_once(body,
        "forward_thread_fn=lambda i, d: i + d % 16 // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + d % 4",
        "forward_thread_fn=lambda i, d: d % 16 + i // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + i % 4")
    body = replace_once(body, "acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A')", "acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'B')")
    body = replace_once(body, "vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)", "vb = T.alloc_local([pv.warp_rows * pv.k_pack * pv.local_size_a], T.float16)")
    body = replace_once(body, "pv.mma(acc_s_cast, vb, acc_o, ki)", "pv.mma(vb, acc_s_cast, acc_o, ki)")
    old = """                for cast_chunk in T.unroll(VW // 16):
                    for cast_lane in T.unroll(4):
                        O_reg[T.get_thread_binding() % 16, vo * VW + cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_o[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
"""
    body = replace_once(body, old, """                for i, d in T.Parallel(G, VW):
                    O_reg[i, vo * VW + d] = acc_o[d, i]
""")
    start = body.index("            O_shared = T.alloc_shared")
    end = body.index("    return kernel", start)
    body = body[:start] + "            T.copy(O_reg, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])\n" + body[end:]
    return body


def main():
    source = (HERE / "baseline.py").read_text()
    funcs = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    targets = ["native_sparse_attention_single_packed_qo_v2_mathcast",
               "_coalesced_block_loads_prim_fp32_sum", "_coalesced_block_loads_prim_fp32_mask",
               "_coalesced_block_loads_prim_boundary_v8"]
    result = source
    for name in targets:
        old = ast.get_source_segment(source, funcs[name])
        new = packed(old) if name == targets[0] else coalesced(old)
        result = replace_once(result, old, new)
    ast.parse(result)
    path = HERE / "pv_transposed.py"
    with path.open("x") as output:
        output.write(result)
    (HERE / "pv_transposed_manifest.json").write_text(json.dumps(dict(
        source_sha256=hashlib.sha256(source.encode()).hexdigest(),
        output_sha256=hashlib.sha256(result.encode()).hexdigest(),
        changed_builders=targets, qk_and_probability_layout_unchanged=True), indent=2) + "\n")
    print(path)


if __name__ == "__main__":
    main()
