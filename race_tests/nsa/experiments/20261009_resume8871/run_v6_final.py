"""Finish v6 validation on the current device, preserving the actual source hashes."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
OLD = ROOT / "experiments/20261008_resume8871"
V4 = ROOT / "experiments/20261008_goal895/release_v4"
DEV, SUB = OLD / "candidate_v6.py", OLD / "candidate_v6_submission.py"
BASE, CONTROL = V4 / "nsa.py", V4 / "submission.py"
PY = sys.executable


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--stages", default="reference,full,cold,audit,static")
    args = parser.parse_args()
    cold_cases = json.loads((ROOT / "experiments/20261008_goal895/oj_cases.json").read_text())
    cold_cases = {k: cold_cases[k] for k in ("oj1", "oj2", "oj6")}
    supplied = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    for case in (69, 70, 83):
        cold_cases[str(case)] = supplied[case - 1]
    for name, b, t, h in (("bs32_grid1024_h2", 1, 512, 2),
                           ("bs32_grid8192_h2", 4, 1024, 2),
                           ("bs32_grid16384_h1", 16, 1024, 1)):
        cold_cases[name] = dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=128, S=1,
                                block_size=32, is_causal=True)
    cold_file = HERE / "v6_final_cold_cases.json"
    if cold_file.exists():
        assert json.loads(cold_file.read_text()) == cold_cases
    else:
        with cold_file.open("x") as f:
            json.dump(cold_cases, f, indent=2)
            f.write("\n")
    result_file = lambda name: str(HERE / f"v6_final_{name}.json")
    commands = {
        "reference": [PY, str(ROOT / "experiments/20261002_mid_blocks/verify_reference.py"),
                      str(SUB), "--cases", "all", "--extras", "--output", result_file("reference")],
        "full": [PY, str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py"),
                 str(BASE), str(CONTROL), str(SUB), "--cases", "all", "--seeds", "0",
                 "--attempts", "12", "--repeat", "200", "--shared-pool", "--output", result_file("full")],
        "cold": [PY, str(ROOT / "experiments/20261008_goal895/profile_cold.py"),
                 str(BASE), str(CONTROL), str(SUB), "--case-file", str(cold_file),
                 "--cases", ",".join(cold_cases), "--seed", "61", "--repeat", "48", "--rounds", "6",
                 "--output", result_file("cold")],
        "audit": [PY, str(HERE / "audit_v6.py"), "--dev", str(DEV), "--submission", str(SUB),
                  "--timings", str(HERE / "v6_oj.json"), result_file("full"),
                  "--pack-family", str(OLD / "pack_tiling_family.json"), "--output", result_file("audit")],
        "static": [PY, str(ROOT / "check_submission_nsa.py"), str(DEV), str(SUB)],
    }
    stages = args.stages.split(",")
    assert all(s in commands for s in stages)
    paths = [BASE, CONTROL, DEV, SUB]
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
    status_file = HERE / "v6_final_runs.json"
    history = json.loads(status_file.read_text()) if status_file.exists() else []
    run = dict(command=sys.argv, started_utc=datetime.now(timezone.utc).isoformat(),
               source_sha256=hashes, status="running", stages=[])
    history.append(run)

    def save():
        status_file.write_text(json.dumps(history, indent=2) + "\n")

    save()
    for stage in stages:
        log_file = HERE / f"v6_final_{stage}.log"
        assert not log_file.exists() and not Path(result_file(stage)).exists(), stage
        item = dict(stage=stage, command=commands[stage], status="running",
                    started_utc=datetime.now(timezone.utc).isoformat())
        run["stages"].append(item)
        save()
        print("START", stage, flush=True)
        with log_file.open("x") as log:
            result = subprocess.run(commands[stage], cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
        item.update(returncode=result.returncode, finished_utc=datetime.now(timezone.utc).isoformat(),
                    status="PASS" if result.returncode == 0 else "FAIL")
        save()
        print(item["status"], stage, flush=True)
        if result.returncode:
            run["status"] = "FAIL"
            save()
            raise SystemExit(result.returncode)
    run.update(status="PASS", finished_utc=datetime.now(timezone.utc).isoformat())
    save()


if __name__ == "__main__":
    main()
