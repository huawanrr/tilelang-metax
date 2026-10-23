"""Sweep runner: bench a list of modules over representative cases, CUDA-graph timed.

Usage: python sweep.py --modules mla,mla2 --cases 1,3,6,12,17,22,26,27,31
Prints per-case us and geomean vs the first module (baseline).
"""
import argparse
import importlib
import json
import math
import statistics
from pathlib import Path

import torch


def inputs(c, seed=0):
    g = torch.Generator(device='cuda').manual_seed(seed)
    b, h, n, d, p = [c[k] for k in ('batch', 'heads', 'kv_ctx', 'dim', 'pe_dim')]
    kw = dict(device='cuda', dtype=torch.float16, generator=g)
    return (torch.randn(b, h, d, **kw), torch.randn(b, h, p, **kw),
            torch.randn(b, n, 1, d, **kw), torch.randn(b, n, 1, p, **kw))


def reference(xs):
    q, qp, kv, kp = xs
    result = torch.empty_like(q)
    for b in range(q.shape[0]):
        k = kv[b, :, 0].float()
        scores = (q[b].float() @ k.T + qp[b].float() @ kp[b, :, 0].float().T)
        prob = torch.softmax(scores * (q.shape[-1] + qp.shape[-1]) ** -0.5, -1)
        result[b] = prob @ k
    return result


def latency(fn, repeat=100, samples=7, agg='median'):
    for _ in range(3):
        fn()
    torch.cuda.synchronize()
    graph = torch.cuda.CUDAGraph()
    with torch.cuda.graph(graph):
        for _ in range(repeat):
            fn()
    graph.replay()
    torch.cuda.synchronize()
    times = []
    for _ in range(samples):
        a, b = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
        a.record(); graph.replay(); b.record(); b.synchronize()
        times.append(a.elapsed_time(b) * 1000 / repeat)
    return min(times) if agg == 'min' else statistics.median(times)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--modules', default='mla,mla2')
    ap.add_argument('--cases', default='1,3,6,12,17,22,26,27,31')
    ap.add_argument('--repeat', type=int, default=100)
    ap.add_argument('--cfg', default='', help='mla2._CFG override: key=val,key2=val2')
    ap.add_argument('--agg', default='median')
    ap.add_argument('--output')
    args = ap.parse_args()

    cases = json.loads(Path('test_cases_mla_batch_ctx.json').read_text())
    chosen = [int(x) for x in args.cases.split(',')]
    modules = {}
    for name in args.modules.split(','):
        modules[name] = importlib.import_module(name)
    if args.cfg:
        for kv in args.cfg.split(','):
            k, v = kv.split('=')
            try:
                v = int(v)
            except ValueError:
                pass
            modules['mla2']._CFG[k] = v
        print('mla2 overrides:', modules['mla2']._CFG)

    results = {}
    base = {}
    for cid in chosen:
        c = cases[cid - 1]
        xs = inputs(c)
        ref = reference(xs)
        params = [c[k] for k in ('batch', 'heads', 'kv_heads', 'kv_ctx', 'dim', 'pe_dim')]
        for name, mod in modules.items():
            out = torch.empty_like(xs[0])
            fn = lambda: mod.run_kernel(*xs, out, *params)
            fn(); torch.cuda.synchronize()
            err = (out.float() - ref.float()).abs()
            strict_bad = (err > (1e-4 + 2e-4 * ref.float().abs())).sum().item()
            ok = torch.allclose(out, ref, atol=3e-4, rtol=1e-3)
            us = latency(fn, args.repeat, samples=15, agg=args.agg)
            results[(name, cid)] = us
            if name == args.modules.split(',')[0]:
                base[cid] = us
            print(f'case {cid:2d} b={c["batch"]:2d} ctx={c["kv_ctx"]:5d}  {name:12s} {us:10.2f} us  bad={strict_bad} ok={ok}', flush=True)
        del xs, ref
        torch.cuda.empty_cache()

    print('\n== geomean ratio vs baseline (lower is better)')
    for name in modules:
        ratios = [results[(name, c)] / base[c] for c in chosen]
        gm = math.exp(sum(math.log(r) for r in ratios) / len(ratios))
        print(f'   {name:12s} geomean={gm:.4f}  n_cases={len(ratios)}')
    if args.output:
        Path(args.output).write_text(json.dumps({f'{n}|{c}': v for (n, c), v in results.items()}, indent=1))


if __name__ == '__main__':
    main()
