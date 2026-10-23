"""Validate exact v13 bytes with one serialized GPU queue and retained logs."""
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
V12_SHA = "58bc2fd7a2aeb8ea805be63cc4aefae81487bcc39c3608fb5edc8293380888f9"
TARGET = "native_sparse_attention_q_preload_vfirst"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    module = Path(args.module).resolve()
    output = Path(args.output_dir).resolve()
    output.mkdir(exist_ok=False)
    parent = HERE / "baseline.py"
    assert sha(parent) == V12_SHA
    control = output / "control.py"
    shutil.copy2(parent, control)
    before, after = (ast.parse(p.read_text()) for p in (parent, module))
    functions = [{n.name: ast.dump(n) for n in tree.body if isinstance(n, ast.FunctionDef)}
                 for tree in (before, after)]
    assert functions[0].keys() == functions[1].keys()
    changed = [name for name in functions[0] if functions[0][name] != functions[1][name]]
    assert changed == [TARGET], changed
    assert [ast.dump(n) for n in before.body if not isinstance(n, ast.FunctionDef)] == [
        ast.dump(n) for n in after.body if not isinstance(n, ast.FunctionDef)]
    original = next(n for n in before.body if isinstance(n, ast.FunctionDef) and n.name == TARGET)
    revised = next(n for n in after.body if isinstance(n, ast.FunctionDef) and n.name == TARGET)
    assert ast.dump(original.args) == ast.dump(revised.args)
    assert [ast.dump(n) for n in original.decorator_list] == [ast.dump(n) for n in revised.decorator_list]
    report = dict(
        status="running", module=str(module), candidate_sha256=sha(module),
        parent_sha256=sha(parent), steps=[],
        static=dict(changed_functions=changed, unchanged_functions=len(functions[0])-1,
                    module_statements_equal=True, builder_parameters_and_decorators_equal=True),
    )
    cases = json.loads((HERE / "cases.json").read_text())
    for length in (31, 32, 48, 63, 64, 65, 80, 96, 128):
        for causal in (False, True):
            cases[f"d32_t{length}_c{int(causal)}"] = dict(
                B=1, SEQ_LEN=length, H=1, HQ=16, D=32, S=1,
                block_size=16, is_causal=causal)
    case_file = output / "cases.json"
    case_file.write_text(json.dumps(cases, indent=2) + "\n")
    old = ROOT / "experiments/20261014_resume8933"
    python = sys.executable
    modules = [str(parent), str(control), str(module)]
    oj = ",".join(f"oj{i}" for i in range(1, 15))
    hot = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
    cold = ROOT / "experiments/20261008_goal895/profile_cold.py"
    pin = ("import os,runpy\n"
           "os.sched_setaffinity(0, {min(os.sched_getaffinity(0))})\n"
           f"runpy.run_path({str(ROOT / 'experiments/20261009_goal8933/bench_public_loop.py')!r}, run_name='__main__')\n")
    jobs = [
        ("submission_rules", [python, str(ROOT / "check_submission_nsa.py"), str(module)]),
        ("host_fast_cpu", [python, str(old / "verify_host_fast_cpu.py"), str(module),
                           "--output", str(output / "host_fast_cpu.json")]),
        ("reference", [python, str(ROOT / "verify_nsa.py"), str(module), "--cases", "all",
                       "--extras", "--output", str(output / "reference.json")]),
        ("changed_families", [python, str(HERE / "verify_changed_families.py"), str(module),
                              "--output", str(output / "changed_families.json")]),
        ("host_call", [python, str(old / "verify_host_call.py"), str(module),
                       "--parent", str(parent), "--output", str(output / "host_call.json")]),
        ("oj_graph", [python, str(hot), *modules, "--case-file", str(case_file),
                      "--cases", oj, "--seeds", "0,61", "--attempts", "24",
                      "--repeat", "400", "--shared-pool", "--output", str(output / "oj_graph.json")]),
        ("public_loop", [python, "-c", pin, *modules, "--case-file", str(case_file),
                         "--cases", "oj1,oj2,oj11", "--seeds", "0,61", "--attempts", "16",
                         "--repeat", "2400", "--output", str(output / "public_loop.json")]),
    ]
    for seed in (0, 61):
        name = f"cold_seed{seed}"
        jobs.append((name, [python, str(cold), *modules, "--case-file", str(case_file),
                           "--cases", "oj1,d32_t32_c1,d32_t64_c0", "--seed", str(seed),
                           "--rounds", "8", "--repeat", "96", "--output", str(output / (name + ".json"))]))
    jobs.append(("actual_binary", [python, str(HERE / "audit_binary.py"), str(parent), str(module),
                                   "--case-file", str(case_file), "--cases",
                                   oj + ",d32_t32_c1,d32_t63_c1,d32_t64_c0,d32_t65_c1,d32_t128_c1",
                                   "--output-dir", str(output / "actual_binary")]))
    for name, command in jobs:
        assert sha(module) == report["candidate_sha256"]
        assert sha(parent) == V12_SHA
        step = dict(name=name, command=command,
                    started=datetime.datetime.now(datetime.timezone.utc).isoformat())
        report["steps"].append(step)
        (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
        print("START", name, flush=True)
        start = time.monotonic()
        with (output / (name + ".log")).open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        step.update(returncode=result.returncode, seconds=time.monotonic()-start,
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
