"""Validate and measure the exact final submission, serializing all GPU work."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DEV = HERE / "candidate_v7.py"
SUB = HERE / "candidate_v7_submission.py"


def main():
    baseline = [HERE / "baseline.py", HERE / "baseline_submission.py"]
    parent = HERE / "parent_submission.py"
    bench = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
    oj = ",".join(f"oj{i}" for i in range(1, 15))
    jobs = {
        "v7_static": [ROOT / "check_submission_nsa.py", DEV, SUB],
        "v7_reference": [ROOT / "experiments/20261002_mid_blocks/verify_reference.py", SUB,
            "--cases", "all", "--extras", "--output", HERE / "v7_reference.json"],
        "v7_extra": [HERE / "verify_candidate_extra.py", SUB, "--output", HERE / "v7_extra.json"],
        "v7_oj": [bench, *baseline, parent, SUB, "--case-file", HERE / "oj_cases.json",
            "--cases", oj, "--seeds", "0,61", "--attempts", "20", "--repeat", "300",
            "--shared-pool", "--output", HERE / "v7_oj.json"],
        "v7_full": [bench, *baseline, SUB, "--cases", "all", "--seeds", "0",
            "--attempts", "12", "--repeat", "200", "--shared-pool", "--output", HERE / "v7_full.json"],
        "v7_audit": [HERE / "audit_candidate.py", "--manifest", HERE / "candidate_v7_manifest.json",
            "--case-files", HERE / "fp32_family_cases.json", HERE / "followup_cases.json",
            "--timings", HERE / "v7_oj.json", HERE / "v7_full.json", "--output", HERE / "v7_audit.json"],
    }
    path = HERE / "final_runs.json"
    history = json.loads(path.read_text()) if path.exists() else []
    immutable = [DEV, SUB, *baseline, parent]
    for name in sys.argv[1:] or list(jobs):
        log_path = HERE / f"{name}.log"
        assert not log_path.exists(), name
        command = [sys.executable, *map(str, jobs[name])]
        hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in immutable}
        record = dict(name=name, command=command, source_sha256=hashes, status="running",
                      started_utc=datetime.now(timezone.utc).isoformat())
        history.append(record)
        path.write_text(json.dumps(history, indent=2) + "\n")
        print("START", name, flush=True)
        start = time.time()
        with log_path.open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in immutable}
        record.update(returncode=result.returncode, seconds=time.time()-start,
                      status="PASS" if result.returncode == 0 else "FAIL")
        path.write_text(json.dumps(history, indent=2) + "\n")
        print(record["status"], name, round(record["seconds"], 1), flush=True)
        if result.returncode:
            raise SystemExit(result.returncode)


if __name__ == "__main__":
    main()
