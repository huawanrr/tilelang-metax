"""Retest complete-block pair loads with the v4 short-list math body."""
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
PRIOR = HERE.parent / "20261007_resume"
sys.path.insert(0, str(PRIOR))
spec = importlib.util.spec_from_file_location("prior_short_pairs", PRIOR / "make_short_block_loads.py")
prior = importlib.util.module_from_spec(spec)
spec.loader.exec_module(prior)

base = (HERE / "baseline.py").read_text()
manifest = []
for parent, name in (("baseline.py", "short_complete_pairs.py"),
                     ("short_wave_only.py", "short_wave_pairs.py")):
    parent_source = (HERE / parent).read_text()
    node = next(n for n in ast.parse(parent_source).body if isinstance(n, ast.FunctionDef)
                and n.name == "native_sparse_attention_short_list_oct8")
    body = prior.region(parent_source, node, decorated=True)
    body = prior.transform(body, 2)
    body = body.replace("native_sparse_attention_short_list_oct8", "native_sparse_attention_short_complete")
    marker = "    head_kv = heads // groups\n"
    assert body.count(marker) == 1
    body = body.replace(marker,
        "    assert dim == 64 and block_size == 16 and seq_len % block_size == 0\n"
        "    assert groups == 16 and threads == 64 and selected_blocks == 2\n" + marker, 1)
    result = base.replace("\ndef _get_kernel(", "\n" + body + "\n\ndef _get_kernel(", 1)
    marker = "        elif oct8_short:\n"
    assert result.count(marker) == 1
    result = result.replace(marker,
        "        elif oct8_short and seq_len % block_size == 0:\n"
        "            kernel = native_sparse_attention_short_complete(\n"
        "                selected_blocks=S, late_normalize=False, lane_reduce=True,\n"
        "                kv_split=False, direct_k=False, **common)\n" + marker, 1)
    ast.parse(result)
    path = HERE / name
    with path.open("x") as file:
        file.write(result)
    manifest.append(dict(source=name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        parent=parent, transform=str(PRIOR / "make_short_block_loads.py"), fp16_width=2,
        dispatch="Default v4 oct8_short and complete sequence blocks only",
        guard="Original raw block validated before multiplication; invalid K/V tiles explicitly zeroed."))
(HERE / "short_pairs_assembly.json").write_text(json.dumps(manifest, indent=2) + "\n")
print(json.dumps(manifest, indent=2))
