"""Confirm neighboring shape families sequentially on the one GPU."""
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
cases = {}
for group in ("d128", "d32", "s2"):
    cases.update(json.loads((HERE / f"{group}_confirmation_cases.json").read_text()))
for length in (64, 128, 192, 256):
    for causal in (True, False):
        cases[f"d64_late_t{length}_c{int(causal)}"] = dict(
            B=1, SEQ_LEN=length, H=1, HQ=16, D=64, S=1, block_size=16,
            is_causal=causal)
case_path = HERE / "confirmation_cases.json"
with case_path.open("x") as file:
    file.write(json.dumps(cases, indent=2) + "\n")
paths = ["baseline.py", "baseline_submission.py", "candidate_probe_v2.py", "qsync_wide_late.py"]
command = [sys.executable, str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py")]
command += [str(HERE / name) for name in paths]
command += ["--case-file", str(case_path), "--cases", ",".join(cases),
    "--seeds", "0,61,2026", "--attempts", "24", "--repeat", "500", "--shared-pool",
    "--output", str(HERE / "confirmation_screen.json")]
print("Confirming", len(cases), "cases, three seeds", flush=True)
subprocess.run(command, cwd=ROOT, check=True)
