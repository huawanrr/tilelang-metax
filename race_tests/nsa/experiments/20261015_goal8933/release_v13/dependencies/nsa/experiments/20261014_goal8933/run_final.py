"""Validate and time the exact selected submission bytes, using one GPU queue."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module")
    p.add_argument("--output-dir", required=True)
    args = p.parse_args()
    module = Path(args.module).resolve()
    output = Path(args.output_dir).resolve()
    output.mkdir(exist_ok=False)
    cases = json.loads((HERE / "followup_cases.json").read_text())
    for family in ("bs32", "short"):
        cases.update(json.loads((HERE / f"{family}_cold_family_cases.json").read_text()))
    cases.update(json.loads((HERE / "current_grid_family_cases.json").read_text()))
    for name,b,t,h,s,bs,d,c in (
        ("bs32_b8_t512_h1_c1",8,512,1,1,32,128,True),
        ("s2_b4_t128_h1_c1",4,128,1,2,16,64,True),
        ("s4_b4_t512_h1_c1",4,512,1,4,16,64,True),
        ("s4_b1_t384_h1_c1",1,384,1,4,16,64,True),
        ("s4_b2_t768_h1_c1",2,768,1,4,16,64,True),
        ("mid_b1_t384_h2",1,384,2,1,16,64,True),
        ("mid_b3_t128_h2",3,128,2,1,16,64,True),
    ):
        cases[name] = dict(B=b,SEQ_LEN=t,H=h,HQ=16*h,S=s,block_size=bs,D=d,is_causal=c)
    case_file = output / "cases.json"
    case_file.write_text(json.dumps(cases, indent=2) + "\n")
    base = str(HERE / "baseline.py")
    control = str(HERE / "control.py")
    selected = str(module)
    oj = ",".join(f"oj{i}" for i in range(1,15))
    hot = str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py")
    cold = str(ROOT / "experiments/20261008_goal895/profile_cold.py")
    jobs = [
        ("static", [str(ROOT / "check_submission_nsa.py"), selected]),
        ("dispatch", [str(HERE / "verify_dispatch_cpu.py"), selected, "--output", str(output / "dispatch.json")]),
        ("reference", [str(ROOT / "experiments/20261002_mid_blocks/verify_reference.py"), selected,
            "--cases", "all", "--extras", "--output", str(output / "reference.json")]),
        ("changed_families", [str(HERE / "verify_changed_families.py"), selected,
            "--output", str(output / "changed_families.json")]),
        ("oj", [hot, base, control, selected, "--case-file", str(case_file), "--cases", oj,
            "--seeds", "0,61", "--attempts", "24", "--repeat", "400", "--shared-pool", "--output", str(output / "oj.json")]),
        ("full", [hot, base, control, selected, "--cases", "all", "--seeds", "0", "--attempts", "12",
            "--repeat", "300", "--shared-pool", "--output", str(output / "full.json")]),
    ]
    cold_cases = "oj1,oj6,oj10,oj11,oj13,bs32_b8_t512_h1_c1,bs32_b4_t1280_h1_c1,bs32_b8_t1025_h1_c1,s2_b4_t128_h1_c1,s4_b4_t512_h1_c1,s4_b1_t384_h1_c1,s4_b2_t768_h1_c1,mid_b1_t384_h2,mid_b3_t128_h2"
    for seed in (0,61):
        name = f"cold_seed{seed}"
        jobs.append((name, [cold, base, control, selected, "--case-file", str(case_file), "--cases", cold_cases,
            "--seed", str(seed), "--repeat", "48", "--rounds", "6", "--output", str(output / (name + ".json"))]))
    jobs.append(("binary", [str(ROOT / "experiments/20261008_resume8871/audit_actual_binary.py"), base, selected,
        "--case-file", str(case_file), "--cases", oj + ",small_d32_t128_c1,bs32_h2_c1,s2_b1_t256_h2_c1,s4_b1_t1536_h1_c1,s4_b2_t512_h1_c0",
        "--output-dir", str(output / "binary")]))
    report = dict(module=selected, module_sha256=hashlib.sha256(module.read_bytes()).hexdigest(),
        baseline_sha256=hashlib.sha256(Path(base).read_bytes()).hexdigest(), jobs=[], status="running")
    for name, arguments in jobs:
        assert hashlib.sha256(module.read_bytes()).hexdigest() == report["module_sha256"]
        print("START", name, flush=True)
        start = time.time()
        with (output / (name + ".log")).open("x") as log:
            result = subprocess.run([sys.executable, "-u", *arguments], cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        report["jobs"].append(dict(name=name, command=arguments, exit_code=result.returncode, seconds=time.time()-start))
        report["status"] = "running" if result.returncode == 0 else "FAILED"
        (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
        print("DONE", name, result.returncode, flush=True)
        if result.returncode != 0:
            sys.exit(result.returncode)
    report["status"] = "PASS"
    (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
