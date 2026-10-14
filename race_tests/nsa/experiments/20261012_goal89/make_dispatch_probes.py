"""Compare existing builders over whole shape families, using frozen v9 bytes."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent

REPLACEMENTS = {
    "large_v6": (
        "fp32_large = mathcast_blocks and (D == 128 or is_causal)",
        "fp32_large = mathcast_blocks and D == 128",
    ),
    "large_fp32": (
        "native_sparse_attention_coalesced_blocks_fp32_sum if D == 128 else native_sparse_attention_coalesced_blocks_boundary_v8",
        "native_sparse_attention_coalesced_blocks_fp32_sum",
    ),
    "small_qpreload": (
        "tiny_vfirst = preload_direct and D == 32",
        "tiny_vfirst = False",
    ),
    "small_direct": (
        "preload_direct = oct8_direct and (D != 32 or (seq_len >= 64 and grid <= 64 and is_causal)) or (oct8_complete and D == 128 and (grid <= 128))",
        "preload_direct = (oct8_direct and D != 32) or (oct8_complete and D == 128 and grid <= 128)",
    ),
    "mid_fp32": (
        "native_sparse_attention_coalesced_blocks_fp32_mask if fp32_multih else native_sparse_attention_coalesced_blocks_oct8",
        "native_sparse_attention_coalesced_blocks_fp32_sum if fp32_multih else native_sparse_attention_coalesced_blocks_oct8",
    ),
    "mid_mathcast": (
        "native_sparse_attention_coalesced_blocks_fp32_mask if fp32_multih else native_sparse_attention_coalesced_blocks_oct8",
        "native_sparse_attention_coalesced_blocks_mathcast if fp32_multih else native_sparse_attention_coalesced_blocks_oct8",
    ),
    "large_q4": (
        "builder(q_vec=4 if qo_four else 8, pv_width=64 if qo_narrow else 128, **common)",
        "builder(q_vec=4 if (qo_four or (mathcast_blocks and D == 64)) else 8, pv_width=64 if qo_narrow else 128, **common)",
    ),
}


def main():
    source = (HERE / "parent_v9.py").read_text()
    old_functions = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    manifest = {}
    for name, (old, new) in REPLACEMENTS.items():
        assert source.count(old) == 1, (name, source.count(old))
        code = source.replace(old, new, 1)
        functions = {n.name: ast.dump(n) for n in ast.parse(code).body if isinstance(n, ast.FunctionDef)}
        assert functions.keys() == old_functions.keys()
        assert all(functions[n] == old_functions[n] for n in functions if n != "_get_kernel")
        path = HERE / f"{name}.py"
        with path.open("x") as file:
            file.write(code)
        manifest[name] = dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), old=old, new=new)
    with (HERE / "dispatch_probes.json").open("x") as file:
        json.dump(manifest, file, indent=2)
        file.write("\n")
    print("Created", len(manifest), "dispatch-only probes")


if __name__ == "__main__":
    main()
