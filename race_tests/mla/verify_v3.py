"""Standalone verification of mla_v3: correctness (two tolerance regimes) +
CUDA-graph latency on all 31 official cases, compared against the recorded
mla2-best and mla (submitted baseline) numbers.
"""
import json
import math
import statistics
from pathlib import Path

import torch

import mla_v3

CASES = json.loads(Path('test_cases_mla_batch_ctx.json').read_text())
PREV = json.loads(Path('regression_v2_full.json').read_text())


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


def latency(fn, repeat=100, samples=7):
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
    return statistics.median(times)


def main():
    ratios, ratios2 = [], []
    nfail = 0
    for c in CASES:
        cid = c['case_id']
        xs = inputs(c)
        ref = reference(xs)
        out = torch.empty_like(xs[0])
        params = [c[k] for k in ('batch', 'heads', 'kv_heads', 'kv_ctx', 'dim', 'pe_dim')]
        fn = lambda: mla_v3.run_kernel(*xs, out, *params)
        fn(); torch.cuda.synchronize()
        err = (out.float() - ref.float()).abs()
        tol_loose = (3e-4, 1e-3)
        strict_bad = (err > (1e-4 + 2e-4 * ref.float().abs())).sum().item()
        tmpl_bad = (err > (1e-4 + 2e-4 * ref.float().abs())).sum().item()
        ok_loose = torch.allclose(out, ref, atol=tol_loose[0], rtol=tol_loose[1])
        us = latency(fn)
        key = f'mla2|{cid}'
        prev = PREV.get(key)
        base = PREV.get(f'mla|{cid}')
        if prev:
            ratios.append(us / prev)
        if base:
            ratios2.append(us / base)
        flag = 'OK ' if (ok_loose and strict_bad == 0) else 'FAIL'
        if flag == 'FAIL':
            nfail += 1
        print(f'case {cid:2d} {flag} us={us:10.2f} max_abs={err.max().item():.2e} '
              f'strict_bad={strict_bad} vs_mla2={"-" if not prev else f"{us/prev:.3f}"} '
              f'vs_mla={"-" if not base else f"{us/base:.3f}"}', flush=True)
        del xs, ref, out
        torch.cuda.empty_cache()
    gm2 = math.exp(sum(math.log(r) for r in ratios) / len(ratios)) if ratios else float('nan')
    gmb = math.exp(sum(math.log(r) for r in ratios2) / len(ratios2)) if ratios2 else float('nan')
    print(f'\nvs mla2-best geomean: {gm2:.4f}   vs submitted-mla geomean: {gmb:.4f}   fails={nfail}')


if __name__ == '__main__':
    main()
