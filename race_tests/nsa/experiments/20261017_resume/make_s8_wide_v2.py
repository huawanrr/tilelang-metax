"""Fix eager frontend lambda/loop variable shadowing; keep the failed pilot."""
import ast
import hashlib
import json
from pathlib import Path

from make_s8_wide import NAME, DUAL, QUAD, proof

HERE = Path(__file__).resolve().parent


def main():
    base = (HERE / "baseline.py").read_text()
    template = (HERE / "s8_wide_template.py").read_text()
    template = template.replace("lambda i, j: i + j // 4 * 16", "lambda sum_i, sum_j: sum_i + sum_j // 4 * 16")
    template = template.replace("lambda i, j: j % 4", "lambda sum_i, sum_j: sum_j % 4")
    template = template.replace("lambda i, d: i + (d % 16 // 4) * 16", "lambda oi, od: oi + (od % 16 // 4) * 16")
    template = template.replace("lambda i, d: d // 16 * 4 + d % 4", "lambda oi, od: od // 16 * 4 + od % 4")
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
        dest = HERE / f"s8_wide_v2_p{pair}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            pair=pair, proof=proof(pair)))
    with (HERE / "s8_wide_v2_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(base.encode()).hexdigest(),
                       effective_template_sha256=hashlib.sha256(template.encode()).hexdigest(),
                       original_functions_ast_unchanged_except_dispatch=True,
                       default_mathcast_scope_and_separate_cache=True,
                       all_launches_in_public_call=True, variants=records,
                       previous_failure="s8_wide_pilot.log: eager frontend lambda/loop name shadowing before device compilation; no timing"), out, indent=2)
        out.write("\n")
    print("Generated 3 wide S8 v2 probes; distinct layout lambda parameters")


if __name__ == "__main__":
    main()
