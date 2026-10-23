#!/usr/bin/env python3
"""Summarise one mcTracer Chrome-trace JSON: per-kernel time, registers, shared memory.

mcTracer is the only profiler on this box.  Kernel events are the ones with `cat == "0"`
and `dur` in nanoseconds; `args.mem` carries `registers_per_thread`, `dynamic_shared`
and `static_shared`, which is what the occupancy argument in the design document rests
on (250 registers per thread and 32 KiB of LDS = two blocks per CU).

    python trace_summary.py /tmp/moe_submit_trace_oj3exact/*.json
"""
import collections
import json
import sys


def main(paths):
    for path in paths:
        with open(path) as fh:
            doc = json.load(fh)
        events = doc["traceEvents"] if isinstance(doc, dict) else doc
        agg = collections.OrderedDict()
        for ev in events:
            if str(ev.get("cat")) != "0":
                continue
            mem = (ev.get("args") or {}).get("mem") or {}
            key = (ev.get("name"), mem.get("registers_per_thread"),
                   mem.get("dynamic_shared"), mem.get("static_shared"))
            slot = agg.setdefault(key, [0, 0.0])
            slot[0] += 1
            slot[1] += ev.get("dur", 0)
        total = 0.0
        for (name, regs, dyn, static), (n, dur) in agg.items():
            if not str(name).startswith("kernel_kernel"):
                continue
            total += dur / 1e6 / max(n, 1)
            print("%-16s launches=%-4d %8.3f ms/launch  regs/thread=%-4s "
                  "shared=%s+%s B" % (name, n, dur / 1e6 / max(n, 1), regs, dyn, static))
        print("%-16s %27.3f ms/call" % ("SUM", total))


if __name__ == "__main__":
    main(sys.argv[1:])
