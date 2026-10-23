"""Apply the instruction-changing synchronous memcpy lowering option."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_q_preload_vfirst", "native_sparse_attention_q_preload",
    "native_sparse_attention_direct_kv", "native_sparse_attention_linear_v_blocks_oct8",
    "native_sparse_attention_coalesced_blocks_oct8",
    "native_sparse_attention_coalesced_blocks_fp32_sum",
    "native_sparse_attention_coalesced_blocks_fp32_mask",
    "native_sparse_attention_coalesced_blocks_boundary_v8",
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_short_list_oct8_sum_v11",
    "native_sparse_attention_staged_sparse_blocks_sum_v11",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def main():
    source = (HERE / "baseline.py").read_text()
    functions = [n for n in ast.parse(source).body
                 if isinstance(n, ast.FunctionDef) and n.name in NAMES]
    assert len(functions) == len(NAMES)
    lines = source.splitlines(keepends=True)
    flag = ["-mllvm", "--metaxgpu-MemcpyToLoadStore=true"]
    for fn in sorted(functions, key=lambda n: -n.lineno):
        assert len(fn.decorator_list) == 1
        start = fn.decorator_list[0].lineno - 1
        end = fn.lineno - 1
        decorator = "".join(lines[start:end])
        assert decorator.count("@tilelang.jit(") == 1
        lines[start:end] = [decorator.replace("@tilelang.jit(",
                           f"@tilelang.jit(compile_flags={flag!r}, ", 1)]
    result = "".join(lines)
    original = ast.parse(source)
    changed = ast.parse(result)
    for tree in (original, changed):
        for fn in tree.body:
            if isinstance(fn, ast.FunctionDef):
                fn.decorator_list = []
    assert ast.dump(original) == ast.dump(changed)
    path = HERE / "memcpy_lower.py"
    with path.open("x") as out:
        out.write(result)
    with (HERE / "memcpy_manifest.json").open("x") as out:
        json.dump(dict(baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       candidate_sha256=hashlib.sha256(result.encode()).hexdigest(),
                       flags=flag, affected_decorators=sorted(NAMES),
                       all_function_bodies_unchanged=True), out, indent=2)
        out.write("\n")
    print(path)


if __name__ == "__main__":
    main()
