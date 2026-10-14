"""Record per-device-kernel times with a fresh L2 flush before every public call."""
import argparse
import hashlib
import inspect
import json
from pathlib import Path
import statistics
import sys

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module


def number_of_parts(kernel):
    if inspect.isfunction(kernel):
        values = inspect.getclosurevars(kernel).nonlocals
        if "pack" in values and "attention" in values:
            return 2
    return 1


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("modules", nargs="+")
    p.add_argument("--cases", default="oj6,oj9,oj12")
    p.add_argument("--seed", type=int, default=0)
    p.add_argument("--repeat", type=int, default=32)
    p.add_argument("--rounds", type=int, default=4)
    p.add_argument("--flush-bytes", type=int, default=256000000)
    p.add_argument("--output", required=True)
    a = p.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    supplied = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    named = {
        "oj6": dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
        "oj9": dict(B=1, SEQ_LEN=8192, H=1, HQ=16, D=64, S=1, block_size=16, is_causal=True),
        "oj12": dict(B=4, SEQ_LEN=1024, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
    }
    modules = [load_module(path) for path in a.modules]
    cache = torch.empty((a.flush_bytes + 3) // 4, device="cuda", dtype=torch.int32)
    report = dict(command=sys.argv, flush_bytes=cache.numel() * 4,
        method="Torch device profiler; direct public calls; per-invocation L2 flush; sum of all NSA kernel durations",
        sha256={path: hashlib.sha256(Path(path).read_bytes()).hexdigest() for path in a.modules}, rows=[])
    for case_id in a.cases.split(","):
        cfg = named[case_id] if case_id in named else supplied[int(case_id) - 1]
        inputs = make_inputs(cfg, a.seed)
        expected = sparse_reference(*inputs, cfg["block_size"], cfg["is_causal"], 0.1)
        output = torch.empty_like(inputs[0])
        args = (*inputs, output, cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"],
                cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
        counts, errors = [], []
        for mod in modules:
            output.fill_(float("nan"))
            mod.run_kernel(*args)
            errors.append(check_output(output, expected, case_id))
            kernel = mod._get_kernel(cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"],
                cfg["D"], cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
            counts.append(number_of_parts(kernel))
        records = [[] for _ in modules]
        for trial in range(a.rounds):
            order = range(len(modules)) if trial % 2 == 0 else reversed(range(len(modules)))
            for index in order:
                mod = modules[index]
                for _ in range(4):
                    if a.flush_bytes:
                        cache.zero_()
                    mod.run_kernel(*args)
                torch.cuda.synchronize()
                with torch.profiler.profile(activities=[torch.profiler.ProfilerActivity.CUDA]) as prof:
                    for _ in range(a.repeat):
                        if a.flush_bytes:
                            cache.zero_()
                        mod.run_kernel(*args)
                    torch.cuda.synchronize()
                all_events = [dict(name=e.name, device_type=str(e.device_type),
                                   device_time_us=e.device_time_total, self_device_time_us=e.self_device_time_total)
                              for e in prof.events()]
                kernels = [e for e in all_events if "kernel_kernel" in e["name"]
                           and "CUDA" in e["device_type"]]
                record = dict(trial=trial, kernel_events=kernels, all_events=all_events,
                              expected_kernels=a.repeat * counts[index])
                records[index].append(record)
                if len(kernels) != a.repeat * counts[index]:
                    report["rows"].append(dict(case=case_id, config=cfg, records=records,
                                               failure="Unexpected device kernel count"))
                    Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
                    raise AssertionError((case_id, index, len(kernels), record["expected_kernels"]))
                record["total_kernel_us_per_call"] = sum(e["device_time_us"] for e in kernels) / a.repeat
                record["max_abs_error"] = check_output(output, expected, case_id)
                print(case_id, trial, index, record["total_kernel_us_per_call"], flush=True)
        medians = [statistics.median(r["total_kernel_us_per_call"] for r in rows) for rows in records]
        report["rows"].append(dict(case=case_id, config=cfg, max_abs_error=errors, records=records,
                                   median_kernel_us=medians, speedup=[medians[0] / x for x in medians]))
        Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
        print("SUMMARY", case_id, medians, report["rows"][-1]["speedup"], flush=True)


if __name__ == "__main__":
    main()
