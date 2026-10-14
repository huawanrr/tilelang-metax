"""Packing and CTA order probes on the fixed 10.1 attention implementation."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
OLD = HERE.parent / "20261001_next"
BASE = (OLD / "packed_q4_latev.py").read_text()


def once(s, a, b):
    assert s.count(a) == 1, (a[:100], s.count(a))
    return s.replace(a, b)


def change(s, name, fn):
    node = next(n for n in ast.parse(s).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = s.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return "".join(lines[:start]) + fn("".join(lines[start:node.end_lineno])) + "".join(lines[node.end_lineno:])


def save(name, source):
    ast.parse(source)
    p = HERE / (name + ".py")
    if p.exists():
        raise FileExistsError(p)
    p.write_text(source)
    print(p.name)


for name in ("pack_v_direct", "pack_v_shared4", "pack_v_shared8", "pack_v_shared4_t64"):
    old = (OLD / (name + ".py")).read_text()
    def extract(fn):
        node = next(n for n in ast.parse(old).body if isinstance(n, ast.FunctionDef) and n.name == "native_sparse_attention_pack_kv")
        return "\n".join(old.splitlines()[min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1:node.end_lineno]) + "\n"
    save(name + "_latev", change(BASE, "native_sparse_attention_pack_kv", extract))

for mode in ("batch_minor", "flat", "reverse", "interleave4", "interleave16", "interleave64"):
    def grid(fn):
        launch = "        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):\n"
        if mode == "batch_minor":
            new = "        with T.Kernel(batch * H, seq_len, threads=threads) as (bh, token):\n"
        elif mode == "flat":
            new = "        with T.Kernel(seq_len * batch * H, threads=threads) as (flat,):\n            token, bh = flat % seq_len, flat // seq_len\n"
        elif mode == "reverse":
            new = "        with T.Kernel(seq_len, batch * H, threads=threads) as (tx, bh):\n            token = seq_len - tx - 1\n"
        else:
            n = int(mode.removeprefix("interleave"))
            new = f"""        with T.Kernel(T.ceildiv(seq_len, {n}) * batch * H, {n}, threads=threads) as (bx, by):
            bh = bx % (batch * H)
            token = bx // (batch * H) * {n} + by
"""
            # All probes below are only dispatched for divisible sequence lengths.
        return once(fn, launch, new)
    source = change(BASE, "native_sparse_attention_single_packed_qo", grid)
    if mode.startswith("interleave"):
        n = int(mode.removeprefix("interleave"))
        source = once(source, "and grid >= 1024 and True", f"and grid >= 1024 and seq_len % {n} == 0")
    save("packed_" + mode, source)
