"""Combine the frozen 928 trials with the validated 929 synchronous paths."""
import argparse
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PROBES = ROOT / "experiments/20260929_recheck"


def extract(path, original, replacement):
    text = path.read_text()
    node = next(n for n in ast.parse(text).body if isinstance(n, ast.FunctionDef) and n.name == original)
    lines = text.splitlines(keepends=True)
    part = "".join(lines[node.decorator_list[0].lineno - 1:node.end_lineno])
    return part.replace(f"def {original}(", f"def {replacement}(", 1)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--output", default="nsa.py")
    p.add_argument("--mid-q", action="store_true")
    a = p.parse_args()
    base_path = ROOT / "experiments/20260928_s8_order_oj/nsa.py"
    source = base_path.read_text()
    inputs = [base_path]
    definitions = []
    for path, old, new in (
        (ROOT / "experiments/20260928_pv32_oj/nsa.py", "native_sparse_attention_single_block_pv32", "native_sparse_attention_single_block_pv32"),
        (PROBES / "d32_k_linear.py", "single_block_shuffle", "native_sparse_attention_d32_shuffle"),
        (PROBES / "swizzle16.py", "native_sparse_attention_single_block_emitter", "native_sparse_attention_single_vec16"),
        (PROBES / "v_linear.py", "single_block_shared_layout", "native_sparse_attention_single_linear_v"),
    ):
        inputs.append(path)
        definitions.append(extract(path, old, new))
    if a.mid_q:
        path = PROBES / "q_shared_linear.py"
        inputs.append(path)
        definitions.append(extract(path, "single_shared_q", "native_sparse_attention_mid_shared_q"))
    source = source.replace("\n\n_KERNEL_CACHE = {}", "\n\n" + "\n\n".join(definitions) + "\n\n_KERNEL_CACHE = {}", 1)
    start = source.index("def _get_kernel(")
    host = source[start:]
    flags = """    # Register-K exchange pays off once a D32 launch has multiple waves.
    d32_shuffle = (S == 1 and use_emitter and D == 32 and block_size == 16
        and grid >= 1024 and not kv_split)
    # The direct-K D128 path only needs V shared memory; use wider swizzling.
    direct_vec16 = (S == 1 and use_emitter and D == 128 and block_size == 16
        and direct_k and not kv_split)
    # Small and medium launches benefit from independent K/V shared layouts.
    linear_v = (S == 1 and use_emitter and not kv_split and grid <= 2048 and (
        (D == 128 and block_size == 16 and not direct_k)
        or (D == 64 and (block_size >= 32 or direct_k))))
    # Retain the independently tested 928 throughput trial.
    pv32_trial = (S == 1 and use_emitter and D == 128 and block_size == 32
        and grid >= 4096 and late_normalize and not kv_split)
"""
    if a.mid_q:
        flags += """    mid_shared_q = (S == 1 and D == 64 and block_size == 16 and groups == 16
        and threads == 64 and not kv_frag and not kv_split and 1536 < grid <= 2560
        and kv_reuse and stage_regs and q_preload and not q_frag
        and nmax and not o_stage and min_blocks == 0)
"""
    host = host.replace("    key = (", flags + "    key = (", 1)
    host = host.replace("        prefetch_depth,\n    )", "        prefetch_depth,\n        d32_shuffle, direct_vec16, linear_v, pv32_trial,\n" +
                        ("        mid_shared_q,\n" if a.mid_q else "") + "    )", 1)
    branches = """        if d32_shuffle:
            kernel = native_sparse_attention_d32_shuffle(
                late_normalize=late_normalize, kv_split=False,
                direct_k=False, lane_reduce=True, **common)
        elif direct_vec16:
            kernel = native_sparse_attention_single_vec16(
                late_normalize=late_normalize, kv_split=False,
                direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif linear_v:
            kernel = native_sparse_attention_single_linear_v(
                late_normalize=late_normalize, kv_split=False,
                direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif pv32_trial:
            kernel = native_sparse_attention_single_block_pv32(
                late_normalize=late_normalize, kv_split=False,
                direct_k=direct_k, lane_reduce=lane_reduce, **common)
"""
    if a.mid_q:
        branches += """        elif mid_shared_q:
            kernel = native_sparse_attention_mid_shared_q(
                late_normalize=late_normalize, kv_split=False,
                direct_k=False, lane_reduce=False, **common)
"""
    branches += "        elif S == 1 and use_emitter:\n"
    host = host.replace("        if S == 1 and use_emitter:\n", branches, 1)
    source = source[:start] + host
    ast.parse(source)
    (HERE / a.output).write_text(source)
    manifest = dict(output=a.output, mid_q=a.mid_q,
                    inputs={str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs},
                    sha256=hashlib.sha256(source.encode()).hexdigest())
    (HERE / (Path(a.output).stem + "_build.json")).write_text(json.dumps(manifest, indent=2) + "\n")
    print(json.dumps(manifest, indent=2))


if __name__ == "__main__":
    main()
