"""Load a leading V slice before the existing Q shared-memory barrier.

The remaining V columns keep their original place after QK. This overlaps a
bounded amount of input work without adding synchronization or a launch.
"""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
name = "native_sparse_attention_single_packed_qo_v2_mathcast"
node = next(n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef) and n.name == name)
lines = base.splitlines(keepends=True)
original = "".join(lines[node.lineno - 1:node.end_lineno])
old_load = '''                for j, d in T.Parallel(BS, W):
                    v[j, d] = V[b, block, h, j // 16, d // 32,
                        (j % 16 // 4) * 16 + d % 16,
                        (d % 32 // 16) * 4 + j % 4]
'''
assert original.count(old_load) == 1
anchor = "                T.copy(q_stage, q_shared)\n"
assert original.count(anchor) == 1

for width in (16, 32, 64, 128):
    def load(test):
        return f'''                for j, d in T.Parallel(BS, W):
                    if {test}:
                        v[j, d] = V[b, block, h, j // 16, d // 32,
                            (j % 16 // 4) * 16 + d % 16,
                            (d % 32 // 16) * 4 + j % 4]
'''
    modified = original.replace(old_load, load(f"d >= {width}"))
    modified = modified.replace(anchor, load(f"d < {width}") + anchor)
    source = base.replace(original, modified, 1)
    ast.parse(source)
    target = HERE / f"packed_v_preload{width}.py"
    with target.open("x") as file:
        file.write(source)
    print(target.name)
