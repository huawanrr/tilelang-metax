"""Probe explicit one-wave synchronization on the v4 natural-exp short list."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
manifest = []
for parent, name, q_fence in (
    ("baseline.py", "short_wave_only.py", False),
    ("lane_shuffle.py", "short_wave_lane.py", False),
    ("lane_shuffle.py", "short_wave_qpreload.py", True),
):
    source = (HERE / parent).read_text()
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
                and n.name == "native_sparse_attention_short_list_oct8")
    lines = source.splitlines(keepends=True)
    body = "".join(lines[min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1:node.end_lineno])
    original_body = body
    deco = "tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})"
    assert body.count(deco) == 1
    body = body.replace(deco, "tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True, "
        "tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True})", 1)
    for marker in (
        "                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)\n",
        "                for j, d in T.Parallel(BS, BV):\n                    KV_shared[j * BK + d] = V_reg[j, d]\n",
        "                vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)\n",
    ):
        assert body.count(marker) == 1, marker
        body = body.replace(marker, "                T.sync_warp()\n" + marker, 1)
    if q_fence:
        marker = "            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_reg)\n"
        assert body.count(marker) == 1
        body = body.replace(marker, marker + "            T.sync_warp()\n", 1)
    # Only transplant this builder; do not include the parent's other probes.
    target_node = next(n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)
                       and n.name == node.name)
    base_lines = base.splitlines(keepends=True)
    start = min([target_node.lineno] + [d.lineno for d in target_node.decorator_list]) - 1
    before = "".join(base_lines[start:target_node.end_lineno])
    assert base.count(before) == 1
    result = base.replace(before, body, 1)
    ast.parse(result)
    path = HERE / name
    with path.open("x") as file:
        file.write(result)
    manifest.append(dict(source=name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        parent=parent, q_fence=q_fence, wave_barriers=4 if q_fence else 3,
        hazards="K shared RAW, K shared read before V overwrite, V shared RAW; one 64-lane wave"))
(HERE / "short_sync_assembly.json").write_text(json.dumps(manifest, indent=2) + "\n")
print(json.dumps(manifest, indent=2))
