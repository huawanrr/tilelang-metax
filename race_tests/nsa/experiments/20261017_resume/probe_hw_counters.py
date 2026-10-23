"""Try the SDK's documented scoped profiler on unchanged public calls.

This is a diagnostic only. It does not alter submission code, compilation,
launch mode, cache invalidation, or safety settings. Profiler timings are not
used as benchmark results.
"""
import argparse
import ctypes
import hashlib
import json
import os
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--case", default="oj6")
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    output = Path(args.output_dir).resolve()
    output.mkdir(exist_ok=False)
    config = json.loads(Path("/opt/maca/samples/0_Introduction/profilerScope/mcProfiler.json").read_text())
    config["conditions"].update(counts=6, profile_from_start=False, is_perkernel=True)
    config_path = output / "mcProfiler.json"
    config_path.write_text(json.dumps(config, indent=2) + "\n")
    os.environ["MCTX_TARGET_PROFILE_PATH"] = str(output)

    import torch
    sys.path.insert(0, str(ROOT))
    from benchmark_nsa import make_inputs, sparse_reference, check_output
    from experiment_bench import load_module

    torch.backends.cuda.matmul.allow_tf32 = False
    module_path = HERE / "baseline.py"
    mod = load_module(str(module_path))
    cfg = json.loads((HERE / "cases.json").read_text())[args.case]
    inputs = make_inputs(cfg, 0)
    expected = sparse_reference(*inputs, cfg["block_size"], cfg["is_causal"], 0.1)
    result = torch.empty_like(inputs[0])
    call_args = (*inputs, result, cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"],
                 cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
    mod.run_kernel(*call_args)
    torch.cuda.synchronize()
    error = check_output(result, expected, args.case)
    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")

    class ConfigFile(ctypes.Structure):
        _fields_ = [("fp", ctypes.c_char_p)]

    runtime.mcProfilerConfigFile.argtypes = [ConfigFile]
    runtime.mcProfilerConfigFile.restype = ctypes.c_int
    runtime.mcProfilerStart.argtypes = []
    runtime.mcProfilerStart.restype = ctypes.c_int
    runtime.mcProfilerStop.argtypes = []
    runtime.mcProfilerStop.restype = ctypes.c_int
    report = dict(case=args.case, config=cfg, max_abs_error=error,
                  source_sha256=hashlib.sha256(module_path.read_bytes()).hexdigest(),
                  benchmark=False, calls=[])

    def record(name, code):
        report["calls"].append(dict(api=name, return_code=code))
        (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")
        print(name, code, flush=True)
        return code

    if record("mcProfilerConfigFile", runtime.mcProfilerConfigFile(ConfigFile(str(config_path).encode()))) != 0:
        return
    if record("mcProfilerStart", runtime.mcProfilerStart()) != 0:
        return
    try:
        for _ in range(3):
            mod.run_kernel(*call_args)
            torch.cuda.synchronize()
    finally:
        record("mcProfilerStop", runtime.mcProfilerStop())
    report["post_profile_max_abs_error"] = check_output(result, expected, args.case)
    report["files"] = [p.name for p in output.iterdir() if p.is_file()]
    (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
