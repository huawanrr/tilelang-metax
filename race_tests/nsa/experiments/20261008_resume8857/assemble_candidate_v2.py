"""Keep the cold-cache wins and restrict D32 to the smallest grids."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
components = [
    ("tiny_qsync.py", "native_sparse_attention_tiny_preload", "native_sparse_attention_q_preload"),
    ("lane_shuffle.py", "native_sparse_attention_short_list_oct8", "native_sparse_attention_short_lane_source"),
]
added = []
for filename, old, new in components:
    text = (HERE / filename).read_text()
    node = next(n for n in ast.parse(text).body if isinstance(n, ast.FunctionDef) and n.name == old)
    lines = text.splitlines(keepends=True)
    part = "".join(lines[min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1:node.end_lineno])
    added.append(part.replace("def " + old + "(", "def " + new + "(", 1))

source = base.replace("def _get_kernel(", "\n\n".join(added) + "\n\ndef _get_kernel(", 1)
marker = "    key = (\n        B,\n"
assert source.count(marker) == 1
source = source.replace(marker, '''    # Q stays ahead of sparse-index dependent loads across a wave fence.
    # Larger D32 grids and coalesced paths retain their existing schedule.
    preload_direct = (oct8_direct and (D != 32 or grid <= 64)) or (
        oct8_complete and D == 128 and grid <= 128)
    lane_short = oct8_short

''' + marker, 1)
key = "        oct8_direct, oct8_linear, oct8_coalesced, oct8_short, oct8_s4, oct8_staged,\n"
assert source.count(key) == 1
source = source.replace(key, key + "        preload_direct, lane_short,\n", 1)
branch = "        if oct8_direct:\n"
assert source.count(branch) == 1
source = source.replace(branch, '''        if preload_direct:
            kernel = native_sparse_attention_q_preload(natural=True, late=D == 32, **common)
        elif lane_short:
            kernel = native_sparse_attention_short_lane_source(
                selected_blocks=S, late_normalize=False, lane_reduce=True,
                kv_split=False, direct_k=False, **common)
        elif oct8_direct:
''', 1)
old = {n.name: n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)}
new = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
for name, node in old.items():
    if name != "_get_kernel":
        assert ast.dump(node) == ast.dump(new[name]), name
path = HERE / "candidate_probe_v2.py"
with path.open("x") as file:
    file.write(source)
(HERE / "candidate_probe_v2_assembly.json").write_text(json.dumps(dict(
    source=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
    components=components, original_functions_kept=sorted(set(old) - {"_get_kernel"}),
    added_functions=sorted(set(new) - set(old)), status="Experimental; validation required"), indent=2) + "\n")
print(path.name)
