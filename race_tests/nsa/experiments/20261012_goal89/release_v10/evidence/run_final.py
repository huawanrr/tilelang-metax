"""Validate and time the immutable final submission with serialized GPU work."""
from datetime import datetime, timezone
import fcntl
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    dev, sub = HERE / "candidate_v10.py", HERE / "candidate_v10_submission.py"
    base = [HERE / "baseline_v6.py", HERE / "control_v6.py"]
    parent = HERE / "parent_v9.py"
    bench = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
    cold = ROOT / "experiments/20261008_goal895/profile_cold.py"
    jobs = {
        "final_static": [ROOT / "check_submission_nsa.py", dev, sub],
        "final_cpu": [HERE / "check_public_cache_cpu.py", "--candidate", sub, "--output", HERE / "final_cpu.json"],
        "final_scalars": [HERE / "check_public_scalar_fallback.py", sub, "--output", HERE / "final_scalars.json"],
        "final_reference": [ROOT / "experiments/20261002_mid_blocks/verify_reference.py", sub,
            "--cases", "all", "--extras", "--output", HERE / "final_reference.json"],
        "final_extra": [ROOT / "experiments/20261010_resume8893/verify_candidate_extra_v8.py", sub,
            "--parent", base[0], "--output", HERE / "final_extra.json"],
        "final_oj": [bench, *base, parent, sub, "--case-file", HERE / "cases.json",
            "--cases", ",".join(f"oj{i}" for i in range(1,15)), "--seeds", "0,61", "--attempts", "24",
            "--repeat", "400", "--shared-pool", "--output", HERE / "final_oj.json"],
        "final_full": [bench, *base, sub, "--cases", "all", "--seeds", "0", "--attempts", "12",
            "--repeat", "300", "--shared-pool", "--output", HERE / "final_full.json"],
        "final_cold_seed61": [cold, *base, sub, "--case-file", HERE / "cases.json",
            "--cases", "oj1,oj4,oj5,oj7,oj8,oj9,oj13,oj14,d128_large,d64_mid_noncausal,d128_b1_t1280_h1_c0,d64_b1_t512_h3_c0,d64_b1_t256_h4_c0",
            "--seed", "61", "--repeat", "48", "--rounds", "6", "--output", HERE / "final_cold_seed61.json"],
        "final_cold_seed0": [cold, *base, sub, "--case-file", HERE / "cases.json",
            "--cases", "oj1,oj4,oj5,oj9,oj13,oj14,d128_large,d64_mid_noncausal",
            "--seed", "0", "--repeat", "48", "--rounds", "6", "--output", HERE / "final_cold_seed0.json"],
        "final_audit": [HERE / "audit_final.py", "--manifest", HERE / "candidate_v10_manifest.json",
            "--timings", HERE / "final_oj.json", HERE / "final_full.json", "--output", HERE / "final_audit.json"],
        "final_binary": [ROOT / "experiments/20261008_resume8871/audit_actual_binary.py", *base[:1], parent, sub,
            "--case-file", HERE / "cases.json", "--cases", "oj1,oj5,oj9,oj13,d128_large",
            "--output-dir", HERE / "final_binary_audit"],
    }
    journal = HERE / "final_runs.json"
    history = json.loads(journal.read_text()) if journal.exists() else []
    with (HERE / "gpu.lock").open("w") as lock:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        for name in sys.argv[1:] or jobs:
            command = [sys.executable, "-u", *map(str, jobs[name])]
            files = [dev, sub, *base, parent] + [Path(jobs[name][0])]
            hashes = {str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in files}
            log = HERE / (name + ".log")
            assert not log.exists(), name
            record = dict(name=name, command=command, source_sha256=hashes, status="running",
                          started_utc=datetime.now(timezone.utc).isoformat())
            history.append(record)
            journal.write_text(json.dumps(history, indent=2)+"\n")
            print("START", name, flush=True)
            start = time.monotonic()
            with log.open("x") as file:
                result = subprocess.run(command, cwd=ROOT, stdout=file, stderr=subprocess.STDOUT)
            assert hashes == {str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in files}
            record.update(status="PASS" if result.returncode == 0 else "FAIL", returncode=result.returncode,
                          seconds=time.monotonic()-start)
            journal.write_text(json.dumps(history, indent=2)+"\n")
            print(record["status"], name, round(record["seconds"],1), flush=True)
            if result.returncode:
                raise SystemExit(result.returncode)


if __name__ == "__main__":
    main()
