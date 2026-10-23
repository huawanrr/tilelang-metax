"""Widen QK on the current S8 path, preserving original FP32 sum ownership."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_online_packed_wide_mathcast"
DUAL = "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast"
QUAD = "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast"


def proof(pair):
    k, v = set(), set()
    for p in range(pair):
        for c in range(2):
            for lane in range(64):
                for e in range(8):
                    kj, kd = p * 16 + lane % 16, c * 32 + lane // 16 * 8 + e
                    vj, vd = p * 16 + lane // 16 * 4 + e % 4, c * 32 + e // 4 * 16 + lane % 16
                    assert (kd // 32, (kd % 32 // 8) * 16 + kj % 16, kd % 8) == (c, lane, e)
                    assert (vd // 32, (vj % 16 // 4) * 16 + vd % 16, vd % 32 // 16 * 4 + vj % 4) == (c, lane, e)
                    assert (kj, kd) not in k and (vj, vd) not in v
                    k.add((kj, kd))
                    v.add((vj, vd))
    target = {(j, d) for j in range(pair * 16) for d in range(64)}
    assert k == v == target
    for acc in (2, 4):
        for valid_bits in range(256):
            old_order = [[s for s in range(8) if s % acc == a and valid_bits >> s & 1] for a in range(acc)]
            new_order = [[] for _ in range(acc)]
            denom_order = []
            for group in range(8 // pair):
                for p in range(pair):
                    s = group * pair + p
                    if valid_bits >> s & 1:
                        new_order[s % acc].append(s)
                        denom_order.append(s)
            assert new_order == old_order
            assert denom_order == [s for s in range(8) if valid_bits >> s & 1]
    return dict(vector_elements=len(k), all_validity_masks=256,
                accumulator_counts=[2, 4], denominator_and_pv_order_preserved=True)


def main():
    base = (HERE / "baseline.py").read_text()
    template = (HERE / "s8_wide_template.py").read_text()
    old_functions = {n.name: n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)}
    dispatch = ast.get_source_segment(base, old_functions["_get_kernel"])
    records = []
    for pair in (2, 4, 8):
        additions = []
        for acc, label in ((2, "dual"), (4, "quad")):
            impl = template.replace(NAME, NAME + "_" + label, 1)
            impl = impl.replace("    PAIR = 2", f"    PAIR = {pair}", 1)
            impl = impl.replace("    ACC = 2", f"    ACC = {acc}", 1)
            additions.append(impl)
        revised = dispatch.replace("    key = (B, seq_len,", "    wide_s8 = mathcast_s8 and (seq_len + block_size - 1) // block_size >= S\n    key = (B, seq_len,", 1)
        revised = revised.replace("small_coalesced_blocks, s2_wave_output)", "small_coalesced_blocks, s2_wave_output, wide_s8)", 1)
        for old_name, label in ((DUAL, "dual"), (QUAD, "quad")):
            before = "online_builder = " + old_name + "\n"
            assert revised.count(before) == 1
            revised = revised.replace(before, "online_builder = " + NAME + "_" + label + " if wide_s8 else " + old_name + "\n", 1)
        result = base.replace(dispatch, "\n\n".join(additions) + "\n\n" + revised, 1)
        functions = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        for name, fn in old_functions.items():
            if name != "_get_kernel":
                assert ast.dump(fn) == ast.dump(functions[name]), name
        dest = HERE / f"s8_wide_p{pair}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            pair=pair, proof=proof(pair)))
    with (HERE / "s8_wide_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(base.encode()).hexdigest(),
                       template_sha256=hashlib.sha256(template.encode()).hexdigest(),
                       original_functions_ast_unchanged_except_dispatch=True,
                       default_mathcast_scope_and_separate_cache=True,
                       all_launches_in_public_call=True, variants=records), out, indent=2)
        out.write("\n")
    print("Generated 3 wide S8 probes; vector mapping and all validity masks checked")


if __name__ == "__main__":
    main()
