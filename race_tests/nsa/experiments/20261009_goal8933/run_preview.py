"""Measure host-call time and confirm the assembled preview on cold inputs."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    prefix = [HERE / "parent.py", HERE / "parent_submission.py"]
    preview = HERE / "candidate_v7_preview_submission.py"
    host = HERE / "candidate_host_submission.py"
    cold_cases = "oj1,oj13,oj14,d64_b1_t192_h3_c1,d64_b1_t256_h3_c1,d64_b1_t512_h2_c0,d64_b1_t256_h4_c1,oj5,d128_b1_t1280_h1_c1"
    jobs = {"host_public_loop": dict(harness=HERE / "bench_public_loop.py", modules=prefix + [host, preview],
                options=["--cases", "oj1,oj2,oj3,oj6,oj9,oj10,oj12,oj13,oj14", "--seeds", "0,61",
                         "--attempts", "12", "--repeat", "200", "--case-file", str(HERE / "oj_cases.json")])}
    for seed in (0, 61):
        jobs[f"preview_cold_seed{seed}"] = dict(harness=ROOT / "experiments/20261008_goal895/profile_cold.py",
            modules=prefix + [preview], options=["--cases", cold_cases, "--seed", str(seed),
            "--repeat", "48", "--rounds", "6", "--case-file", str(HERE / "followup_cases.json")])
    path = HERE / "preview_runs.json"
    history = json.loads(path.read_text()) if path.exists() else []
    for name in sys.argv[1:] or list(jobs):
        spec = jobs[name]
        output, log_path = HERE / f"{name}.json", HERE / f"{name}.log"
        assert not output.exists() and not log_path.exists(), name
        command = [sys.executable, str(spec["harness"]), *map(str, spec["modules"]),
                   *spec["options"], "--output", str(output)]
        hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in spec["modules"]}
        record = dict(name=name, command=command, source_sha256=hashes, status="running",
                      started_utc=datetime.now(timezone.utc).isoformat())
        history.append(record)
        path.write_text(json.dumps(history, indent=2)+"\n")
        start = time.time()
        print("START", name, flush=True)
        with log_path.open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        assert hashes == {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in spec["modules"]}
        record.update(returncode=result.returncode, seconds=time.time()-start,
                      status="PASS" if result.returncode == 0 else "FAIL")
        path.write_text(json.dumps(history, indent=2)+"\n")
        print(record["status"], name, round(record["seconds"], 1), flush=True)


if __name__ == "__main__":
    main()
