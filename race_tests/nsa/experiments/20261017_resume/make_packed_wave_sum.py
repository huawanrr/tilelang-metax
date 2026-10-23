"""Spell out the existing single-wave sum without an unused LDS workspace."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
NAMES={'native_sparse_attention_single_packed_qo_v2_mathcast_block_joint',
       'native_sparse_attention_single_packed_qo_v2_mathcast'}


def nodes(s):
    return ast.parse(s).body


class Rewrite(ast.NodeTransformer):
    def __init__(self,mode):
        self.mode=mode

    def visit_Expr(self,node):
        if isinstance(node.value,ast.Call) and ast.unparse(node.value.func)=='T.reduce_sum' and ast.unparse(node.value.args[0])=='scores':
            assert ast.unparse(node.value.args[1])=='denom'
            text='''
packed_sum_local[0] = T.float32(0.0)
for reduce_element in T.unroll(4):
    for reduce_chunk in T.unroll(BS // 16):
        packed_sum_local[0] += scores[T.get_thread_binding() % 16, reduce_chunk * 16 + T.get_thread_binding() // 16 * 4 + reduce_element]
'''
            for delta in (32,16):
                call=(f'T.shfl_xor(packed_sum_local[0], {delta}, 64, 18446744073709551615)' if self.mode=='xor'
                      else f'T.shfl_sync(packed_sum_local[0], T.get_thread_binding() ^ {delta}, 64, 18446744073709551615)')
                text+=f'packed_sum_local[0] = packed_sum_local[0] + {call}\n'
            return nodes(text)
        return self.generic_visit(node)

    def visit_For(self,node):
        if (ast.unparse(node.iter)=='T.Parallel(G)' and len(node.body)==1
            and isinstance(node.body[0],ast.Assign) and ast.unparse(node.body[0].targets[0])=='inv[i]'):
            return nodes('packed_sum_local[0] = T.if_then_else(packed_sum_local[0] > 0, 1.0 / packed_sum_local[0], 0.0)')
        return self.generic_visit(node)

    def visit_Subscript(self,node):
        if isinstance(node.value,ast.Name) and node.value.id=='inv':
            return ast.copy_location(ast.parse('packed_sum_local[0]',mode='eval').body,node)
        return self.generic_visit(node)


def transform(fn,mode):
    fn=copy.deepcopy(fn)
    fn.decorator_list=[]
    kernel=next(n for n in fn.body if isinstance(n,ast.FunctionDef))
    scope=next(n for n in kernel.body if isinstance(n,ast.With))
    scope.body[:0]=nodes('packed_sum_local = T.alloc_local([1], T.float32)')
    fn=Rewrite(mode).visit(fn)
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source=(HERE/'baseline.py').read_text()
    records=[]
    for mode in ('xor','index'):
        result=source
        for fn in ast.parse(source).body:
            if isinstance(fn,ast.FunctionDef) and fn.name in NAMES:
                result=result.replace(ast.get_source_segment(source,fn),transform(fn,mode),1)
        ast.parse(result)
        path=HERE/f'packed_sum_{mode}.py'
        with path.open('x') as f: f.write(result)
        records.append(dict(path=path.name,mode=mode,sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE/'packed_sum_manifest.json').write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),variants=records,
        functions=sorted(NAMES),local_order='for element in 0..3, for chunk in 0..BS/16-1',
        wave_order=[32,16],reference='Actual v17 generated C++ and maca/reduce.h; identical FP32 additions and reciprocal guard.'),indent=2)+'\n')
    print('Generated two explicit single-wave sum probes')


if __name__=='__main__':
    main()
