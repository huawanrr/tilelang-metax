"""Compare graph lengths in one process with identical input/output allocations."""
import argparse
import ctypes
import hashlib
import json
import math
from pathlib import Path
import random
import statistics
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("modules", nargs="+")
    parser.add_argument("--repeats", default="100,400,800,1600")
    parser.add_argument("--seeds", default="0,61,2026")
    parser.add_argument("--attempts", type=int, default=24)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    output = Path(args.output)
    assert not output.exists()
    repeats = list(map(int, args.repeats.split(",")))
    assert repeats and all(n > 0 for n in repeats)
    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    torch.backends.cuda.matmul.allow_tf32 = False
    modules = [load_module(path) for path in args.modules]
    config = json.loads((HERE / "cases.json").read_text())["oj1"]
    report = dict(command=sys.argv,
        method="A/B/A CUDA graphs; same input/output storage across graph lengths; randomized length order; 100 ms warmup per graph",
        sha256={path:hashlib.sha256(Path(path).read_bytes()).hexdigest() for path in args.modules}, rows=[])
    for seed in map(int, args.seeds.split(",")):
        inputs = make_inputs(config, seed)
        expected = sparse_reference(*inputs, 16, True, 0.1)
        out = torch.empty_like(inputs[0])
        shape = (1, 64, 1, 16, 32, 1, 16, True, 0.1)
        call_args = (*inputs, out, *shape)
        errors, sources, flags = [], [], []
        for module in modules:
            out.fill_(float("nan"))
            module.run_kernel(*call_args)
            errors.append(check_output(out, expected, "oj1"))
            kernel = module._get_kernel(*shape)
            sources.append([hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest()])
            flags.append([list(kernel.compile_flags or [])])
        pool = torch.cuda.graph_pool_handle()
        graphs = {repeat:[] for repeat in repeats}
        for repeat in repeats:
            for module in modules:
                stream.wait_stream(torch.cuda.current_stream())
                stream.synchronize()
                graph = torch.cuda.CUDAGraph()
                with torch.cuda.graph(graph, stream=stream, pool=pool):
                    for _ in range(repeat):
                        module.run_kernel(*call_args)
                graphs[repeat].append(graph)
                out.fill_(float("nan"))
                graph.replay()
                torch.cuda.synchronize()
                check_output(out, expected, f"replay-{repeat}")

        def time_graph(graph, repeat):
            start, end = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
            start.record()
            graph.replay()
            end.record()
            end.synchronize()
            return start.elapsed_time(end) * 1000 / repeat

        for repeat in repeats:
            for graph in graphs[repeat]:
                latency = time_graph(graph, repeat)
                for _ in range(max(1, math.ceil(100000 / (latency * repeat)))):
                    graph.replay()
        torch.cuda.synchronize()
        trials = {repeat:[[] for _ in modules] for repeat in repeats}
        rng = random.Random(0x47524150 + seed)
        for attempt in range(args.attempts):
            order = repeats.copy()
            rng.shuffle(order)
            for repeat in order:
                variants = list(range(1, len(modules)))
                rng.shuffle(variants)
                for index in variants:
                    before = time_graph(graphs[repeat][0], repeat)
                    value = time_graph(graphs[repeat][index], repeat)
                    after = time_graph(graphs[repeat][0], repeat)
                    baseline = (before + after) / 2
                    drift = abs(before - after) / baseline
                    trials[repeat][index].append(dict(before_us=before, candidate_us=value,
                        after_us=after, drift=drift, accepted=drift <= 0.01, speedup=baseline/value))
        for repeat in repeats:
            summaries = []
            for values in trials[repeat][1:]:
                kept = [value for value in values if value["accepted"]]
                summaries.append(dict(accepted=len(kept), total=len(values),
                    median_speedup=statistics.median(t["speedup"] for t in kept) if kept else None,
                    unfiltered_speedup=statistics.median(t["speedup"] for t in values)))
            report["rows"].append(dict(case=f"oj1_repeat{repeat}", config=config, seed=seed,
                repeat=repeat, max_abs_error=errors, device_source_sha256=sources, compile_flags=flags,
                trials=trials[repeat], summaries=summaries))
            print(seed, repeat, summaries, flush=True)
        output.write_text(json.dumps(report, indent=2) + "\n")
        del graphs, graph, inputs, out


if __name__ == "__main__":
    main()
