"""Build positive-denominator rsqrt probes from the frozen v15 source."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / "20261016_s2_family/release_v15/submission.py"
EXPECTED = "58bbd21b67192a467242ae078cc8e7a135e0cbb9441401b0733e5d8155ac78c1"
NAMES = {
    "native_sparse_attention_q_preload",
    "native_sparse_attention_q_preload_vfirst",
    "native_sparse_attention_linear_v_blocks_oct8",
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_sum",
    "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
    "native_sparse_attention_short_list_oct8_sum_v11",
    "native_sparse_attention_short_list_oct8_wave_output_v15",
    "native_sparse_attention_staged_sparse_blocks_sum_v11",
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}
HELPERS = {
    "rsqrt": """def _rsqrt_denominator_probe(value):
    root_inv = T.rsqrt(value)
    return root_inv * root_inv

""",
    "ieee_rsqrt": """def _rsqrt_denominator_probe(value):
    root_inv = T.ieee_frsqrt(value)
    return root_inv * root_inv

""",
}


def main():
    source = PARENT.read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == EXPECTED
    functions = {fn.name: fn for fn in ast.parse(source).body
                 if isinstance(fn, ast.FunctionDef)}
    assert NAMES <= functions.keys()
    offsets = [0]
    for line in source.splitlines(keepends=True):
        offsets.append(offsets[-1] + len(line))
    substitutions = []
    for name in sorted(NAMES):
        count = 0
        for node in ast.walk(functions[name]):
            value = None
            if (isinstance(node, ast.BinOp) and isinstance(node.op, ast.Div)
                    and isinstance(node.left, ast.Constant) and node.left.value == 1.0):
                value = node.right
            elif (isinstance(node, ast.Call) and isinstance(node.func, ast.Name)
                  and node.func.id == "_small_newton2"):
                assert len(node.args) == 1 and not node.keywords
                value = node.args[0]
            elif isinstance(node, ast.Call) and ast.unparse(node.func) == "T.exp":
                assert len(node.args) == 1
                arg = node.args[0]
                if (isinstance(arg, ast.UnaryOp) and isinstance(arg.op, ast.USub)
                        and isinstance(arg.operand, ast.Call)
                        and ast.unparse(arg.operand.func) == "T.log"):
                    assert len(arg.operand.args) == 1
                    value = arg.operand.args[0]
            if value is not None:
                substitutions.append((offsets[node.lineno - 1] + node.col_offset,
                                      offsets[node.end_lineno - 1] + node.end_col_offset,
                                      ast.get_source_segment(source, value), name))
                count += 1
        assert count, name
    for name in ("baseline.py", "control.py"):
        with (HERE / name).open("x") as out:
            out.write(source)
    variants = []
    for mode, helper in HELPERS.items():
        result = source
        for start, end, value, _ in sorted(substitutions, reverse=True):
            result = result[:start] + f"_rsqrt_denominator_probe({value})" + result[end:]
        at = result.index("def _small_newton2(")
        result = result[:at] + helper + result[at:]
        changed = {fn.name: ast.dump(fn) for fn in ast.parse(result).body
                   if isinstance(fn, ast.FunctionDef)}
        assert {name for name, fn in functions.items()
                if changed[name] != ast.dump(fn)} == NAMES
        compile(result, mode, "exec")
        path = HERE / f"{mode}.py"
        with path.open("x") as out:
            out.write(result)
        variants.append(dict(file=path.name, helper=helper,
                             sha256=hashlib.sha256(result.encode()).hexdigest()))
    old_cases = json.loads((HERE.parent / "20261016_s2_family/candidate_cases.json").read_text())
    cases = {name: config for name, config in old_cases.items() if name.startswith("oj")}
    with (HERE / "cases.json").open("x") as out:
        json.dump(cases, out, indent=2)
        out.write("\n")
    report = dict(parent=str(PARENT), parent_sha256=EXPECTED, variants=variants,
                  functions=sorted(NAMES), expressions=len(substitutions),
                  guards_and_dispatch_unchanged=True, status="unvalidated probes")
    with (HERE / "manifest.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print("Generated", len(variants), "probes with", len(substitutions), "expressions")


if __name__ == "__main__":
    main()
