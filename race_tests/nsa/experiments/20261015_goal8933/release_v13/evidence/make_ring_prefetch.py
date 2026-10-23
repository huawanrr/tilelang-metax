"""Interleave ordinary K/V register loads with successive sparse block work.

No asynchronous primitive is used. Every selected block is read from the
current packed input; the original mask, arithmetic and output remain.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
NAMES={
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def nodes(s):
    return ast.parse(s).body


def rename(node, names, step=None):
    class R(ast.NodeTransformer):
        def visit_Name(self,n):
            if n.id=='s' and step is not None:
                return ast.copy_location(ast.Constant(step),n)
            if n.id in names:
                return ast.copy_location(ast.Name(id=names[n.id],ctx=n.ctx),n)
            return n
    return R().visit(copy.deepcopy(node))


def prove(kslots,vslots):
    k=list(range(kslots));v=list(range(vslots))
    reads=[]
    for step in range(8):
        assert k[step%kslots]==step and v[step%vslots]==step
        reads.append(dict(step=step,key_slot=step%kslots,value_slot=step%vslots))
        if step+kslots<8:k[step%kslots]=step+kslots
        if step+vslots<8:v[step%vslots]=step+vslots
    return reads


def transform(fn,kslots,vslots,early):
    fn=copy.deepcopy(fn)
    fn.name+='_ring_v13'
    fn.body[:0]=nodes('assert selected_blocks == 8')
    kernel=next(n for n in fn.body if isinstance(n,ast.FunctionDef))
    scope=next(n for n in kernel.body if isinstance(n,ast.With))
    algorithm=next(n for n in scope.body if isinstance(n,ast.If)
        and ast.unparse(n.test)=='prefetch_depth == 1')
    serial=algorithm.body[0]
    assert isinstance(serial,ast.For) and ast.unparse(serial.target)=='s'
    guard=serial.body[1]
    assert isinstance(guard,ast.If)
    kload,vload=guard.body[:2]
    assert 'K_reg[j, d] = K[' in ast.unparse(kload)
    assert 'V_reg[j, d] = V[' in ast.unparse(vload)
    compute=guard.body[2:]
    assert 'qk.mma' in ast.unparse(compute[1]) and 'pv.mma' in ast.unparse(compute[-1])
    declarations=[]
    for tensor,slots,dim,emitter in [('K',kslots,'BK','qk'),('V',vslots,'BV','pv')]:
        for slot in range(slots):
            name=f'{tensor}_ring{slot}'
            declarations+=nodes(f'''{name} = T.alloc_fragment([BS, {dim}], T.float16)
T.annotate_layout({{{name}: {emitter}.make_mma_load_layout({name}, "B")}})
''')
    scope.body[:0]=declarations

    def load(tensor,slot,step):
        position=f'ring_{tensor.lower()}_position{step}'
        mapping={'i_s':position,f'{tensor}_reg':f'{tensor}_ring{slot}'}
        condition=rename(guard.test,mapping)
        body=[rename(kload if tensor=='K' else vload,mapping)]
        return nodes(f'{position} = indices[{step}]')+[ast.If(test=condition,body=body,orelse=[])]

    replacement=[]
    for slot in range(kslots):replacement+=load('K',slot,slot)
    for slot in range(vslots):replacement+=load('V',slot,slot)
    for step in range(8):
        position=f'ring_position{step}'
        mapping={'i_s':position,'K_reg':f'K_ring{step%kslots}','V_reg':f'V_ring{step%vslots}'}
        body=[rename(n,mapping,step) for n in compute]
        test=rename(guard.test,mapping,step)
        replacement+=nodes(f'{position} = indices[{step}]')
        if early:
            replacement.append(ast.If(test=copy.deepcopy(test),body=body[:2],orelse=[]))
            if step+kslots<8:replacement+=load('K',step%kslots,step+kslots)
            replacement.append(ast.If(test=test,body=body[2:],orelse=[]))
        else:
            replacement.append(ast.If(test=test,body=body,orelse=[]))
            if step+kslots<8:replacement+=load('K',step%kslots,step+kslots)
        if step+vslots<8:replacement+=load('V',step%vslots,step+vslots)
    at=scope.body.index(algorithm)
    scope.body[at:at+1]=replacement
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source=(HERE/'baseline.py').read_text()
    records=[]
    for kslots,vslots,early in [(2,1,False),(2,2,False),(2,2,True),(3,1,False),(3,2,False),(3,2,True)]:
        result=source
        additions=[]
        for fn in ast.parse(source).body:
            if isinstance(fn,ast.FunctionDef) and fn.name in NAMES:
                additions.append(transform(fn,kslots,vslots,early))
                marker=f'                    online_builder = {fn.name}\n'
                assert result.count(marker)==1
                result=result.replace(marker,f'                    online_builder = {fn.name}_ring_v13\n',1)
        assert len(additions)==2
        at=result.index('def _get_kernel(')
        result=result[:at]+'\n\n'.join(additions)+'\n\n'+result[at:]
        path=HERE/f'ring_k{kslots}_v{vslots}_e{int(early)}.py'
        compile(result,str(path),'exec')
        with path.open('x') as f:f.write(result)
        records.append(dict(file=path.name,sha256=hashlib.sha256(result.encode()).hexdigest(),
            key_slots=kslots,value_slots=vslots,key_load_after_qk=early,slot_proof=prove(kslots,vslots)))
    with (HERE/'ring_manifest.json').open('x') as f:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),variants=records,
            scope='Existing default large S8 paths only. Original per-block masks, sum/PV order, packing and output.'),f,indent=2)
        f.write('\n')
    print('Generated',len(records),'ring prefetch variants')


if __name__=='__main__':main()
