"""Compile probes independently and check FP32 correctness before timing.

A rejected compiler layout is recorded without losing other probes' results.
GPU execution errors still stop the process. This script reports no timings.
"""
import argparse
import hashlib
import inspect
import json
from pathlib import Path
import sys
import traceback

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module


def parts(kernel):
    if inspect.isfunction(kernel):
        values = inspect.getclosurevars(kernel).nonlocals
        if "pack" in values and "attention" in values:
            return [values["pack"], values["attention"]]
    return [kernel]


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("modules", nargs="+")
    p.add_argument("--cases", default="oj12")
    p.add_argument("--case-file")
    p.add_argument("--output", required=True)
    a = p.parse_args()
    named = {
        "oj6": dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
        "oj9": dict(B=1, SEQ_LEN=8192, H=1, HQ=16, D=64, S=1, block_size=16, is_causal=True),
        "oj12": dict(B=4, SEQ_LEN=1024, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
    }
    if a.case_file:
        named.update(json.loads(Path(a.case_file).read_text()))
    supplied = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    torch.backends.cuda.matmul.allow_tf32 = False
    modules = [load_module(path) for path in a.modules]
    report = dict(command=sys.argv, sha256={path: hashlib.sha256(Path(path).read_bytes()).hexdigest()
        for path in a.modules}, rows=[], method="Compilation then independent FP32 reference; no timings")
    for case_id in a.cases.split(","):
        cfg = named[case_id] if case_id in named else supplied[int(case_id) - 1]
        inputs = make_inputs(cfg, 0)
        expected = sparse_reference(*inputs, cfg["block_size"], cfg["is_causal"], 0.1)
        output = torch.empty_like(inputs[0])
        shape = (cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"], cfg["S"],
                 cfg["block_size"], cfg["is_causal"], 0.1)
        for path, mod in zip(a.modules, modules):
            row = dict(module=path, case=case_id, config=cfg, passed=False)
            report["rows"].append(row)
            try:
                kernel = mod._get_kernel(*shape)
            except Exception:
                row.update(failure_stage="compile", traceback=traceback.format_exc())
            else:
                compiled = parts(kernel)
                row.update(device_source_sha256=[hashlib.sha256(k.get_kernel_source().encode()).hexdigest()
                           for k in compiled], compile_flags=[list(k.compile_flags or []) for k in compiled])
                output.fill_(float("nan"))
                try:
                    mod.run_kernel(*inputs, output, *shape)
                    torch.cuda.synchronize()
                except Exception:
                    row.update(failure_stage="execute", traceback=traceback.format_exc())
                    Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
                    raise
                try:
                    row["max_abs_error"] = check_output(output, expected, case_id)
                except AssertionError:
                    row.update(failure_stage="reference", traceback=traceback.format_exc())
                else:
                    row["passed"] = True
            Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
            print(case_id, path, "PASS" if row["passed"] else row["failure_stage"] + " FAILED", flush=True)


if __name__ == "__main__":
    main()
