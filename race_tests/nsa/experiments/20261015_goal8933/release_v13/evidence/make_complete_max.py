"""Use unsigned maximum to test a complete group with one final comparison."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def expr(s):
    return ast.parse(s, mode="eval").body


def maximum(values):
    while len(values)>1:
        values = [f"T.max({values[i]}, {values[i+1]})" if i+1<len(values) else values[i]
                  for i in range(0,len(values),2)]
    return values[0]


class Predicate(ast.NodeTransformer):
    def __init__(self, mode):
        self.mode=mode
        self.count=0

    def visit_If(self,node):
        if ast.unparse(node.test).startswith("S == 8 and"):
            self.count+=1
            bound="T.Cast('uint32', ((i_t + 1) // BS if is_causal else seq_len // BS) * BS)"
            if self.mode=="all":
                values=[f"T.Cast('uint32', indices[{i}])" for i in range(8)]
            else:
                values=[f"T.if_then_else(prefetch_depth > {i}, T.Cast('uint32', i_s{i}), T.uint32(0))" for i in range(4)]
            node.test=expr(f"S == 8 and {maximum(values)} < {bound}")
            return node
        return self.generic_visit(node)


def main():
    records=[]
    # Exhaust signed index endpoints and block/causal boundaries for the
    # integer predicate, independently of the device implementation.
    checks=0
    for bs in (16,32,64):
        for length in (1,15,16,17,63,64,65,127,128,129,1024,1025,4096):
            for token in set((0,length//2,length-1)):
                for causal in (False,True):
                    bound=((token+1)//bs if causal else length//bs)*bs
                    for raw in (-2147483648,-10000000,-2,-1,0,1,2,length//bs-1,length//bs,(length+bs-1)//bs,2147483647):
                        index=min(max(raw,-1),(length+bs-1)//bs)*bs
                        original=index>=0 and index+bs<=length and (not causal or index+bs<=token+1)
                        revised=(index&0xffffffff)<bound
                        assert original==revised,(bs,length,token,causal,raw)
                        checks+=1
    for mode in ('all','groups'):
        parent=HERE/f'complete_{mode}_a0.py'
        source=parent.read_text()
        result=source
        changed={}
        for fn in ast.parse(source).body:
            if isinstance(fn,ast.FunctionDef) and fn.name in NAMES:
                rewrite=Predicate(mode)
                node=rewrite.visit(copy.deepcopy(fn))
                node.decorator_list=[]
                assert rewrite.count==1
                changed[fn.name]=rewrite.count
                result=result.replace(ast.get_source_segment(source,fn),ast.unparse(ast.fix_missing_locations(node)),1)
        path=HERE/f'complete_{mode}_umax.py'
        compile(result,str(path),'exec')
        with path.open('x') as f:f.write(result)
        records.append(dict(file=path.name,sha256=hashlib.sha256(result.encode()).hexdigest(),
            parent=parent.name,parent_sha256=hashlib.sha256(source.encode()).hexdigest(),changed=changed))
    with (HERE/'complete_max_manifest.json').open('x') as f:
        json.dump(dict(variants=records,cpu_predicate_comparisons=checks,
            proof='Clamped positions are multiples of BS. Negative positions become unsigned maxima; positive positions are complete iff below the aligned end of the valid prefix. An all predicate is equivalent to its unsigned maximum comparison.'),f,indent=2)
        f.write('\n')
    print('Generated maximum predicates; CPU comparisons',checks)


if __name__=='__main__':main()
