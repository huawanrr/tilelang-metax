"""Check packed FP32 sums, then confirm the core family with raw A/B/A data."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BENCH = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
family = json.loads((HERE / "fp32_family_cases.json").read_text())
jobs = {
    "fp32_packed_screen": ("fp32_packed_sum.py", "oj_cases.json", "oj6,69,83,oj12,81,98"),
    "fp32_family": ("fp32_core.py", "fp32_family_cases.json", ",".join(family)),
}
names = sys.argv[1:] or list(jobs)
history_path = HERE / "fp32_study_runs.json"
history = json.loads(history_path.read_text()) if history_path.exists() else []
for name in names:
    module, case_file, cases = jobs[name]
    output, log_path = HERE / f"{name}.json", HERE / f"{name}.log"
    assert not output.exists() and not log_path.exists(), name
    modules = [HERE / "parent.py", HERE / "parent_submission.py", HERE / module]
    command = [sys.executable, str(BENCH), *map(str, modules),
               "--case-file", str(HERE / case_file), "--cases", cases,
               "--seeds", "0,61", "--attempts", "16", "--repeat", "300", "--shared-pool",
               "--output", str(output)]
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
    start = time.time()
    record = dict(name=name, command=command, source_sha256=hashes, status="running",
                  started_utc=datetime.now(timezone.utc).isoformat())
    history.append(record)
    history_path.write_text(json.dumps(history, indent=2) + "\n")
    print("START", name, flush=True)
    with log_path.open("x") as log:
        result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
    record.update(returncode=result.returncode, seconds=time.time()-start,
                  status="PASS" if result.returncode == 0 else "FAIL")
    history_path.write_text(json.dumps(history, indent=2) + "\n")
    print(record["status"], name, round(record["seconds"], 1), flush=True)
