"""Run selected GPU jobs strictly one at a time and preserve every result."""
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
    groups = json.loads((HERE / "confirmation_groups.json").read_text())
    probes = dict(mid_q=["q_vec4.py"], mid_reduce=["reduce_independent.py", "loads_vec4.py"],
                  d128_load=["loads_vec4.py", "large_boundary_exp.py", "large_boundary_exp_vec4.py"],
                  large_mixed=["large_boundary_exp.py"])
    history_path = HERE / "confirmation_runs.json"
    history = json.loads(history_path.read_text()) if history_path.exists() else []
    for name in sys.argv[1:] or list(groups):
        modules = [HERE / p for p in ["baseline.py", "baseline_control.py", "v7_parent.py", *probes[name]]]
        log_path = HERE / f"{name}_family.log"
        output_path = HERE / f"{name}_family.json"
        assert not log_path.exists() and not output_path.exists()
        command = [sys.executable, "-u", str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py"),
                   *map(str, modules), "--case-file", str(HERE / "confirmation_cases.json"),
                   "--cases", ",".join(groups[name]), "--seeds", "0,61", "--attempts", "18",
                   "--repeat", "400", "--shared-pool", "--output", str(output_path)]
        hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
        record = dict(name=name, status="running", command=command, source_sha256=hashes,
                      started_utc=datetime.now(timezone.utc).isoformat())
        history.append(record)
        history_path.write_text(json.dumps(history, indent=2) + "\n")
        print("START", name, flush=True)
        start = time.monotonic()
        with log_path.open("x") as file:
            result = subprocess.run(command, cwd=ROOT, stdout=file, stderr=subprocess.STDOUT)
        assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
        record.update(returncode=result.returncode, seconds=time.monotonic()-start,
                      status="PASS" if result.returncode == 0 else "FAIL")
        history_path.write_text(json.dumps(history, indent=2) + "\n")
        print(record["status"], name, round(record["seconds"], 1), flush=True)
        if result.returncode:
            raise SystemExit(result.returncode)


if __name__ == "__main__":
    main()
