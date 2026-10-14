"""Confirm candidate mechanisms with their shape families and cold inputs."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def prepare_cases():
    cases = json.loads((HERE / "combined_cases.json").read_text())
    d32 = json.loads((HERE.parent / "20261009_resume8871/d32_denom_family_cases.json").read_text())
    controls = {(1, 64, 1), (1, 128, 1), (1, 32, 2), (2, 32, 1), (1, 48, 3), (4, 16, 1)}
    d32 = {k: c for k, c in d32.items() if c["is_causal"] or
           (c["B"], c["SEQ_LEN"], c["H"]) in controls}
    cases.update(d32)
    multih = {k: c for k, c in cases.items() if k.startswith("d64_") and c["D"] == 64
              and c["S"] == 1 and c["H"] >= 2 and c["SEQ_LEN"] >= 128
              and 512 <= c["B"] * c["H"] * c["SEQ_LEN"] < 2304}
    for b, n, h in ((1, 192, 3), (1, 256, 3), (1, 512, 3), (2, 192, 3), (3, 128, 3)):
        for causal in (True, False):
            name = f"d64_b{b}_t{n}_h{h}_c{int(causal)}"
            multih[name] = dict(B=b, SEQ_LEN=n, H=h, HQ=h*16, D=64, S=1,
                               block_size=16, is_causal=causal)
    cases.update(multih)
    path = HERE / "followup_cases.json"
    encoded = json.dumps(cases, indent=2) + "\n"
    if path.exists():
        assert path.read_text() == encoded
    else:
        path.write_text(encoded)
    return path, d32, multih


def main():
    case_file, d32, multih = prepare_cases()
    cold_cases = "oj3,oj4,oj13,oj14,d128_b4_t96_h1_c1,d64_b1_t512_h1_c1,d64_b1_t128_h4_c1,oj9,d64_b4_t1024_h1_c0,d128_b1_t1280_h1_c1,d128_b1_t2048_h1_c0,d128_b1_t512_h4_c1,d128_b1_t512_h4_c0"
    jobs = {
        "balanced_sum_v2_screen": dict(modules=["balanced_sum_v2.py", "fp32_balanced_sum_v2.py"],
            cases="oj1,oj2,oj3,oj4,oj9,oj10,oj13,oj14"),
        "d32_vfirst_family": dict(modules=["small_vfirst.py"], cases=",".join(d32)),
        "fp32_mask_multih_family": dict(modules=["fp32_core.py", "fp32_mask_post.py"], cases=",".join(multih)),
        "fp32_cold_seed0": dict(modules=["fp32_core.py", "fp32_mask_post.py"], cases=cold_cases, seed=0),
        "fp32_cold_seed61": dict(modules=["fp32_core.py", "fp32_mask_post.py"], cases=cold_cases, seed=61),
    }
    history_path = HERE / "followup_study_runs.json"
    history = json.loads(history_path.read_text()) if history_path.exists() else []
    for name in sys.argv[1:] or list(jobs):
        spec = jobs[name]
        output, log_path = HERE / f"{name}.json", HERE / f"{name}.log"
        assert not output.exists() and not log_path.exists(), name
        modules = [HERE / "parent.py", HERE / "parent_submission.py"] + [HERE / m for m in spec["modules"]]
        cold = "seed" in spec
        harness = ROOT / ("experiments/20261008_goal895/profile_cold.py" if cold else
                          "experiments/20261005_goal8929/bracketed_audited.py")
        command = [sys.executable, str(harness), *map(str, modules),
                   "--case-file", str(case_file), "--cases", spec["cases"]]
        command += (["--seed", str(spec["seed"]), "--repeat", "48", "--rounds", "6"] if cold else
                    ["--seeds", "0,61", "--attempts", "16", "--repeat", "300", "--shared-pool"])
        command += ["--output", str(output)]
        hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
        record = dict(name=name, command=command, source_sha256=hashes, status="running",
                      started_utc=datetime.now(timezone.utc).isoformat())
        history.append(record)
        history_path.write_text(json.dumps(history, indent=2) + "\n")
        print("START", name, flush=True)
        start = time.time()
        with log_path.open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in modules}
        record.update(returncode=result.returncode, seconds=time.time()-start,
                      status="PASS" if result.returncode == 0 else "FAIL")
        history_path.write_text(json.dumps(history, indent=2) + "\n")
        print(record["status"], name, round(record["seconds"], 1), flush=True)


if __name__ == "__main__":
    main()
