"""Place live packed K/V operands in adjacent cache-line portions for BS32."""
import ast
import hashlib
import json
from pathlib import Path

from make_joint_pack_probes import builder

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"


class Interleave(ast.NodeTransformer):
    def __init__(self, pack):
        self.pack = pack
        self.counts = {"K": 0, "V": 0}

    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        name = ast.unparse(node.value)
        is_k = name == ("PackedK" if self.pack else "K")
        is_v = name == ("Packed" if self.pack else "V")
        if not (is_k or is_v) or not isinstance(node.slice, ast.Tuple) or len(node.slice.elts) != 7:
            return node
        indices = node.slice.elts
        plane_a, plane_b = [ast.unparse(x) for x in indices[3:5]]
        stride = "BS // 16" if is_k else "D // 32"
        plane = ast.parse(f"({plane_a}) * ({stride}) + ({plane_b})", mode="eval").body
        last = indices[-1] if is_k else ast.parse(f"8 + ({ast.unparse(indices[-1])})", mode="eval").body
        node.slice.elts = indices[:3] + [plane, indices[-2], last]
        if self.pack:
            node.value = ast.Name(id="Packed", ctx=ast.Load())
        self.counts["K" if is_k else "V"] += 1
        return node


def once(text, before, after):
    assert text.count(before) == 1, (before[:100], text.count(before))
    return text.replace(before, after, 1)


def main():
    source = BASE.read_text()
    lines = source.splitlines(keepends=True)
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == "native_sparse_attention_single_packed_qo_v2_mathcast")
    first = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    old_attention = "".join(lines[first:node.end_lineno])
    reports = []
    for shared_k in (False, True):
        pack = ast.parse(builder("native_sparse_attention_pack_interleaved_bs32", 256, shared_k)).body[0]
        prim = next(n for n in pack.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
        prim.args.args = [a for a in prim.args.args if a.arg != "PackedK"]
        packed = next(a for a in prim.args.args if a.arg == "Packed")
        packed.annotation = ast.parse("T.Tensor([batch, T.ceildiv(seq_len, BS), heads, (D//32)*(BS//16), 64, 16], T.float16)", mode="eval").body
        transform = Interleave(True)
        pack = transform.visit(pack)
        assert transform.counts == {"K":1,"V":1}
        ast.fix_missing_locations(pack)

        attention = ast.parse(old_attention).body[0]
        attention.name = "native_sparse_attention_single_interleaved_bs32"
        prim = next(n for n in attention.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
        for arg in prim.args.args:
            if arg.arg in ("K", "V"):
                arg.annotation = ast.parse("T.Tensor([batch, NB, H, (D//32)*(BS//16), 64, 16], T.float16)", mode="eval").body
        transform = Interleave(False)
        attention = transform.visit(attention)
        assert transform.counts == {"K":1,"V":2}
        ast.fix_missing_locations(attention)

        helper = '''
def _make_interleaved_bs32_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    shape = (batch, (seq_len + block_size - 1) // block_size, heads,
             (dim // 32) * (block_size // 16), 64, 16)
    def run(q, k, v, indices, output):
        packed = torch.empty(shape, device=k.device, dtype=k.dtype)
        pack(k, v, packed)
        attention(q, packed, packed, indices, output)
    return run
'''
        extra = ast.unparse(pack) + "\n\n" + ast.unparse(attention) + "\n\n" + helper
        result = once(source, "def _get_kernel(", extra + "\n\ndef _get_kernel(")
        result = once(result, "packed_builder = (native_sparse_attention_single_packed_qo_v2_mathcast if mathcast_single",
                      "packed_builder = (native_sparse_attention_single_interleaved_bs32 if mathcast_single")
        before = '''            pack_builder = (native_sparse_attention_pack_kv_bs32_direct if packed_direct
                            else native_sparse_attention_pack_kv_bs32_shared)
            pack = pack_builder(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)'''
        after = '''            if mathcast_single:
                pack = native_sparse_attention_pack_interleaved_bs32(B, seq_len, H, D, block_size)
                kernel = _make_interleaved_bs32_attention(pack, attention, B, seq_len, H, D, block_size)
            else:
                pack_builder = (native_sparse_attention_pack_kv_bs32_direct if packed_direct
                                else native_sparse_attention_pack_kv_bs32_shared)
                pack = pack_builder(B, seq_len, H, D, block_size)
                kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)'''
        result = once(result, before, after)
        ast.parse(result)
        path = HERE / f"interleaved_bs32_kshared{int(shared_k)}.py"
        with path.open("x") as f:
            f.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), k_shared=shared_k))
        print(path.name)
    # Check every payload address is unique and the two sides are disjoint.
    proof = []
    for d,bs in ((64,16),(128,16),(128,32)):
        k_addresses, v_addresses = set(), set()
        for j in range(bs):
            for c in range(d):
                kp = c//32 * (bs//16) + j//16
                kl = (c%32//8)*16 + j%16
                ka = (kp*64+kl)*16+c%8
                vp = j//16 * (d//32) + c//32
                vl = (j%16//4)*16+c%16
                va = (vp*64+vl)*16+8+(c%32//16)*4+j%4
                assert ka not in k_addresses and va not in v_addresses
                k_addresses.add(ka); v_addresses.add(va)
        assert not k_addresses & v_addresses
        assert k_addresses | v_addresses == set(range(2*bs*d))
        proof.append(dict(dim=d,block_size=bs,payload_elements=2*bs*d))
    (HERE / "interleaved_bs32_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=reports,
        proof=proof, attention_math_and_sync_unchanged=True,
        aliasing="Both attention pointers are read-only views of the same fresh packed allocation",
        packing="Current K/V packed on every invocation; source copies zero-fill partial blocks"), indent=2) + "\n")


if __name__ == "__main__":
    main()
