"""Coalesce D32 output stores while retaining its register K permutation."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE.parent / "20261001_final/nsa.py").read_text()


def once(s, a, b):
    assert s.count(a) == 1, (a, s.count(a))
    return s.replace(a, b)


def modify(source, name, vec, query):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    fn = "".join(lines[start:node.end_lineno])
    wave = name.endswith("_wave")
    if query:
        fn = once(fn, "            Q_reg = T.alloc_fragment([G, BK], T.float16)", """            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            T.annotate_layout({
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda qi, qd: (qi * BK + qd) // 8 % 64,
                    forward_index_fn=lambda qi, qd: (qi * BK + qd) // 512 * 8 + qd % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
            })""")
        fn = once(fn, "            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)",
                  "            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)")
        qcopy = "                T.copy(Q_stage, Q_shared)\n"
        if wave:
            qcopy += "                T.sync_warp()\n"
        qcopy += "                T.copy(Q_shared, Q_reg)\n"
        if wave:
            qcopy += "                T.sync_warp()\n"
        marker = "                if is_causal and i_s + BS > i_t + 1:"
        fn = once(fn, marker, qcopy + marker)
    old = """            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])"""
    layout = (f"tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize={vec})"
              if vec else "T.Layout([G, BV], lambda oi, od: (oi, od))")
    new = f"""            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({{
                O_reg: T.Fragment([G, BV],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                O_shared: {layout},
            }})
            T.copy(acc_o, O_reg)
"""
    if wave:
        new += "            T.sync_warp()\n"
    new += "            T.copy(O_reg, O_shared)\n"
    if wave:
        new += "            T.sync_warp()\n"
    new += "            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])"
    fn = once(fn, old, new)
    return "".join(lines[:start]) + fn + "".join(lines[node.end_lineno:])


for vec, query in ((8, False), (4, False), (0, False), (8, True)):
    source = BASE
    for name in ("native_sparse_attention_d32_shuffle", "native_sparse_attention_d32_shuffle_wave"):
        source = modify(source, name, vec, query)
    ast.parse(source)
    p = HERE / f"d32_q{int(query)}_o{vec}.py"
    if p.exists():
        raise FileExistsError(p)
    p.write_text(source)
    print(p.name)
