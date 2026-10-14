"""Run independent follow-up studies in one serial GPU queue."""
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = [str(HERE / "baseline.py"), str(HERE / "control.py")]
CASES = HERE / "followup_cases.json"
HOT = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
COLD = ROOT / "experiments/20261008_goal895/profile_cold.py"


def main():
    cases = json.loads((HERE / "cases.json").read_text())
    for name, b, length, h, s, bs, d, causal in (
        ("bs32_h2_c1", 1, 512, 2, 1, 32, 128, True),
        ("bs32_h2_c0", 1, 512, 2, 1, 32, 128, False),
        ("s8_b8_t1024", 8, 1024, 1, 8, 16, 64, True),
        ("s8_b4_t2048", 4, 2048, 1, 8, 16, 64, True),
    ):
        cases[name] = dict(B=b, SEQ_LEN=length, H=h, HQ=16*h, S=s, block_size=bs, D=d, is_causal=causal)
    with CASES.open("x") as out:
        json.dump(cases, out, indent=2)
        out.write("\n")
    jobs = []
    audit = ROOT / "experiments/20261008_resume8871/audit_actual_binary.py"
    modules = BASE + [str(HERE / n) for n in ("memory_latency400.py", "memory_no_vectorizer.py", "small_nr2.py")]
    modules.append(str(HERE.parent / "20261013_goal8933/reciprocal_v2_newton2.py"))
    jobs.append(("timing_signal_binary", [str(audit), *modules, "--case-file", str(CASES),
        "--cases", "oj1,oj10,oj11", "--output-dir", str(HERE / "timing_signal_binary")]))
    for name, modules, selected in (
        ("s4_prefetch_screen", ["s4_prefetch_before_exp.py", "s4_prefetch_before_qk.py"], "77,oj11,79"),
        ("s8_sum_screen", ["s8_sum_e0_n0.py", "s8_sum_e1_n0.py", "s8_sum_e1_n1.py"], "oj12,s8_b8_t1024,s8_b4_t2048"),
    ):
        jobs.append((name, [str(HOT), *BASE, *(str(HERE / n) for n in modules), "--case-file", str(CASES),
            "--cases", selected, "--seeds", "0,61", "--attempts", "16", "--repeat", "350", "--shared-pool",
            "--output", str(HERE / (name + ".json"))]))
    jobs.append(("newton_gpu_math", [str(HERE / "verify_newton_math.py")]))
    for prefix, modules, selected in (
        ("bs32_focus_cold", [str(HERE / "bs32_j1_g1_m0.py")], "oj6,69,68,83,bs32_h2_c1,bs32_h2_c0"),
        ("short_sum_cold", [str(HERE / "short_sum_r2_m1_n1.py")], "oj10,oj11,79"),
        ("tiny_newton_cold", [str(HERE / "small_nr2.py"), str(HERE.parent / "20261013_goal8933/reciprocal_v2_newton2.py")],
         "oj1,small_d32_t128_c1"),
    ):
        for seed in (0, 61):
            name = f"{prefix}_seed{seed}"
            jobs.append((name, [str(COLD), *BASE, *modules, "--case-file", str(CASES), "--cases", selected,
                "--seed", str(seed), "--repeat", "48", "--rounds", "6", "--output", str(HERE / (name + ".json"))]))
    status = []
    for name, args in jobs:
        print("START", name, flush=True)
        start = time.time()
        with (HERE / (name + ".log")).open("x") as log:
            result = subprocess.run([sys.executable, "-u", *args], cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        status.append(dict(name=name, command=args, exit_code=result.returncode, seconds=time.time() - start))
        (HERE / "followup_status.json").write_text(json.dumps(status, indent=2) + "\n")
        print("DONE", name, result.returncode, flush=True)


if __name__ == "__main__":
    main()
