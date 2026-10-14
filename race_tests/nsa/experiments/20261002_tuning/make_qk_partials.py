"""Recheck QK dependency splitting after the Q/O and packing changes."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE.parent / "20261001_final/nsa.py").read_text()
PACKED = (HERE / "pack_v_shared4_latev.py").read_text()


def modify(source, name, ways, packed=False):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    fn = "".join(lines[start:node.end_lineno])
    score = "scores" if packed else "acc_s"
    declaration = f"            {score} = T.alloc_fragment([G, BS], T.float32)"
    extra = "".join(f"            part{k} = T.alloc_fragment([G, BS], T.float32)\n" for k in range(1, ways))
    assert fn.count(declaration) == 1
    fn = fn.replace(declaration, extra + declaration)
    ann = f"                {score}: qk.make_mma_store_layout({score}),"
    assert fn.count(ann) == 1
    fn = fn.replace(ann, "".join(f"                part{k}: qk.make_mma_store_layout(part{k}),\n" for k in range(1, ways)) + ann)
    steps = "D // 32" if packed else "qk_steps"
    loop = f"                for ki in T.serial({steps}):"
    assert fn.count(loop) == 1
    fn = fn.replace(loop, "".join(f"                T.clear(part{k})\n" for k in range(1, ways))
                    + f"                for ki in T.unroll({steps}):")
    pairs = [("q", "k")] if packed else [("Q_reg", "K_reg"), ("Q_reg", "kb")]
    for q, k in pairs:
        old = f"qk.mma({q}, {k}, {score}, ki)"
        assert fn.count(old) == 1
        line = next(l for l in fn.splitlines() if old in l)
        indent = line[:len(line)-len(line.lstrip())]
        code = []
        for i in range(ways):
            dest = score if i == 0 else f"part{i}"
            code += [f"{indent}{'if' if i == 0 else 'elif'} ki % {ways} == {i}:",
                     f"{indent}    qk.mma({q}, {k}, {dest}, ki)"]
        fn = fn.replace(line, "\n".join(code))
    marker = f"                for i, j in T.Parallel(G, BS):\n                    {score}[i, j] = T.exp2"
    assert fn.count(marker) == 1
    reduction = "                for i, j in T.Parallel(G, BS):\n" + "".join(
        f"                    {score}[i, j] += part{k}[i, j]\n" for k in range(1, ways))
    fn = fn.replace(marker, reduction + marker)
    return "".join(lines[:start]) + fn + "".join(lines[node.end_lineno:])


for ways in (2, 4):
    for family in ("coalesced", "packed"):
        result = modify(PACKED if family == "packed" else BASE,
                        "native_sparse_attention_single_packed_qo" if family == "packed" else "_coalesced_qo_prim",
                        ways, family == "packed")
        ast.parse(result)
        path = HERE / f"{family}_qk{ways}.py"
        if path.exists():
            raise FileExistsError(path)
        path.write_text(result)
        print(path.name)
