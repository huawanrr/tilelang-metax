"""Accumulate the denominator from the actual PV half weights using FP32 MMA.

This changes the rounding point of denominator inputs. Independent FP32
reference checks use the unchanged atol=rtol=1e-2. The numerator, masks,
indices, load schedule and alternating PV accumulators remain unchanged.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
NAMES={'native_sparse_attention_online_packed_batch_minor_o_v2_mathcast',
       'native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast'}


def nodes(s):
    return ast.parse(s).body


class Rewrite(ast.NodeTransformer):
    def visit_For(self,node):
        if (ast.unparse(node.iter)=='T.Parallel(G, BS)' and len(node.body)==1
            and isinstance(node.body[0],ast.AugAssign) and ast.unparse(node.body[0].target)=='sum_acc[i, j]'):
            return None
        if ast.unparse(node.iter)=='T.Parallel(G)' and len(node.body)==1 and isinstance(node.body[0],ast.Assign) and ast.unparse(node.body[0].targets[0])=='inv_sum[i]':
            return nodes('''
den_value = denominator_acc[T.get_thread_binding() % 16, T.get_thread_binding() // 16 * 4]
den_inverse[0] = T.if_then_else(den_value > 0, 1.0 / den_value, 0.0)
''')
        return self.generic_visit(node)

    def visit_Expr(self,node):
        if isinstance(node.value,ast.Call):
            name=ast.unparse(node.value.func)
            if name=='T.reduce_sum' and ast.unparse(node.value.args[0])=='sum_acc':
                return None
            if name=='T.fill' and ast.unparse(node.value.args[0])=='sum_acc':
                return nodes('T.clear(denominator_acc)')
            if name=='pv.mma':
                assert ast.unparse(node.value.args[0])=='acc_s_cast'
                ki=ast.unparse(node.value.args[3])
                return [node]+nodes(f'denominator_mma.mma(acc_s_cast, denominator_one, denominator_acc, {ki})')
        return self.generic_visit(node)

    def visit_Subscript(self,node):
        if isinstance(node.value,ast.Name) and node.value.id=='inv_sum':
            return ast.copy_location(ast.parse('den_inverse[0]',mode='eval').body,node)
        return self.generic_visit(node)


def transform(fn):
    fn=copy.deepcopy(fn)
    fn.decorator_list=[]
    kernel=next(n for n in fn.body if isinstance(n,ast.FunctionDef))
    pos=fn.body.index(kernel)
    fn.body[pos:pos]=nodes('''
denominator_mma = TensorCoreIntrinEmitter(a_dtype="float16", b_dtype="float16", accum_dtype="float32", a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=16, chunk=BS, k_pack=1)
''')
    scope=next(n for n in kernel.body if isinstance(n,ast.With))
    scope.body[:0]=nodes('''
denominator_one = T.alloc_local([4], T.float16)
denominator_acc = T.alloc_fragment([G, 16], T.float32)
den_inverse = T.alloc_local([1], T.float32)
T.annotate_layout({denominator_acc: denominator_mma.make_mma_store_layout(denominator_acc)})
T.fill(denominator_one, 1.0)
''')
    return ast.unparse(ast.fix_missing_locations(Rewrite().visit(fn)))


def main():
    source=(HERE/'baseline.py').read_text()
    result=source
    for fn in ast.parse(source).body:
        if isinstance(fn,ast.FunctionDef) and fn.name in NAMES:
            result=result.replace(ast.get_source_segment(source,fn),transform(fn),1)
    ast.parse(result)
    path=HERE/'s8_pv_denominator.py'
    with path.open('x') as f: f.write(result)
    (HERE/'s8_pv_denominator_manifest.json').write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),path=path.name,
        sha256=hashlib.sha256(result.encode()).hexdigest(),functions=sorted(NAMES),
        changed_rounding='FP16 PV weights now feed an FP32 tensor-core denominator accumulator',
        numerator_and_mask_unchanged=True,test_tolerance_unchanged={'atol':0.01,'rtol':0.01}),indent=2)+'\n')
    print('Generated S8 denominator probe')


if __name__=='__main__':
    main()
