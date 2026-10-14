"""Probe public compiler flags; retain every TileLang safety/synchronization pass."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {
    "native_sparse_attention_q_preload",
    "native_sparse_attention_direct_kv",
    "native_sparse_attention_linear_v_blocks_oct8",
    "native_sparse_attention_coalesced_blocks_oct8",
    "native_sparse_attention_coalesced_blocks_mathcast",
    "native_sparse_attention_short_list_oct8",
    "native_sparse_attention_staged_sparse_blocks",
    "native_sparse_attention_single_packed_qo_v2_mathcast",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}
FLAGS = {
    "vector_loads": ["-mllvm", "--metaxgpu-scalarize-global-loads=0"],
    "half_copy": ["-mllvm", "--metaxgpu-enable-16bit-reg-copy-opt=true"],
    "packed_fma": ["-mllvm", "--metaxgpu-pk-fma=1"],
    "reciprocal": ["-freciprocal-math"],
    "fast_preserve_inf": ["-ffast-math", "-fno-finite-math-only"],
}


def main():
    base = BASE.read_text()
    records = []
    for name, flags in FLAGS.items():
        lines = base.splitlines(keepends=True)
        edits = []
        for node in ast.parse(base).body:
            if not isinstance(node, ast.FunctionDef) or node.name not in TARGETS:
                continue
            start = min(d.lineno for d in node.decorator_list) - 1
            text = "".join(lines[start:node.end_lineno])
            assert text.count("@tilelang.jit(") == 1
            text = text.replace("@tilelang.jit(", f"@tilelang.jit(compile_flags={flags!r}, ", 1)
            edits.append((start, node.end_lineno, text))
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        before = {n.name: n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)}
        after = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        for key, old in before.items():
            new = after[key]
            old.decorator_list = []
            new.decorator_list = []
            assert ast.dump(old) == ast.dump(new), key
        path = HERE / f"compiler_{name}.py"
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path), flags=flags, sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
        print(path.name)
    (HERE / "compiler_manifest.json").write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        targets=sorted(TARGETS), variants=records, function_bodies_unchanged=True,
        safety_passes_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
