"""Measure actual public calls, including Python issue gaps, with A/B/A controls.

This complements GPU graph and cold-device measurements. It does not assume
that the private official grader includes Python time.
"""
import argparse
import hashlib
import json
from pathlib import Path
import statistics
import sys
import time

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from kernel_source import get_kernel_source


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("modules", nargs="+")
    parser.add_argument("--case-file", default=str(HERE / "oj_cases.json"))
    parser.add_argument("--cases", default="oj1,oj2,oj3,oj6,oj9,oj10,oj12,oj13,oj14")
    parser.add_argument("--seeds", default="0,61")
    parser.add_argument("--attempts", type=int, default=12)
    parser.add_argument("--repeat", type=int, default=200)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    output_path = Path(args.output)
    assert not output_path.exists()
    modules = [load_module(str(Path(path).resolve())) for path in args.modules]
    cases = json.loads(Path(args.case_file).read_text())
    torch.backends.cuda.matmul.allow_tf32 = False
    report = dict(command=sys.argv, sha256={p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
        for p in args.modules}, rows=[],
        method="A/B/A actual run_kernel loop; CUDA event span includes host issue gaps; synchronized wall clock recorded separately",
        official_timing_method_known=False)
    for name in args.cases.split(","):
        cfg = cases[name]
        for seed in map(int, args.seeds.split(",")):
            inputs = make_inputs(cfg, seed)
            expected = sparse_reference(*inputs, cfg["block_size"], cfg["is_causal"], 0.1)
            out = torch.empty_like(inputs[0])
            shape = (cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"], cfg["S"],
                     cfg["block_size"], cfg["is_causal"], 0.1)
            call_args = (*inputs, out, *shape)
            hashes, errors = [], []
            for module in modules:
                out.fill_(float("nan"))
                module.run_kernel(*call_args)
                errors.append(check_output(out, expected, name))
                source = get_kernel_source(module._get_kernel(*shape))
                hashes.append(hashlib.sha256(source.encode()).hexdigest())
                for _ in range(20):
                    module.run_kernel(*call_args)
            torch.cuda.synchronize()

            def measure(index):
                module = modules[index]
                start, end = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
                torch.cuda.synchronize()
                wall_start = time.perf_counter_ns()
                start.record()
                for _ in range(args.repeat):
                    module.run_kernel(*call_args)
                end.record()
                end.synchronize()
                wall_us = (time.perf_counter_ns()-wall_start) / 1000 / args.repeat
                return dict(event_us=start.elapsed_time(end)*1000/args.repeat, wall_us=wall_us)

            trials = [[] for _ in modules]
            for trial in range(args.attempts):
                for i in (range(1, len(modules)) if trial % 2 == 0 else reversed(range(1, len(modules)))):
                    before, value, after = measure(0), measure(i), measure(0)
                    base = (before["event_us"]+after["event_us"])/2
                    drift = abs(before["event_us"]-after["event_us"])/base
                    trials[i].append(dict(before=before, candidate=value, after=after,
                        drift=drift, accepted=drift<=0.03, speedup=base/value["event_us"],
                        wall_speedup=((before["wall_us"]+after["wall_us"])/2)/value["wall_us"]))
            summaries = []
            for records in trials[1:]:
                kept = [r for r in records if r["accepted"]]
                summaries.append(dict(accepted=len(kept), total=len(records),
                    median_speedup=statistics.median(r["speedup"] for r in kept) if kept else None,
                    all_samples_speedup=statistics.median(r["speedup"] for r in records),
                    median_wall_speedup=statistics.median(r["wall_speedup"] for r in kept) if kept else None,
                    median_baseline_us=statistics.median((r["before"]["event_us"]+r["after"]["event_us"])/2 for r in kept) if kept else None,
                    median_candidate_us=statistics.median(r["candidate"]["event_us"] for r in kept) if kept else None))
            row = dict(case=name, seed=seed, config=cfg, max_abs_error=errors,
                device_source_sha256=hashes, trials=trials, summaries=summaries)
            report["rows"].append(row)
            output_path.write_text(json.dumps(report, indent=2)+"\n")
            print(name, seed, json.dumps(summaries), flush=True)


if __name__ == "__main__":
    main()
