"""Validate immutable submission bytes, with strictly serialized GPU work."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    dev, sub = HERE / "candidate_v9.py", HERE / "candidate_v9_submission.py"
    baseline = [HERE / "baseline.py", HERE / "baseline_control.py"]
    parent = HERE / "v7_parent.py"
    bench = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
    cold = ROOT / "experiments/20261008_goal895/profile_cold.py"
    case_file = HERE / "validation_cases.json"
    if not case_file.exists():
        cases = {}
        for filename in ("probe_cases.json", "confirmation_cases.json"):
            cases.update(json.loads((HERE / filename).read_text()))
        case_file.write_text(json.dumps(cases, indent=2) + "\n")
    jobs = {
        "v9_static": [ROOT / "check_submission_nsa.py", dev, sub],
        "v9_reference": [ROOT / "experiments/20261002_mid_blocks/verify_reference.py", sub,
            "--cases", "all", "--extras", "--output", HERE / "v9_reference.json"],
        "v9_extra": [HERE / "verify_candidate_extra_v8.py", sub, "--parent", baseline[0],
            "--output", HERE / "v9_extra.json"],
        "v9_oj": [bench, *baseline, parent, sub, "--case-file", case_file,
            "--cases", ",".join(f"oj{i}" for i in range(1, 15)), "--seeds", "0,61",
            "--attempts", "24", "--repeat", "400", "--shared-pool", "--output", HERE / "v9_oj.json"],
        "v9_full": [bench, *baseline, sub, "--cases", "all", "--seeds", "0", "--attempts", "12",
            "--repeat", "300", "--shared-pool", "--output", HERE / "v9_full.json"],
        "v9_cold_seed61": [cold, *baseline, sub, "--case-file", case_file,
            "--cases", "oj1,oj4,oj5,oj7,oj8,oj9,oj13,oj14,d128_large,d64_mid_noncausal,d128_b1_t1280_h1_c0,d64_b1_t512_h3_c0,d64_b1_t256_h4_c0",
            "--seed", "61", "--repeat", "48", "--rounds", "6", "--output", HERE / "v9_cold_seed61.json"],
        "v9_cold_seed0": [cold, *baseline, sub, "--case-file", case_file,
            "--cases", "oj1,oj4,oj5,oj9,oj13,oj14,d128_large,d64_mid_noncausal",
            "--seed", "0", "--repeat", "48", "--rounds", "6", "--output", HERE / "v9_cold_seed0.json"],
        "v9_audit": [HERE / "audit_v9.py", "--manifest", HERE / "candidate_v9_manifest.json",
            "--timings", HERE / "v9_oj.json", HERE / "v9_full.json", "--case-files", case_file,
            "--output", HERE / "v9_audit.json"],
        "v9_binary": [ROOT / "experiments/20261008_resume8871/audit_actual_binary.py",
            baseline[0], parent, sub, "--case-file", case_file,
            "--cases", "oj4,oj5,oj9,oj13,d128_large,d64_mid_noncausal",
            "--output-dir", HERE / "v9_binary_audit"],
        "v9_public_loop": [ROOT / "experiments/20261009_goal8933/bench_public_loop.py",
            *baseline, sub, "--case-file", case_file,
            "--cases", "oj1,oj2,oj3,oj6,oj9,oj10,oj12,oj13,oj14", "--seeds", "0,61",
            "--attempts", "12", "--repeat", "200", "--output", HERE / "v9_public_loop.json"],
    }
    path = HERE / "v9_final_runs.json"
    history = json.loads(path.read_text()) if path.exists() else []
    for name in sys.argv[1:] or list(jobs):
        log_path = HERE / f"{name}.log"
        assert not log_path.exists(), name
        command = [sys.executable, "-u", *map(str, jobs[name])]
        hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (dev, sub, *baseline, parent)}
        record = dict(name=name, command=command, status="running", source_sha256=hashes,
                      started_utc=datetime.now(timezone.utc).isoformat())
        history.append(record)
        path.write_text(json.dumps(history, indent=2) + "\n")
        print("START", name, flush=True)
        start = time.monotonic()
        with log_path.open("x") as file:
            result = subprocess.run(command, cwd=ROOT, stdout=file, stderr=subprocess.STDOUT)
        assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (dev, sub, *baseline, parent)}
        record.update(returncode=result.returncode, seconds=time.monotonic()-start,
                      status="PASS" if result.returncode == 0 else "FAIL")
        path.write_text(json.dumps(history, indent=2) + "\n")
        print(record["status"], name, round(record["seconds"], 1), flush=True)
        if result.returncode:
            raise SystemExit(result.returncode)


if __name__ == "__main__":
    main()
