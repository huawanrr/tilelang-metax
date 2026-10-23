"""Bound V/output lifetime and stage each finished PV tile immediately."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_packed_exchange import NAME, nodes, transform as exchange_transform

HERE=Path(__file__).resolve().parent


def transform(fn, q_exchange, width):
    fn=ast.parse(exchange_transform(fn,q_exchange,0)).body[0]
    width_assignment=next(n for n in fn.body if isinstance(n,ast.Assign) and ast.unparse(n.targets[0])=='W')
    width_assignment.value=ast.parse(f'min(width, D, {width})',mode='eval').body
    kernel=next(n for n in fn.body if isinstance(n,ast.FunctionDef))
    scope=next(n for n in kernel.body if isinstance(n,ast.With))
    # Only the output register tile changes shape; its MMA ownership stays.
    for n in scope.body:
        if isinstance(n,ast.Assign) and ast.unparse(n.targets[0])=='output_reg':
            n.value=ast.parse('T.alloc_fragment([G, W], T.float16)',mode='eval').body
        if isinstance(n,ast.Expr) and isinstance(n.value,ast.Call) and ast.unparse(n.value.func)=='T.annotate_layout':
            mapping=n.value.args[0]
            for key,value in zip(mapping.keys,mapping.values):
                if ast.unparse(key)=='output_reg':
                    value.args[0]=ast.parse('[G, W]',mode='eval').body
    guard=next(n for n in scope.body if isinstance(n,ast.If) and ast.unparse(n.test)=='valid')
    vo=next(n for n in guard.body if isinstance(n,ast.For) and ast.unparse(n.iter)=='T.unroll(D // W)')
    guard.body.remove(vo)
    guard.orelse=[]
    clear=vo.body[0]
    assert ast.unparse(clear)=='T.clear(out)'
    cast=vo.body[-1]
    assert isinstance(cast,ast.For) and ast.unparse(cast.target)=='cast_chunk'
    cast=ast.parse(ast.unparse(cast).replace('vo * W + cast_chunk * 16','cast_chunk * 16')).body[0]
    compute=ast.If(test=ast.Name(id='valid',ctx=ast.Load()),body=vo.body[1:-1],orelse=[])
    vo.body=[clear,compute,cast]+nodes('''
T.sync_warp()
T.copy(output_reg, output_shared)
T.sync_warp()
T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, vo * W:(vo + 1) * W])
''')
    pos=next(i for i,n in enumerate(scope.body) if isinstance(n,ast.Assign) and ast.unparse(n.targets[0])=='output_shared')
    scope.body[pos:]=nodes('''
output_shared = T.alloc_shared([G, W], T.float16)
T.annotate_layout({output_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)})
''')+[vo]
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source=(HERE/'baseline.py').read_text()
    fn=next(n for n in ast.parse(source).body if isinstance(n,ast.FunctionDef) and n.name==NAME)
    old=ast.get_source_segment(source,fn)
    records=[]
    for q_exchange,width in ((1,32),(1,64),(0,32),(0,64)):
        result=source.replace(old,transform(fn,q_exchange,width),1)
        ast.parse(result)
        path=HERE/f'packed_stream_q{q_exchange}_w{width}.py'
        with path.open('x') as f: f.write(result)
        records.append(dict(path=path.name,q_exchange=q_exchange,pv_width=width,
                            sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE/'packed_stream_manifest.json').write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),variants=records,
        method='Full QK and identical normalization; independent PV column tiles immediately cast/staged/stored. Every output element has one writer. RAW/WAR warp fences protect shared tile reuse.'),indent=2)+'\n')
    print('Generated',len(records),'bounded-output-lifetime variants')


if __name__=='__main__':
    main()
