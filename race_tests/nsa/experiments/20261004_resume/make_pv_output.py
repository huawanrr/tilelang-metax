"""Isolate vector conversion and pair adjacent output dimensions by lane exchange."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for width in (128, 64):
        base = HERE / f"pv_transposed_w{width}.py"
        source = base.read_text()
        marker = """                for d, g in T.Parallel(W, G):
                    Output[b, token, h * G + g, vo * W + d] = out[d, g]
"""
        assert source.count(marker) == 1
        for mode in ("cast", "pair"):
            code = """                output_tid = T.get_thread_binding()
                output_raw = T.alloc_local([W // 4], T.float16)
                for output_slot in T.unroll(W // 16):
                    for output_element in T.vectorized(4):
                        output_raw[output_slot * 4 + output_element] = out[
                            output_slot * 16 + output_tid % 16, output_tid // 16 * 4 + output_element]
"""
            if mode == "cast":
                code += """                for output_slot in T.unroll(W // 16):
                    for output_element in T.unroll(4):
                        Output[b, token, h * G + output_tid // 16 * 4 + output_element,
                               vo * W + output_slot * 16 + output_tid % 16] = output_raw[
                                   output_slot * 4 + output_element]
"""
            else:
                code += """                output_words = T.Tensor([W // 8], T.uint32, data=output_raw.data, scope="local")
                output_pairs = T.alloc_local([W // 8], T.uint32)
                output_halves = T.Tensor([W // 4], T.float16, data=output_pairs.data, scope="local")
                for output_word in T.unroll(W // 8):
                    output_neighbor = T.shfl_xor(output_words[output_word], 1, 64, 0xffffffffffffffff)
                    output_pairs[output_word] = T.if_then_else(output_tid % 2 == 0,
                        (output_words[output_word] & T.uint32(65535)) | ((output_neighbor & T.uint32(65535)) << 16),
                        (output_neighbor >> 16) | (output_words[output_word] & T.uint32(4294901760)))
                for output_slot in T.unroll(W // 16):
                    for output_head in T.unroll(2):
                        for output_element in T.vectorized(2):
                            Output[b, token, h * G + output_tid // 16 * 4 + output_tid % 2 + output_head * 2,
                                   vo * W + output_slot * 16 + output_tid % 16 // 2 * 2 + output_element] = output_halves[
                                       output_slot * 4 + output_head * 2 + output_element]
"""
            result = source.replace(marker, code)
            ast.parse(result)
            path = HERE / f"pv_transposed_w{width}_{mode}.py"
            with path.open("x") as f:
                f.write(result)
            records.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                                base=str(base), base_sha256=hashlib.sha256(base.read_bytes()).hexdigest()))
    with (HERE / "pv_output_assembly.json").open("x") as f:
        f.write(json.dumps(dict(variants=records, math_unchanged=True), indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
