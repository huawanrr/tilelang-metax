"""Compare public calls with a cache flush before every individual invocation.

One public invocation is captured per graph. Events enclose that invocation;
the flush is ordered before the start event and excluded from elapsed time.
This tests a different cache condition, not a claim to reproduce the grader.
"""
import argparse
import ctypes
import hashlib
import inspect
import itertools
import json
from pathlib import Path
import statistics
import sys

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
    p.add_argument("--cases", default="oj6,oj9,oj12,69,76,79,80")
    p.add_argument("--seeds", default="0")
    p.add_argument("--attempts", type=int, default=64)
    p.add_argument("--flush-bytes", type=int, default=256000000)
    p.add_argument("--max-drift", type=float, default=0.03)
    p.add_argument("--output", required=True)
    a = p.parse_args()
    assert len(a.modules) >= 2 and a.attempts > 0 and a.flush_bytes >= 0
    torch.backends.cuda.matmul.allow_tf32 = False
    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    supplied = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    named = {
        "oj6": dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
        "oj9": dict(B=1, SEQ_LEN=8192, H=1, HQ=16, D=64, S=1, block_size=16, is_causal=True),
        "oj12": dict(B=4, SEQ_LEN=1024, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
    }
    modules = [load_module(path) for path in a.modules]
    cache = torch.empty((a.flush_bytes + 3) // 4, device="cuda", dtype=torch.int32)
    report = dict(command=sys.argv, method="A/B/A; flush before each one-call graph; event time excludes flush",
                  shared_pool=True, flush_bytes=cache.numel() * 4,
                  sha256={path: hashlib.sha256(Path(path).read_bytes()).hexdigest() for path in a.modules},
                  rows=[])

    def flush():
        if a.flush_bytes:
            cache.zero_()

    for case_id, seed in itertools.product(a.cases.split(","), map(int, a.seeds.split(","))):
        cfg = named[case_id] if case_id in named else supplied[int(case_id) - 1]
        inputs = make_inputs(cfg, seed)
        expected = sparse_reference(*inputs, cfg["block_size"], cfg["is_causal"], 0.1)
        output = torch.empty_like(inputs[0])
        args = (*inputs, output, cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"],
                cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
        graphs, errors, hashes, flags = [], [], [], []
        pool = torch.cuda.graph_pool_handle()
        for mod in modules:
            output.fill_(float("nan"))
            mod.run_kernel(*args)
            errors.append(check_output(output, expected, case_id))
            kernel = mod._get_kernel(cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"],
                cfg["D"], cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
            kernels = parts(kernel)
            hashes.append([hashlib.sha256(k.get_kernel_source().encode()).hexdigest() for k in kernels])
            flags.append([list(k.compile_flags or []) for k in kernels])
            stream.wait_stream(torch.cuda.current_stream())
            stream.synchronize()
            graph = torch.cuda.CUDAGraph()
            with torch.cuda.graph(graph, stream=stream, pool=pool):
                mod.run_kernel(*args)
            graphs.append(graph)
        graph_checks = []
        for index in list(range(len(graphs))) + list(reversed(range(len(graphs)))):
            output.fill_(float("nan"))
            flush()
            graphs[index].replay()
            torch.cuda.synchronize()
            graph_checks.append(dict(module=index, max_abs_error=check_output(output, expected, case_id)))
        for _ in range(16):
            for graph in graphs:
                flush()
                graph.replay()
        torch.cuda.synchronize()

        # Queue the whole sample sequence. The large flush keeps host event and
        # graph-launch submission ahead of the device's timed invocation.
        events = []
        for attempt in range(a.attempts):
            order = range(1, len(graphs)) if attempt % 2 == 0 else reversed(range(1, len(graphs)))
            for index in order:
                triple = []
                for which in (0, index, 0):
                    start = torch.cuda.Event(enable_timing=True)
                    end = torch.cuda.Event(enable_timing=True)
                    flush()
                    start.record()
                    graphs[which].replay()
                    end.record()
                    triple.append((start, end))
                events.append((attempt, index, triple))
        events[-1][2][-1][1].synchronize()
        trials = [[] for _ in graphs]
        for attempt, index, triple in events:
            before, value, after = [s.elapsed_time(e) * 1000 for s, e in triple]
            baseline = (before + after) / 2
            drift = abs(before - after) / baseline
            trials[index].append(dict(attempt=attempt, before_us=before, candidate_us=value,
                after_us=after, drift=drift, accepted=drift <= a.max_drift, speedup=baseline / value))
        summaries = []
        for values in trials[1:]:
            kept = [v for v in values if v["accepted"]]
            summaries.append(dict(accepted=len(kept), total=len(values),
                median_speedup=statistics.median(v["speedup"] for v in kept) if kept else None,
                unfiltered_median_speedup=statistics.median(v["speedup"] for v in values),
                median_baseline_us=statistics.median((v["before_us"] + v["after_us"]) / 2 for v in kept) if kept else None,
                median_candidate_us=statistics.median(v["candidate_us"] for v in kept) if kept else None))
        report["rows"].append(dict(case=case_id, seed=seed, config=cfg, max_abs_error=errors,
            graph_checks=graph_checks, device_source_sha256=hashes, compile_flags=flags,
            trials=trials, summaries=summaries))
        Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
        print(case_id, seed, json.dumps(summaries), flush=True)


if __name__ == "__main__":
    main()
