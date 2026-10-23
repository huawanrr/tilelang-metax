"""Execute the predeclared cold comparison on one serialized GPU queue."""
import datetime
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    plan = json.loads((HERE / "cold_plan.json").read_text())
    status_path = HERE / "cold_status.json"
    assert not status_path.exists()
    report = dict(status="running", steps=[])
    for name, expected in plan["source_hashes"].items():
        assert hashlib.sha256((HERE / name).read_bytes()).hexdigest() == expected
    for seed in plan["seeds"]:
        output = HERE / f"cold_seed{seed}.json"
        assert not output.exists()
        command = [sys.executable, str(ROOT / "experiments/20261008_goal895/profile_cold.py"),
                   *[str(HERE / name) for name in plan["modules"]],
                   "--case-file", str(HERE / "family_cases.json"),
                   "--cases", ",".join(plan["cases"]), "--seed", str(seed),
                   "--rounds", str(plan["rounds"]), "--repeat", str(plan["repeat"]),
                   "--output", str(output)]
        step = dict(seed=seed, command=command,
                    started=datetime.datetime.now(datetime.timezone.utc).isoformat())
        report["steps"].append(step)
        status_path.write_text(json.dumps(report, indent=2) + "\n")
        print("START", seed, flush=True)
        start = time.monotonic()
        with (HERE / f"cold_seed{seed}.log").open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        step.update(returncode=result.returncode, seconds=time.monotonic()-start)
        if result.returncode:
            report["status"] = "FAIL"
            status_path.write_text(json.dumps(report, indent=2) + "\n")
            raise SystemExit(result.returncode)
        print("PASS", seed, flush=True)
        status_path.write_text(json.dumps(report, indent=2) + "\n")
    report["status"] = "PASS"
    status_path.write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
