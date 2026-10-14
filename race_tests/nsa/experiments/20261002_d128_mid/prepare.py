"""Probe complete-block D128 medium-grid loads in an isolated directory."""
import ast
import hashlib
import json
from pathlib import Path
import re
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE_DIR = ROOT / "experiments/20261002_output_v1"
BASE = BASE_DIR / "nsa.py"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def once(source, old, new):
    assert source.count(old) == 1, (source.count(old), old)
    return source.replace(old, new)


def function(source, name):
    node = next(node for node in ast.parse(source).body
                if isinstance(node, ast.FunctionDef) and node.name == name)
    start = min([node.lineno] + [item.lineno for item in node.decorator_list]) - 1
    return "\n".join(source.splitlines()[start:node.end_lineno])


def write_new(path, source):
    with path.open("x") as output:
        output.write(source)


def main():
    manifest = json.loads((BASE_DIR / "release_manifest.json").read_text())
    hashes = dict(manifest["preserved_baselines"])
    hashes.update({str((BASE_DIR / name).relative_to(ROOT)): value
                   for name, value in manifest["source_sha256"].items()})
    for name, expected in hashes.items():
        assert digest(ROOT / name) == expected, name
    write_new(HERE / "baseline_manifest.json", json.dumps(dict(source_sha256=hashes,
        baseline=str(BASE.relative_to(ROOT)), parent_manifest_sha256=digest(BASE_DIR / "release_manifest.json"),
        last_official_score=87.93, target_official_score=88.5, new_official_score=None), indent=2) + "\n")
    for original, name in ((BASE, "reference_output.py"), (BASE, "reference_control.py"),
        *[(ROOT / "experiments/20261002_mid_output" / name, name) for name in
          ("compare_family.py", "bracketed_multiseed.py", "family_cases.json", "inspect_resources.py")]):
        assert not (HERE / name).exists(), name
        shutil.copyfile(original, HERE / name)

    source = BASE.read_text()
    original = function(source, "native_sparse_attention_single_linear_v_wave")
    records = []
    for label, width in (("pairs", 2), ("quads", 4)):
        part = once(original, "def native_sparse_attention_single_linear_v_wave(",
                    "def native_sparse_attention_linear_v_blocks(")
        part = once(part, "    lane_reduce = True",
            "    assert dim == 128 and block_size == 16 and seq_len % block_size == 0 and not direct_k\n"
            "    lane_reduce = True")
        part = once(part, "            Q_reg = T.alloc_fragment([G, BK], T.float16)",
            "            _start_buffer_0 = T.alloc_local([1], T.int32)\n"
            "            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])\n"
            "            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])\n"
            "            Q_reg = T.alloc_fragment([G, BK], T.float16)")
        part = once(part, "            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS",
                    "            _selected_block = BlockIndices[i_b, i_t, i_h, 0]")
        part = once(part, "            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):",
            "            if _selected_block >= 0 and _selected_block < seq_len // BS and (not is_causal or _selected_block <= i_t // BS):\n"
            "                _start_buffer_0[0] = _selected_block * BS")
        loads = ""
        for name, cols in (("K", "BK"), ("V", "BV")):
            prefix = name.lower()
            row = f"({prefix}_slot * 512 + tid * 8) // {cols}"
            col = f"tid % ({cols} // 8) * 8 + {prefix}_word * {width} + {prefix}_element"
            loads += f"""                for {prefix}_slot in T.unroll(BS * {cols} // 512):
                    for {prefix}_word in T.unroll({8 // width}):
                        for {prefix}_element in T.vectorized({width}):
                            {name}_reg[{row}, {col}] = {name}_blocks[i_b, _selected_block, {row}, i_h, {col}]
"""
        part = once(part, """                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
""", loads)
        part = re.sub(r"\bi_s\b", "_start_buffer_0[0]", part)
        result = once(source, "def _get_kernel(\n", part + "\n\n\ndef _get_kernel(\n")
        result = once(result, "    key = (\n", """    linear_blocks = (qo_defaults and wave_single and linear_v
        and D == 128 and block_size == 16 and not direct_k and 128 < grid < 1280
        and seq_len % block_size == 0 and pair_resolved == 1 and num_stages == 1
        and online_unroll == 2 and not late_normalize)

    key = (
""")
        result = once(result, "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks,",
            "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks, linear_blocks,")
        result = once(result, "        if d32_compact:", """        if linear_blocks:
            kernel = native_sparse_attention_linear_v_blocks(
                late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif d32_compact:""")
        before = {node.name: ast.dump(node) for node in ast.parse(source).body
                  if isinstance(node, ast.FunctionDef) and node.name != "_get_kernel"}
        after = {node.name: ast.dump(node) for node in ast.parse(result).body
                 if isinstance(node, ast.FunctionDef)}
        assert len(before) == 44 and all(after[name] == body for name, body in before.items())
        target = HERE / f"linear_{label}.py"
        write_new(target, result)
        records.append(dict(path=str(target.relative_to(ROOT)), sha256=digest(target),
            elements_per_load=width, unchanged_non_dispatch_functions=len(before)))
    write_new(HERE / "assembly.json", json.dumps(dict(baseline=str(BASE.relative_to(ROOT)),
        baseline_sha256=digest(BASE), variants=records,
        hypothesis="Validated block views and scalar vector loads may reduce address/promotion overhead in the D128 medium linear-V builder",
        scope="Default S1/D128/BS16/G16/64 threads; 128 < grid < 1280; complete blocks",
        official_new_score=None), indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
