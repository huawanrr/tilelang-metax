"""Run the next probes one process at a time, with immutable timed modules."""
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
JOBS = {
    "reduction_mid": ("oj4,oj13,oj14,d64_mid_noncausal,d64_b1_t192_h3_c0", ["balanced_mid"]),
    "reduction_short": ("oj10", ["balanced_short"]),
    "reduction_large": ("oj5,oj7,oj8,oj9,d128_large", ["balanced_large"]),
    "pv_tiles": ("oj4,oj5,oj9,oj13,oj14,d128_large", ["pv32", "pv16"]),
}


def main():
    journal = HERE / "study_runs.json"
    history = json.loads(journal.read_text()) if journal.exists() else []
    with (HERE / "gpu.lock").open("w") as lock:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        for name in sys.argv[1:] or JOBS:
            cases, probes = JOBS[name]
            modules = [HERE / (stem + ".py") for stem in ["parent_v9", "control_v9", *probes]]
            command = [sys.executable, "-u", str(BENCH), *map(str, modules), "--case-file", str(HERE / "cases.json"),
                       "--cases", cases, "--seeds", "0,61", "--attempts", "18", "--repeat", "400",
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
