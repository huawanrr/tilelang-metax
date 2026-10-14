"""Assemble only selected default-path probes; preserve original builders."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
components = [
    ("tiny_qsync.py", "native_sparse_attention_tiny_preload", "native_sparse_attention_q_preload"),
    ("qschedule_pair_load.py", "_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_q_preload"),
    ("qschedule_pair_load.py", "_coalesced_block_loads_prim_oct8", "_coalesced_block_loads_prim_q_preload_mid"),
    ("baseline.py", "native_sparse_attention_coalesced_blocks_mathcast", "native_sparse_attention_coalesced_q_preload"),
    ("baseline.py", "native_sparse_attention_coalesced_blocks_oct8", "native_sparse_attention_coalesced_q_preload_mid"),
    ("lane_shuffle.py", "native_sparse_attention_short_list_oct8", "native_sparse_attention_short_lane_source"),
]
rename = {old: new for _, old, new in components}
added = []
for filename, old, new in components:
    source = (HERE / filename).read_text()
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == old)
    lines = source.splitlines(keepends=True)
    part = "".join(lines[min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1:node.end_lineno])
    # Apply longest names first to avoid changing shared name prefixes twice.
    for prior in sorted(rename, key=len, reverse=True):
        part = part.replace(prior + "(", rename[prior] + "(")
    assert "def " + new + "(" in part
    added.append(part)

assert base.count("def _get_kernel(") == 1
source = base.replace("def _get_kernel(", "\n\n".join(added) + "\n\ndef _get_kernel(", 1)
marker = "    key = (\n        B,\n"
assert source.count(marker) == 1
scope = '''    # A Q load before the wave fence stays ahead of the sparse-index branch.
    preload_direct = oct8_direct or (oct8_complete and D == 128 and grid <= 128)
    preload_coalesced = (mathcast_defaults and S == 1 and groups == 16
        and D == 64 and H == 1 and block_size == 16 and seq_len % 16 == 0
        and seq_len >= 128 and grid >= 512)
    lane_short = oct8_short

'''
source = source.replace(marker, scope + marker, 1)
key = "        oct8_direct, oct8_linear, oct8_coalesced, oct8_short, oct8_s4, oct8_staged,\n"
assert source.count(key) == 1
source = source.replace(key, key + "        preload_direct, preload_coalesced, lane_short,\n", 1)
branch = "        if oct8_direct:\n"
assert source.count(branch) == 1
source = source.replace(branch, '''        if preload_direct:
            kernel = native_sparse_attention_q_preload(natural=True, late=D == 32, **common)
        elif preload_coalesced:
            builder = (native_sparse_attention_coalesced_q_preload_mid if oct8_coalesced
                       else native_sparse_attention_coalesced_q_preload)
            kernel = builder(q_vec=8, pv_width=128, **common)
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
destination = HERE / "candidate_probe_v1.py"
with destination.open("x") as file:
    file.write(source)
report = dict(source=str(destination), sha256=hashlib.sha256(destination.read_bytes()).hexdigest(),
    components=components, original_functions_kept=sorted(set(old) - {"_get_kernel"}),
    added_functions=sorted(set(new) - set(old)), status="Experimental; validation required")
(HERE / "candidate_probe_v1_assembly.json").write_text(json.dumps(report, indent=2) + "\n")
print(destination.name, report["sha256"])
