"""Per-kernel profile of the current mla.py: main vs merge kernel time per case."""
import importlib
import json
import sys
from collections import defaultdict

import torch

cases = json.loads(open('test_cases_mla_batch_ctx.json').read())
which = [int(x) for x in sys.argv[1].split(',')] if len(sys.argv) > 1 else [1, 3, 22, 31]
mods = sys.argv[2].split(',') if len(sys.argv) > 2 else ['mla']

for name in mods:
    mod = importlib.import_module(name)
    for cid in which:
        c = cases[cid - 1]
        b, h, n, d, p = [c[k] for k in ('batch', 'heads', 'kv_ctx', 'dim', 'pe_dim')]
        g = torch.Generator(device='cuda').manual_seed(0)
        kw = dict(device='cuda', dtype=torch.float16, generator=g)
        xs = (torch.randn(b, h, d, **kw), torch.randn(b, h, p, **kw),
              torch.randn(b, n, 1, d, **kw), torch.randn(b, n, 1, p, **kw))
        out = torch.empty_like(xs[0])
        params = [b, h, c['kv_heads'], n, d, p]
        fn = lambda: mod.run_kernel(*xs, out, *params)
        for _ in range(5):
            fn()
        torch.cuda.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph):
            for _ in range(10):
                fn()
        graph.replay()
        torch.cuda.synchronize()

        from torch.profiler import profile, ProfilerActivity
        with profile(activities=[ProfilerActivity.CUDA]) as prof:
            graph.replay()
            torch.cuda.synchronize()
        agg = defaultdict(lambda: [0, 0.0])
        for e in prof.events():
            if e.device_type == torch.autograd.DeviceType.CUDA and e.self_device_time_total > 0:
                agg[e.name[:44]][0] += 1
                agg[e.name[:44]][1] += e.self_device_time_total
        print(f'== case {cid} (b={b} ctx={n}) module={name}')
        for k, (cnt, us) in sorted(agg.items(), key=lambda kv: -kv[1][1]):
            print(f'   {us:10.1f} us total  n={cnt:3d}  {us/cnt:9.2f} us/launch  {k}')
        del xs, out
        torch.cuda.empty_cache()
