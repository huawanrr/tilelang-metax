"""Recheck sparse-block loop expansion with the v11 FP32 denominator."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
NAME='native_sparse_attention_staged_sparse_blocks_sum_v11'
source=(HERE/'baseline.py').read_text()
fn=next(n for n in ast.parse(source).body if isinstance(n,ast.FunctionDef) and n.name==NAME)
old=ast.get_source_segment(source,fn)
records=[]
for name,iteration in [('serial','T.serial(S)'),('unroll1','T.unroll(S, unroll_factor=1)'),
                       ('unroll4','T.unroll(S, unroll_factor=4)'),('full','T.unroll(S)')]:
    node=copy.deepcopy(fn)
    node.decorator_list=[]
    loop=next(n for n in ast.walk(node) if isinstance(n,ast.For)
              and ast.unparse(n.iter)=='T.unroll(S, unroll_factor=2)')
    loop.iter=ast.parse(iteration,mode='eval').body
    result=source.replace(old,ast.unparse(ast.fix_missing_locations(node)),1)
    path=HERE/f's4_{name}.py'
    compile(result,str(path),'exec')
    with path.open('x') as f:f.write(result)
    records.append(dict(file=path.name,sha256=hashlib.sha256(result.encode()).hexdigest(),iteration=iteration))
with (HERE/'s4_loops_manifest.json').open('x') as f:
    json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),variants=records,
                   changed_function=NAME,arithmetic_and_dispatch_unchanged=True),f,indent=2)
    f.write('\n')
cases=json.loads((HERE/'cases.json').read_text())
for b,t in [(1,128),(1,256),(1,512),(1,1024),(2,256),(4,256),(2,512)]:
    cases[f's4_b{b}_t{t}']=dict(B=b,SEQ_LEN=t,H=1,HQ=16,D=64,S=4,block_size=16,is_causal=True)
with (HERE/'s4_cases.json').open('x') as f:
    json.dump(cases,f,indent=2)
    f.write('\n')
print('Generated four S4 loop probes')
