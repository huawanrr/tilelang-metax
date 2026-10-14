"""Keep current Q loads ahead of sparse-index dependent accesses."""
import ast
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / "baseline.py").read_text()
functions = {
    n.name: n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)
}
lines = base.splitlines(keepends=True)
names = [
    "native_sparse_attention_direct_kv",
    "native_sparse_attention_linear_v_blocks_oct8",
    "_coalesced_block_loads_prim_mathcast",
    "_coalesced_block_loads_prim_oct8",
    "native_sparse_attention_single_packed_qo_v2_mathcast",
    "native_sparse_attention_short_list_oct8",
    "native_sparse_attention_staged_sparse_blocks",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
]


def part(name):
    node = functions[name]
    return "".join(lines[node.lineno - 1:node.end_lineno])


def write(name, edits):
    source = base
    for function, change in edits.items():
        old = part(function)
        assert source.count(old) == 1
        source = source.replace(old, change, 1)
    ast.parse(source)
    with (HERE / name).open("x") as file:
        file.write(source)
    print(name)


edits = {}
for name in names:
    old = part(name)
    copies = re.findall(r"^            T\.copy\(Q\[.*\], \w+\)\n", old, re.M)
    assert len(copies) == 1, (name, copies)
    qcopy = copies[0]
    if "online_packed" in name:
        new = old.replace(qcopy, "")
        before = "            indices = T.alloc_local([S], T.int32)\n"
        assert new.count(before) == 1
        new = new.replace(before, qcopy + "            T.sync_warp()\n" + before)
    else:
        new = old.replace(qcopy, qcopy + "            T.sync_warp()\n")
    edits[name] = new
write("qschedule_wave.py", edits)

# Move the existing shared-Q staging rather than add a second synchronization.
edits = {}
for name in ("_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
             "native_sparse_attention_single_packed_qo_v2_mathcast"):
    old = part(name)
    if name.startswith("_coalesced"):
        sequence = ("                T.copy(Q_stage, Q_shared)\n"
                    "                T.sync_warp()\n"
                    "                T.copy(Q_shared, Q_reg)\n")
    else:
        sequence = ("                T.copy(q_stage, q_shared)\n"
                    "                T.sync_warp()\n"
                    "                T.copy(q_shared, q)\n")
    assert old.count(sequence) == 1, name
    new = old.replace(sequence, "")
    qcopy = re.findall(r"^            T\.copy\(Q\[.*\], \w+\)\n", new, re.M)
    assert len(qcopy) == 1
    hoisted = "\n".join(line[4:] for line in sequence.rstrip("\n").splitlines()) + "\n"
    new = new.replace(qcopy[0], qcopy[0] + hoisted)
    edits[name] = new
write("qschedule_shared_early.py", edits)
