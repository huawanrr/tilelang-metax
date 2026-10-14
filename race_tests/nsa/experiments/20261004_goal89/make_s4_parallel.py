"""Test whether the S8 splitting/packing mechanism helps the four-block family."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once
from make_v_only_packed import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/submission.py"


def main():
    original = BASE.read_text()
    records = []
    for mode in ("split_packed", "split_direct", "single_packed"):
        source = original
        if mode.startswith("split"):
            parent = HERE / ("split_s8_w2_fp32_balanced.py" if mode == "split_packed"
                             else "split_s8_directkv_swizzle4_balanced.py")
            fn = extract(parent.read_text(), "native_sparse_attention_split_blocks_packed")
            source = replace_once(source, "\ndef _get_kernel(", "\n" + fn + "\n\ndef _get_kernel(")
            builder = "native_sparse_attention_split_blocks_packed"
            kwargs = "selected_blocks=S, waves=2, prefetch=1, **common"
        else:
            builder = "native_sparse_attention_online_packed"
            kwargs = "selected_blocks=S, prefetch_depth=2, dual_acc=False, online_unroll=online_unroll, **common"
        branch = "        elif S == 4 and use_emitter_online:\n"
        if mode == "split_direct":
            branch += f"            kernel = {builder}({kwargs})\n"
        else:
            branch += f"            attention = {builder}({kwargs})\n"
            branch += """            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
"""
        branch += "        elif joined_short:\n"
        source = replace_once(source, "        elif joined_short:\n", branch)
        ast.parse(source)
        path = HERE / f"s4_{mode}.py"
        with path.open("x") as f:
            f.write(source)
        records.append(dict(path=path.name, mode=mode,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "s4_parallel_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        selection="S4/D64/BS16/G16 in the existing emitter domain; unrelated families retained.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
