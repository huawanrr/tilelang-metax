"""Avoid aggregate-copy private arrays across the new Q-preload barrier."""
import ast
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent


def build(parent, stem, pair_store):
    base = parent.read_text()
    lines = base.splitlines(keepends=True)
    names = ("_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
             "native_sparse_attention_single_packed_qo_v2_mathcast")
    source = base
    for node in ast.parse(base).body:
        if not isinstance(node, ast.FunctionDef) or node.name not in names:
            continue
        old = "".join(lines[node.lineno - 1:node.end_lineno])
        is_coalesced = node.name.startswith("_coalesced")
        reg, shared = ("Q_stage", "Q_shared") if is_coalesced else ("q_stage", "q_shared")
        dim = "BK" if is_coalesced else "D"
        vec = "q_vec" if is_coalesced else "4"
        bt, tok, hd = ("i_b", "i_t", "i_h") if is_coalesced else ("b", "token", "h")
        qcopy = re.findall(r"^            T\.copy\(Q\[.*\], " + reg + r"\)\n", old, re.M)
        assert len(qcopy) == 1, (node.name, qcopy)
        pre = ""
        if not is_coalesced:
            pre = "            tid = T.get_thread_binding()\n"
        linear = f"(q_slot * 64 + tid) * ({vec}) + q_word * 2 + q_element"
        coords = f"({linear}) // {dim}, ({linear}) % {dim}"
        qload = (pre + f"            for q_slot in T.unroll(G * {dim} // (64 * ({vec}))):\n"
            f"                for q_word in T.unroll(({vec}) // 2):\n"
            "                    for q_element in T.vectorized(2):\n"
            f"                        {reg}[{coords}] = Q[{bt}, {tok}, {hd} * G + ({linear}) // {dim}, ({linear}) % {dim}]\n")
        new = old.replace(qcopy[0], qload)
        if pair_store:
            store = f"                T.copy({reg}, {shared})\n"
            assert new.count(store) == 1
            qstore = (f"                for qs_slot in T.unroll(G * {dim} // (64 * ({vec}))):\n"
                f"                    for qs_word in T.unroll(({vec}) // 2):\n"
                "                        for qs_element in T.vectorized(2):\n")
            linear2 = linear.replace("q_slot", "qs_slot").replace("q_word", "qs_word").replace("q_element", "qs_element")
            coords2 = f"({linear2}) // {dim}, ({linear2}) % {dim}"
            qstore += f"                            {shared}[{coords2}] = {reg}[{coords2}]\n"
            new = new.replace(store, qstore)
        assert source.count(old) == 1
        source = source.replace(old, new, 1)
    ast.parse(source)
    with (HERE / (stem + ".py")).open("x") as file:
        file.write(source)
    print(stem)


build(HERE / "qschedule_wave.py", "qschedule_pair_load", False)
build(HERE / "qschedule_wave.py", "qschedule_pair_both", True)
build(HERE / "baseline.py", "qpair_both_control", True)
