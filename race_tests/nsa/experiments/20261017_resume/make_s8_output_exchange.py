"""Test coalesced register-only output conversion on the existing S8 kernels."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_packed_exchange import output_code, prove_output

HERE = Path(__file__).resolve().parent
NAMES = {
    'native_sparse_attention_online_packed_batch_minor_o_v2_mathcast',
    'native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast',
}


class Rename(ast.NodeTransformer):
    names = {'D':'BV', 'b':'i_b', 'token':'i_t', 'h':'i_h', 'output_reg':'acc_o'}

    def visit_Name(self,node):
        if node.id in self.names:
            return ast.copy_location(ast.Name(id=self.names[node.id],ctx=node.ctx),node)
        return node


def transform(fn,bits):
    fn=copy.deepcopy(fn)
    fn.decorator_list=[]
    kernel=next(n for n in fn.body if isinstance(n,ast.FunctionDef))
    scope=next(n for n in kernel.body if isinstance(n,ast.With))
    index=next(i for i,n in enumerate(scope.body) if isinstance(n,ast.Assign)
               and ast.unparse(n.targets[0])=='O_reg')
    code=output_code(bits)
    scope.body[index:]=[Rename().visit(n) for n in code]
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source=(HERE/'baseline.py').read_text()
    records=[]
    for bits in (1,2):
        result=source
        for fn in ast.parse(source).body:
            if isinstance(fn,ast.FunctionDef) and fn.name in NAMES:
                result=result.replace(ast.get_source_segment(source,fn),transform(fn,bits),1)
        ast.parse(result)
        path=HERE/f's8_output_exchange{bits}.py'
        with path.open('x') as f: f.write(result)
        records.append(dict(path=path.name,bits=bits,sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE/'s8_output_exchange_manifest.json').write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
        functions=sorted(NAMES),variants=records,output_proofs=[prove_output(64,b) for b in (1,2)],
        scope='Existing default D64 S8 mathcast builders only; all QK/PV, masking, summation and normalisation preserved'),indent=2)+'\n')
    print('Generated two S8 output probes')


if __name__=='__main__':
    main()
