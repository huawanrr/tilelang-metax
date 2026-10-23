"""Validate exact dispatch-candidate bytes in one serialized GPU queue."""
import argparse
import ast
import datetime
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE_SHA = "49c5e4b40ba926ef0d9d687760a520306ccde4bc82b077907a5b3568b918b2ea"
FAMILY = [
    "d128_b1_h1_t128_c1", "d128_b1_h1_t144_c1", "d128_b1_h1_t1264_c1",
    "d128_b1_h1_t1280_c1", "d128_b2_h3_t64_c1", "d128_b16_h1_t16_c1",
    "d64_b1_h1_t240_c1", "d64_b1_h1_t256_c1", "d64_b1_h1_t272_c1",
    "d64_b1_h1_t384_c1", "d64_b1_h1_t496_c1", "d64_b1_h1_t511_c1",
    "d64_b1_h1_t512_c1", "d64_b1_h1_t513_c1", "d64_b16_h1_t16_c1",
    "d64_b1_h3_t96_c1", "d64_b1_h4_t64_c1", "d64_b1_h1_t256_c0",
]
COLD = ["oj3", "d64_b1_h1_t256_c1", "d128_b1_h1_t1264_c1",
        "d64_b1_h1_t496_c1", "d128_b16_h1_t16_c1", "d64_b16_h1_t16_c1"]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--output-dir", required=True)
    parser.add_argument("--cpu-report", required=True)
    args = parser.parse_args()
    module, parent = Path(args.module).resolve(), HERE / "baseline.py"
    output = Path(args.output_dir).resolve()
    assert sha(parent) == BASE_SHA
    trees = [ast.parse(path.read_text()) for path in (parent, module)]
    functions = [{n.name: ast.dump(n) for n in tree.body if isinstance(n, ast.FunctionDef)}
                 for tree in trees]
    assert functions[0].keys() == functions[1].keys()
    changed = [name for name in functions[0] if functions[0][name] != functions[1][name]]
    assert changed == ["_get_kernel"], changed
    assert [ast.dump(n) for n in trees[0].body if not isinstance(n, ast.FunctionDef)] == [
        ast.dump(n) for n in trees[1].body if not isinstance(n, ast.FunctionDef)]
    cpu_path = Path(args.cpu_report).resolve()
    cpu = json.loads(cpu_path.read_text())
    assert cpu["status"] == "PASS" and cpu["sources"][str(module)] == sha(module)
    assert cpu["sources"][str(parent.resolve())] == BASE_SHA
    cases = json.loads((HERE / "validation_cases.json").read_text())
    assert set(FAMILY + COLD) <= cases.keys()
    output.mkdir(exist_ok=False)
    control = output / "control.py"
    shutil.copy2(parent, control)
    shutil.copy2(cpu_path, output / "dispatch_cpu.json")
    case_file = output / "cases.json"
    shutil.copy2(HERE / "validation_cases.json", case_file)
    report = dict(status="running", module=str(module), candidate_sha256=sha(module),
                  parent_sha256=BASE_SHA, steps=[],
                  prevalidated=dict(cpu_report=str(cpu_path), sha256=sha(cpu_path)),
                  static=dict(changed_functions=changed,
                              unchanged_functions=len(functions[0])-1,
                              module_statements_equal=True, all_device_builders_equal=True))
    python = sys.executable
    hot = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
    cold = ROOT / "experiments/20261008_goal895/profile_cold.py"
    old_host = ROOT / "experiments/20261014_resume8933/verify_host_call.py"
    audit = ROOT / "experiments/20261015_goal8933/audit_binary.py"
    modules = [str(parent), str(control), str(module)]
    oj = ",".join(f"oj{i}" for i in range(1, 15))
    jobs = [
        ("submission_rules", [python, str(ROOT / "check_submission_nsa.py"), str(module)]),
        ("reference", [python, str(ROOT / "verify_nsa.py"), str(module), "--cases", "all",
                       "--extras", "--output", str(output / "reference.json")]),
        ("changed_families", [python, str(HERE / "verify_dispatch_gpu.py"), str(module),
                              "--output", str(output / "changed_families.json")]),
        ("host_call", [python, str(old_host), str(module), "--parent", str(parent),
                       "--output", str(output / "host_call.json")]),
        ("oj_graph", [python, str(hot), *modules, "--case-file", str(case_file),
                      "--cases", oj, "--seeds", "0,61", "--attempts", "24",
                      "--repeat", "400", "--shared-pool", "--output", str(output / "oj_graph.json")]),
        ("family_graph", [python, str(hot), *modules, "--case-file", str(case_file),
                          "--cases", ",".join(FAMILY), "--seeds", "0,61", "--attempts", "24",
                          "--repeat", "240", "--shared-pool", "--output", str(output / "family_graph.json")]),
    ]
    for seed in (0, 61):
        name = f"cold_seed{seed}"
        jobs.append((name, [python, str(cold), *modules, "--case-file", str(case_file),
                           "--cases", ",".join(COLD), "--seed", str(seed),
                           "--rounds", "6", "--repeat", "64", "--output", str(output / (name + ".json"))]))
    jobs.append(("actual_binary", [python, str(audit), str(parent), str(module),
                                   "--case-file", str(case_file), "--cases", oj + "," + ",".join(FAMILY),
                                   "--output-dir", str(output / "actual_binary")]))
    for name, command in jobs:
        assert sha(module) == report["candidate_sha256"] and sha(parent) == BASE_SHA
        step = dict(name=name, command=command,
                    started=datetime.datetime.now(datetime.timezone.utc).isoformat())
        report["steps"].append(step)
        (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
        print("START", name, flush=True)
        started = time.monotonic()
        with (output / (name + ".log")).open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        step.update(returncode=result.returncode, seconds=time.monotonic()-started,
                    finished=datetime.datetime.now(datetime.timezone.utc).isoformat())
        if result.returncode:
            report["status"] = "FAIL"
            (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
            print("FAIL", name, "log:", output / (name + ".log"), flush=True)
            raise SystemExit(result.returncode)
        (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
        print("PASS", name, round(step["seconds"], 1), flush=True)
    assert sha(module) == report["candidate_sha256"]
    report["status"] = "PASS"
    (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PASS all final checks", output, flush=True)


if __name__ == "__main__":
    main()
