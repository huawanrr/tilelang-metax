"""Inline the unchanged index normalization at both public call sites."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = HERE / "host_direct.py"
source = base.read_text()
replacements = {
    "        kernel(Q, K, V, _as_int32(BlockIndices), output)": """        if BlockIndices.dtype != torch.int32:
            BlockIndices = BlockIndices.to(torch.int32)
        if not BlockIndices.is_contiguous():
            BlockIndices = BlockIndices.contiguous()
        kernel(Q, K, V, BlockIndices, output)""",
    "    kernel(q, k, v, _as_int32(block_indices), output)": """    if block_indices.dtype != torch.int32:
        block_indices = block_indices.to(torch.int32)
    if not block_indices.is_contiguous():
        block_indices = block_indices.contiguous()
    kernel(q, k, v, block_indices, output)""",
}
for old, new in replacements.items():
    assert source.count(old) == 1
    source = source.replace(old, new)
def functions(text):
    return {n.name:ast.dump(n, include_attributes=False) for n in ast.parse(text).body
            if isinstance(n, ast.FunctionDef)}
old, new = functions(base.read_text()), functions(source)
changed = [k for k in old if old[k] != new[k]]
assert set(changed) == {"native_sparse_attention", "run_kernel"}
compile(source, "host_inline.py", "exec")
path = HERE / "host_inline.py"
with path.open("x") as out:
    out.write(source)
with (HERE / "host_inline_manifest.json").open("x") as out:
    json.dump(dict(parent=base.name, parent_sha256=hashlib.sha256(base.read_bytes()).hexdigest(),
        file=path.name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(), changed_functions=changed,
        normalization_body_unchanged=True), out, indent=2)
    out.write("\n")
