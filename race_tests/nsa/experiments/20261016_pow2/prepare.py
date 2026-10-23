"""Use the public pow intrinsic to expose the native exp2 implementation."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / "20261016_rsqrt/release_v16/submission.py"
EXPECTED = "fb6b0fb5df10bc497841e9a0da922a0062f84689088c9503bc526aef71b9a976"
NAMES = {
    "native_sparse_attention_q_preload", "native_sparse_attention_q_preload_vfirst",
    "_coalesced_block_loads_prim_oct8", "_coalesced_block_loads_prim_fp32_sum",
    "_coalesced_block_loads_prim_fp32_mask", "_coalesced_block_loads_prim_boundary_v8",
    "native_sparse_attention_short_list_oct8_sum_v11",
    "native_sparse_attention_short_list_oct8_wave_output_v15",
    "native_sparse_attention_staged_sparse_blocks_sum_v11",
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def replacement(call, include_natural):
    name = ast.unparse(call.func)
    if name == "T.exp2":
        return f"T.pow(T.float32(2.0), {ast.unparse(call.args[0])})"
    if name != "T.exp" or not include_natural:
        return None
    value = call.args[0]
    assert isinstance(value, ast.Call) and ast.unparse(value.func) == "T.min"
    product, cap = value.args
    assert ast.literal_eval(cap) == 10.39720770839918
    assert isinstance(product, ast.BinOp) and isinstance(product.op, ast.Mult)
    assert ast.unparse(product.right) == "scale_log2 * 0.6931471805599453"
    return f"T.pow(T.float32(2.0), T.min({ast.unparse(product.left)} * scale_log2, 15.0))"


def main():
    source = PARENT.read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == EXPECTED
    offsets = [0]
    for line in source.splitlines(keepends=True):
        offsets.append(offsets[-1] + len(line))
    functions = {node.name: node for node in ast.parse(source).body if isinstance(node, ast.FunctionDef)}
    assert NAMES <= functions.keys()
    for name in ("baseline.py", "control.py"):
        with (HERE / name).open("x") as out:
            out.write(source)
    records = []
    for include_natural, name in ((False, "pow2_existing"), (True, "pow2_all")):
        edits, changes = [], {}
        for function_name in sorted(NAMES):
            count = 0
            for node in ast.walk(functions[function_name]):
                if not isinstance(node, ast.Call):
                    continue
                text = replacement(node, include_natural)
                if text is not None:
                    edits.append((offsets[node.lineno - 1] + node.col_offset,
                                  offsets[node.end_lineno - 1] + node.end_col_offset, text))
                    count += 1
            if count:
                changes[function_name] = count
        result = source
        for start, end, text in sorted(edits, reverse=True):
            result = result[:start] + text + result[end:]
        after = {node.name: node for node in ast.parse(result).body if isinstance(node, ast.FunctionDef)}
        assert {key for key in functions if ast.dump(functions[key]) != ast.dump(after[key])} == set(changes)
        compile(result, name, "exec")
        path = HERE / f"{name}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            include_natural=include_natural, changed_functions=changes))
    cases = json.loads((HERE.parent / "20261016_rsqrt/cases.json").read_text())
    with (HERE / "cases.json").open("x") as out:
        json.dump(cases, out, indent=2)
        out.write("\n")
    report = dict(parent_sha256=EXPECTED, variants=records,
                  invariants="All score masks, normalization, FP32 emitter strings, layout, synchronization, packing, public interfaces and dispatch remain unchanged.",
                  status="unvalidated attention probes; scalar exp2 equivalence checked separately")
    with (HERE / "manifest.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print("Generated", len(records), "pow2 probes")


if __name__ == "__main__":
    main()
