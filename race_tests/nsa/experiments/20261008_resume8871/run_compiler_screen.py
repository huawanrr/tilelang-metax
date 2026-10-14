"""Run each probe separately so a failed variant does not discard other results."""
from datetime import datetime, timezone
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
records = []
for probe in json.loads((HERE / "compiler_manifest.json").read_text())["variants"]:
    path = Path(probe["path"])
    name = path.stem
    command = [sys.executable, str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py"),
        str(HERE / "parent.py"), str(HERE / "parent_submission.py"), str(path),
        "--case-file", str(ROOT / "experiments/20261008_goal895/oj_cases.json"),
        "--cases", "oj2,oj4,oj5,oj6,oj10,oj11,oj12", "--seeds", "61",
        "--attempts", "10", "--repeat", "200", "--shared-pool",
        "--output", str(HERE / f"{name}_screen.json")]
    print("START", name, flush=True)
    start = datetime.now(timezone.utc).isoformat()
    with (HERE / f"{name}_screen.log").open("x") as log:
        result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    records.append(dict(name=name, command=command, started_utc=start,
        finished_utc=datetime.now(timezone.utc).isoformat(), returncode=result.returncode))
    (HERE / "compiler_runs.json").write_text(json.dumps(records, indent=2) + "\n")
    print("FINISH", name, result.returncode, flush=True)
