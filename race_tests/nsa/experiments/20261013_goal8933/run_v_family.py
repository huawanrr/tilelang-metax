"""Serial multiseed validation of both promising V-lifetime schedules."""
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
report = HERE / "v_lifetime_family.json"
log = HERE / "v_lifetime_family.log"
assert not report.exists() and not log.exists()
cases = json.loads((HERE / "v_lifetime_cases.json").read_text())
command = [sys.executable, str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py")]
command += [str(HERE / name) for name in (
    "baseline.py", "control.py", "v_lifetime_after_q.py", "v_lifetime_after_kstore.py")]
command += ["--case-file", str(HERE / "v_lifetime_cases.json"), "--cases", ",".join(cases),
            "--seeds", "0,61", "--attempts", "18", "--repeat", "350", "--shared-pool", "--output", str(report)]
print("START", len(cases), "shapes, two seeds", flush=True)
with log.open("x") as file:
    result = subprocess.run(command, cwd=ROOT, stdout=file, stderr=subprocess.STDOUT)
print("DONE", result.returncode, flush=True)
raise SystemExit(result.returncode)
