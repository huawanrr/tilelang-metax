"""Restore v4 at D32/T48 after its six-round cold-cache regression."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
parent = HERE / "candidate_v5.py"
source = parent.read_text()
assert hashlib.sha256(source.encode()).hexdigest() == "ea3968b5c4940caf0dfe5c8e3a5cc95e05d91e37db7be314a4e5b49bb303dd86"
old = "D != 32 or (seq_len >= 48 and grid <= 64 and is_causal)"
new = "D != 32 or (seq_len >= 64 and grid <= 64 and is_causal)"
assert source.count(old) == 1
result = source.replace(old, new, 1)
before = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
after = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
assert before.keys() == after.keys()
for name in before:
    if name != "_get_kernel":
        assert ast.dump(before[name]) == ast.dump(after[name]), name
dev = HERE / "candidate_v5b.py"
sub = HERE / "candidate_v5b_submission.py"
assert not dev.exists() and not sub.exists()
with dev.open("x") as file:
    file.write(result)
subprocess.run([sys.executable, str(ROOT / "experiments/20261007_exp_math/make_submission.py"),
               str(dev), str(sub)], check=True)
report = dict(parent=str(parent), parent_sha256=hashlib.sha256(parent.read_bytes()).hexdigest(),
    source=str(dev), source_sha256=hashlib.sha256(dev.read_bytes()).hexdigest(),
    submission=str(sub), submission_sha256=hashlib.sha256(sub.read_bytes()).hexdigest(),
    short_mode="none", change="D32 lower sequence-length threshold 48 -> 64; no other AST change.",
    evidence="candidate_v5_cold.json: D32/T48 median ratio 0.9819518716577593, all six paired rounds regressed.",
    unchanged_functions=sorted(set(before) - {"_get_kernel"}),
    final_version_label="v5", status="Revised final candidate; validation pending.")
(HERE / "candidate_v5b_assembly.json").write_text(json.dumps(report, indent=2) + "\n")
print(json.dumps(report, indent=2))
