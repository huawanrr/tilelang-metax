"""Screen log/exp reciprocals using public TileLang math intrinsics."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_q_preload",
    "native_sparse_attention_q_preload_vfirst",
    "native_sparse_attention_linear_v_blocks_oct8",
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_sum",
    "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
    "native_sparse_attention_short_list_oct8_sum_v11",
    "native_sparse_attention_staged_sparse_blocks_sum_v11",
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}
MODES = {
    "exp2_log2": "T.exp2(-T.log2({value}))",
    "exp_log": "T.exp(-T.log({value}))",
    "exp_log2": "T.exp(-T.log2({value}) * 0.6931471805599453)",
}


def main():
    source = (HERE / "baseline.py").read_text()
    tree = ast.parse(source)
    offsets = [0]
    for line in source.splitlines(keepends=True):
        offsets.append(offsets[-1] + len(line))
    functions = {fn.name: fn for fn in tree.body if isinstance(fn, ast.FunctionDef)}
    assert NAMES <= functions.keys()
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
            if value is not None:
                substitutions.append((
                    offsets[node.lineno - 1] + node.col_offset,
                    offsets[node.end_lineno - 1] + node.end_col_offset,
                    ast.get_source_segment(source, value), name,
                ))
                count += 1
        assert count > 0, name
    variants = []
    for mode, expression in MODES.items():
        result = source
        for start, end, value, _ in sorted(substitutions, reverse=True):
            result = result[:start] + expression.format(value=value) + result[end:]
        changed = {fn.name: ast.dump(fn, include_attributes=False)
                   for fn in ast.parse(result).body if isinstance(fn, ast.FunctionDef)}
        assert {name for name, fn in functions.items()
                if changed[name] != ast.dump(fn, include_attributes=False)} == NAMES
        compile(result, mode, "exec")
        path = HERE / f"recip_{mode}.py"
        with path.open("x") as file:
            file.write(result)
        variants.append(dict(file=path.name, expression=expression,
                             sha256=hashlib.sha256(result.encode()).hexdigest()))
    report = dict(
        parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
        variants=variants, functions=sorted(NAMES), expressions=len(substitutions),
        semantics=("Only replace positive-denominator reciprocal expressions; "
                   "retain every zero guard, mask, reduction order, packing, "
                   "dispatch and checked public adapter. Screening probes only."),
        validation_needed="Actual device instructions, independent math and attention references, hot/cold A/B/A.",
    )
    with (HERE / "recip_log_manifest.json").open("x") as file:
        json.dump(report, file, indent=2)
        file.write("\n")
    print("Generated", len(variants), "probes with", len(substitutions), "reciprocals")


if __name__ == "__main__":
    main()
