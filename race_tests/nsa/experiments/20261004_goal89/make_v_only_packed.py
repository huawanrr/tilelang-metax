"""Keep packed V, read vector-friendly K directly, and pay only V packing."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/submission.py"


def extract(source, name):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    begin = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return "".join(lines[begin:node.end_lineno])


def pack_v(source, suffix):
    name = f"native_sparse_attention_pack_kv_bs32_{suffix}"
    fn = extract(source, name)
    fn = fn.replace(name, f"native_sparse_attention_pack_v_bs32_{suffix}")
    fn = replace_once(fn, "        K: T.Tensor([batch, seq_len, heads, D], T.float16),\n", "")
    fn = replace_once(fn, "        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D//32, BS//16, 64, 8], T.float16),\n", "")
    begin = fn.index("            ktile = T.alloc_fragment")
    end = fn.index("            tile = T.alloc_fragment", begin)
    fn = fn[:begin] + fn[end:]
    return fn


def main():
    original = BASE.read_text()
    attention = extract(original, "native_sparse_attention_single_packed_qo_v2")
    changed = replace_once(attention,
        "        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),",
        "        K: T.Tensor([batch, seq_len, H, D], T.float16),")
    changed = replace_once(changed,
        "            valid = block >= 0 and block < NB and (not is_causal or start <= token)",
        "            valid = block >= 0 and block < NB and (not is_causal or block <= token // BS)")
    changed = replace_once(changed, """                    k[j, d] = K[b, block, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8]""",
        "                    k[j, d] = T.if_then_else(start + j < seq_len, K[b, start + j, h, d], T.float16(0))")
    source = replace_once(original, attention, changed)
    wrapper = """
def _make_v_packed_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    blocks = (seq_len + block_size - 1) // block_size
    v_shape = (batch, blocks, heads, block_size // 16, dim // 32, 64, 8)

    def run(q, k, v, indices, output):
        packed_v = torch.empty(v_shape, device=v.device, dtype=v.dtype)
        pack(v, packed_v)
        attention(q, k, packed_v, indices, output)

    return run
"""
    appended = pack_v(original, "direct") + "\n\n" + pack_v(original, "shared") + "\n\n" + wrapper
    source = replace_once(source, "\ndef _get_kernel(", "\n" + appended + "\n\ndef _get_kernel(")
    old = """            pack_builder = (native_sparse_attention_pack_kv_bs32_direct if packed_direct
                            else native_sparse_attention_pack_kv_bs32_shared)
            pack = pack_builder(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)"""
    records = []
    for mode in ("original", "shared128"):
        if mode == "original":
            branch = """            pack_builder = (native_sparse_attention_pack_v_bs32_direct if packed_direct
                            else native_sparse_attention_pack_v_bs32_shared)"""
            result = source
        else:
            branch = "            pack_builder = native_sparse_attention_pack_v_bs32_shared"
            fn = extract(source, "native_sparse_attention_pack_v_bs32_shared")
            result = replace_once(source, fn, fn.replace("256", "128"))
        branch += """
            pack = pack_builder(B, seq_len, H, D, block_size)
            kernel = _make_v_packed_attention(pack, attention, B, seq_len, H, D, block_size)"""
        result = replace_once(result, old, branch)
        ast.parse(result)
        path = HERE / f"bs32_vonly_{mode}.py"
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=path.name, pack_mode=mode,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "vonly_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        changes="K reads use the original MMA register layout directly from input; only V is freshly packed every invocation.",
        preserved="All other attention builders, arithmetic, output staging, and existing synchronization are retained.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
