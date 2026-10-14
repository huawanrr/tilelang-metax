"""Run the remaining independent probes sequentially on the GPU."""
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
CASES = HERE / "combined_cases.json"


def main():
    cases = json.loads((HERE / "oj_cases.json").read_text())
    cases.update(json.loads((HERE / "fp32_family_cases.json").read_text()))
    for d, b, n, h, causal in ((32, 1, 64, 1, False), (32, 2, 32, 1, True),
            (64, 1, 64, 1, True), (64, 2, 64, 1, True), (64, 1, 128, 1, False),
            (64, 1, 64, 2, True), (128, 1, 64, 1, True),
            (128, 2, 64, 1, True), (128, 1, 128, 1, False)):
        cases[f"d{d}_b{b}_t{n}_h{h}_c{int(causal)}"] = dict(B=b, SEQ_LEN=n,
            H=h, HQ=h*16, D=d, S=1, block_size=16, is_causal=causal)
    encoded = json.dumps(cases, indent=2) + "\n"
    if CASES.exists():
        assert CASES.read_text() == encoded
    else:
        CASES.write_text(encoded)
    jobs = {
        "fp32_sum_numeric": dict(command=[sys.executable, str(HERE / "verify_fp32_sum.py")],
                                  sources=[HERE / "verify_fp32_sum.py"]),
        "small_load_order_screen": dict(modules=["small_vfirst.py", "small_kv_fence.py", "small_vfirst_fence.py"],
            cases="oj1,oj2,d32_b1_t64_h1_c0,d32_b2_t32_h1_c1,d64_b1_t64_h1_c1,d64_b2_t64_h1_c1,d64_b1_t128_h1_c0,d64_b1_t64_h2_c1,d128_b1_t64_h1_c1,d128_b2_t64_h1_c1,d128_b1_t128_h1_c0"),
        "fp32_mask_screen": dict(modules=["fp32_core.py", "fp32_mask_post.py", "fp32_mask_split.py"],
            cases="oj3,oj4,oj13,oj14,d128_b1_t160_h1_c1,d128_b1_t384_h1_c1,d128_b4_t96_h1_c1,d128_b1_t256_h1_c0,d64_b1_t512_h1_c1,d64_b1_t768_h1_c1,d64_b1_t128_h4_c1,d64_b4_t512_h1_c1,d64_b1_t256_h2_c0,d64_b2_t512_h2_c0"),
        "balanced_sum_screen": dict(modules=["balanced_sum.py", "fp32_balanced_sum.py"],
            cases="oj1,oj2,oj3,oj4,oj9,oj10,oj13,oj14"),
    }
    names = sys.argv[1:] or list(jobs)
    path = HERE / "next_study_runs.json"
    history = json.loads(path.read_text()) if path.exists() else []
    for name in names:
        spec = jobs[name]
        output, log_path = HERE / f"{name}.json", HERE / f"{name}.log"
        assert not output.exists() and not log_path.exists(), name
        if "modules" in spec:
            sources = [HERE / "parent.py", HERE / "parent_submission.py"] + [HERE / m for m in spec["modules"]]
            command = [sys.executable, str(BENCH), *map(str, sources),
                       "--case-file", str(CASES), "--cases", spec["cases"],
                       "--seeds", "0,61", "--attempts", "16", "--repeat", "300",
                       "--shared-pool", "--output", str(output)]
        else:
            command, sources = spec["command"], spec["sources"]
        hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in sources}
        record = dict(name=name, command=command, source_sha256=hashes, status="running",
                      started_utc=datetime.now(timezone.utc).isoformat())
        history.append(record)
        path.write_text(json.dumps(history, indent=2) + "\n")
        start = time.time()
        print("START", name, flush=True)
        with log_path.open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in sources}
        record.update(returncode=result.returncode, seconds=time.time()-start,
                      status="PASS" if result.returncode == 0 else "FAIL")
        path.write_text(json.dumps(history, indent=2) + "\n")
        print(record["status"], name, round(record["seconds"], 1), flush=True)


if __name__ == "__main__":
    main()
