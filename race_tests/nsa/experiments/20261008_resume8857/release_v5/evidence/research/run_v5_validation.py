"""Run final-source checks and measurements in sequence on the single GPU."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
from datetime import datetime, timezone

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PY = sys.executable
DEV = HERE / "candidate_v5.py"
SUB = HERE / "candidate_v5_submission.py"
BASE = HERE / "baseline.py"
CONTROL = HERE / "baseline_submission.py"
OJ = HERE / "oj_cases.json"
COLD = HERE / "final_cold_cases.json"
oj_cases = ",".join(json.loads(OJ.read_text()))
cold_cases = ",".join(json.loads(COLD.read_text()))


def report(name):
    return str(HERE / f"candidate_v5_{name}.json")


commands = {
    "reference": [PY, str(ROOT / "experiments/20261002_mid_blocks/verify_reference.py"),
        str(SUB), "--cases", "all", "--extras", "--output", report("reference")],
    "extra": [PY, str(HERE / "verify_candidate.py"), str(SUB), "--output", report("extra")],
    "oj": [PY, str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py"),
        str(BASE), str(CONTROL), str(DEV), str(SUB), "--case-file", str(OJ),
        "--cases", oj_cases, "--seeds", "0,61", "--attempts", "20", "--repeat", "300",
        "--shared-pool", "--output", report("oj")],
    "full": [PY, str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py"),
        str(BASE), str(CONTROL), str(SUB), "--cases", "all", "--seeds", "0",
        "--attempts", "12", "--repeat", "200", "--shared-pool", "--output", report("full")],
    "cold": [PY, str(ROOT / "experiments/20261008_goal895/profile_cold.py"),
        str(BASE), str(CONTROL), str(SUB), "--case-file", str(COLD), "--cases", cold_cases,
        "--seed", "61", "--repeat", "48", "--rounds", "6", "--output", report("cold")],
    "audit": [PY, str(HERE / "audit_candidate.py"), "--dev", str(DEV), "--submission", str(SUB),
        "--short-mode", "none", "--timings", report("oj"), report("full"), "--output", report("audit")],
    "components": [PY, str(HERE / "audit_components.py"), str(DEV), "--short-mode", "none",
        "--output", report("components")],
    "performance_summary": [PY, str(HERE / "summarize_candidate.py"), "--oj", report("oj"),
        "--full", report("full"), "--cold", report("cold"), "--confirmation",
        str(HERE / "confirmation_screen.json"), "--components", report("components"),
        "--output", report("performance_summary")],
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--stages", default=",".join(commands))
    args = parser.parse_args()
    selected = args.stages.split(",")
    assert selected and all(stage in commands for stage in selected)
    status_path = HERE / "candidate_v5_validation_runs.json"
    history = json.loads(status_path.read_text()) if status_path.exists() else []
    run = dict(started_utc=datetime.now(timezone.utc).isoformat(), command=sys.argv,
        source_sha256={str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (BASE, CONTROL, DEV, SUB)},
        stages=[], status="running")
    history.append(run)

    def save():
        status_path.write_text(json.dumps(history, indent=2) + "\n")

    save()
    for stage in selected:
        log_path = HERE / f"candidate_v5_{stage}.log"
        assert not log_path.exists() and not Path(report(stage)).exists(), stage
        entry = dict(stage=stage, command=commands[stage], status="running",
                     started_utc=datetime.now(timezone.utc).isoformat())
        run["stages"].append(entry)
        save()
        print("START", stage, flush=True)
        with log_path.open("x") as log:
            result = subprocess.run(commands[stage], cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        entry["returncode"] = result.returncode
        entry["finished_utc"] = datetime.now(timezone.utc).isoformat()
        entry["status"] = "PASS" if result.returncode == 0 else "FAIL"
        for path in (BASE, CONTROL, DEV, SUB):
            assert hashlib.sha256(path.read_bytes()).hexdigest() == run["source_sha256"][str(path)]
        save()
        print(entry["status"], stage, flush=True)
        if result.returncode:
            run["status"] = "FAIL"
            save()
            raise SystemExit(result.returncode)
    run["status"] = "PASS"
    run["finished_utc"] = datetime.now(timezone.utc).isoformat()
    save()
    print("PASS", selected, flush=True)


if __name__ == "__main__":
    main()
