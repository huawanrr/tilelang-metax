"""Serial cold-cache confirmations and a direct-output screen.

All jobs use the public interface and independent FP32 references. Reports
are never overwritten. Run only after the V-lifetime family job finishes.
"""
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def run(name, script, modules, options):
    report = HERE / f"{name}.json"
    log = HERE / f"{name}.log"
    assert not report.exists() and not log.exists(), name
    command = [sys.executable, str(ROOT / script)]
    command += [str(HERE / module) for module in modules]
    command += ["--case-file", str(HERE / "cases.json"), *options,
                "--output", str(report)]
    print("START", name, flush=True)
    with log.open("x") as stream:
        result = subprocess.run(command, cwd=ROOT, stdout=stream,
                                stderr=subprocess.STDOUT)
    records.append(dict(name=name, command=command, returncode=result.returncode))
    manifest.write_text(json.dumps(records, indent=2) + "\n")
    print("DONE", name, result.returncode, flush=True)
    if result.returncode:
        raise SystemExit(result.returncode)


if __name__ == "__main__":
    family = json.loads((HERE / "v_lifetime_family.json").read_text())
    assert len(family["rows"]) == 108, "Wait for the existing family job"
    manifest = HERE / "confirm_round1_runs.json"
    assert not manifest.exists()
    records = []
    cold = "experiments/20261008_goal895/profile_cold.py"
    baseline = ["baseline.py", "control.py"]
    for seed in (0, 61):
        run(f"newton_cold_seed{seed}", cold,
            baseline + ["reciprocal_v2_newton2.py", "small_newton2_early.py",
                        "reciprocal_v2_newton3.py"],
            ["--cases", "oj1", "--seed", str(seed), "--repeat", "48",
             "--rounds", "6"])
    for seed in (0, 61):
        run(f"v_lifetime_cold_seed{seed}", cold,
            baseline + ["v_lifetime_after_q.py", "v_lifetime_after_kstore.py"],
            ["--cases", "oj4,oj5,oj7,oj9,oj13,oj14,d64_mid_noncausal,"
             "d64_b1_t512_h1_c1,d64_b2_t768_h1_c1,d64_b2_t1024_h1_c1",
             "--seed", str(seed), "--repeat", "48", "--rounds", "6"])
    run("output_direct_screen", "experiments/20261005_goal8929/bracketed_audited.py",
        baseline + ["output_direct4.py"],
        ["--cases", "oj4,oj5,oj6,oj12,d128_large,oj13,oj9",
         "--seeds", "0,61", "--attempts", "18", "--repeat", "350", "--shared-pool"])
