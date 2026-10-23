"""Run the final v12 checks serially, preserving commands, logs and exit codes."""
import argparse
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


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module")
    p.add_argument("--output-dir", required=True)
    p.add_argument("--legacy-result", help="Reuse a completed exact-source check from this session")
    a = p.parse_args()
    module, output = Path(a.module).resolve(), Path(a.output_dir).resolve()
    output.mkdir(exist_ok=False)
    python = sys.executable
    official = ROOT / "experiments/20261013_mfma_fix/submission.py"
    official_control = output / "official_control.py"
    shutil.copy2(official, official_control)
    parent = HERE / "baseline.py"
    cases = HERE / "v12_cases.json"
    oj = ",".join("oj" + str(i) for i in range(1, 15))
    modules = [str(official), str(official_control), str(parent), str(module)]
    pin = '''import os,runpy
os.sched_setaffinity(0, {min(os.sched_getaffinity(0))})
runpy.run_path(%r, run_name="__main__")
''' % str(ROOT / "experiments/20261009_goal8933/bench_public_loop.py")
    steps = [
        ("host_fast_cpu", [python, str(HERE / "verify_host_fast_cpu.py"), str(module), "--output", str(output / "host_fast_cpu.json")]),
        ("host_call", [python, "-u", str(HERE / "verify_host_call.py"), str(module), "--parent", str(parent), "--output", str(output / "host_call.json")]),
        ("reference", [python, "-u", str(ROOT / "verify_nsa.py"), str(module), "--cases", "all", "--extras", "--output", str(output / "reference.json")]),
        ("oj_graph", [python, "-u", str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py"), *modules,
            "--case-file", str(cases), "--cases", oj, "--seeds", "0,61", "--attempts", "16", "--repeat", "240", "--shared-pool", "--output", str(output / "oj_graph.json")]),
        ("oj_public", [python, "-u", "-c", pin, *modules,
            "--case-file", str(cases), "--cases", oj, "--seeds", "0,61", "--attempts", "16", "--repeat", "2400", "--output", str(output / "oj_public.json")]),
        ("actual_binary", [python, str(ROOT / "experiments/20261008_resume8871/audit_actual_binary.py"), str(parent), str(module),
            "--case-file", str(cases), "--cases", oj + ",bs32_b8_t1025_h1_c1,s2_b1_t128_h4_c1,s4_b1_t256_h2_c1,d128_large,d64_large_noncausal,legacy_s2_t37_h2,legacy_s4_t37_h2,legacy_s4_t127_h1",
            "--output-dir", str(output / "actual_binary")]),
    ]
    report = dict(status="running", module=str(module), source_sha256=hashlib.sha256(module.read_bytes()).hexdigest(),
        official_baseline_sha256=hashlib.sha256(official.read_bytes()).hexdigest(),
        parent_sha256=hashlib.sha256(parent.read_bytes()).hexdigest(), steps=[])
    if a.legacy_result:
        evidence = Path(a.legacy_result).resolve()
        legacy = json.loads(evidence.read_text())
        assert legacy["status"] == "PASS" and len(legacy["rows"]) == 32
        assert report["source_sha256"] in legacy["sources"].values()
        assert report["parent_sha256"] in legacy["sources"].values()
        shutil.copy2(evidence, output / "legacy_scale.json")
        report["reused_legacy_check"] = dict(path=str(evidence), sha256=hashlib.sha256(evidence.read_bytes()).hexdigest())
    else:
        steps.insert(2, ("legacy_scale", [python, "-u", str(HERE / "verify_legacy_scale.py"), str(module),
            "--parent", str(parent), "--output", str(output / "legacy_scale.json")]))
    for name, command in steps:
        row = dict(name=name, command=command, started=datetime.datetime.now(datetime.timezone.utc).isoformat())
        report["steps"].append(row)
        (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
        print("START", name, flush=True)
        start = time.monotonic()
        with (output / (name + ".log")).open("x") as log:
            result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        row.update(returncode=result.returncode, elapsed_seconds=time.monotonic()-start,
            finished=datetime.datetime.now(datetime.timezone.utc).isoformat())
        if result.returncode:
            report["status"] = "FAIL"
            (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
            print("FAIL", name, "log", output / (name + ".log"), flush=True)
            raise SystemExit(result.returncode)
        (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
        print("PASS", name, round(row["elapsed_seconds"], 1), flush=True)
    assert hashlib.sha256(module.read_bytes()).hexdigest() == report["source_sha256"]
    report["status"] = "PASS"
    (output / "status.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PASS all final checks", output, flush=True)


if __name__ == "__main__":
    main()
