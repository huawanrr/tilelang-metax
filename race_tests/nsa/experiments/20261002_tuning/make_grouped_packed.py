"""Build independent, complete modules without changing the 10.1 baseline."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE.parent / "20261001_final/nsa.py").read_text()
KERNEL = (HERE / "grouped_packed_kernel.py").read_text()
KERNEL = KERNEL[KERNEL.index("@tilelang.jit"):]

for n, late, output, query in (
    (2, False, True, False), (4, False, True, False), (8, False, True, False),
    (2, True, True, False), (4, True, True, False),
    (4, False, False, False), (4, False, True, True),
):
    branch = f"""        if S == 8 and use_emitter_online:
            attention = native_sparse_attention_grouped_packed(
                selected_blocks=S, block_group={n}, late_v={late!r},
                output_stage={output!r}, query_stage={query!r},
                batch_minor=grid >= 4096, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif packed_qo:
"""
    assert BASE.count("        if packed_qo:\n") == 1
    source = BASE.replace("\ndef _get_kernel(", "\n" + KERNEL + "\n\ndef _get_kernel(", 1)
    source = source.replace("        if packed_qo:\n", branch, 1)
    ast.parse(source)
    path = HERE / f"s8_group{n}_late{int(late)}_q{int(query)}o{int(output)}.py"
    if path.exists():
        raise FileExistsError(path)
    path.write_text(source)
    print(path.name)
