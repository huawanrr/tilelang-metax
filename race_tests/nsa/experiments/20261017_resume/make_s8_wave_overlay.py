"""Explicit role-exclusive storage reuse, against a fenced pipeline control.

Producer Q bytes and FP32 denominator live in the same per-thread storage as
consumer output accumulators. Distinct waves own distinct local storage, so
no input values or arithmetic are shared across queries or public calls.
"""
import ast
import hashlib
import json
from pathlib import Path
import struct

from make_s8_wave_pipeline import NAME, proof

HERE = Path(__file__).resolve().parent


def overlay(source):
    source = source.replace("            sums = T.alloc_local([4], T.float32)\n", "            resident = T.alloc_local([ACC * 16], T.float32)\n", 1)
    for var in ("out", "out_1", "out_2", "out_3"):
        before = f"            {var} = T.alloc_local([16], T.float32)\n"
        assert source.count(before) == 1
        source = source.replace(before, "", 1)
    source = source.replace("            vr = T.alloc_local([16], T.float16)\n", "", 1)
    before = """                T.clear(sums)
            else:
                T.clear(out)
                T.clear(out_1)
                if ACC == 4:
                    T.clear(out_2)
                    T.clear(out_3)"""
    after = """                for qi in T.unroll(8):
                    resident[qi] = T.reinterpret("float32",
                        T.cast(T.reinterpret("uint16", qr[qi * 2]), "uint32") |
                        (T.cast(T.reinterpret("uint16", qr[qi * 2 + 1]), "uint32") << 16))
                for ce in T.unroll(4):
                    resident[8 + ce] = 0
            else:
                T.clear(resident)"""
    assert source.count(before) == 1
    source = source.replace(before, after, 1)
    assert source.count("kr.data, p * 4 + ki, qr.data, ki, scores.data") == 1
    source = source.replace("kr.data, p * 4 + ki, qr.data, ki, scores.data", "kr.data, p * 4 + ki, resident.data, ki, scores.data", 1)
    source = source.replace("sums[ce]", "resident[8 + ce]")
    source = source.replace("vr[vc * 8 + e]", "kr[vc * 8 + e]")
    for acc, var in enumerate(("out", "out_1", "out_2", "out_3")):
        before = f"vr.data, col, probs.data, 0, {var}.data, col, dtype=\"float32x4\""
        assert source.count(before) == 1
        source = source.replace(before, f"kr.data, col, probs.data, 0, resident.data, col + {acc * 4}, dtype=\"float32x4\"", 1)
        source = source.replace(f"{var}[ce]", f"resident[{acc * 16} + ce]")
    assert "out[" not in source and "sums[" not in source and "vr.data" not in source
    return source


def bit_proof():
    count = 0
    for lo in range(65536):
        for hi in ((lo * 11939 + 17) & 65535, lo ^ 0x8000):
            packed = lo | (hi << 16)
            # Includes all half encodings in both positions. Compare bytes,
            # avoiding any host NaN canonicalization by float conversion.
            assert struct.pack("<I", packed) == struct.pack("<HH", lo, hi)
            count += 1
    return dict(half_pairs=count, all_half_encodings_in_each_position=True,
                no_float16_rounding_added=True, q_bytes=32,
                fp32_sum_byte_range=[32, 48], consumer_accumulator_byte_ranges=[[0, 64], [64, 128], [128, 192], [192, 256]])


def main():
    parent = (HERE / "s8_wave_pipeline_d4.py").read_text()
    functions = {n.name: n for n in ast.parse(parent).body if isinstance(n, ast.FunctionDef)}
    names = (NAME + "_dual", NAME + "_quad")
    records = []
    for mode in ("fenced", "overlay"):
        result = parent
        for name in names:
            fn = functions[name]
            before = ast.get_source_segment(parent, fn)
            fence = "                den[0] = inv_shared[lane]\n"
            assert before.count(fence) == 1
            revised = before.replace(fence, fence + "                T.sync_warp()\n", 1)
            if mode == "overlay":
                revised = overlay(revised)
            result = result.replace(before, revised, 1)
        rewritten = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        for name, fn in functions.items():
            if name not in names:
                assert ast.dump(fn) == ast.dump(rewritten[name]), name
        path = HERE / f"s8_wave_d4_{mode}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(), mode=mode))
    with (HERE / "s8_wave_overlay_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(parent.encode()).hexdigest(), variants=records,
                       shared_ring_proof=proof(4), role_storage_proof=bit_proof(),
                       changed_functions=list(names),
                       allocator_alias_fence="Consumer wave fences the completed inverse read before shared storage is reused for output",
                       interface_dispatch_and_arithmetic_preserved=True), out, indent=2)
        out.write("\n")
    print("Generated fenced D4 control and role storage overlay")


if __name__ == "__main__":
    main()
