"""Compare one-allocation packed KV layouts without caching input data.

The old K/V tensors have the same element count and differ only in layout.
All references are rewritten by flattening their original indices, then
bijectively mapping the two planes into a joint tensor. Every pack call
still reads the current K and V tensors and produces all packed elements.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / "20261013_mfma_fix/submission.py"
ATTENTION = {
    "native_sparse_attention_single_packed_qo_v2_mathcast",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}
PACK = {
    "native_sparse_attention_pack_kv",
    "native_sparse_attention_pack_kv_bs32_direct",
    "native_sparse_attention_pack_kv_bs32_tiles",
}


def expr(text):
    return ast.parse(text, mode="eval").body


class JointAccess(ast.NodeTransformer):
    def __init__(self, names, mode):
        self.names = names
        self.mode = mode
        self.count = [0, 0]

    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        if not isinstance(node.value, ast.Name) or node.value.id not in self.names:
            return node
        plane = self.names[node.value.id]
        indices = node.slice.elts
        assert len(indices) == 7, ast.unparse(node)
        b, nb, h, x, y, lane, element = map(ast.unparse, indices)
        # K: D/32 x BS/16 x 64 x 8. V: BS/16 x D/32 x 64 x 8.
        dim4 = "BS // 16" if plane == 0 else "D // 32"
        local = f"((((({x}) * ({dim4}) + ({y})) * 64 + ({lane})) * 8) + ({element}))"
        block = f"((({b}) * NB + ({nb})) * H + ({h}))"
        if self.mode == "planes":
            offset = f"({plane} * batch * NB * H + {block}) * (BS * D) + {local}"
        elif self.mode == "blocks":
            offset = f"({block} * 2 + {plane}) * (BS * D) + {local}"
        else:
            assert self.mode == "chunks"
            offset = f"{block} * (2 * BS * D) + (({local} // 512) * 2 + {plane}) * 512 + ({local} % 512)"
        self.count[plane] += 1
        return ast.copy_location(ast.Subscript(value=ast.Name(id="PackedKV", ctx=ast.Load()),
                                              slice=expr(offset), ctx=node.ctx), node)


def convert(fn, mode, is_pack):
    fn = copy.deepcopy(fn)
    fn.name += "_joint"
    # Top-level decorators are inserted separately with the cloned function.
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    args = kernel.args.args
    names = {"K_packed": 0, "V_packed": 1} if is_pack else {"K": 0, "V": 1}
    if is_pack:
        outputs = [a.arg for a in args if a.arg not in ("K", "V")]
        assert len(outputs) == 2, outputs
        names = dict(zip(outputs, (0, 1)))
    selected = [i for i, a in enumerate(args) if a.arg in names]
    assert len(selected) == 2 and selected[1] == selected[0] + 1
    new_arg = ast.arg(arg="PackedKV", annotation=expr("T.Tensor([2 * batch * NB * H * BS * D], T.float16)"))
    kernel.args.args = args[:selected[0]] + [new_arg] + args[selected[1] + 1:]
    # Give all builders the same constant names before constructing PrimFunc.
    at = fn.body.index(kernel)
    constants = ast.parse("D = dim\nBS = block_size\nH = heads if True else heads\nNB = T.ceildiv(seq_len, BS)\n").body
    constants[2].value = expr("heads" if is_pack else "heads // groups")
    fn.body[at:at] = constants
    transform = JointAccess(names, mode)
    kernel.body = [transform.visit(n) for n in kernel.body]
    assert all(transform.count), (fn.name, transform.count)
    return ast.unparse(ast.fix_missing_locations(fn)), transform.count


def prove_layout(mode):
    for bs in (16, 32):
        for dim in (32, 64, 128):
            size = bs * dim
            addresses = []
            blocks = 12
            for block in range(blocks):
                for plane in range(2):
                    for local in range(size):
                        if mode == "planes":
                            out = (plane * blocks + block) * size + local
                        elif mode == "blocks":
                            out = (block * 2 + plane) * size + local
                        else:
                            out = block * (2 * size) + (local // 512 * 2 + plane) * 512 + local % 512
                        addresses.append(out)
            assert sorted(addresses) == list(range(2 * blocks * size))


def main():
    source = PARENT.read_text()
    tree = ast.parse(source)
    original = {n.name: n for n in tree.body if isinstance(n, ast.FunctionDef)}
    for name in ("baseline.py", "control.py"):
        with (HERE / name).open("x") as out:
            out.write(source)
    records = []
    for mode in ("planes", "blocks", "chunks"):
        prove_layout(mode)
        additions = []
        counts = {}
        for name in sorted(ATTENTION | PACK):
            text, count = convert(original[name], mode, name in PACK)
            additions.append(text)
            counts[name] = count
        additions.append('''def _make_joint_packed_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    size = 2 * batch * ((seq_len + block_size - 1) // block_size) * heads * dim * block_size
    def run(Q, K, V, BlockIndices, Output):
        packed = torch.empty((size,), dtype=Q.dtype, device=Q.device)
        pack(K, V, packed)
        attention(Q, packed, BlockIndices, Output)
    return run
''')
        dispatch = ast.get_source_segment(source, original["_get_kernel"])
        revised = dispatch
        for name in sorted(ATTENTION | PACK, key=len, reverse=True):
            # Names are replaced structurally to avoid prefix collisions.
            class Rename(ast.NodeTransformer):
                def visit_Name(self, node):
                    if node.id == name:
                        return ast.copy_location(ast.Name(id=name + "_joint", ctx=node.ctx), node)
                    return node
            revised = ast.unparse(ast.fix_missing_locations(Rename().visit(ast.parse(revised))))
        # All packed paths reached with defaults use the three new attention
        # builders. Leave non-default/legacy dispatch on its original ABI.
        revised = revised.replace("kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)",
            "kernel = (_make_joint_packed_attention if (mathcast_single or mathcast_s8) else _make_packed_attention)(pack, attention, B, seq_len, H, D, block_size)")
        # The generic S8 pack must keep its old ABI outside the selected path.
        revised = revised.replace("pack = native_sparse_attention_pack_kv_joint(B, seq_len, H, D, block_size)",
            "pack = (native_sparse_attention_pack_kv_joint if mathcast_s8 else native_sparse_attention_pack_kv)(B, seq_len, H, D, block_size)")
        # BS32 non-mathcast callers must also keep their original packer.
        revised = revised.replace("pack_builder = native_sparse_attention_pack_kv_bs32_tiles_joint if tiled_pack else native_sparse_attention_pack_kv_bs32_direct_joint if packed_direct else native_sparse_attention_pack_kv_bs32_shared",
            "pack_builder = native_sparse_attention_pack_kv_bs32_tiles_joint if tiled_pack else (native_sparse_attention_pack_kv_bs32_direct_joint if mathcast_single else native_sparse_attention_pack_kv_bs32_direct) if packed_direct else native_sparse_attention_pack_kv_bs32_shared")
        # The existing shared BS32 fallback is used by some larger defaults.
        # Clone it too so its signature agrees with the joint attention.
        shared, count = convert(original["native_sparse_attention_pack_kv_bs32_shared"], mode, True)
        additions.append(shared)
        revised = revised.replace("else native_sparse_attention_pack_kv_bs32_shared", "else (native_sparse_attention_pack_kv_bs32_shared_joint if mathcast_single else native_sparse_attention_pack_kv_bs32_shared)")
        result = source.replace(dispatch, "\n\n".join(additions) + "\n\n" + revised, 1)
        ast.parse(result)
        path = HERE / f"joint_{mode}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(), mode=mode, rewrites=counts))
    (HERE / "joint_pack_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        proof="Exhaustive bijection for 12 blocks, BS16/32, D32/64/128; original logical K and V coordinates preserved"), indent=2) + "\n")
    print("Generated three joint-KV variants", flush=True)


if __name__ == "__main__":
    main()
