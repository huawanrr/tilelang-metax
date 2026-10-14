"""Time the baseline kernel and nsa.py variants on selected cases.

Examples:
    python sweep_nsa.py --cases 6,12,70,104
    python sweep_nsa.py --cases 74-82 --variants opt,st1,st3
    python sweep_nsa.py --cases 6 --variants opt,t64r --check
"""

import argparse
import json
import sys
from functools import partial
from pathlib import Path

import benchmark_nsa as bn
from nsa import native_sparse_attention
from test_tilelang_nsa_fwd import native_sparse_attention_baseline

CASE_PATH = Path(__file__).with_name("test_cases_nsa_fwd.json")

VARIANTS = {
    # stage_regs (registers stage the global loads) x o_stage (shared stages
    # the output write) factorial, both on the single-block kernel.
    "os": native_sparse_attention,                                    # sr+os
    "os_sr0": partial(native_sparse_attention, stage_regs=False),
    "d": partial(native_sparse_attention, o_stage=False),
    "d_sr0": partial(native_sparse_attention, stage_regs=False, o_stage=False),
    "t64r": partial(native_sparse_attention, kv_reuse=True),
    "t32": partial(native_sparse_attention, threads=32),
    "st1": partial(native_sparse_attention, num_stages=1),
    "st3": partial(native_sparse_attention, num_stages=3),
    # online-kernel variants: num_stages x per-iteration register staging
    "st2_0": partial(native_sparse_attention, num_stages=2, stage_regs=False),
    "st2_r": partial(native_sparse_attention, num_stages=2, stage_regs=True),
    "st1_0": partial(native_sparse_attention, num_stages=1, stage_regs=False),
    "st1_r": partial(native_sparse_attention, num_stages=1, stage_regs=True),
    # Q via fragment A (single-block kernel only)
    "qf": partial(native_sparse_attention, q_frag=True),
}


def parse_range(value):
    out = []
    for part in value.split(","):
        part = part.strip()
        if "-" in part:
            lo, hi = part.split("-")
            out.extend(range(int(lo), int(hi) + 1))
        else:
            out.append(int(part))
    return list(dict.fromkeys(out))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cases", required=True, help="1-based, e.g. 6,12,70-82")
    parser.add_argument("--variants", default="opt,t64r")
    parser.add_argument("--repeat", type=int, default=100)
    parser.add_argument("--samples", type=int, default=7)
    parser.add_argument("--scale", type=float, default=0.1)
    parser.add_argument("--check", action="store_true", help="verify each variant against the reference")
    args = parser.parse_args()

    with CASE_PATH.open() as source:
        cases = json.load(source)
    indices = parse_range(args.cases)
    bad = [i for i in indices if not 1 <= i <= len(cases)]
    if bad:
        sys.exit(f"case indices out of range: {bad}")
    names = args.variants.split(",")
    unknown = [n for n in names if n not in VARIANTS]
    if unknown:
        sys.exit(f"unknown variants: {unknown} (have {sorted(VARIANTS)})")

    print(f"{'case':>4} {'shape':<44} {'base_us':>8} " + " ".join(f"{n:>8}" for n in names) + " " + " ".join(f"{n+'/base':>9}" for n in names))
    for i in indices:
        case = cases[i - 1]
        shape = (f"B{case['B']} T{case['SEQ_LEN']} D{case['D']} S{case['S']} "
                 f"bs{case['block_size']} g{case['HQ'] // case['H']} c{int(case['is_causal'])}")
        inputs = bn.make_inputs(case, 0)
        base = bn.compile_kernel(native_sparse_attention_baseline, case, args.scale)
        base_us = bn.graph_latency(base, inputs, args.repeat, args.samples) * 1e3

        cells, ratios = [], []
        for name in names:
            kernel = bn.compile_kernel(VARIANTS[name], case, args.scale)
            if args.check:
                ref = bn.sparse_reference(*inputs, case["block_size"], case["is_causal"], args.scale)
                bn.check_output(kernel(*inputs), ref, f"case {i} {name}")
            us = bn.graph_latency(kernel, inputs, args.repeat, args.samples) * 1e3
            cells.append(us)
            ratios.append(base_us / us)
        print(f"{i:>4} {shape:<44} {base_us:>8.2f} " + " ".join(f"{c:>8.2f}" for c in cells) + " " + " ".join(f"{r:>8.3f}x" for r in ratios), flush=True)


if __name__ == "__main__":
    main()
