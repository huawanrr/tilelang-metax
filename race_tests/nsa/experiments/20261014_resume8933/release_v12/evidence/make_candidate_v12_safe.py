"""Preserve ordinary callable fallback when a host guard returns None."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
parent = HERE / "candidate_v12_submission.py"
original = parent.read_text()
needle = "kernel = kernel.torch_function"
assert original.count(needle) == 2
source = original.replace(needle, "kernel = kernel.torch_function or kernel")
def functions(text):
    return {n.name:ast.dump(n, include_attributes=False) for n in ast.parse(text).body
            if isinstance(n, ast.FunctionDef)}
before, after = functions(original), functions(source)
assert {name for name in before if before[name] != after[name]} == {"native_sparse_attention", "run_kernel"}
compile(source, "candidate_v12_final_submission.py", "exec")
path = HERE / "candidate_v12_final_submission.py"
with path.open("x") as out:
    out.write(source)
with (HERE / "candidate_v12_final_manifest.json").open("x") as out:
    json.dump(dict(parent=parent.name, parent_sha256=hashlib.sha256(parent.read_bytes()).hexdigest(),
        file=path.name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        device_builders_and_dispatch_unchanged=True,
        reason="RestrictedPython safer_getattr returns None for an absent torch_function; retain the original ordinary callable in that case."), out, indent=2)
    out.write("\n")
print(path.name, hashlib.sha256(path.read_bytes()).hexdigest())
