"""Probe explicit read-only loads without changing addresses or guards."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_q_preload_vfirst",
    "native_sparse_attention_q_preload",
    "native_sparse_attention_linear_v_blocks_oct8",
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_short_list_oct8_sum_v11",
    "native_sparse_attention_staged_sparse_blocks_sum_v11",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


class ReadOnly(ast.NodeTransformer):
    def __init__(self, buffers):
        self.buffers = buffers
        self.count = 0

    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        if (isinstance(node.ctx, ast.Load) and isinstance(node.value, ast.Name)
                and node.value.id in self.buffers
                and not any(isinstance(n, ast.Slice) for n in ast.walk(node.slice))):
            self.count += 1
            return ast.copy_location(ast.Call(
                func=ast.Attribute(value=ast.Name(id="T", ctx=ast.Load()),
                                   attr="__ldg", ctx=ast.Load()),
                args=[node], keywords=[]), node)
        return node


def main():
    source = (HERE / "baseline.py").read_text()
    functions = [n for n in ast.parse(source).body
                 if isinstance(n, ast.FunctionDef) and n.name in NAMES]
    assert len(functions) == len(NAMES)
    records = []
    for mode, buffers in (
        ("indices", {"BlockIndices", "Indices"}),
        ("kv", {"K", "V", "K_blocks", "V_blocks", "PackedKV"}),
        ("all", {"BlockIndices", "Indices", "K", "V", "K_blocks", "V_blocks", "PackedKV"}),
    ):
        result = source
        edits = {}
        for fn in functions:
            transformer = ReadOnly(buffers)
            changed = transformer.visit(copy.deepcopy(fn))
            # get_source_segment excludes decorators; retain the original ones.
            changed.decorator_list = []
            replacement = ast.unparse(ast.fix_missing_locations(changed))
            original = ast.get_source_segment(source, fn)
            assert result.count(original) == 1
            result = result.replace(original, replacement, 1)
            edits[fn.name] = transformer.count
        ast.parse(result)
        path = HERE / f"readonly_{mode}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            replaced_loads=edits))
    with (HERE / "readonly_manifest.json").open("x") as out:
        json.dump(dict(baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       variants=records, dispatch_unchanged=True,
                       address_and_guard_unchanged=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "explicit read-only load probes")


if __name__ == "__main__":
    main()
