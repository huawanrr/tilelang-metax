"""Trade additional wave barriers for a smaller shared Q/O staging tile."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE.parent / "20261001_next/packed_q4_latev.py").read_text()
NAME = "native_sparse_attention_single_packed_qo"
node = next(n for n in ast.parse(BASE).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
lines = BASE.splitlines(keepends=True)
start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
original = "".join(lines[start:node.end_lineno])


def once(s, a, b):
    assert s.count(a) == 1, a
    return s.replace(a, b)


for split in (2, 4):
    for width in (64, 128):
        fn = once(original, "    W = min(width, D)", f"    W = min(width, D)\n    SD = D // {split}")
        fn = once(fn, "q_shared = T.alloc_shared([G, D]", "q_shared = T.alloc_shared([G, SD]")
        fn = once(fn, """                T.copy(q_stage, q_shared)
                T.sync_warp()
                T.copy(q_shared, q)""", f"""                for qi in T.unroll({split}):
                    if qi > 0:
                        T.sync_warp()
                    for i, d in T.Parallel(G, SD):
                        q_shared[i, d] = q_stage[i, qi * SD + d]
                    T.sync_warp()
                    for i, d in T.Parallel(G, SD):
                        q[i, qi * SD + d] = q_shared[i, d]""")
        fn = once(fn, "output_shared = T.alloc_shared([G, D]", "output_shared = T.alloc_shared([G, SD]")
        fn = once(fn, """            T.sync_warp()
            T.copy(output_reg, output_shared)
            T.sync_warp()
            T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])""", f"""            for oi in T.unroll({split}):
                T.sync_warp()
                for i, d in T.Parallel(G, SD):
                    output_shared[i, d] = output_reg[i, oi * SD + d]
                T.sync_warp()
                T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, oi * SD:(oi + 1) * SD])""")
        result = "".join(lines[:start]) + fn + "".join(lines[node.end_lineno:])
        result = once(result, f"{NAME}(width=128, late=False, **common)",
                      f"{NAME}(width={width}, late=False, **common)")
        ast.parse(result)
        p = HERE / f"packed_split{split}_w{width}.py"
        if p.exists():
            raise FileExistsError(p)
        p.write_text(result)
        print(p.name)
