"""Remove JITKernel's forwarding call while retaining the checked adapter."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = HERE / "baseline.py"


def digest(text):
    return hashlib.sha256(text.encode()).hexdigest()


def functions(text):
    return {n.name: ast.dump(n, include_attributes=False)
            for n in ast.parse(text).body if isinstance(n, ast.FunctionDef)}


def main():
    original = SOURCE.read_text()
    boundary = original.index("\ndef native_sparse_attention(\n")
    prefix, public = original[:boundary], original[boundary:]
    marker = "\n    def run(Q, K, V, BlockIndices):\n"
    assert public.count(marker) == 1
    public = public.replace(marker, """
    try:
        kernel = kernel.torch_function
    except AttributeError:
        pass

    def run(Q, K, V, BlockIndices):
""")
    marker = """            kernel = _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale_value)
            _KERNEL_CACHE[key] = kernel
"""
    assert public.count(marker) == 1
    public = public.replace(marker, """            kernel = _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale_value)
            try:
                kernel = kernel.torch_function
            except AttributeError:
                pass
            _KERNEL_CACHE[key] = kernel
""")
    direct = prefix + public
    all_calls = direct
    replacements = {
        "        pack(k, v, packed_k, packed_v)": "        pack.torch_function(k, v, packed_k, packed_v)",
        "        attention(q, packed_k, packed_v, indices, output)": "        attention.torch_function(q, packed_k, packed_v, indices, output)",
        "        pack(K, V, packed)": "        pack.torch_function(K, V, packed)",
        "        attention(Q, packed, BlockIndices, Output)": "        attention.torch_function(Q, packed, BlockIndices, Output)",
    }
    for old, new in replacements.items():
        assert all_calls.count(old) == 1, old
        all_calls = all_calls.replace(old, new)
    base_functions = functions(original)
    rows = []
    for name, source, expected in (
        ("host_direct", direct, {"native_sparse_attention", "run_kernel"}),
        ("host_all", all_calls, {"native_sparse_attention", "run_kernel", "_make_packed_attention", "_make_block_joint_attention"}),
    ):
        parsed = functions(source)
        changed = {key for key in base_functions if parsed[key] != base_functions[key]}
        assert changed == expected, changed
        assert parsed.keys() == base_functions.keys()
        assert "adapter.executable" not in source
        compile(source, name, "exec")
        path = HERE / (name + ".py")
        with path.open("x") as out:
            out.write(source)
        rows.append(dict(file=path.name, sha256=digest(source), changed_functions=sorted(changed)))
    with (HERE / "host_call_manifest.json").open("x") as out:
        json.dump(dict(baseline_sha256=digest(original), rows=rows,
            all_device_builders_unchanged=True, dispatch_builder_unchanged=True,
            retains_adapter_validation=True, retains_per_call_int32_contiguous_conversion=True,
            packed_source_inspection_captures_retained=True), out, indent=2)
        out.write("\n")
    print(json.dumps(rows, indent=2))


if __name__ == "__main__":
    main()
