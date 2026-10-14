"""Run the query-pair experiment and full D32 denominator family in series."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
OLD = ROOT / "experiments/20261008_resume8871"
BENCH = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
existing = []
for name in ("d32_confirmation_cases", "tiny_family_cases"):
    existing += list(json.loads((ROOT / f"experiments/20261008_resume8857/{name}.json").read_text()).values())
for b, t, h in ((1, 160, 1), (1, 176, 1), (2, 80, 1), (1, 80, 2),
                 (3, 64, 1), (1, 64, 3), (2, 48, 2), (4, 48, 1), (1, 48, 4)):
    for causal in (False, True):
        existing.append(dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=32, S=1, block_size=16, is_causal=causal))
cases = {}
for c in existing:
    if c["D"] != 32 or c["B"] * c["H"] * c["SEQ_LEN"] > 256:
        continue
    key = f"d32_b{c['B']}_t{c['SEQ_LEN']}_h{c['H']}_c{int(c['is_causal'])}"
    cases[key] = c
family = HERE / "d32_denom_family_cases.json"
with family.open("x") as handle:
    json.dump(cases, handle, indent=2)
baseline = [OLD / "candidate_v6.py", OLD / "candidate_v6_submission.py"]
jobs = [
    ("pair_ilp_screen", [HERE / f"pair_ilp_p{p}_w{w}.py" for p, w in ((1, 64), (2, 32), (2, 64), (2, 128))],
     HERE / "second_screen_cases.json", ["oj6", "69", "83", "70"], "61", 16, 300),
    ("d32_denom_family", [HERE / "tensor_denom_before.py", HERE / "tensor_denom_floor.py"],
     family, list(cases), "0,61,2026", 20, 400),
]
records = []
for name, probes, case_file, ids, seeds, attempts, repeat in jobs:
    output = HERE / (name + ".json")
    assert not output.exists(), output
    modules = baseline + probes
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
    command = [sys.executable, str(BENCH), *map(str, modules), "--case-file", str(case_file),
               "--cases", ",".join(ids), "--seeds", seeds, "--attempts", str(attempts),
               "--repeat", str(repeat), "--shared-pool", "--output", str(output)]
    start = time.time()
    with (HERE / (name + ".log")).open("x") as log:
        done = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
    records.append(dict(name=name, command=command, source_sha256=hashes, returncode=done.returncode,
                        seconds=time.time() - start))
    (HERE / "third_screens_runs.json").write_text(json.dumps(records, indent=2) + "\n")
    print(name, done.returncode, round(time.time() - start, 1), flush=True)
