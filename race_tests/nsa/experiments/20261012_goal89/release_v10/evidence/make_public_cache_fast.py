"""Skip repeated scalar conversion on normal public calls; cache canonical keys only."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent

ENTRY = '''def run_kernel(q, k, v, block_indices, output, B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None):
    scale_value = None if scale is None else float(scale)
    key = ('public_default_arguments', B, seq_len, H, HQ, D, S, block_size, is_causal, scale_value)
    try:
        kernel = _KERNEL_CACHE.get(key)
    except TypeError:
        kernel = None
    if kernel is None:
        B, seq_len, H, HQ, D, S, block_size = int(B), int(seq_len), int(H), int(HQ), int(D), int(S), int(block_size)
        is_causal = bool(is_causal)
        key = ('public_default_arguments', B, seq_len, H, HQ, D, S, block_size, is_causal, scale_value)
        kernel = _KERNEL_CACHE.get(key)
        if kernel is None:
            kernel = _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale_value)
            _KERNEL_CACHE[key] = kernel
    kernel(q, k, v, _as_int32(block_indices), output)
'''


def main():
    parent = HERE / "parent_v9.py"
    source = parent.read_text()
    original = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == "run_kernel")
    lines = source.splitlines(keepends=True)
    lines[original.lineno - 1:original.end_lineno] = [ENTRY]
    code = "".join(lines)
    old = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    new = {n.name: ast.dump(n) for n in ast.parse(code).body if isinstance(n, ast.FunctionDef)}
    assert old.keys() == new.keys()
    assert [n for n in old if old[n] != new[n]] == ["run_kernel"]
    path = HERE / "public_cache_fast.py"
    with path.open("x") as file:
        file.write(code)
    with (HERE / "public_cache_fast_manifest.json").open("x") as file:
        json.dump(dict(parent=str(parent), parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
            path=str(path), sha256=hashlib.sha256(code.encode()).hexdigest(),
            changed_function="run_kernel", device_functions_unchanged=True,
            keys="Only canonical built-in integers, bool, None/float and a string namespace are stored. No tensor, tensor address, input values or preprocessed data are stored.",
            scalar_conversion="Probe the canonical dictionary directly with normal scalar arguments; on a miss or an unhashable scalar, normalize exactly as the parent before looking up or compiling."), file, indent=2)
        file.write("\n")
    print(path.name)


if __name__ == "__main__":
    main()
