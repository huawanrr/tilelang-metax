"""Check neighboring shapes before selecting any optimized dispatch range."""
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    jobs = [("newton_gpu_math_r2", [str(HERE / "verify_newton_math.py")])]
    for family, candidate in (("bs32", "bs32_j1_g1_m0.py"), ("short", "short_sum_r2_m1_n1.py")):
        case_file = HERE / f"{family}_cold_family_cases.json"
        cases = ",".join(json.loads(case_file.read_text()))
        for seed in (0, 61):
            name = f"{family}_cold_family_seed{seed}"
            jobs.append((name, [str(ROOT / "experiments/20261008_goal895/profile_cold.py"),
                str(HERE / "baseline.py"), str(HERE / "control.py"), str(HERE / candidate),
                "--case-file", str(case_file), "--cases", cases, "--seed", str(seed),
                "--repeat", "48", "--rounds", "6", "--output", str(HERE / (name + ".json"))]))
    report = []
    for name, args in jobs:
        print("START", name, flush=True)
        start = time.time()
        with (HERE / (name + ".log")).open("x") as log:
            result = subprocess.run([sys.executable, "-u", *args], cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        report.append(dict(name=name, command=args, exit_code=result.returncode, seconds=time.time()-start))
        (HERE / "family_cold_status.json").write_text(json.dumps(report, indent=2) + "\n")
        print("DONE", name, result.returncode, flush=True)


if __name__ == "__main__":
    main()
