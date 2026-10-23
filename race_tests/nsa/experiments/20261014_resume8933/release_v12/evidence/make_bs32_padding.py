"""Shift joint K/V plane strides by individual cache lines.

An older experiment padded each separate allocation by 1--4 KiB. This
probe keeps v11's joint allocation and adds 128--512 bytes per plane,
preserving every 128-bit load alignment and avoiding padding writes.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_pack_kv_bs32_direct_block_joint",
    "native_sparse_attention_pack_kv_bs32_shared_block_joint",
    "native_sparse_attention_pack_kv_bs32_tiles_block_joint",
    "_make_block_joint_attention",
}


def expression(source):
    return ast.parse(source, mode="eval").body


class FlattenPlane(ast.NodeTransformer):
    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        if not isinstance(node.value, ast.Name) or node.value.id != "PackedKV":
            return node
        assert isinstance(node.slice, ast.Tuple) and len(node.slice.elts) == 7
        a = node.slice.elts
        last = expression(f"(({ast.unparse(a[4])}) * 64 + ({ast.unparse(a[5])})) * 8 + ({ast.unparse(a[6])})")
        node.slice.elts = a[:4] + [last]
        return node


def transform(fn, padding):
    fn = copy.deepcopy(fn)
    fn.name += "_pad_v12"
    if fn.name.startswith("_make_"):
        shape = next(n for n in fn.body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "shape")
        shape.value = expression(f"(batch, (seq_len + block_size - 1) // block_size, heads, 2, dim * block_size + {padding})")
        return ast.unparse(ast.fix_missing_locations(fn))
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    packed = next(a for a in kernel.args.args if a.arg == "PackedKV")
    packed.annotation.args[0] = expression(f"[batch, NB, H, 2, D * BS + {padding}]")
    fn = FlattenPlane().visit(fn)
    return ast.unparse(ast.fix_missing_locations(fn))


class Rename(ast.NodeTransformer):
    def visit_Name(self, node):
        if node.id in NAMES:
            node.id += "_pad_v12"
        return node


def prove(padding):
    k_offsets, v_offsets = set(), set()
    for j in range(32):
        for d in range(128):
            ko = ((d // 32 * 2 + j // 16) * 64 + d % 32 // 8 * 16 + j % 16) * 8 + d % 8
            vo = ((j // 16 * 4 + d // 32) * 64 + j % 16 // 4 * 16 + d % 16) * 8 + d % 32 // 16 * 4 + j % 4
            k_offsets.add(ko)
            v_offsets.add(4096 + padding + vo)
    assert k_offsets == set(range(4096))
    assert v_offsets == set(range(4096 + padding, 8192 + padding))
    assert not (k_offsets & v_offsets)
    assert max(k_offsets | v_offsets) < 2 * (4096 + padding)
    assert (2 * (4096 + padding) * 2) % 128 == 0
    return dict(plane_padding_half=padding, payload_elements=8192,
                allocation_elements_per_block=2 * (4096 + padding), proof="PASS")


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name:n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for padding in (0,64,128,256):
        additions = "\n\n".join(transform(functions[name], padding) for name in sorted(NAMES))
        dispatch = Rename().visit(copy.deepcopy(functions["_get_kernel"]))
        result = source.replace(ast.get_source_segment(source, functions["_get_kernel"]),
                                additions + "\n\n" + ast.unparse(ast.fix_missing_locations(dispatch)), 1)
        ast.parse(result)
        path = HERE / f"bs32_pad{padding}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            **prove(padding)))
    (HERE / "bs32_padding_manifest.json").write_text(json.dumps(dict(
        parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        pad0_control="Same physical layout as v11; only equivalent plane indexing is flattened",
        padding="Never read or written; each public invocation packs all live payload values",
        dispatch="Unchanged v11 joint-buffer family"), indent=2) + "\n")
    print("Generated",len(records),"BS32 padding variants")


if __name__ == "__main__":
    main()
