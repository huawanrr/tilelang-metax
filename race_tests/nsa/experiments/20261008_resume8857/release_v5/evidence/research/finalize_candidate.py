"""Narrow the confirmed probe without changing its device-kernel bodies."""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--short-mode", choices=("none", "wave"), required=True)
args = parser.parse_args()
source_path = HERE / "candidate_probe_v2.py"
source = source_path.read_text()
assert hashlib.sha256(source.encode()).hexdigest() == (
    "dc3a9a936606f9a32a1ff18d00e1898c946f7ad27cd0a5d27850423fe5190107")

old = "preload_direct = (oct8_direct and (D != 32 or grid <= 64)) or ("
new = "preload_direct = (oct8_direct and (D != 32 or (seq_len >= 48 and grid <= 64 and is_causal))) or ("
assert source.count(old) == 1
source = source.replace(old, new, 1)
source = source.replace(
    "    # Larger D32 grids and coalesced paths retain their existing schedule.\n",
    "    # D32 short sequences, noncausal cases, and multiple B/H partitions\n"
    "    # showed mixed or negative confirmation results. Keep their old schedule.\n", 1)

short_name = "native_sparse_attention_short_lane_source"
node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == short_name)
lines = source.splitlines(keepends=True)
old_short = "".join(lines[min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1:node.end_lineno])
if args.short_mode == "wave":
    short_source = (HERE / "short_wave_lane.py").read_text()
    wave = next(n for n in ast.parse(short_source).body if isinstance(n, ast.FunctionDef)
                and n.name == "native_sparse_attention_short_list_oct8")
    wave_lines = short_source.splitlines(keepends=True)
    new_short = "".join(wave_lines[min([wave.lineno] + [d.lineno for d in wave.decorator_list]) - 1:wave.end_lineno])
    new_short = new_short.replace("def native_sparse_attention_short_list_oct8(", "def " + short_name + "(", 1)
    source = source.replace(old_short, new_short, 1)
else:
    source = source.replace(old_short, "", 1)
    source = source.replace("    lane_short = oct8_short\n", "", 1)
    source = source.replace("        preload_direct, lane_short,\n", "        preload_direct,\n", 1)
    branch = """        elif lane_short:
            kernel = native_sparse_attention_short_lane_source(
                selected_blocks=S, late_normalize=False, lane_reduce=True,
                kv_split=False, direct_k=False, **common)
"""
    assert source.count(branch) == 1
    source = source.replace(branch, "", 1)

tree = ast.parse(source)
lines = source.splitlines(keepends=True)
replacements = []
docs = {
    "native_sparse_attention_q_preload":
        '    """Keep Q loads ahead of the sparse index with one uniform wave fence.\n\n'
        '    Complete K/V blocks are consumed directly in the emitter layouts.\n'
        '    This path has no shared memory and is selected only on measured\n'
        '    small-grid defaults; the public tuning paths stay unchanged.\n'
        '    """\n',
    "native_sparse_attention_short_lane_source":
        '    """Consume a short selected-block list with an explicit source-lane reduction.\n\n'
        '    The two shuffles use exactly the original XOR source lanes and\n'
        '    arithmetic order. Three explicit full-wave fences protect the\n'
        '    original K RAW, K/V WAR, and V RAW shared-memory dependencies.\n'
        '    Score masks and normalization follow the v4 short-list kernel.\n'
        '    """\n',
}
for node in tree.body:
    if isinstance(node, ast.FunctionDef) and node.name in docs:
        first = node.body[0]
        assert isinstance(first, ast.Expr) and isinstance(first.value, ast.Constant)
        assert isinstance(first.value.value, str)
        replacements.append((first.lineno - 1, first.end_lineno, docs[node.name]))
for start, end, text in sorted(replacements, reverse=True):
    lines[start:end] = [text]
source = "".join(lines)

spec = importlib.util.spec_from_file_location(
    "final_strip", ROOT / "experiments/20261007_exp_math/make_submission.py")
strip = importlib.util.module_from_spec(spec)
spec.loader.exec_module(strip)
before = {n.name: n for n in strip.no_docs(ast.parse(source_path.read_text())).body
          if isinstance(n, ast.FunctionDef)}
after = {n.name: n for n in strip.no_docs(ast.parse(source)).body
         if isinstance(n, ast.FunctionDef)}
assert set(before) - set(after) == ({short_name} if args.short_mode == "none" else set())
assert set(after) <= set(before)
for name, node in before.items():
    if name not in ("_get_kernel", short_name):
        assert ast.dump(node) == ast.dump(after[name]), name

target = HERE / "candidate_v5.py"
submission = HERE / "candidate_v5_submission.py"
assert not target.exists() and not submission.exists()
with target.open("x") as file:
    file.write(source)
subprocess.run([sys.executable, str(ROOT / "experiments/20261007_exp_math/make_submission.py"),
    str(target), str(submission)], check=True)
report = dict(probe=str(source_path), probe_sha256=hashlib.sha256(source_path.read_bytes()).hexdigest(),
    source=str(target), sha256=hashlib.sha256(target.read_bytes()).hexdigest(),
    submission=str(submission), submission_sha256=hashlib.sha256(submission.read_bytes()).hexdigest(),
    short_mode=args.short_mode,
    changes="D32 Q preload restricted to causal complete blocks with seq_len >= 48 and grid <= 64; "
        + ("S2 uses explicit wave synchronization and source-lane shuffles." if args.short_mode == "wave"
           else "All S2 changes excluded after mixed confirmation results."),
    unchanged_kernel_bodies=sorted(set(before) - {"_get_kernel", short_name}),
    status="Final candidate source; verification and timing required before release.")
(HERE / "candidate_v5_assembly.json").write_text(json.dumps(report, indent=2) + "\n")
print(json.dumps(report, indent=2))
