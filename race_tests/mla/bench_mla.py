"""Reproducible MLA correctness and graph-latency comparison."""
import argparse
import importlib
import json
import statistics
from pathlib import Path
import torch


def inputs(c, seed=0):
    g = torch.Generator(device='cuda').manual_seed(seed)
    b, h, n, d, p = [c[k] for k in ('batch', 'heads', 'kv_ctx', 'dim', 'pe_dim')]
    kw = dict(device='cuda', dtype=torch.float16, generator=g)
    return (torch.randn(b,h,d,**kw), torch.randn(b,h,p,**kw),
            torch.randn(b,n,1,d,**kw), torch.randn(b,n,1,p,**kw))


def reference(xs):
    q, qp, kv, kp = xs
    result = torch.empty_like(q)
    for b in range(q.shape[0]):
        k = kv[b,:,0].float()
        scores = (q[b].float() @ k.T + qp[b].float() @ kp[b,:,0].float().T)
        prob = torch.softmax(scores * (q.shape[-1] + qp.shape[-1]) ** -0.5, -1)
        result[b] = prob @ k
    return result


def latency(fn, repeat=100, samples=7):
    for _ in range(3): fn()
    torch.cuda.synchronize()
    graph = torch.cuda.CUDAGraph()
    with torch.cuda.graph(graph):
        for _ in range(repeat): fn()
    graph.replay()
    torch.cuda.synchronize()
    times = []
    for _ in range(samples):
        a,b = torch.cuda.Event(enable_timing=True),torch.cuda.Event(enable_timing=True)
        a.record(); graph.replay(); b.record(); b.synchronize()
        times.append(a.elapsed_time(b)*1000/repeat)
    return statistics.median(times)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--modules',default='baseline_mla,mla')
    ap.add_argument('--cases',default='1')
    ap.add_argument('--splits',default='')
    ap.add_argument('--repeat',type=int,default=100)
    ap.add_argument('--output')
    args=ap.parse_args()
    cases=json.loads(Path(__file__).with_name('test_cases_mla_batch_ctx.json').read_text())
    chosen=range(1,len(cases)+1) if args.cases=='all' else [int(x) for x in args.cases.split(',')]
    records=[]
    for cid in chosen:
        c=cases[cid-1]; xs=inputs(c); ref=reference(xs)
        for name in args.modules.split(','):
            mod=importlib.import_module(name)
            for split in ([int(x) for x in args.splits.split(',')] if args.splits else [None]):
                out=torch.empty_like(xs[0])
                params=[c[k] for k in ('batch','heads','kv_heads','kv_ctx','dim','pe_dim')]
                if split is None:
                    fn=lambda: mod.run_kernel(*xs,out,*params)
                else:
                    kernel=mod.flashattn(*params,32,16,split,(c['dim']+c['pe_dim'])**-0.5)
                    fn=lambda: kernel(*xs,out)
                fn(); torch.cuda.synchronize()
                err=(out.float()-ref.float()).abs()
                strict_bad = (err > (1e-4 + 2e-4 * ref.float().abs())).sum().item()
                torch.testing.assert_close(out,ref,atol=3e-4,rtol=1e-3)
                us=latency(fn,args.repeat)
                row=dict(case=cid,module=name,split=split,us=us,max_abs=err.max().item(),strict_bad=strict_bad,status='PASS_3e-4_1e-3')
                print(json.dumps(row),flush=True); records.append(row)
        del xs, ref
    if args.output: Path(args.output).write_text(json.dumps(records,indent=2)+'\n')


if __name__=='__main__': main()
