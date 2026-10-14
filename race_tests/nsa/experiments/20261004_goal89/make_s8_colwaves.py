"""Assemble whole-list, multiple-wave S8 experiments without changing packing."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/submission.py"


def main():
    original = BASE.read_text()
    template = (HERE / "s8_colwaves_template.py").read_text()
    template = template[template.index("@tilelang.jit"):]
    records = []
    for waves in (2, 4):
        for staging in (False, True):
            fn = template.replace("NW_TEMPLATE", str(waves)).replace("QSTAGE_TEMPLATE", str(staging))
            source = replace_once(original, "\ndef _get_kernel(", "\n" + fn + "\n\ndef _get_kernel(")
            branch = """        elif S == 8 and use_emitter_online:
            attention = native_sparse_attention_s8_colwaves(selected_blocks=S, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif S >= 8 and use_emitter_online:
"""
            source = replace_once(source, "        elif S >= 8 and use_emitter_online:\n", branch)
            ast.parse(source)
            path = HERE / f"s8_colwaves_w{waves}_{'stage' if staging else 'direct'}.py"
            with path.open("x") as f:
                f.write(source)
            records.append(dict(path=path.name, waves=waves, q_staging=staging,
                                sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "s8_colwaves_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        math="Join all selected keys, distribute QK columns over waves, then redistribute probabilities for disjoint output columns.",
        packing="Original packing, invoked afresh on every public call.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
