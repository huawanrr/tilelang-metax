"""Probe splitting S2 output dimensions into independent CTAs.

Each output slice recomputes its own QK and normalization, so no cross-block
communication or new launch is required. All math and input guards are retained.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_short_list_oct8_sum_v11"


def once(source, before, after):
    assert source.count(before) == 1, (before, source.count(before))
    return source.replace(before, after, 1)


def main():
    records = []
    for parent, label in (("baseline.py", "auto"), ("s2_wave_q0_o1.py", "wave_o")):
        source = (HERE / parent).read_text()
        functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
        original = ast.get_source_segment(source, functions[NAME])
        for width in (16, 32):
            fn = once(original, "    BK = BV = min(128, tilelang.math.next_power_of_2(dim))\n",
                      f"    BK = min(128, tilelang.math.next_power_of_2(dim))\n    BV = {width}\n")
            # QK still spans the full head. Only the PV emitter becomes narrower.
            fn = once(fn, "    qk, pv = _emitters(T.float16, T.float32, BS, BK)\n", """    qk, unused_pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(
        a_dtype='float16', b_dtype='float16', accum_dtype='float32',
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BV, chunk=BS, k_pack=1)
""")
            fn = once(fn, "V[i_b, vpos, i_h, d]", "V[i_b, vpos, i_h, i_v * BV + d]")
            result = once(source, original, fn)
            updated = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
            assert [name for name in functions if ast.dump(functions[name]) != ast.dump(updated[name])] == [NAME]
            path = HERE / f"s2_pv{width}_{label}.py"
            with path.open("x") as out:
                out.write(result)
            records.append(dict(file=path.name, parent=parent,
                                parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                                sha256=hashlib.sha256(result.encode()).hexdigest(),
                                pv_width=width, changed_function=NAME))
    with (HERE / "s2_pv_split_manifest.json").open("x") as out:
        json.dump(dict(status="screening probes", variants=records), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "S2 PV-slice probes")


if __name__ == "__main__":
    main()
