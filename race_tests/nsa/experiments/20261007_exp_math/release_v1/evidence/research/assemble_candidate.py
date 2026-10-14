"""Build a default-only math/cast candidate directly on the official 88.29 base."""
import ast
import hashlib
import json
from pathlib import Path
import re
import textwrap

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"
OFFICIAL = BASE.with_name("submission.py")
S8 = (
    "native_sparse_attention_online_packed_batch_minor_o_v2",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2",
)
SINGLE = "native_sparse_attention_single_packed_qo_v2"
PRIM = "_coalesced_block_loads_prim"
WRAPPER = "native_sparse_attention_coalesced_blocks"
RENAMES = {name: name + "_mathcast" for name in S8 + (SINGLE, PRIM, WRAPPER)}


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def region(source, name):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return "".join(source.splitlines(keepends=True)[start:node.end_lineno])


def once(source, old, new):
    assert source.count(old) == 1, (old[:120], source.count(old))
    return source.replace(old, new)


def scale_guard(fn, name):
    score = "scores" if name == SINGLE else "acc_s"
    lines = fn.splitlines(keepends=True)
    nodes = sorted((n for n in ast.walk(ast.parse(fn)) if isinstance(n, ast.For)
        and isinstance(n.body[0], ast.Assign)
        and ast.unparse(n.body[0]).startswith(score + "[i, j] = T.exp")), key=lambda n: n.lineno)
    assert len(nodes) == (5 if name in S8 else 1)
    edits = []
    for index, node in enumerate(nodes):
        if name in S8:
            start, token = ("i_s" if index == 0 else f"i_s{index-1}"), "i_t"
        elif name == SINGLE:
            start, token = "start", "token"
        else:
            start, token = "_start_buffer_0[0]", "i_t"
        pad = re.match(" *", lines[node.lineno - 1])[0]
        old = "".join(lines[node.lineno - 1:node.end_lineno])
        expr = ast.unparse(node.body[0].value)
        valid = f"{start} + j < seq_len and (not is_causal or {start} + j <= {token})"
        new = (pad + "if scale_log2 > 0:\n" + textwrap.indent(old, "    ")
               + pad + "else:\n" + pad + "    for i, j in T.Parallel(G, BS):\n"
               + pad + f"        {score}[i, j] = T.if_then_else({valid}, {expr}, 0.0)\n")
        edits.append((node.lineno - 1, node.end_lineno, new))
    for first, last, new in reversed(edits):
        lines[first:last] = [new]
    return "".join(lines)


def main():
    source = BASE.read_text()
    before = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    additions = []
    origins = []
    for name in S8 + (SINGLE, PRIM, WRAPPER):
        parent = HERE / ("lane_cast_folded.py" if name in S8 else "lane_cast_baseline.py")
        fn = region(parent.read_text(), name)
        if name != WRAPPER:
            fn = scale_guard(fn, name)
        if name in S8:
            fn = once(fn, "                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS",
                "                raw_index = BlockIndices[i_b, i_t, i_h, si]\n"
                "                indices[si] = T.min(T.max(raw_index, -1), T.ceildiv(seq_len, BS)) * BS")
        fn = once(fn, "def " + name + "(", "def " + RENAMES[name] + "(")
        if name == WRAPPER:
            fn = once(fn, "return " + PRIM + "(", "return " + RENAMES[PRIM] + "(")
        additions.append(fn)
        origins.append(dict(function=RENAMES[name], parent=str(parent), parent_sha256=digest(parent)))
    source = once(source, "\ndef _get_kernel(", "\n\n" + "\n\n".join(additions) + "\n\ndef _get_kernel(")
    dispatcher = region(source, "_get_kernel")
    updated = once(dispatcher, "    if q_frag is None:\n", """    # A separately keyed path preserves every explicitly supplied tuning option.
    mathcast_defaults = (threads == 64 and num_stages == 1 and kv_reuse
        and stage_regs and not o_stage and q_frag is None and nmax
        and not kv_frag and pair is None and min_blocks == 0
        and q_frag_online is None and online_unroll == 2
        and late_normalize is None and q_preload is None and not kv_split)
    if q_frag is None:
""")
    updated = once(updated, "    key = (\n", """    mathcast_s8 = mathcast_defaults and s8_output_v2
    mathcast_single = mathcast_defaults and packed_qo
    mathcast_blocks = mathcast_defaults and coalesced_blocks

    key = (
""")
    updated = once(updated,
        "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks,\n",
        "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks,\n"
        "        mathcast_s8, mathcast_single, mathcast_blocks,\n")
    updated = once(updated,
        "            attention = native_sparse_attention_single_packed_qo_v2(width=128, late=False, **common)",
        f"            packed_builder = ({RENAMES[SINGLE]} if mathcast_single\n"
        f"                              else {SINGLE})\n"
        "            attention = packed_builder(width=128, late=False, **common)")
    old_blocks = ("            builder = (native_sparse_attention_coalesced_blocks if coalesced_blocks\n"
                  "                       else native_sparse_attention_coalesced_qo)\n")
    updated = once(updated, old_blocks, old_blocks
        + f"            if mathcast_blocks:\n                builder = {RENAMES[WRAPPER]}\n")
    for old_name, fallback in ((S8[1], "native_sparse_attention_online_packed_quad_batch_minor"),
                               (S8[0], "native_sparse_attention_online_packed_batch_minor")):
        original = (f"                online_builder = ({old_name} if s8_output_v2\n"
                    f"                                  else {fallback})\n")
        updated = once(updated, original, original
            + f"                if mathcast_s8:\n                    online_builder = {RENAMES[old_name]}\n")
    source = once(source, dispatcher, updated)
    after = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    assert all(before[name] == after[name] for name in before if name != "_get_kernel")
    target = HERE / "candidate_v1.py"
    with target.open("x") as f:
        f.write(source)
    metadata = dict(parent=str(BASE), parent_sha256=digest(BASE), official_baseline=str(OFFICIAL),
        official_baseline_sha256=digest(OFFICIAL), official_score=88.29, target_score=89,
        candidate=str(target), candidate_sha256=digest(target), new_official_score=None,
        origins=origins, original_builders_unchanged=True, default_arguments_only=True,
        cache_key_distinguishes_explicit_tuning=True,
        s8_scope="Existing s8_output_v2: S8/D64/BS16/G16, grid >= 4096",
        single_scope="Existing packed_qo: S1/D128/BS32/G16, grid >= 1024",
        blocks_scope="Existing coalesced_blocks, complete BS16 blocks; D64 grid >= 2304, D128 grid >= 1280",
        extra_fp16_rounding=False, scales_guarded_after_exp_when_nonpositive=True,
        s8_raw_index_clamped_before_multiply=True)
    (HERE / "candidate_v1_assembly.json").write_text(json.dumps(metadata, indent=2) + "\n")
    print(target, digest(target))


if __name__ == "__main__":
    main()
