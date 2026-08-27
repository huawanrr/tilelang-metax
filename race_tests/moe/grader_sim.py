#!/usr/bin/env python3
"""Reproduce the grader's memory and call pattern, not just its shapes.

The CHECK-DIAG dumps show the grader holding **three** full argument sets
(`original`, `target`, `baseline`) -- 3 x 5.6 GiB of weights for Config3, which is
where its reported 22.2 G comes from -- and the reference harness clones the whole
input list inside the timed loop.  Our own harness allocates one set and clones
nothing, so two things the grader does are untested locally:

  * the caching allocator works against a nearly full device, and
  * `run_kernel` may be called with alternating shapes in one process.

The second is why this exists: `_get_workspace` used to drop its cache whenever
the shape changed, so alternating configs meant a free plus a fresh `torch.empty`
of tens of megabytes on every call.  `--alternate` measures exactly that.

    python grader_sim.py --cases oj1real,oj2real --sets 3
    python grader_sim.py --cases oj1real --alternate oj2real
"""
import argparse
import os

import torch

from local_bench import (ARG_ORDER, SENTINEL, build_case, check_reference,
                         check_untouched, load_cases, load_module, time_fn)

GIB = float(1 << 30)


def clone_args(pos):
    return tuple(t.clone() for t in pos)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--module", default="moe.py")
    p.add_argument("--cases", default="oj1real")
    p.add_argument("--alternate", default=None,
                   help="second case to interleave call-by-call with the first")
    p.add_argument("--sets", type=int, default=3,
                   help="argument sets held resident, as the grader does")
    p.add_argument("--iters", type=int, default=20)
    p.add_argument("--warmup", type=int, default=6)
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()

    mod = load_module(a.module)
    dev = torch.device("cuda")
    names = [n for n in a.cases.split(",") if n]
    if a.alternate:
        names.append(a.alternate)

    built = {}
    for name in names:
        case = load_cases(a.configs, [name])[0]
        args, meta = build_case(case, dev)
        pos = tuple(args[k] for k in ARG_ORDER)
        out = torch.full_like(args["stacked_expert_tokens"], SENTINEL)
        # Extra resident copies of the inputs, to put the allocator under the same
        # pressure the grader does.  Held, never used.
        held = [clone_args(pos) for _ in range(max(0, a.sets - 1))]
        built[name] = (case, args, meta, pos, out, held)
        print(f"built {name}: {case.n_padded}x{case.dhidden} "
              f"sets={a.sets} reserved={torch.cuda.memory_reserved() / GIB:.2f} GiB")

    for name in names:
        case, args, meta, pos, out, _ = built[name]
        out.fill_(SENTINEL)
        mod.run_kernel(*pos, out)
        torch.cuda.synchronize()
        pad = check_untouched(out, meta)
        st = check_reference(out, args, meta)
        kern = time_fn(lambda: mod.run_kernel(*pos, out), a.warmup, a.iters)
        full = time_fn(lambda: mod.run_kernel(*clone_args(pos), out),
                       max(1, a.warmup // 2), max(3, a.iters // 2))
        print(f"{name:9s} {'PASS' if st['ok'] else 'FAIL'} "
              f"{'clean' if pad['ok'] else 'TOUCHED'}  "
              f"kernel {kern:7.3f} ms   +clone_data {full:7.3f} ms "
              f"(clone costs {full - kern:6.3f} ms)")

    if a.alternate:
        first, second = names[0], names[-1]
        p1, o1 = built[first][3], built[first][4]
        p2, o2 = built[second][3], built[second][4]

        def one_each():
            mod.run_kernel(*p1, o1)
            mod.run_kernel(*p2, o2)

        alt = time_fn(one_each, a.warmup, a.iters)
        solo = (time_fn(lambda: mod.run_kernel(*p1, o1), a.warmup, a.iters)
                + time_fn(lambda: mod.run_kernel(*p2, o2), a.warmup, a.iters))
        print(f"\ninterleaved {first}+{second}: {alt:7.3f} ms per pair"
              f"   vs {solo:7.3f} ms run separately"
              f"   -> interleaving costs {alt - solo:+.3f} ms")
        print("(a large positive number here means the workspace is being "
              "reallocated per call)")
    print(f"peak allocated {torch.cuda.max_memory_allocated() / GIB:.2f} GiB, "
          f"reserved {torch.cuda.memory_reserved() / GIB:.2f} GiB")


if __name__ == "__main__":
    main()
