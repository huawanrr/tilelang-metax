"""Confirm the two remaining measured mechanisms, with serial GPU work."""
import json
from datetime import datetime, timezone
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
HARNESS = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
family_file = HERE / "mid_boundary_cases.json"
jobs = [
    ("mid_boundary_family", ["boundary_mask_post.py"], family_file,
     ",".join(json.loads(family_file.read_text())), "0,61", 20, 400),
    ("tiled_pack_screen", ["joint_pack256.py", "pack_tiles_rows.py", "pack_tiles_cols.py"],
     ROOT / "experiments/20261008_goal895/oj_cases.json", "oj6,69,83", "0,61", 16, 300),
]
records = []
for name, modules, case_file, cases, seeds, attempts, repeat in jobs:
    output, log = HERE / (name + ".json"), HERE / (name + ".log")
    assert not output.exists() and not log.exists(), name
    command = [sys.executable, str(HARNESS), str(HERE / "parent.py"), str(HERE / "parent_submission.py")]
    command += [str(HERE / m) for m in modules]
    command += ["--case-file", str(case_file), "--cases", cases, "--seeds", seeds,
                "--attempts", str(attempts), "--repeat", str(repeat), "--shared-pool", "--output", str(output)]
    record = dict(name=name, command=command, started_utc=datetime.now(timezone.utc).isoformat())
    records.append(record)
    (HERE / "mid_pack_confirmation_runs.json").write_text(json.dumps(records, indent=2) + "\n")
    print("START", name, flush=True)
    with log.open("x") as handle:
        result = subprocess.run(command, stdout=handle, stderr=subprocess.STDOUT)
    record.update(returncode=result.returncode, finished_utc=datetime.now(timezone.utc).isoformat())
    (HERE / "mid_pack_confirmation_runs.json").write_text(json.dumps(records, indent=2) + "\n")
    print("DONE", name, result.returncode, flush=True)
