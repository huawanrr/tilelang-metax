"""Combine the measured D32 register-K path with V layouts and coalesced Q."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
source = (HERE / "d32_shuffle_k.py").read_text()
node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
            and n.name == "single_block_shuffle")
lines = source.splitlines(keepends=True)
start, end = node.decorator_list[0].lineno - 1, node.end_lineno
original = "".join(lines[start:end])
for name, layout, shuffle_q in (("d32_k_linear", "linear", False),
                              ("d32_k_vec16", "vec16", False),
                              ("d32_k_q", "original", True),
                              ("d32_k_linear_q", "linear", True)):
    part = original
    if layout == "linear":
        part = part.replace("tilelang.maca.intrinsics.make_mma_swizzle_layout(\n                    KV_shared, vecSize=8)",
                            "T.Layout([BS, BK], lambda j, d: (j, d))")
    elif layout == "vec16":
        part = part.replace("vecSize=8", "vecSize=16")
    if shuffle_q:
        part = part.replace("            Q_reg = T.alloc_fragment([G, BK], T.float16)", """            qraw = T.alloc_local([8], T.float16)
            qwords = T.Tensor([4], T.uint32, data=qraw.data, scope="local")
            qoutwords = T.alloc_local([4], T.uint32)
            qshuffled = T.Tensor([8], T.float16, data=qoutwords.data, scope="local")
            Q_reg = T.alloc_fragment([G, BK], T.float16)""")
        part = part.replace("            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)", """            for e in T.vectorized(8):
                qraw[e] = Q[i_b, i_t, i_h * G + tid // 4, (tid % 4) * 8 + e]
            for e in T.unroll(4):
                qoutwords[e] = T.shfl_sync(qwords[e], (tid % 16) * 4 + tid // 16, 64, 0xffffffffffffffff)
            for i, d in T.Parallel(G, BK):
                Q_reg[i, d] = qshuffled[d % 8]""", 1)
    result = "".join(lines[:start]) + part + "".join(lines[end:])
    ast.parse(result)
    (HERE / f"{name}.py").write_text(result)
    print(name)
