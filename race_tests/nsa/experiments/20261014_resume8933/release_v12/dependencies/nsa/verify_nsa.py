"""Check both public NSA interfaces against the independent float32 reference."""

import argparse
import json
from pathlib import Path

import torch

from benchmark_nsa import make_inputs, sparse_reference, check_output, parse_cases
from experiment_bench import load_module


@torch.no_grad()
def check_case(module, case, seed, scale, indices=None):
    inputs = list(make_inputs(case, seed=seed))
    if indices is not None:
        inputs[3] = indices(inputs[3])
    expected = sparse_reference(*inputs, case["block_size"], case["is_causal"], scale)
    factory = module.native_sparse_attention(
        case["B"], case["HQ"], case["SEQ_LEN"], case["D"], case["is_causal"],
        scale=scale, block_size=case["block_size"], groups=case["HQ"] // case["H"],
        selected_blocks=case["S"],
    )
    error = check_output(factory(*inputs), expected, "factory")
    output = torch.full_like(inputs[0], float("nan"))
    module.run_kernel(
        *inputs, output, case["B"], case["SEQ_LEN"], case["H"], case["HQ"],
        case["D"], case["S"], case["block_size"], case["is_causal"], scale,
    )
    error = max(error, check_output(output, expected, "run_kernel"))
    return error


def edge_indices(indices):
    batch, length, heads, selected = indices.shape
    patterns = torch.tensor(
        [[-1, -2, 99, 37, -1, 99, -1, 37],
         [2, 0, -1, 37, 2, 0, -1, 37],
         [0, 0, 1, 2, 1, 2, 0, 0]], dtype=torch.int64, device=indices.device,
    )[:, :selected]
    # An int64 expanded view exercises both dtype conversion and noncontiguous input.
    return patterns[torch.arange(length, device=indices.device) % 3].view(
        1, length, 1, selected).expand(batch, length, heads, selected)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module", nargs="?", default="nsa.py")
    p.add_argument("--cases", default="all")
    p.add_argument("--extras", action="store_true")
    p.add_argument("--output", default="verification_nsa.json")
    args = p.parse_args()
    module = load_module(args.module)
    cases = json.loads(Path(__file__).with_name("test_cases_nsa_fwd.json").read_text())
    rows = []
    for index in parse_cases(args.cases, len(cases)):
        error = check_case(module, cases[index - 1], seed=0, scale=0.1)
        row = dict(case=index, max_abs_error=error, status="PASS")
        rows.append(row)
        print(json.dumps(row), flush=True)
    if args.extras:
        for selected in (1, 2, 4, 8):
            for dim, bs in ((64, 16), (128, 32)):
                for causal in (True, False):
                    case = dict(B=2, SEQ_LEN=37, H=2, HQ=32, D=dim, S=selected,
                                block_size=bs, is_causal=causal)
                    error = check_case(module, case, 123, None, edge_indices)
                    row = dict(case=f"edge_S{selected}_D{dim}_BS{bs}_causal{causal}",
                               max_abs_error=error, status="PASS")
                    rows.append(row)
                    print(json.dumps(row), flush=True)
    Path(args.output).write_text(json.dumps(rows, indent=2) + "\n")
    print(f"PASS: {len(rows)} cases, factory and run_kernel", flush=True)


if __name__ == "__main__":
    main()
