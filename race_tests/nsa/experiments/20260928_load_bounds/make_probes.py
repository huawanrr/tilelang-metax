"""Expose bounds implied by an aligned valid selected block."""
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20260927_next/selected.py"
source = BASE.read_text()
assert hashlib.sha256(BASE.read_bytes()).hexdigest() == "311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26"
tree = ast.parse(source)
node = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
            and n.name == "native_sparse_attention_single_block_emitter")
lines = source.splitlines(keepends=True)
start, stop = node.lineno - 1, node.end_lineno
original = "".join(lines[start:stop])
marker = "            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):\n"
assert original.count(marker) == 1
for mode in ["assume_full", "index_bound", "assume_global", "assume_scoped"]:
    body = original
    if mode == "assume_full":
        body = body.replace(marker, marker + "                if seq_len % BS == 0:\n"
                            "                    T.assume(i_s <= seq_len - BS)\n")
    elif mode == "index_bound":
        body = body.replace("            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS\n",
                            "            block_id = BlockIndices[i_b, i_t, i_h, 0]\n"
                            "            i_s = block_id * BS\n")
        body = body.replace(marker,
                            "            if block_id >= 0 and block_id < T.ceildiv(seq_len, BS) and (not is_causal or i_s <= i_t):\n"
                            "                if seq_len % BS == 0:\n"
                            "                    T.assume(i_s <= seq_len - BS)\n")
    elif mode == "assume_global":
        body = body.replace("            T.fill(acc_o, 0)\n",
                            "            if seq_len % BS == 0:\n"
                            "                T.assume(i_s >= seq_len or i_s <= seq_len - BS)\n"
                            "            T.fill(acc_o, 0)\n")
    else:
        left = body.index("                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)")
        right = body.index("                if not direct_k:", left)
        loads = body[left:right]
        body = (body[:left] + '                with T.block("bounded_loads"):\n'
                + "                    if seq_len % BS == 0:\n"
                + "                        T.assume(i_s <= seq_len - BS)\n"
                + "".join("    " + line if line.strip() else line
                          for line in loads.splitlines(keepends=True))
                + body[right:])
    target = HERE / f"{mode}.py"
    target.write_text("".join(lines[:start]) + body + "".join(lines[stop:]))
    print(target)
(HERE / "baseline.py").write_text(source)
