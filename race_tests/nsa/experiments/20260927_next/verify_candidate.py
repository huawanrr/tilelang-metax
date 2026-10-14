"""Check dispatch boundaries and per-call input freshness against the reference."""
import argparse
import json
import sys
from pathlib import Path

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from verify_nsa import check_case, edge_indices

p = argparse.ArgumentParser()
p.add_argument('module')
p.add_argument('--output', required=True)
args = p.parse_args()
module = load_module(args.module)

def extended_indices(idx):
    if idx.shape[-1] <= 8:
        return edge_indices(idx)
    base = edge_indices(idx[..., :8])
    return base.repeat(1, 1, 1, (idx.shape[-1] + 7) // 8)[..., :idx.shape[-1]]

cases = []
for d, t, h, bs, selected in [
    (32, 511, 2, 16, 1), (32, 512, 2, 16, 1), (32, 513, 2, 16, 1),
    (64, 127, 2, 16, 1), (64, 128, 2, 16, 1), (64, 129, 2, 16, 1),
    (128, 63, 2, 16, 1), (128, 64, 2, 16, 1), (128, 65, 2, 16, 1),
    (128, 1023, 2, 32, 1), (128, 1024, 2, 32, 1), (128, 1025, 2, 32, 1),
    (64, 37, 2, 16, 8), (64, 128, 2, 16, 8), (64, 129, 2, 16, 8),
    (64, 256, 2, 16, 8), (64, 257, 2, 16, 8),
    (64, 2047, 2, 16, 8), (64, 2048, 2, 16, 8), (64, 2049, 2, 16, 8),
    (64, 37, 2, 16, 9), (64, 37, 2, 16, 16),
]:
    for causal in (False, True):
        cases.append(dict(B=1, SEQ_LEN=t, H=h, HQ=h*16, D=d, S=selected,
                          block_size=bs, is_causal=causal))

rows = []
for case in cases:
    error = check_case(module, case, 39, None, extended_indices)
    row = dict(config=case, max_abs_error=error, status='PASS')
    rows.append(row)
    print(row, flush=True)

refresh = []
for b, t, h in [(1, 37, 2), (8, 513, 1)]:
    for causal in (False, True):
        case = dict(B=b, SEQ_LEN=t, H=h, HQ=h*16, D=64, S=8,
                    block_size=16, is_causal=causal)
        q, k, v, idx = make_inputs(case, seed=39)
        idx = edge_indices(idx)
        fn = module.native_sparse_attention(b, h*16, t, 64, causal,
            scale=None, block_size=16, groups=16, selected_blocks=8)
        output = torch.empty_like(q)
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=39+iteration)
                q.copy_(nq); k.copy_(nk); v.copy_(nv)
            expected = sparse_reference(q, k, v, idx, 16, causal, None)
            error = check_output(fn(q, k, v, idx), expected, 'factory refresh')
            module.run_kernel(q, k, v, idx, output, b, t, h, h*16,
                              64, 8, 16, causal, None)
            error = max(error, check_output(output, expected, 'run_kernel refresh'))
            row = dict(config=case, iteration=iteration, max_abs_error=error, status='PASS')
            refresh.append(row)
            print(row, flush=True)

Path(args.output).write_text(json.dumps(dict(boundaries=rows, refresh=refresh), indent=2)+'\n')
print(f'PASS: {len(rows)} boundary cases and {len(refresh)} refreshes, both interfaces', flush=True)
