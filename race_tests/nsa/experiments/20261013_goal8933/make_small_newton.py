"""Check normalization placement after changing the small path's reciprocal."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
source = (HERE / "reciprocal_v2_newton2.py").read_text()
fn = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
          and n.name == "native_sparse_attention_q_preload_vfirst")
old = ast.get_source_segment(source, fn)
marker = "    assert threads == 64"
assert old.count(marker) == 1
new = old.replace(marker, "    late = False\n" + marker, 1)
result = source.replace(old, new, 1)
ast.parse(result)
path = HERE / "small_newton2_early.py"
with path.open("x") as file:
    file.write(result)
(HERE / "small_newton_manifest.json").write_text(json.dumps(dict(
    parent="reciprocal_v2_newton2.py", path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(),
    note="Only vfirst builder changes normalization placement; research, no finalized dispatch"), indent=2) + "\n")
print(path.name)
