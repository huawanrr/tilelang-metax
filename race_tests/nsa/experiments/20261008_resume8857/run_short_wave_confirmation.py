"""Confirm the one surviving S2 probe across the complete neighboring family."""
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
cases = json.loads((HERE / "s2_confirmation_cases.json").read_text())
command = [sys.executable, str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py")]
command += [str(HERE / name) for name in ("baseline.py", "baseline_submission.py", "short_wave_lane.py")]
command += ["--case-file", str(HERE / "s2_confirmation_cases.json"), "--cases", ",".join(cases),
    "--seeds", "0,61,2026", "--attempts", "20", "--repeat", "400", "--shared-pool",
    "--output", str(HERE / "short_wave_confirmation.json")]
print("Confirm", len(cases), "shapes, three seeds; retain all negative samples", flush=True)
subprocess.run(command, cwd=ROOT, check=True)
