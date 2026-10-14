"""Run independent scheduler screens serially, retaining compiler failures."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BENCH = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
names = sys.argv[1:] or ["ilp", "minreg", "maxocc", "native_exp", "streg_abi"]
history_path = HERE / "schedule_runs.json"
history = json.loads(history_path.read_text()) if history_path.exists() else []
for name in names:
    label = f"schedule_{name}_screen"
    output = HERE / f"{label}.json"
    log_path = HERE / f"{label}.log"
    assert not output.exists() and not log_path.exists(), label
    modules = [HERE / "parent.py", HERE / "parent_submission.py", HERE / f"schedule_{name}.py"]
    command = [sys.executable, str(BENCH), *map(str, modules),
               "--case-file", str(HERE / "oj_cases.json"), "--cases", "oj2,oj6,oj9,oj12",
               "--seeds", "0,61", "--attempts", "12", "--repeat", "300", "--shared-pool",
               "--output", str(output)]
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
    start = time.time()
    record = dict(name=name, command=command, source_sha256=hashes, status="running",
                  started_utc=datetime.now(timezone.utc).isoformat())
    history.append(record)
    history_path.write_text(json.dumps(history, indent=2) + "\n")
    print("START", name, flush=True)
    with log_path.open("x") as log:
        result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
    record.update(returncode=result.returncode, seconds=time.time()-start,
                  status="PASS" if result.returncode == 0 else "FAIL")
    history_path.write_text(json.dumps(history, indent=2) + "\n")
    print(record["status"], name, round(record["seconds"], 1), flush=True)
