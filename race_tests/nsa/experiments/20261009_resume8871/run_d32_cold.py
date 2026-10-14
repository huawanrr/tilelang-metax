"""Confirm the whole small-D32 denominator idea, including hot regressions."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
from datetime import datetime, timezone

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
OLD = HERE.parent / "20261008_resume8871"
MODULES = [OLD / "candidate_v6.py", OLD / "candidate_v6_submission.py",
           HERE / "tensor_denom_floor.py"]
IDS = [
    "d32_b1_t16_h1_c1", "d32_b1_t16_h1_c0",
    "d32_b2_t16_h1_c1", "d32_b2_t16_h1_c0",
    "d32_b1_t32_h1_c1", "d32_b2_t32_h1_c1",
    "d32_b1_t64_h1_c1", "d32_b1_t64_h1_c0",
    "d32_b1_t128_h1_c1", "d32_b2_t64_h1_c1",
    "d32_b1_t32_h2_c1", "d32_b1_t48_h2_c0",
    "d32_b1_t96_h1_c1", "d32_b1_t192_h1_c1",
    "d32_b3_t64_h1_c1", "d32_b1_t64_h3_c1",
]


def main():
    source = json.loads((HERE / "d32_denom_family_cases.json").read_text())
    cases = {key: source[key] for key in IDS}
    case_file = HERE / "d32_denom_cold_cases.json"
    with case_file.open("x") as handle:
        json.dump(cases, handle, indent=2)
        handle.write("\n")
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in MODULES}
    history = []
    for seed in (0, 61):
        name = f"d32_denom_cold_seed{seed}"
        output = HERE / (name + ".json")
        assert not output.exists(), output
        command = [sys.executable, str(ROOT / "experiments/20261008_goal895/profile_cold.py"),
                   *map(str, MODULES), "--case-file", str(case_file), "--cases", ",".join(cases),
                   "--seed", str(seed), "--repeat", "48", "--rounds", "6", "--output", str(output)]
        item = dict(name=name, command=command, source_sha256=hashes,
                    started_utc=datetime.now(timezone.utc).isoformat(), status="running")
        history.append(item)
        status_file = HERE / "d32_denom_cold_runs.json"
        status_file.write_text(json.dumps(history, indent=2) + "\n")
        print("START", name, flush=True)
        with (HERE / (name + ".log")).open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in MODULES}
        item.update(returncode=result.returncode, status="PASS" if result.returncode == 0 else "FAIL",
                    finished_utc=datetime.now(timezone.utc).isoformat())
        status_file.write_text(json.dumps(history, indent=2) + "\n")
        print(item["status"], name, flush=True)
        if result.returncode:
            raise SystemExit(result.returncode)


if __name__ == "__main__":
    main()
