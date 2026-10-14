"""Check and benchmark both NSA kernels against an independent sparse reference."""

import argparse
import csv
import json
import math
from pathlib import Path
import random
import statistics

import torch


CASE_PATH = Path(__file__).with_name("test_cases_nsa_fwd.json")


def make_block_indices(case, seed=0, device="cuda"):
    """Match the original past-block sampling, with one host-to-device copy."""
    rng = random.Random(seed)
    seq_len, selected = case["SEQ_LEN"], case["S"]
    rows = []
    for _ in range(case["B"]):
        for token in range(seq_len):
            population = range(max(1, token // case["block_size"]))
            for _ in range(case["H"]):
                blocks = sorted(rng.sample(population, min(selected, len(population))))
                rows.append(blocks + [seq_len] * (selected - len(blocks)))
    return torch.tensor(rows, dtype=torch.int32).reshape(
        case["B"], seq_len, case["H"], selected
    ).to(device).contiguous()


def make_inputs(case, seed=0, device="cuda"):
    generator = torch.Generator(device=device).manual_seed(seed)
    batch, seq_len, dim = case["B"], case["SEQ_LEN"], case["D"]
    kwargs = dict(dtype=torch.float16, device=device, generator=generator)
    q = torch.randn((batch, seq_len, case["HQ"], dim), **kwargs)
    k = torch.randn((batch, seq_len, case["H"], dim), **kwargs)
    v = torch.randn((batch, seq_len, case["H"], dim), **kwargs)
    return q, k, v, make_block_indices(case, seed, device)


@torch.no_grad()
def sparse_reference(q, k, v, block_indices, block_size, is_causal, scale=None, chunk_size=256):
    """Gather selected keys in bounded chunks and compute attention in float32.

    Negative and out-of-range block indices are ignored. Empty attention rows
    produce zeros. Repeated block indices retain their multiplicity.
    """
    if chunk_size <= 0:
        raise ValueError("chunk_size must be positive")
    batch, seq_len, query_heads, dim = q.shape
    kv_heads = k.shape[2]
    if query_heads % kv_heads:
        raise ValueError("query heads must be divisible by key/value heads")
    groups = query_heads // kv_heads
    scale = dim ** -0.5 if scale is None else scale
    output = torch.zeros_like(q)
    offsets = torch.arange(block_size, device=q.device)
    for b in range(batch):
        for h in range(kv_heads):
            keys = k[b, :, h].float()
            values = v[b, :, h].float()
            for start in range(0, seq_len, chunk_size):
                end = min(start + chunk_size, seq_len)
                positions = (
                    block_indices[b, start:end, h].long().unsqueeze(-1) * block_size
                    + offsets
                ).flatten(1)
                valid = (positions >= 0) & (positions < seq_len)
                if is_causal:
                    valid &= positions <= torch.arange(start, end, device=q.device).unsqueeze(-1)
                safe_positions = positions.clamp(0, seq_len - 1)
                selected_k = keys[safe_positions]
                selected_v = values[safe_positions]
                queries = q[b, start:end, h * groups : (h + 1) * groups].float()
                scores = torch.matmul(queries, selected_k.transpose(-1, -2)) * scale
                scores.masked_fill_(~valid.unsqueeze(1), float("-inf"))
                weights = torch.softmax(scores, dim=-1).nan_to_num_(nan=0.0)
                output[b, start:end, h * groups : (h + 1) * groups] = torch.matmul(
                    weights, selected_v
                ).to(q.dtype)
    return output


def compile_kernel(factory, case, scale):
    return factory(
        batch=case["B"], heads=case["HQ"], seq_len=case["SEQ_LEN"], dim=case["D"],
        is_causal=case["is_causal"], scale=scale, block_size=case["block_size"],
        groups=case["HQ"] // case["H"], selected_blocks=case["S"],
    )


def graph_latency(kernel, inputs, repeat=100, samples=9):
    """Median GPU time per call; capture allocations are outside timed replays."""
    if repeat <= 0 or samples <= 0:
        raise ValueError("repeat and samples must be positive")
    stream = torch.cuda.Stream()
    stream.wait_stream(torch.cuda.current_stream())
    with torch.cuda.stream(stream):
        for _ in range(3):
            kernel(*inputs)
    stream.synchronize()
    graph = torch.cuda.CUDAGraph()
    with torch.cuda.graph(graph, stream=stream):
        for _ in range(repeat):
            output = kernel(*inputs)
    graph.replay()
    torch.cuda.synchronize()
    starts = [torch.cuda.Event(enable_timing=True) for _ in range(samples)]
    ends = [torch.cuda.Event(enable_timing=True) for _ in range(samples)]
    for start, end in zip(starts, ends):
        start.record()
        graph.replay()
        end.record()
    ends[-1].synchronize()
    latency = statistics.median(start.elapsed_time(end) / repeat for start, end in zip(starts, ends))
    # Keep captured storage alive until the last replay completes.
    del output, graph
    return latency


def check_output(actual, expected, name):
    try:
        torch.testing.assert_close(actual, expected, atol=1e-2, rtol=1e-2)
    except AssertionError as error:
        raise AssertionError(f"{name} failed the float32 reference check:\n{error}") from error
    return (actual.float() - expected.float()).abs().max().item()


@torch.no_grad()
def check_extra_cases(factory, chunk_size=256):
    """Exercise masks and tails absent from the supplied performance cases."""
    for selected in (1, 4):
        for causal in (True, False):
            case = dict(B=2, SEQ_LEN=37, H=2, HQ=32, D=64, S=selected,
                        block_size=16, is_causal=causal)
            q, k, v, indices = make_inputs(case, seed=123)
            # Include the partial final block, future blocks, invalid slots,
            # and a row with no valid keys, independently for both KV heads.
            rows = torch.tensor(
                [[2, -1, 37, 0], [0, 2, -1, 37], [-1, 37, -2, 99]],
                dtype=torch.int32, device=q.device,
            )[:, :selected]
            tokens = torch.arange(case["SEQ_LEN"], device=q.device)
            indices.copy_(rows[tokens % 3].view(1, case["SEQ_LEN"], 1, selected).expand_as(indices))
            inputs = (q, k, v, indices)
            kernel = compile_kernel(factory, case, scale=None)
            expected = sparse_reference(*inputs, case["block_size"], causal, chunk_size=chunk_size)
            error = check_output(kernel(*inputs), expected, f"extra S={selected}, causal={causal}")
            print(f"Extra S={selected} causal={causal}: PASS (max_abs_error={error:.6g})", flush=True)


def parse_cases(value, total):
    if value == "all":
        return list(range(1, total + 1))
    try:
        cases = list(dict.fromkeys(int(item.strip()) for item in value.split(",")))
    except ValueError as error:
        raise ValueError("--cases must be 'all' or comma-separated 1-based indices") from error
    if not cases or any(index < 1 or index > total for index in cases):
        raise ValueError(f"case indices must be between 1 and {total}")
    return cases


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cases", default="all", help="1-based indices, e.g. 1,15,82, or all")
    parser.add_argument("--output", type=Path, default=Path(__file__).with_name("benchmark_nsa.csv"))
    parser.add_argument("--repeat", type=int, default=100, help="kernel calls per CUDA graph")
    parser.add_argument("--samples", type=int, default=9, help="timed graph replays")
    parser.add_argument("--chunk-size", type=int, default=256, help="reference query tokens per chunk")
    parser.add_argument("--scale", type=float, default=0.1)
    parser.add_argument("--seed", type=int, default=0)
    parser.add_argument("--correctness-only", action="store_true")
    parser.add_argument("--extra-correctness", action="store_true", help="also check masks and partial blocks")
    args = parser.parse_args()
    with CASE_PATH.open() as source:
        cases = json.load(source)
    try:
        selected = parse_cases(args.cases, len(cases))
    except ValueError as error:
        parser.error(str(error))
    if min(args.repeat, args.samples, args.chunk_size) <= 0:
        parser.error("--repeat, --samples and --chunk-size must be positive")
    if not torch.cuda.is_available():
        parser.error("a CUDA-compatible GPU is required")

    import os as _os, importlib.util as _ilu
    _spec = _ilu.spec_from_file_location('nsa_variant', _os.environ['NSA_MODULE'])
    _mod = _ilu.module_from_spec(_spec)
    _spec.loader.exec_module(_mod)
    native_sparse_attention = _mod.native_sparse_attention
    from test_tilelang_nsa_fwd import native_sparse_attention_baseline

    torch.backends.cuda.matmul.allow_tf32 = False
    fields = ["idx", "B", "SEQ_LEN", "H", "HQ", "D", "S", "block_size", "is_causal",
              "baseline_ms", "optimized_ms", "speedup", "max_abs_error", "status"]
    speedups = []
    with args.output.open("w", newline="") as destination:
        writer = csv.DictWriter(destination, fieldnames=fields)
        writer.writeheader()
        for position, index in enumerate(selected, 1):
            case = cases[index - 1]
            print(f"[{position}/{len(selected)}] case {index}: {case}", flush=True)
            inputs = make_inputs(case, args.seed)
            baseline = compile_kernel(native_sparse_attention_baseline, case, args.scale)
            optimized = compile_kernel(native_sparse_attention, case, args.scale)
            expected = sparse_reference(*inputs, case["block_size"], case["is_causal"],
                                        args.scale, args.chunk_size)
            check_output(baseline(*inputs), expected, "baseline")
            max_error = check_output(optimized(*inputs), expected, "optimized")
            row = dict(idx=index, **case, baseline_ms="", optimized_ms="", speedup="",
                       max_abs_error=max_error, status="PASS")
            if not args.correctness_only:
                baseline_ms = graph_latency(baseline, inputs, args.repeat, args.samples)
                optimized_ms = graph_latency(optimized, inputs, args.repeat, args.samples)
                speedup = baseline_ms / optimized_ms
                speedups.append(speedup)
                row.update(baseline_ms=baseline_ms, optimized_ms=optimized_ms, speedup=speedup)
                print(f"  PASS baseline={baseline_ms:.6f} ms optimized={optimized_ms:.6f} ms "
                      f"speedup={speedup:.3f}x max_abs_error={max_error:.6g}", flush=True)
            else:
                print(f"  PASS max_abs_error={max_error:.6g}", flush=True)
            writer.writerow(row)
            destination.flush()
    if args.extra_correctness:
        check_extra_cases(native_sparse_attention, args.chunk_size)
    if speedups:
        geometric_mean = math.exp(sum(math.log(value) for value in speedups) / len(speedups))
        print(f"Geometric mean speedup: {geometric_mean:.3f}x ({len(speedups)} cases)")
    print(f"Results: {args.output.resolve()}")


if __name__ == "__main__":
    main()
