#!/usr/bin/env python3
"""Repeated A/B of the stage-2/stage-1 tail split on one graded layout.

The gate in `_choose_block_m` enables the split only at `blocks >= 64`, which the
graded Config3 (96 blocks) clears and Config2 (48) does not.  Config2 was excluded
on a single local measurement showing +1.1%; Config3 has since gained a point on
the OJ, so the exclusion is worth re-deciding with repeats rather than one sample.

    python exp_tail.py --case oj2real
"""
import argparse
import os

import torch

from local_bench import (ARG_ORDER, SENTINEL, build_case, check_reference,
                         check_untouched, load_cases, load_module, time_fn)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--case", default="oj2real")
    p.add_argument("--module", default="moe.py")
    p.add_argument("--reps", type=int, default=3)
    p.add_argument("--iters", type=int, default=25)
    p.add_argument("--warmup", type=int, default=8)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()

    mod = load_module(a.module)
    dev = torch.device("cuda")
    case = load_cases(a.configs, [a.case])[0]
    args, meta = build_case(case, dev)
    pos = tuple(args[k] for k in ARG_ORDER)
    out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
    up = mod._get_workspace(args["stacked_expert_tokens"], case.dexpert)

    def measure(tail_rows, check):
        kern = mod._get_kernel(case.dhidden, case.dexpert, case.nroutedexperts,
                               case.n_padded, case.n_valid, case.num_blocks_m,
                               128, tail_rows)
        call = lambda: kern(*pos, up, out)
        out.fill_(SENTINEL)
        call()
        torch.cuda.synchronize()
        status = ""
        if check:
            pad = check_untouched(out, meta)
            st = check_reference(out, args, meta)
            status = (f"  {'PASS' if st['ok'] else 'FAIL'}/"
                      f"{'clean' if pad['ok'] else 'TOUCHED'}")
        return time_fn(call, a.warmup, a.iters), status

    print(f"{a.case}: E={case.nroutedexperts} blocks={case.num_blocks_m} "
          f"valid={case.n_valid} padded={case.n_padded}")
    tail_blocks = sum(1 for c in meta["counts"] if c > 0
                      and c - 128 * (-(-c // 128) - 1) <= 64)
    blocks = sum(-(-c // 128) for c in meta["counts"] if c > 0)
    print(f"blocks with <= 64 valid rows: {tail_blocks}/{blocks} "
          f"({100 * tail_blocks / blocks:.0f}%)")
    for rep in range(a.reps):
        off, s_off = measure(0, rep == 0)
        on, s_on = measure(64, rep == 0)
        win = "ON " if on < off else "OFF"
        print(f"  rep{rep}: off {off:7.3f}{s_off}   on {on:7.3f}{s_on}   "
              f"{win} by {abs(on - off) / off * 100:4.1f}%")


if __name__ == "__main__":
    main()
