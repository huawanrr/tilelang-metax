"""Exchange output column bits inside a wave, then store eight/sixteen halves.

The original MMA layout has row bits in lane[0:4], column[2:4] in
lane[4:6], and column[4:] in the register index. A butterfly exchanges
lane bit 4 with column bit 4. Optionally repeat for lane/column bit 5.
All lanes participate, including invalid queries whose output is zero.
"""
import ast
import hashlib
import json
import textwrap
from pathlib import Path

HERE = Path(__file__).resolve().parent
COALESCED = {
    "_coalesced_block_loads_prim_mathcast",
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_sum",
    "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
}
PACKED = "native_sparse_attention_single_packed_qo_v2_mathcast"
ONLINE = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def output_code(size, register, b, token, h, width):
    code = f"""
o_tid = T.get_thread_binding()
o_words = T.alloc_local([{size} // 8], T.uint32)
o_halves = T.Tensor([{size} // 4], T.float16, data=o_words.data, scope="local")
for o_chunk in T.unroll({size} // 16):
    for o_element in T.unroll(4):
        o_halves[o_chunk * 4 + o_element] = {register}[o_tid % 16, o_chunk * 16 + o_tid // 16 * 4 + o_element]
o_swap8 = T.alloc_local([{size} // 8], T.uint32)
for o_chunk32 in T.unroll({size} // 32):
    for o_word in T.unroll(2):
        o_low = o_words[o_chunk32 * 4 + o_word]
        o_high = o_words[o_chunk32 * 4 + 2 + o_word]
        o_recv = T.shfl_xor(T.if_then_else(o_tid % 32 < 16, o_high, o_low), 16, 64, 18446744073709551615)
        o_swap8[o_chunk32 * 4 + o_word] = T.if_then_else(o_tid % 32 < 16, o_low, o_recv)
        o_swap8[o_chunk32 * 4 + 2 + o_word] = T.if_then_else(o_tid % 32 < 16, o_recv, o_high)
"""
    if width == 8:
        code += f"""
o_store = T.Tensor([{size} // 4], T.float16, data=o_swap8.data, scope="local")
for o_chunk32 in T.unroll({size} // 32):
    for o_element in T.vectorized(8):
        Output[{b}, {token}, {h} * G + o_tid % 16, o_chunk32 * 32 + o_tid // 32 * 8 + o_tid % 32 // 16 * 16 + o_element] = o_store[o_chunk32 * 8 + o_element]
"""
    else:
        assert width == 16
        code += f"""
o_swap16 = T.alloc_local([{size} // 8], T.uint32)
for o_chunk64 in T.unroll({size} // 64):
    for o_word in T.unroll(4):
        o_low = o_swap8[o_chunk64 * 8 + o_word]
        o_high = o_swap8[o_chunk64 * 8 + 4 + o_word]
        o_recv = T.shfl_xor(T.if_then_else(o_tid < 32, o_high, o_low), 32, 64, 18446744073709551615)
        o_swap16[o_chunk64 * 8 + o_word] = T.if_then_else(o_tid < 32, o_low, o_recv)
        o_swap16[o_chunk64 * 8 + 4 + o_word] = T.if_then_else(o_tid < 32, o_recv, o_high)
o_store = T.Tensor([{size} // 4], T.float16, data=o_swap16.data, scope="local")
for o_chunk64 in T.unroll({size} // 64):
    for o_element in T.vectorized(16):
        Output[{b}, {token}, {h} * G + o_tid % 16, o_chunk64 * 64 + o_tid // 16 * 16 + o_element] = o_store[o_chunk64 * 16 + o_element]
"""
    return textwrap.indent(textwrap.dedent(code).strip() + "\n", " " * 12)


def transform(fn, name, width):
    if name in COALESCED:
        start = fn.index("            O_shared = T.alloc_shared")
        code = output_code("BV", "O_reg", "i_b", "i_t", "i_h", width)
    elif name == PACKED:
        start = fn.index("            output_shared = T.alloc_shared")
        code = output_code("D", "output_reg", "b", "token", "h", width)
    else:
        assert name in ONLINE
        fn = fn.replace("            O_shared = T.alloc_shared([G, BV], T.float16)\n", "", 1)
        fn = fn.replace("                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),\n", "", 1)
        start = fn.index("            T.copy(O_reg, O_shared)")
        code = output_code("BV", "O_reg", "i_b", "i_t", "i_h", width)
    end = fn.rindex("\n    return kernel")
    return fn[:start] + code + fn[end:]


def prove(dim, width):
    # Every word is an immutable pair of coordinates, so the proof includes
    # half ordering, lane selection, register selection and final coverage.
    data = [[tuple((tid % 16, slot // 2 * 16 + tid // 16 * 4 + slot % 2 * 2 + e)
                   for e in range(2)) for slot in range(dim // 8)] for tid in range(64)]
    for bit, pair_words in [(16, 2)] + ([(32, 4)] if width == 16 else []):
        after = [[None] * (dim // 8) for _ in range(64)]
        for tid in range(64):
            for chunk in range(dim // 8 // (2 * pair_words)):
                for w in range(pair_words):
                    lo = chunk * pair_words * 2 + w
                    hi = lo + pair_words
                    if tid & bit:
                        after[tid][lo] = data[tid ^ bit][hi]
                        after[tid][hi] = data[tid][hi]
                    else:
                        after[tid][lo] = data[tid][lo]
                        after[tid][hi] = data[tid ^ bit][lo]
        data = after
    covered = set()
    for tid in range(64):
        halves = [v for word in data[tid] for v in word]
        for chunk in range(dim // (4 * width)):
            col = chunk * 4 * width + (tid // 32 * 8 + tid % 32 // 16 * 16 if width == 8 else tid // 16 * 16)
            for e in range(width):
                expected = tid % 16, col + e
                actual = halves[chunk * width + e]
                assert actual == expected, (dim, width, tid, chunk, e, actual, expected)
                assert expected not in covered
                covered.add(expected)
    assert covered == {(i, d) for i in range(16) for d in range(dim)}
    return dict(dim=dim, width=width, elements=len(covered), result="PASS")


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    proofs = [prove(dim, width) for dim in (64, 128) for width in (8, 16)]
    for width in (8, 16):
        result = source
        changed = []
        for node in ast.parse(source).body:
            if isinstance(node, ast.FunctionDef) and node.name in COALESCED | ONLINE | {PACKED}:
                body = ast.get_source_segment(source, node)
                new = transform(body, node.name, width)
                assert new != body
                result = result.replace(body, new, 1)
                changed.append(node.name)
        assert len(changed) == 8
        ast.parse(result)
        path = HERE / f"output_exchange{width}.py"
        with path.open("x") as file:
            file.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(), changed=changed))
    (HERE / "output_exchange_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records, mappings=proofs), indent=2) + "\n")
    print("PASS", proofs, flush=True)


if __name__ == "__main__":
    main()
