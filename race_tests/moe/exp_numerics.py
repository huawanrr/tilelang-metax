#!/usr/bin/env python3
"""Numerical robustness of the submission across random data, not just one seed.

The OJ documents that each test point holds several groups of random data, and
suggests fp16 intermediate truncation as a cause of pass-on-some-fail-on-others.
This sweeps seeds and routing distributions on the graded layouts and reports the
worst deviation from a float32 reference against the grader's rtol=atol=0.05.

It also prints the `(block_m, tail_rows)` each group selects: those come from the
real group sizes, so different random data can legitimately run a different kernel,
which is a timing effect rather than a correctness one.

    python exp_numerics.py --cases oj1real,oj2real,oj3real --seeds 5
"""
import argparse
import dataclasses
import os

import torch

from local_bench import (ARG_ORDER, SENTINEL, build_case, check_reference,
                         check_untouched, load_cases, load_module)

ATOL = 0.05  # the grader's tolerance


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--module", default="submission.py")
    p.add_argument("--cases", default="oj1real,oj2real,oj3real")
    p.add_argument("--seeds", type=int, default=5)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()

    mod = load_module(a.module)
    dev = torch.device("cuda")
    print(f"tolerance the grader uses: atol=rtol={ATOL}")
    print(f"{'case':10s}{'seed':>7}{'block_m':>9}{'tail':>6}{'max_abs':>11}"
          f"{'max_rel':>10}{'|ref|max':>10}{'margin':>9}  padding")
    worst = 0.0
    for name in a.cases.split(","):
        base = load_cases(a.configs, [name])[0]
        for s in range(a.seeds):
            case = dataclasses.replace(base, seed=base.seed + 1013 * s)
            args, meta = build_case(case, dev)
            pos = tuple(args[k] for k in ARG_ORDER)
            out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
            bm, tr = mod._choose_block_m(args["group_sizes"], case.nroutedexperts,
                                         case.n_valid, case.num_blocks_m)
            mod.run_kernel(*pos, out)
            torch.cuda.synchronize()
            pad = check_untouched(out, meta)
            st = check_reference(out, args, meta, atol=ATOL, rtol=ATOL)
            worst = max(worst, st["max_abs"])
            print(f"{name:10s}{case.seed:>7}{bm:>9}{tr:>6}{st['max_abs']:>11.2e}"
                  f"{st['max_rel']:>10.2e}{st['ref_absmax']:>10.2f}"
                  f"{ATOL / max(st['max_abs'], 1e-12):>8.0f}x  "
                  f"{'clean' if pad['ok'] else 'TOUCHED'}"
                  f"{'' if st['ok'] else '   <-- WOULD FAIL'}")
            del args, meta, out, pos
            mod._WORKSPACE_CACHE.clear()
            mod._BLOCK_M_CACHE.clear()
            torch.cuda.empty_cache()
    print(f"\nworst deviation over every group: {worst:.2e}, "
          f"which is {ATOL / max(worst, 1e-12):.0f}x inside the tolerance")


if __name__ == "__main__":
    main()
