"""Compare public compiler scheduling options with identical kernel bodies."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {
    "native_sparse_attention_q_preload", "native_sparse_attention_direct_kv",
    "native_sparse_attention_linear_v_blocks_oct8",
    "native_sparse_attention_coalesced_blocks_oct8",
    "native_sparse_attention_coalesced_blocks_mathcast",
    "native_sparse_attention_short_list_oct8", "native_sparse_attention_staged_sparse_blocks",
    "native_sparse_attention_single_packed_qo_v2_mathcast",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}
FLAGS = {
    "ilp": ["-mllvm", "--misched=metaxgpu-ilp"],
    "minreg": ["-mllvm", "--misched=metaxgpu-minreg"],
    "maxocc": ["-mllvm", "--misched=metaxgpu-maxocc"],
    "native_exp": ["-mllvm", "--metaxgpu-use-native=exp,exp2"],
    "streg_abi": ["-metaxgpu-new-streg-abi", "true"],
}


def main(flags_by_name=None, manifest_name="schedule_manifest.json"):
    base = BASE.read_text()
    records = []
    for name, flags in (FLAGS if flags_by_name is None else flags_by_name).items():
        lines = base.splitlines(keepends=True)
        edits = []
        for node in ast.parse(base).body:
            if not isinstance(node, ast.FunctionDef) or node.name not in TARGETS:
                continue
            start = min(d.lineno for d in node.decorator_list) - 1
            value = "".join(lines[start:node.end_lineno])
            assert value.count("@tilelang.jit(") == 1
            value = value.replace("@tilelang.jit(", f"@tilelang.jit(compile_flags={flags!r}, ", 1)
            edits.append((start, node.end_lineno, value))
        assert len(edits) == len(TARGETS)
        for start, end, value in reversed(edits):
            lines[start:end] = [value]
        result = "".join(lines)
        old_functions = {n.name: n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)}
        for fn in ast.parse(result).body:
            if isinstance(fn, ast.FunctionDef):
                old = old_functions[fn.name]
                fn.decorator_list = []
                old.decorator_list = []
                assert ast.dump(fn) == ast.dump(old)
        path = HERE / f"schedule_{name}.py"
        with path.open("x") as output:
            output.write(result)
        records.append(dict(path=str(path), flags=flags, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / manifest_name).open("x") as output:
        json.dump(dict(parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
                       targets=sorted(TARGETS), variants=records,
                       kernel_bodies_and_safety_passes_unchanged=True), output, indent=2)
        output.write("\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
