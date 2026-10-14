"""Screen synchronous S1 shared layouts and QK operand width."""
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
source = (ROOT / "experiments/20260927_next/selected.py").read_text()
assert hashlib.sha256(source.encode()).hexdigest() == "311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26"
node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
            and n.name == "native_sparse_attention_single_block_emitter")
lines = source.splitlines(keepends=True)
start, end = node.decorator_list[0].lineno - 1, node.end_lineno
original = "".join(lines[start:end])
for name, vec, pack in (
    ("swizzle4", 4, 2), ("swizzle16", 16, 2),
    ("linear", 0, 2), ("qk1", 8, 1), ("qk1_swizzle4", 4, 1),
):
    part = original.replace("qk, pv = _emitters(T.float16, T.float32, BS, BK)",
                            f"qk, pv = _emitters(T.float16, T.float32, BS, BK, qk_k_pack={pack})")
    if vec:
        part = part.replace("vecSize=8", f"vecSize={vec}")
    else:
        part = part.replace("tilelang.maca.intrinsics.make_mma_swizzle_layout(\n                    KV_shared, vecSize=8)",
                            "T.Layout([BS, BK], lambda j, d: (j, d))")
        part = part.replace("tilelang.maca.intrinsics.make_mma_swizzle_layout(\n                        V_shared, vecSize=8)",
                            "T.Layout([BS, BV], lambda j, d: (j, d))")
    result = "".join(lines[:start]) + part + "".join(lines[end:])
    ast.parse(result)
    (HERE / f"{name}.py").write_text(result)
    print(name)
