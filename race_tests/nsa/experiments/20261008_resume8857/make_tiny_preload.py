"""Test whether tiny global-Q reads can overlap the block-index dependency.

All probes are ordinary TileLang; generated code is only inspected, never injected.
"""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
tree = ast.parse(base)
node = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
            and n.name == "native_sparse_attention_direct_kv")
lines = base.splitlines(keepends=True)
template = "".join(lines[min(d.lineno for d in node.decorator_list) - 1:node.end_lineno])
copy = "            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)\n"
assert template.count(copy) == 1

variants = {
    "qvolatile": template.replace(copy, '            T.attr(Q.data, "volatile_scope", 1)\n' + copy),
    "qsync": template.replace(copy, copy + "            T.sync_warp()\n"),
    "qscalar_volatile": template.replace(copy,
        '            T.attr(Q.data, "volatile_scope", 1)\n'
        '            for chunk in T.unroll(D // 32):\n'
        '                for lane in T.unroll(8):\n'
        '                    q[tid % 16, chunk * 32 + tid // 16 * 8 + lane] = Q[b, token, h * G + tid % 16, chunk * 32 + tid // 16 * 8 + lane]\n'),
}
for name, function in variants.items():
    function = function.replace("native_sparse_attention_direct_kv", "native_sparse_attention_tiny_preload")
    source = base.replace("def _get_kernel(", function + "\n\ndef _get_kernel(", 1)
    before = "            kernel = native_sparse_attention_direct_kv(natural=True, late=D == 32, **common)"
    after = "            kernel = native_sparse_attention_tiny_preload(natural=True, late=D == 32, **common)"
    assert source.count(before) == 1
    source = source.replace(before, after)
    ast.parse(source)
    path = HERE / f"tiny_{name}.py"
    with path.open("x") as file:
        file.write(source)
    print(path.name)
