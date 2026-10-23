"""Screen a one-refinement reciprocal in the existing default-only builders.

This is a numerical experiment, not a release. Masks, positive denominator
guards, reduction order, conversion, packing and public dispatch stay intact.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_q_preload",
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
HELPER = '''def _minimax_reciprocal_probe(value):
    initial = T.reinterpret("float32", T.uint32(2129867785) - T.reinterpret("uint32", value))
    return initial * (2.001281261444092 - value * initial)

'''


def main():
    assert 2129867785 == 0x7EF33409
    source = (HERE / "baseline.py").read_text()
    functions = {fn.name: fn for fn in ast.parse(source).body
                 if isinstance(fn, ast.FunctionDef)}
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
            if value is not None:
                substitutions.append((offsets[node.lineno - 1] + node.col_offset,
                                      offsets[node.end_lineno - 1] + node.end_col_offset,
                                      ast.get_source_segment(source, value), name))
                count += 1
        assert count, name
    result = source
    for start, end, value, name in sorted(substitutions, reverse=True):
        result = result[:start] + f"_minimax_reciprocal_probe({value})" + result[end:]
    at = result.index("def _small_newton2(")
    result = result[:at] + HELPER + result[at:]
    changed = {fn.name: ast.dump(fn, include_attributes=False)
               for fn in ast.parse(result).body if isinstance(fn, ast.FunctionDef)}
    assert {name for name, fn in functions.items()
            if changed[name] != ast.dump(fn, include_attributes=False)} == NAMES
    compile(result, "minimax_reciprocal", "exec")
    path = HERE / "minimax_reciprocal.py"
    with path.open("x") as out:
        out.write(result)
    report = dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                  parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                  functions=sorted(NAMES), expressions=len(substitutions),
                  helper=HELPER, end_to_end_tolerance_unchanged=True,
                  status="unvalidated numerical probe")
    with (HERE / "minimax_reciprocal_manifest.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print(path, len(substitutions))


if __name__ == "__main__":
    main()
