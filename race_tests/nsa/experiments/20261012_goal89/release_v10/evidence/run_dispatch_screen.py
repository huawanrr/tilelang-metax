"""Run GPU comparisons serially; preserve source hashes, failures and raw samples."""
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
BENCH = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"


def main():
    jobs = {
        "dispatch_small": ("oj1", ["small_qpreload", "small_direct"]),
        "dispatch_large": ("oj5,oj7,oj8,oj9", ["large_v6", "large_fp32", "large_q4"]),
        "dispatch_mid": ("oj13", ["mid_fp32", "mid_mathcast"]),
    }
    journal = HERE / "dispatch_runs.json"
    history = json.loads(journal.read_text()) if journal.exists() else []
    with (HERE / "gpu.lock").open("w") as lock:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        for name in sys.argv[1:] or jobs:
            cases, probes = jobs[name]
            modules = [HERE / (stem + ".py") for stem in ["parent_v9", "control_v9", "baseline_v6", *probes]]
            command = [sys.executable, "-u", str(BENCH), *map(str, modules), "--case-file", str(HERE / "cases.json"),
                       "--cases", cases, "--seeds", "0,61", "--attempts", "20", "--repeat", "400",
                       "--shared-pool", "--output", str(HERE / (name + ".json"))]
            hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
            log = HERE / (name + ".log")
            assert not log.exists(), name
            record = dict(name=name, command=command, source_sha256=hashes, status="running",
                          started_utc=datetime.now(timezone.utc).isoformat())
            history.append(record)
            journal.write_text(json.dumps(history, indent=2) + "\n")
            print("START", name, flush=True)
            start = time.monotonic()
            with log.open("x") as file:
                result = subprocess.run(command, cwd=ROOT, stdout=file, stderr=subprocess.STDOUT)
            assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
            record.update(status="PASS" if result.returncode == 0 else "FAIL", returncode=result.returncode,
                          seconds=time.monotonic() - start)
            journal.write_text(json.dumps(history, indent=2) + "\n")
            print(record["status"], name, round(record["seconds"], 1), flush=True)
            if result.returncode:
                raise SystemExit(result.returncode)


if __name__ == "__main__":
    main()
