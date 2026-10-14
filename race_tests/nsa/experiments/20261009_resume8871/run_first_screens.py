"""Run resumed baseline and new arithmetic screens sequentially."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BENCH = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
OLD = ROOT / "experiments/20261008_resume8871"
OJ = ROOT / "experiments/20261008_goal895/oj_cases.json"

jobs = [
    ("v6_oj", [OLD / "baseline.py", OLD / "baseline_submission.py", OLD / "candidate_v6_submission.py"],
     list(json.loads(OJ.read_text())), "0,61", 16, 300),
    ("tensor_denom_screen", [OLD / "candidate_v6.py", OLD / "candidate_v6_submission.py",
      HERE / "tensor_denom_before.py", HERE / "tensor_denom_after.py"],
     ["oj1", "oj2", "oj4", "oj13", "oj14", "15"], "0,61", 16, 300),
]
records = []
for name, modules, cases, seeds, attempts, repeat in jobs:
    output = HERE / (name + ".json")
    assert not output.exists(), output
    command = [sys.executable, str(BENCH), *map(str, modules), "--case-file", str(OJ),
               "--cases", ",".join(cases), "--seeds", seeds, "--attempts", str(attempts),
               "--repeat", str(repeat), "--shared-pool", "--output", str(output)]
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
    start = time.time()
    with (HERE / (name + ".log")).open("x") as log:
        done = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
    records.append(dict(name=name, command=command, source_sha256=hashes,
                        returncode=done.returncode, seconds=time.time() - start))
    (HERE / "first_screens_runs.json").write_text(json.dumps(records, indent=2) + "\n")
    print(name, done.returncode, round(time.time() - start, 1), flush=True)
