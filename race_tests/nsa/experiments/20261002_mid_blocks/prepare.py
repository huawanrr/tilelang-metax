"""Prepare isolated D64 medium-grid experiments without modifying releases."""
import ast
import hashlib
import json
import shutil
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_blocks_v2/nsa.py"


def once(source, old, new):
    assert source.count(old) == 1, (source.count(old), old)
    return source.replace(old, new)


def function(source, name):
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == name)
    start = min([node.lineno] + [n.lineno for n in node.decorator_list]) - 1
    return "\n".join(source.splitlines()[start:node.end_lineno])


def write_new(path, content):
    assert not path.exists(), path
    path.write_text(content)


def main():
    for source, target in (
        (BASE, HERE / "reference_blocks_v2.py"),
        (BASE, HERE / "reference_control.py"),
        (ROOT / "experiments/20261001_final/nsa.py", HERE / "reference_1001.py"),
        *[(ROOT / "experiments/20261002_goal885" / name, HERE / name)
          for name in ("compare_family.py", "bracketed_multiseed.py", "family_cases.json")],
        (ROOT / "experiments/20261001_next/inspect_resources.py", HERE / "inspect_resources.py"),
    ):
        assert not target.exists(), target
        shutil.copyfile(source, target)

    source = BASE.read_text()
    original = function(source, "native_sparse_attention_shared_q_reuse")
    records = []
    for label, width in (("guard", 0), ("pairs", 2), ("quads", 4)):
        part = once(original, "def native_sparse_attention_shared_q_reuse(",
                    "def native_sparse_attention_shared_q_blocks(")
        part = once(part, "    lane_reduce = True", "    assert dim == 64 and block_size == 16 and seq_len % block_size == 0\n    lane_reduce = True")
        allocation = "            _start_buffer_0 = T.alloc_local([1], T.int32)\n"
        if width:
            allocation += "            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])\n"
            allocation += "            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])\n"
        part = once(part, "            Q_stage = T.alloc_fragment([G, BK], T.float16)",
                    allocation + "            Q_stage = T.alloc_fragment([G, BK], T.float16)")
        part = once(part, "            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS",
                    "            _selected_block = BlockIndices[i_b, i_t, i_h, 0]")
        part = once(part, "            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):",
                    "            if _selected_block >= 0 and _selected_block < seq_len // BS and (not is_causal or _selected_block <= i_t // BS):\n                _start_buffer_0[0] = _selected_block * BS")
        if width:
            loads = ""
            for name, cols, tile in (("K", "BK", "K_reg"), ("V", "BV", "V_reg")):
                prefix = name.lower()
                row = f"({prefix}_slot * 512 + tid * 8) // {cols}"
                col = f"tid % ({cols} // 8) * 8 + {prefix}_word * {width} + {prefix}_element"
                loads += f"""                for {prefix}_slot in T.unroll(BS * {cols} // 512):
                    for {prefix}_word in T.unroll({8 // width}):
                        for {prefix}_element in T.vectorized({width}):
                            {tile}[{row}, {col}] = {name}_blocks[i_b, _selected_block, {row}, i_h, {col}]
"""
            part = once(part, """                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
""", loads)
        # Only the validated local start participates in the causal mask.
        import re
        part = re.sub(r"\bi_s\b", "_start_buffer_0[0]", part)
        result = once(source, "def _get_kernel(\n", part + "\n\n\ndef _get_kernel(\n")
        result = once(result, "    key = (\n", """    shared_q_blocks = (wave_q_reuse and seq_len % block_size == 0
        and pair_resolved == 1 and num_stages == 1 and online_unroll == 2
        and not late_normalize)

    key = (
""")
        result = once(result, "        d32_index_guard, d32_compact, coalesced_blocks,",
                      "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks,")
        result = once(result, """        elif wave_q_reuse:
            kernel = native_sparse_attention_shared_q_reuse(
""", """        elif wave_q_reuse:
            builder = (native_sparse_attention_shared_q_blocks if shared_q_blocks
                       else native_sparse_attention_shared_q_reuse)
            kernel = builder(
""")
        parsed = ast.parse(result)
        original_functions = {n.name: ast.dump(n) for n in ast.parse(source).body
                              if isinstance(n, ast.FunctionDef) and n.name != "_get_kernel"}
        new_functions = {n.name: ast.dump(n) for n in parsed.body if isinstance(n, ast.FunctionDef)}
        assert all(new_functions[name] == value for name, value in original_functions.items())
        target = HERE / f"mid_{label}.py"
        write_new(target, result)
        records.append(dict(path=target.name, sha256=hashlib.sha256(target.read_bytes()).hexdigest(),
                            elements_per_load=width, preserved_functions=len(original_functions)))

    write_new(HERE / "assembly.json", json.dumps(dict(
        baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, restriction="Only default complete-block D64 shared-Q reuse paths, 256 < B*H*T <= 2048",
        method="Same-storage K/V views and explicit vector loads; no new launch, backend changes, asynchronous copy, or disabled checking"), indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
