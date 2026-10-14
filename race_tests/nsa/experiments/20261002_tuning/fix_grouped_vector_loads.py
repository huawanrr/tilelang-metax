"""Preserve packed V's 16-byte loads when joining selected blocks."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
for path in sorted(HERE.glob("s8_group*_q?o?.py")):
    s = path.read_text()
    s = s.replace("            v = T.alloc_fragment([J, D], T.float16)",
                  "            v = T.alloc_local([J * D // 64], T.float16)\n"
                  "            tid = T.get_thread_binding()")
    s = s.replace('                v: pv.make_mma_load_layout(v, "B"),\n', '')
    old = """                        for j, d in T.Parallel(BS, D):
                            v[nj * BS + j, d] = T.if_then_else(valid,
                                V[b, block, h, j // 16, d // 32,
                                  (j % 16 // 4) * 16 + d % 16,
                                  (d % 32 // 16) * 4 + j % 4], 0)"""
    new = """                        for dj in T.unroll(D // 32):
                            for e in T.vectorized(8):
                                v[nj * D // 4 + dj * 8 + e] = T.if_then_else(valid,
                                    V[b, block, h, 0, dj, tid, e], T.float16(0))"""
    assert s.count(old) == 2
    s = s.replace(old, new)
    ast.parse(s)
    dest = path.with_stem(path.stem + "_v2")
    if dest.exists():
        raise FileExistsError(dest)
    dest.write_text(s)
    print(dest.name)
