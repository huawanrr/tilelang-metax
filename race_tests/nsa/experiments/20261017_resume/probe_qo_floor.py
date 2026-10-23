"""Diagnostic Q/O copy timings, not NSA implementations or submission candidates.

Compare complete public NSA, its prepared attention phase, and plain Q->O
copies of the same shape/address range. Copy timings are a diagnostic reference,
not a proven lower bound or a realizable NSA speedup. GPU work is serial.
"""
import argparse
import hashlib
import inspect
import json
import math
from pathlib import Path
import statistics
import sys
import ctypes

import torch
import tilelang
import tilelang.language as T

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module


@tilelang.jit
def copy_only(elements, tile_size, threads):
    @T.prim_func
    def kernel(Input: T.Tensor([elements], T.float16), Output: T.Tensor([elements], T.float16)):
        with T.Kernel(T.ceildiv(elements, tile_size), threads=threads) as block:
            values = T.alloc_fragment([tile_size], T.float16)
            T.copy(Input[block * tile_size:(block + 1) * tile_size], values)
            T.copy(values, Output[block * tile_size:(block + 1) * tile_size])
    return kernel


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cases", default="oj6,oj12")
    parser.add_argument("--repeat", type=int, default=240)
    parser.add_argument("--attempts", type=int, default=12)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    output_path = Path(args.output)
    assert not output_path.exists()
    torch.backends.cuda.matmul.allow_tf32 = False
    rt = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    ptr = ctypes.c_void_p()
    assert rt.mcStreamCreate(ctypes.byref(ptr)) == 0
    stream = torch.cuda.ExternalStream(ptr.value)
    torch.cuda.graph.default_capture_stream = stream
    mod_path = HERE / "baseline.py"
    mod = load_module(str(mod_path))
    cases = json.loads((HERE / "cases.json").read_text())
    report = dict(command=sys.argv, not_a_submission=True,
                  method="Serial same-address CUDA graphs; all raw A/B/A timings retained; public NSA includes pack",
                  copy_limitation="Copy kernel omits all attention computation and KV traffic; measured copy time is not an NSA speedup claim",
                  baseline_sha256=hashlib.sha256(mod_path.read_bytes()).hexdigest(),
                  tool_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), rows=[])
    for name in args.cases.split(","):
        cfg = cases[name]
        q, k, v, indices = make_inputs(cfg, 0)
        expected = sparse_reference(q, k, v, indices, cfg["block_size"], cfg["is_causal"], 0.1)
        result = torch.empty_like(q)
        call_args = (q, k, v, indices, result, cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"], cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
        mod.run_kernel(*call_args)
        check_output(result, expected, name)
        prepared = mod._get_kernel(cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"], cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
        closure = inspect.getclosurevars(prepared).nonlocals
        pack, attention = closure["pack"], closure["attention"]
        if "shape" in closure:
            packed = torch.empty(closure["shape"], dtype=k.dtype, device=k.device)
            pack(k, v, packed)
            attention_args = (q, packed, indices, result)
        else:
            pk = torch.empty(closure["k_shape"], dtype=k.dtype, device=k.device)
            pv = torch.empty(closure["v_shape"], dtype=v.dtype, device=v.device)
            pack(k, v, pk, pv)
            attention_args = (q, pk, pv, indices, result)
        flat_q, flat_output = q.view(-1), result.view(-1)
        variants = [("public_nsa", lambda: mod.run_kernel(*call_args)),
                    ("attention_only_prepared_kv", lambda: attention(*attention_args))]
        sources = []
        for tile_size, threads in ((2048, 64), (4096, 128), (8192, 256), (16384, 256)):
            kernel = copy_only(flat_q.numel(), tile_size, threads)
            label = f"copy_tile{tile_size}_threads{threads}"
            sources.append(dict(label=label, source=kernel.get_kernel_source()))
            variants.append((label, lambda kernel=kernel: kernel(flat_q, flat_output)))
        graphs = []
        for label, execute in variants:
            execute()
            if label.startswith("copy"):
                assert torch.equal(result, q)
            else:
                check_output(result, expected, label)
            stream.wait_stream(torch.cuda.current_stream())
            stream.synchronize()
            graph = torch.cuda.CUDAGraph()
            with torch.cuda.graph(graph, stream=stream):
                for _ in range(args.repeat):
                    execute()
            graphs.append(graph)
        def latency(graph):
            begin, end = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
            begin.record()
            graph.replay()
            end.record()
            end.synchronize()
            return begin.elapsed_time(end) * 1000 / args.repeat
        for graph in graphs:
            first = latency(graph)
            for _ in range(max(1, math.ceil(40000 / (first * args.repeat)))):
                graph.replay()
        torch.cuda.synchronize()
        trials = [[] for _ in variants]
        for attempt in range(args.attempts):
            order = range(1, len(variants)) if attempt % 2 == 0 else reversed(range(1, len(variants)))
            for i in order:
                before = latency(graphs[0])
                value = latency(graphs[i])
                after = latency(graphs[0])
                trials[i].append(dict(before_public_us=before, diagnostic_us=value, after_public_us=after))
                trials[0].extend((before, after))
        summaries = [dict(label=variants[0][0], median_us=statistics.median(trials[0]))]
        for i in range(1, len(variants)):
            summaries.append(dict(label=variants[i][0], median_us=statistics.median(x["diagnostic_us"] for x in trials[i])))
        for (label, _), graph in zip(variants, graphs):
            graph.replay()
            torch.cuda.synchronize()
            if label.startswith("copy"):
                assert torch.equal(result, q)
            else:
                check_output(result, expected, label)
        row = dict(case=name, config=cfg, logical_q_plus_o_bytes=2 * q.numel() * q.element_size(),
                   summaries=summaries, trials=trials, copy_kernel_sources=sources)
        report["rows"].append(row)
        output_path.write_text(json.dumps(report, indent=2) + "\n")
        print(name, summaries, flush=True)


if __name__ == "__main__":
    main()
