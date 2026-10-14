"""Run raw-index and interleaved-layout GPU screens strictly in sequence."""
import json
from datetime import datetime, timezone
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
HARNESS = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
jobs = [
    ("s8_raw_signed_screen", ["s8_raw_signed.py"], HERE / "s8_raw_cases.json",
     "n1024_b4_h1,n512_b8_h1,n512_b4_h2,n1024_b8_h1"),
    ("interleaved_bs32_screen", ["interleaved_bs32_kshared0.py", "interleaved_bs32_kshared1.py"],
     ROOT / "experiments/20261008_goal895/oj_cases.json", "oj6,69,83"),
]
records = []
for name, modules, case_file, cases in jobs:
    output = HERE / (name + ".json")
    log = HERE / (name + ".log")
    assert not output.exists() and not log.exists(), name
    command = [sys.executable, str(HARNESS), str(HERE / "parent.py"), str(HERE / "parent_submission.py")]
    command += [str(HERE / module) for module in modules]
    command += ["--case-file", str(case_file), "--cases", cases, "--seeds", "0,61",
                "--attempts", "16", "--repeat", "300", "--shared-pool", "--output", str(output)]
    record = dict(name=name, command=command, started_utc=datetime.now(timezone.utc).isoformat())
    records.append(record)
    (HERE / "layout_runs.json").write_text(json.dumps(records, indent=2) + "\n")
    print("START", name, flush=True)
    with log.open("x") as handle:
        result = subprocess.run(command, stdout=handle, stderr=subprocess.STDOUT)
    record.update(returncode=result.returncode, finished_utc=datetime.now(timezone.utc).isoformat())
    (HERE / "layout_runs.json").write_text(json.dumps(records, indent=2) + "\n")
    print("DONE", name, result.returncode, flush=True)
