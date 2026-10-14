"""Exchange one register/lane bit, then store a fully contiguous D32 output tile."""

import ast
import hashlib
import json
from pathlib import Path

from prepare import BASE, HERE, ROOT, output_code, replace_tail


def full_code(acc, b="i_b", t="i_t", h="i_h", width=8):
    delta = 8 if width == 4 else 16
    source_lane = ("output_tid // 8 + output_tid // 4 % 2 * 8 + output_tid % 2 * 16 + output_tid // 2 % 2 * 32"
                   if width == 4 else "output_tid // 4 + output_tid // 2 % 2 * 16 + output_tid % 2 * 32")
    start = output_code(acc, "32", b, t, h, "0").split("            for output_word in T.unroll")[0]
    start += "            output_crossed = T.alloc_local([4], T.uint32)\n"
    for a in (0, 1):
        z = a + 2
        start += f'''            output_cross_{a} = T.shfl_xor(T.if_then_else(output_tid & {delta} == 0,
                output_words[{z}], output_words[{a}]), {delta}, 64, 0xffffffffffffffff)
            output_crossed[{a}] = T.if_then_else(output_tid & {delta} == 0, output_words[{a}], output_cross_{a})
            output_crossed[{z}] = T.if_then_else(output_tid & {delta} == 0, output_cross_{a}, output_words[{z}])
'''
    start += f'''            for output_word in T.unroll(4):
                output_exchanged[output_word] = T.shfl_sync(output_crossed[output_word],
                    {source_lane}, 64, 0xffffffffffffffff)
            for output_slot in T.unroll({8 // width}):
                for output_element in T.vectorized({width}):
                    output_linear = output_slot * {64 * width} + output_tid * {width} + output_element
                    Output[{b}, {t}, {h} * G + output_linear // 32,
                           output_linear % 32] = output_halves[output_slot * {width} + output_element]
'''
    return start


def prove(width):
    delta = 8 if width == 4 else 16
    raw = [[None] * 8 for _ in range(64)]
    for tid in range(64):
        for slot in range(2):
            for element in range(4):
                raw[tid][slot * 4 + element] = (tid % 16, slot * 16 + tid // 16 * 4 + element)
    crossed = [[None] * 4 for _ in range(64)]
    words = [[raw[tid][2 * i:2 * i + 2] for i in range(4)] for tid in range(64)]
    for tid in range(64):
        for a in (0, 1):
            z = a + 2
            source = tid ^ delta
            cross = words[source][z if source & delta == 0 else a]
            crossed[tid][a] = words[tid][a] if tid & delta == 0 else cross
            crossed[tid][z] = cross if tid & delta == 0 else words[tid][z]
    seen = set()
    for tid in range(64):
        source = (tid // 8 + tid // 4 % 2 * 8 + tid % 2 * 16 + tid // 2 % 2 * 32
                  if width == 4 else tid // 4 + tid // 2 % 2 * 16 + tid % 2 * 32)
        halves = sum(crossed[source], [])
        for slot in range(8 // width):
            for element in range(width):
                linear = slot * 64 * width + tid * width + element
                address = (linear // 32, linear % 32)
                assert halves[slot * width + element] == address
                assert address not in seen
                seen.add(address)
    assert len(seen) == 512
    return dict(width=width, elements=len(seen), unique_complete_stores=True, paired_half_identity=True)


def main():
    records = []
    for width in (4, 8):
        source = BASE.read_text()
        for name in (
            "native_sparse_attention_single_block_emitter_index_guard",
            "native_sparse_attention_single_block_emitter_wave_index_guard",
            "native_sparse_attention_d32_shuffle_wave_index_guard",
            "native_sparse_attention_d32_shuffle", "native_sparse_attention_d32_shuffle_wave",
        ):
            source = replace_tail(source, name, "            T.copy(acc_o, Output[", full_code("acc_o", width=width))
        source = replace_tail(source, "native_sparse_attention_d32_compact", "            T.copy(out, Output[",
                              full_code("out", "b", "t_0", "h", width))
        ast.parse(source)
        path = HERE / f"output_full{width}_d32.py"
        with path.open("x") as output:
            output.write(source)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            proof=prove(width)))
    with (HERE / "full_d32_assembly.json").open("x") as output:
        output.write(json.dumps(records, indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
