"""Measure preprocessing and attention separately, including schedule coverage."""
import argparse
import inspect
import json
from pathlib import Path
import statistics
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / 'experiments/20260927_next'))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from compare_same_output import graph_latency


def check_schedule(indices, sorted_indices, schedule, block_size, causal, qt):
    raw = indices.cpu()
    order = sorted_indices.cpu()
    schedule = schedule.cpu()
    bsz, length, heads, _ = raw.shape
    nb = (length + block_size - 1) // block_size
    for b in range(bsz):
        for h in range(heads):
            seen = []
            for bucket, start, count in schedule[b, h].tolist():
                if bucket == -1:
                    assert start == count == -1
                    continue
                assert 0 <= bucket <= nb and 1 <= count <= qt
                assert 0 <= start <= length - count
                for token in order[b, h, bucket, start:start + count].tolist():
                    assert 0 <= token < length
                    value = int(raw[b, token, h, 0])
                    valid = 0 <= value < nb and (not causal or value * block_size <= token)
                    assert bucket == (value if valid else nb)
                    seen.append(token)
            assert sorted(seen) == list(range(length)), (b, h, len(seen))


@torch.no_grad()
def main():
    p = argparse.ArgumentParser()
    p.add_argument('module')
    p.add_argument('--qt', type=int, required=True)
    p.add_argument('--output', required=True)
    args = p.parse_args()
    module = load_module(args.module)
    case = dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True)
    q, k, v, indices = make_inputs(case)
    fn = module._get_kernel(8, 1024, 1, 16, 128, 1, 32, True, 0.1)
    captured = inspect.getclosurevars(fn).nonlocals
    prepare, attention = captured['prepare'], captured['attention']
    order = torch.empty(captured['sorted_shape'], device=q.device, dtype=torch.int32)
    schedule = torch.empty(captured['schedule_shape'], device=q.device, dtype=torch.int32)
    output = torch.empty_like(q)
    def prep():
        prepare(indices, order, schedule)
    def attn():
        attention(q, k, v, order, schedule, output)
    prep()
    check_schedule(indices, order, schedule, 32, True, args.qt)
    attn()
    error = check_output(output, sparse_reference(q, k, v, indices, 32, True, 0.1), 'parts')
    timings = [[], []]
    for iteration in range(4):
        for i in (range(2) if iteration % 2 == 0 else reversed(range(2))):
            timings[i].append(1000 * graph_latency((prep, attn)[i]))
    report = dict(module=args.module, config=case, schedule='PASS', max_abs_error=error,
                  us=[statistics.median(t) for t in timings], rounds_us=timings)
    Path(args.output).write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report), flush=True)


if __name__ == '__main__':
    main()
