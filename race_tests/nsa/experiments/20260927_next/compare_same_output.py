"""Validated, alternating-order comparison of the public run_kernel interface."""

import argparse
import hashlib
import json
import math
import statistics
import sys
from pathlib import Path

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output, parse_cases
import ctypes

_BENCH_STREAM = None
_RUNTIME = None


def graph_latency(fn, repeat=100, samples=7):
    # Reuse a stream: MACA allocates a hardware queue per stream and this
    # sliced device cannot serve an unbounded series of new streams.
    global _BENCH_STREAM, _RUNTIME
    if _BENCH_STREAM is None:
        # torch.cuda.Stream initializes a pool, which exhausts the hardware
        # queues on this slice/driver. Create exactly one real MACA stream.
        _RUNTIME = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
        pointer = ctypes.c_void_p()
        result = _RUNTIME.mcStreamCreate(ctypes.byref(pointer))
        if result:
            raise RuntimeError(f"mcStreamCreate failed: {result}")
        _BENCH_STREAM = torch.cuda.ExternalStream(pointer.value)
        torch.cuda.graph.default_capture_stream = _BENCH_STREAM
    stream = _BENCH_STREAM
    stream.wait_stream(torch.cuda.current_stream())
    with torch.cuda.stream(stream):
        for _ in range(5):
            fn()
    stream.synchronize()
    graph = torch.cuda.CUDAGraph()
    with torch.cuda.graph(graph, stream=stream):
        for _ in range(repeat):
            fn()
    warm_start = torch.cuda.Event(enable_timing=True)
    warm_end = torch.cuda.Event(enable_timing=True)
    warm_start.record()
    graph.replay()
    warm_end.record()
    warm_end.synchronize()
    for _ in range(max(1, math.ceil(40.0 / max(warm_start.elapsed_time(warm_end), 0.001)))):
        graph.replay()
    torch.cuda.synchronize()
    starts = [torch.cuda.Event(enable_timing=True) for _ in range(samples)]
    ends = [torch.cuda.Event(enable_timing=True) for _ in range(samples)]
    for start, end in zip(starts, ends):
        start.record()
        graph.replay()
        end.record()
    ends[-1].synchronize()
    return statistics.median(s.elapsed_time(e) / repeat for s, e in zip(starts, ends))

from experiment_bench import load_module
from kernel_source import get_kernel_source


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("modules", nargs="+")
    p.add_argument("--cases", default="oj6,oj12,69")
    p.add_argument("--rounds", type=int, default=4)
    p.add_argument("--repeat", type=int, default=100)
    p.add_argument("--samples", type=int, default=7)
    p.add_argument("--seed", type=int, default=0)
    p.add_argument("--output", required=True)
    p.add_argument("--dump", action="store_true")
    args = p.parse_args()
    if min(args.rounds, args.repeat, args.samples) < 1:
        p.error("rounds, repeat and samples must be positive")
    torch.backends.cuda.matmul.allow_tf32 = False
    cases = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    named = {
        "oj6": dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
        "oj12": dict(B=4, SEQ_LEN=1024, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
        "oj9": dict(B=1, SEQ_LEN=8192, H=1, HQ=16, D=64, S=1, block_size=16, is_causal=True),
    }
    selected = [str(i) for i in parse_cases("all", len(cases))] if args.cases == "all" else args.cases.split(",")
    modules = [(path, load_module(path)) for path in args.modules]
    report = dict(
        command=sys.argv, torch=torch.__version__, device=torch.cuda.get_device_name(),
        source_sha256={path: hashlib.sha256(Path(path).read_bytes()).hexdigest() for path, _ in modules},
        backend="CUDA graph, one shared preallocated output for every module, public run_kernel, no cache flush, ~40ms replay warmup",
        repeat=args.repeat, samples=args.samples, rounds=args.rounds, rows=[],
    )
    for name in selected:
        cfg = named[name] if name in named else cases[int(name) - 1]
        inputs = make_inputs(cfg, seed=args.seed)
        expected = sparse_reference(*inputs, cfg["block_size"], cfg["is_causal"], 0.1)
        launches, errors = [], []
        shared_output = torch.empty_like(inputs[0])
        for path, module in modules:
            output = shared_output
            output.fill_(float("nan"))
            call_args = (*inputs, output, cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"],
                         cfg["D"], cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
            def launch(module=module, call_args=call_args):
                module.run_kernel(*call_args)
            launch()
            if args.dump:
                compiled = next(reversed(module._KERNEL_CACHE.values()))
                Path(args.output).with_name(f"{Path(path).stem}_{name}.cpp").write_text(get_kernel_source(compiled))
            errors.append(check_output(output, expected, f"{path}:{name}"))
            launches.append(launch)
        timings = [[] for _ in modules]
        for round_id in range(args.rounds):
            order = range(len(modules)) if round_id % 2 == 0 else reversed(range(len(modules)))
            for i in order:
                timings[i].append(graph_latency(launches[i], args.repeat, args.samples) * 1000)
        medians = [statistics.median(values) for values in timings]
        row = dict(case=name, config=cfg, us=medians, rounds_us=timings,
                   speedups=[medians[0] / value for value in medians], max_abs_error=errors)
        report["rows"].append(row)
        print(json.dumps(row), flush=True)
        Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    report["geomean_speedups"] = [
        math.exp(statistics.mean(math.log(row["speedups"][i]) for row in report["rows"]))
        for i in range(len(modules))
    ]
    Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    print("geomean_speedups", report["geomean_speedups"], flush=True)


if __name__ == "__main__":
    main()
