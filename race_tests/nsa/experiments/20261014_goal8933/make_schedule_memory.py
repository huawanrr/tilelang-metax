"""Apply only scheduling flags that changed instructions in the offline probe."""
import ast
import hashlib
import json
from pathlib import Path

from probe_compiler_offline import FLAGS

HERE = Path(__file__).resolve().parent
TARGETS = {
    "native_sparse_attention_q_preload_vfirst", "native_sparse_attention_q_preload",
    "native_sparse_attention_direct_kv", "native_sparse_attention_linear_v_blocks_oct8",
    "native_sparse_attention_coalesced_blocks_mathcast", "native_sparse_attention_coalesced_blocks_oct8",
    "native_sparse_attention_coalesced_blocks_fp32_sum", "native_sparse_attention_coalesced_blocks_fp32_mask",
    "native_sparse_attention_coalesced_blocks_boundary_v8", "native_sparse_attention_short_list_oct8",
    "native_sparse_attention_staged_sparse_blocks", "native_sparse_attention_single_packed_qo_v2_mathcast",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def main():
    source = (HERE / "baseline.py").read_text()
    original = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for name in ("latency100", "latency400", "latency800", "load_use_on", "no_vectorizer"):
        flags = FLAGS[name]
        lines = source.splitlines(keepends=True)
        for fn in sorted((original[n] for n in TARGETS), key=lambda n: -n.lineno):
            start = min(n.lineno for n in fn.decorator_list) - 1
            text = "".join(lines[start:fn.end_lineno])
            assert text.count("@tilelang.jit(") == 1, fn.name
            text = text.replace("@tilelang.jit(", f"@tilelang.jit(compile_flags={flags!r}, ", 1)
            lines[start:fn.end_lineno] = [text]
        revised = "".join(lines)
        for fn in ast.parse(revised).body:
            if isinstance(fn, ast.FunctionDef):
                old = ast.parse(ast.get_source_segment(source, original[fn.name])).body[0]
                fn.decorator_list = []
                old.decorator_list = []
                assert ast.dump(fn) == ast.dump(old), fn.name
        path = HERE / f"memory_{name}.py"
        with path.open("x") as out:
            out.write(revised)
        records.append(dict(path=path.name, flags=flags,
            sha256=hashlib.sha256(revised.encode()).hexdigest()))
    with (HERE / "memory_schedule_manifest.json").open("x") as out:
        json.dump(dict(variants=records, baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       bodies_unchanged=True, safety_passes_unchanged=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "memory scheduling probes", flush=True)


if __name__ == "__main__":
    main()
