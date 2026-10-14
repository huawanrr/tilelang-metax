"""Serial family confirmation and actual public-loop measurement."""
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
    cases = json.loads((HERE / "followup_cases.json").read_text())
    bench = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
    public = ROOT / "experiments/20261009_goal8933/bench_public_loop.py"
    common = ["--seeds", "0,61", "--attempts", "24", "--repeat", "400", "--shared-pool"]
    modules = lambda names: [str(HERE / (name + ".py")) for name in names]
    base = ["parent_v9", "control_v9"]
    jobs = {
        "pv_family": [str(bench), *modules(base + ["pv32", "pv16", "pv32_balanced"]),
            "--case-file", str(HERE / "followup_cases.json"), "--cases", ",".join(n for n in cases if n.startswith("pv_")),
            *common, "--output", str(HERE / "pv_family.json")],
        "balanced_family": [str(bench), *modules(base + ["balanced_mid"]),
            "--case-file", str(HERE / "followup_cases.json"), "--cases", ",".join(n for n in cases if n.startswith("sum_")),
            *common, "--output", str(HERE / "balanced_family.json")],
        "public_cache_loop": [str(public), *modules(base + ["public_cache"]),
            "--case-file", str(HERE / "cases.json"), "--cases", "oj1,oj2,oj3,oj6,oj9,oj10,oj12,oj13,oj14",
            "--seeds", "0,61", "--attempts", "20", "--repeat", "300", "--output", str(HERE / "public_cache_loop.json")],
    }
    journal = HERE / "followup_runs.json"
    history = json.loads(journal.read_text()) if journal.exists() else []
    with (HERE / "gpu.lock").open("w") as lock:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        for name in sys.argv[1:] or jobs:
            command = [sys.executable, "-u", *jobs[name]]
            files = [Path(p) for p in command if p.endswith(".py")]
            hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files}
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
            assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files}
            record.update(status="PASS" if result.returncode == 0 else "FAIL", returncode=result.returncode,
                          seconds=time.monotonic() - start)
            journal.write_text(json.dumps(history, indent=2) + "\n")
            print(record["status"], name, round(record["seconds"], 1), flush=True)
            if result.returncode:
                raise SystemExit(result.returncode)


if __name__ == "__main__":
    main()
