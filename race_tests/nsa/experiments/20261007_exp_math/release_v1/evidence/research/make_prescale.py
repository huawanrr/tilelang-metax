"""Research moving the attention scale to the reused FP16 Q or packed K.

Unlike scalar conversion alone, this introduces an extra FP16 rounding.
It must pass independent references and beat the math/cast control to be useful.
Every public call still packs current K/V; no input-derived data is cached.
"""
import ast
import hashlib
import json
from pathlib import Path
import re

from make_cast_and_flags import HERE, ONLINE

PACKED = ONLINE + (
    "native_sparse_attention_online_packed_batch_minor",
    "native_sparse_attention_online_packed_quad_batch_minor",
)
BASE = HERE / "lane_cast_folded.py"


def region(source, name):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    begin = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return "".join(lines[begin:node.end_lineno])


def replace_once(source, old, new):
    assert source.count(old) == 1
    return source.replace(old, new)


def main():
    source = BASE.read_text()
    records = []
    for name, mode in (("k_scaled_cast", "k"), ("q_scaled_cast", "q")):
        result = source
        for builder in PACKED:
            old = region(result, builder)
            new, n1 = re.subn(
                r"T\.exp\(T\.min\(acc_s\[i, j\] \* \(scale_log2 \* 0\.6931471805599453\), 10\.39720770839918\)\)",
                "T.exp(T.min(acc_s[i, j], 10.39720770839918))", old)
            new, n2 = re.subn(r"T\.exp2\(\s*T\.min\(acc_s\[i, j\] \* scale_log2, 15\.0\)\)",
                "T.exp(T.min(acc_s[i, j], 10.39720770839918))", new)
            assert n1 + n2 == 5, (builder, n1, n2)
            if mode == "q":
                marker = "            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)"
                coord = "scale_chunk * 32 + T.get_thread_binding() // 16 * 8 + scale_element"
                scaled = (marker + "\n"
                    "            for scale_chunk in T.unroll(BK // 32):\n"
                    "                for scale_element in T.unroll(8):\n"
                    f"                    Q_reg[T.get_thread_binding() % 16, {coord}] = T.cast(Q_reg[T.get_thread_binding() % 16, {coord}], T.float32) * (scale_log2 * 0.6931471805599453)")
                new = replace_once(new, marker, scaled)
            result = replace_once(result, old, new)
        if mode == "k":
            old_pack = region(result, "native_sparse_attention_pack_kv")
            scaled_pack = old_pack.replace(
                "def native_sparse_attention_pack_kv(batch, seq_len, heads, dim, block_size):",
                "def native_sparse_attention_pack_kv_scaled(batch, seq_len, heads, dim, block_size, scale_natural):")
            scaled_pack = replace_once(scaled_pack, "d % 8] = ktile[j, d]",
                "d % 8] = T.cast(ktile[j, d], T.float32) * scale_natural")
            result = replace_once(result, old_pack, old_pack + "\n\n" + scaled_pack)
            result = replace_once(result,
                "            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)",
                "            pack = native_sparse_attention_pack_kv_scaled(B, seq_len, H, D, block_size, scale_log2 * 0.6931471805599453)")
        ast.parse(result)
        path = HERE / (name + ".py")
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path), mode=mode,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "prescale_assembly.json").write_text(json.dumps(dict(parent=str(BASE),
        variants=records, research_only=True, additional_fp16_rounding=True,
        math_scope="Packed online paths only; positive/zero/negative scales need explicit validation"),
        indent=2) + "\n")
    print("Generated", len(records), "scale-placement probes")


if __name__ == "__main__":
    main()
