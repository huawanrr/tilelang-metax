"""Probe output L2 policy and generated-code optimization; keep packing unchanged."""
import ast
import hashlib
import json
from pathlib import Path

from make_compiler_levels import BASE, ROOT, with_flags

HERE = Path(__file__).resolve().parent


def restore_packers(source, original):
    def spans(text):
        lines = text.splitlines(keepends=True)
        result = {}
        for node in ast.parse(text).body:
            if isinstance(node, ast.FunctionDef) and "pack_kv" in node.name:
                start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
                result[node.name] = (start, node.end_lineno, "".join(lines[start:node.end_lineno]))
        return result
    previous, current = spans(original), spans(source)
    lines = source.splitlines(keepends=True)
    for name in sorted(current, key=lambda n: current[n][0], reverse=True):
        start, end, _ = current[name]
        lines[start:end] = [previous[name][2]]
    return "".join(lines)


def main():
    original = BASE.read_text()
    records = []
    options = (
        ("l2_fetch_off", ["-mllvm", "--metaxgpu-FetchOnWrite-global=false"]),
        ("l2_fetch_on", ["-mllvm", "--metaxgpu-FetchOnWrite-global=true"]),
        ("device_g0", ["-Xdevice=-g0"]),
        ("device_no_slp", ["-mllvm", "--metaxgpu-vectorize-slp=false"]),
    )
    for name, flags in options:
        source = restore_packers(with_flags(original, flags), original)
        ast.parse(source)
        path = HERE / (name + ".py")
        with path.open("x") as f:
            f.write(source)
        records.append(dict(path=str(path.relative_to(ROOT)), flags=flags,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    with (HERE / "cache_probes_assembly.json").open("x") as f:
        f.write(json.dumps(dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
                               variants=records, kernel_bodies_unchanged=True, packers_unchanged=True,
                               tilelang_pass_configs_unchanged=True,
                               hypothesis="Check L2 output write allocation; compare code generation without debug line info and vendor SLP",
                               flag_source="mxcc_llvm_help.txt and mxcc --help; no asynchronous, synchronization, bounds, race or cache-invalidation controls changed"), indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
