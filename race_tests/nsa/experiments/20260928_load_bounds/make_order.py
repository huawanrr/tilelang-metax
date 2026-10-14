"""Diagnose load scheduling after proving redundant boundary guards."""
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = HERE / "baseline.py"
source = base.read_text()
assert hashlib.sha256(base.read_bytes()).hexdigest() == "311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26"
node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
            and n.name == "native_sparse_attention_single_block_emitter")
lines = source.splitlines(keepends=True)
start, stop = node.lineno - 1, node.end_lineno
original = "".join(lines[start:stop])
left = original.index("                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)")
right = original.index("                if not direct_k:", left)
for mode in ["mixed", "mixed_bounds", "reverse", "reverse_bounds"]:
    body = original
    if mode.startswith("mixed"):
        loads = ("                for r, d in T.Parallel(BS, BK):\n"
                 "                    K_reg[r, d] = K[i_b, i_s + r, i_h, d]\n"
                 "                    V_reg[r, d] = V[i_b, i_s + r, i_h, d]\n")
    else:
        loads = ("                T.copy(V[i_b, i_s : i_s + BS, i_h,\n"
                 "                         i_v * BV : (i_v + 1) * BV], V_reg)\n"
                 "                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)\n")
    if mode.endswith("bounds"):
        loads = ('                with T.block("bounded_loads"):\n'
                 "                    if seq_len % BS == 0:\n"
                 "                        T.assume(i_s <= seq_len - BS)\n"
                 + "".join("    " + line for line in loads.splitlines(keepends=True)))
    body = body[:left] + loads + body[right:]
    (HERE / f"{mode}.py").write_text("".join(lines[:start]) + body + "".join(lines[stop:]))
