"""Measure the real public dispatcher with a no-op compiled callable.

This isolates CPU lookup overhead. It is not a GPU or official score test.
"""
import ast
import hashlib
import json
import os
from pathlib import Path
import statistics
import time
from types import SimpleNamespace

HERE=Path(__file__).resolve().parent
os.sched_setaffinity(0,{max(os.sched_getaffinity(0))})


class Index:
    dtype='int32'
    def is_contiguous(self):return True


def context(path):
    tree=ast.parse(path.read_text())
    fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='run_kernel')
    def noop(*values):pass
    ns=dict(torch=SimpleNamespace(int32='int32'),_KERNEL_CACHE={},_get_kernel=lambda *args:noop)
    exec(compile(ast.Module(body=[fn],type_ignores=[]),str(path),'exec'),ns)
    return ns


paths=[HERE/'baseline.py',HERE/'control.py',HERE/'host_last.py']
contexts=[context(p) for p in paths]
index=Index()
values=(object(),object(),object(),index,object())
shapes=[(1,64,1,16,32,1,16,True,0.1),(1,128,1,16,64,1,16,True,0.1)]
args=[values+s for s in shapes]
rows=[]
for mode in ('repeated','alternating'):
    for ns in contexts:
        for call in args:ns['run_kernel'](*call)
    trials=[[] for _ in paths]
    count=100000
    for trial in range(24):
        order=list(range(len(paths))) if trial%2==0 else list(reversed(range(len(paths))))
        for i in order:
            fn=contexts[i]['run_kernel']
            start=time.perf_counter_ns()
            if mode=='repeated':
                for _ in range(count):fn(*args[0])
            else:
                for j in range(count):fn(*args[j%2])
            trials[i].append((time.perf_counter_ns()-start)/count)
    medians=[statistics.median(t) for t in trials]
    rows.append(dict(mode=mode,median_ns=medians,speedup=[medians[0]/v for v in medians],trials_ns=trials))
report=dict(method='CPU dispatcher only; no-op device callable; alternating module order',
            sources={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},rows=rows)
with (HERE/'host_last_cpu.json').open('x') as f:
    json.dump(report,f,indent=2)
    f.write('\n')
for r in rows:print(r['mode'],r['median_ns'],r['speedup'])
