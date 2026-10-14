"""Screen distinct arithmetic/packing mechanisms on the verified v6 serially."""
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
cases = json.loads((ROOT / "experiments/20261008_goal895/oj_cases.json").read_text())
cases.update(json.loads((OLD / "pack_tiling_family_cases.json").read_text()))


def cfg(t, d=64, s=1, b=1, h=1, causal=True):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=d, S=s, block_size=16, is_causal=causal)


cases.update(dict(
    d32_t32=cfg(32, d=32), d32_t128=cfg(128, d=32),
    d32_b2_t32=cfg(32, d=32, b=2), d32_h2_t64=cfg(64, d=32, h=2),
    d32_t64_noncausal=cfg(64, d=32, causal=False),
    d128_t64=cfg(64, d=128),
    s8_grid8192=cfg(1024, s=8, b=8), s8_multi4096=cfg(1024, s=8, b=2, h=2),
))
case_file = HERE / "second_screen_cases.json"
with case_file.open("x") as handle:
    json.dump(cases, handle, indent=2)
baseline = [OLD / "candidate_v6.py", OLD / "candidate_v6_submission.py"]
jobs = [
    ("wave_group_pack_screen", [HERE / f"pack_wave_groups{shape}.py" for shape in ("1x2", "2x1", "2x2")],
     ["oj6", "69", "pack_b1_t512_h2", "pack_b2_t512_h2", "pack_b1_t1024_h4", "83"], "61", 16, 300),
    ("packed_tensor_denom_screen", [HERE / "packed_tensor_denom_before.py", HERE / "packed_tensor_denom_after.py",
                                   HERE / "packed_tensor_denom_floor.py", HERE / "raw_denom_floor.py"],
     ["oj6", "69", "oj12", "s8_grid8192", "s8_multi4096"], "0,61", 16, 300),
    ("small_denom_floor_screen", [HERE / "tensor_denom_before.py", HERE / "tensor_denom_floor.py", HERE / "raw_denom_floor.py"],
     ["oj1", "oj2", "d32_t32", "d32_t128", "d32_b2_t32", "d32_h2_t64", "d32_t64_noncausal", "d128_t64"], "0,61", 16, 300),
]
records = []
for name, probes, ids, seeds, attempts, repeat in jobs:
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
    (HERE / "second_screens_runs.json").write_text(json.dumps(records, indent=2) + "\n")
    print(name, done.returncode, round(time.time() - start, 1), flush=True)
