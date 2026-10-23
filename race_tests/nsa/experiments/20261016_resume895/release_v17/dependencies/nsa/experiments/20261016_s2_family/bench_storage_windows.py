"""Check a small-kernel signal across storage placement and graph length.

All variants use exactly the same current input and output addresses in each
comparison. Placement is varied by valid aligned contiguous tensor views;
every view is kept alive through the final replay. No placement-dependent
code is added to the submission.
"""
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

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import check_output, make_inputs, sparse_reference
from experiment_bench import load_module


PADDING_ELEMENTS = (
    (0, 0, 0, 0, 0),
    (256, 512, 768, 256, 1024),
    (2048, 4096, 8192, 2048, 16384),
    (32768, 65536, 131072, 16384, 262144),
)


def placed_tensor(original, padding, copy=True):
    storage = torch.empty(original.numel() + padding + 256,
                          device=original.device, dtype=original.dtype)
    tensor = storage[padding:padding + original.numel()].view(original.shape)
    assert tensor.is_contiguous()
    assert tensor.data_ptr() % 128 == 0
    if copy:
        tensor.copy_(original)
        assert torch.equal(tensor, original)
    return tensor


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("modules", nargs="+")
    parser.add_argument("--case-file", required=True)
    parser.add_argument("--cases", default="oj10,s2_b1_t128,s2_b1_t320")
    parser.add_argument("--seeds", default="0,61")
    parser.add_argument("--repeats", default="96,480")
    parser.add_argument("--attempts", type=int, default=24)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    output = Path(args.output)
    assert not output.exists()
    repeats = [int(value) for value in args.repeats.split(",")]
    assert all(repeat > 0 for repeat in repeats)
    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    runtime.mcStreamCreate.argtypes = [ctypes.POINTER(ctypes.c_void_p)]
    runtime.mcStreamCreate.restype = ctypes.c_int
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    torch.backends.cuda.matmul.allow_tf32 = False
    modules = [load_module(path) for path in args.modules]
    cases = json.loads(Path(args.case_file).read_text())
    report = dict(command=sys.argv,
                  method="A/B/A graphs, identical tensor values across four aligned storage placements, randomized placement/window/module order, shared graph pool",
                  sha256={path: hashlib.sha256(Path(path).read_bytes()).hexdigest()
                          for path in args.modules}, rows=[])
    for case_id in args.cases.split(","):
        cfg = cases[case_id]
        shape = (cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"],
                 cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
        for seed in [int(value) for value in args.seeds.split(",")]:
            original = make_inputs(cfg, seed)
            expected = sparse_reference(*original, cfg["block_size"], cfg["is_causal"], 0.1)
            placements = []
            for offsets in PADDING_ELEMENTS:
                inputs = tuple(placed_tensor(tensor, padding)
                               for tensor, padding in zip(original, offsets[:4]))
                out = placed_tensor(original[0], offsets[4], copy=False)
                placements.append((inputs, out))
            sources = [hashlib.sha256(module._get_kernel(*shape).get_kernel_source().encode()).hexdigest()
                       for module in modules]
            pool = torch.cuda.graph_pool_handle()
            graphs, errors, replay_checks = {}, {}, {}
            for placement, (inputs, out) in enumerate(placements):
                call_args = (*inputs, out, *shape)
                errors[placement] = []
                for index, module in enumerate(modules):
                    out.fill_(float("nan"))
                    module.run_kernel(*call_args)
                    errors[placement].append(check_output(out, expected, f"{case_id}:placement{placement}:{index}"))
                for repeat in repeats:
                    key = (placement, repeat)
                    graphs[key], replay_checks[key] = [], []
                    for module in modules:
                        stream.wait_stream(torch.cuda.current_stream())
                        stream.synchronize()
                        graph = torch.cuda.CUDAGraph()
                        with torch.cuda.graph(graph, stream=stream, pool=pool):
                            for _ in range(repeat):
                                module.run_kernel(*call_args)
                        graphs[key].append(graph)
                    for index in list(range(len(modules))) + list(reversed(range(len(modules)))):
                        out.fill_(float("nan"))
                        graphs[key][index].replay()
                        torch.cuda.synchronize()
                        replay_checks[key].append(dict(module=index,
                            max_abs_error=check_output(out, expected, f"{case_id}:replay:{key}:{index}")))

            def time_graph(key, index):
                start, end = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
                start.record()
                graphs[key][index].replay()
                end.record()
                end.synchronize()
                return start.elapsed_time(end) * 1000 / key[1]

            for key in graphs:
                for index, graph in enumerate(graphs[key]):
                    latency = time_graph(key, index)
                    for _ in range(max(1, math.ceil(30000 / (latency * key[1])))):
                        graph.replay()
            torch.cuda.synchronize()
            trials = {key: [[] for _ in modules] for key in graphs}
            rng = random.Random(0x53544F52 + seed)
            for attempt in range(args.attempts):
                keys = list(graphs)
                rng.shuffle(keys)
                for key in keys:
                    indices = list(range(1, len(modules)))
                    rng.shuffle(indices)
                    for index in indices:
                        before = time_graph(key, 0)
                        value = time_graph(key, index)
                        after = time_graph(key, 0)
                        baseline = (before + after) / 2
                        drift = abs(before - after) / baseline
                        trials[key][index].append(dict(before_us=before, candidate_us=value,
                            after_us=after, drift=drift, accepted=drift <= 0.01, speedup=baseline / value))
            for (placement, repeat), values in trials.items():
                inputs, out = placements[placement]
                row = dict(case=f"{case_id}_pad{placement}_n{repeat}", base_case=case_id,
                           config=cfg, seed=seed, repeat=repeat, placement=placement,
                           padding_elements=PADDING_ELEMENTS[placement],
                           pointer_mod_2mb=[tensor.data_ptr() % (2 * 1024 * 1024) for tensor in (*inputs, out)],
                           max_abs_error=errors[placement],
                           graph_checks=replay_checks[(placement, repeat)],
                           device_source_sha256=[[digest] for digest in sources], trials=values)
                report["rows"].append(row)
                print(row["case"], seed,
                      [statistics.median(t["speedup"] for t in group) for group in values[1:]], flush=True)
            output.write_text(json.dumps(report, indent=2) + "\n")
            del graphs, graph, placements, inputs, out, original


if __name__ == "__main__":
    main()
