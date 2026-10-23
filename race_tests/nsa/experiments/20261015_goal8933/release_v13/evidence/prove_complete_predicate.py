"""Prove complete-block predicates for every int32 raw index with Z3."""
import json
from pathlib import Path
import z3

HERE=Path(__file__).resolve().parent
rows=[]
for bs in (16,32,64):
    raw=z3.Int('raw')
    length=z3.Int('length')
    token=z3.Int('token')
    causal=z3.Bool('causal')
    nblocks=(length+bs-1)/bs
    block=z3.If(raw < -1,-1,z3.If(raw>nblocks,nblocks,raw))
    index=block*bs
    unsigned=z3.If(index<0,index+2**32,index)
    bound=z3.If(causal,((token+1)/bs)*bs,(length/bs)*bs)
    original=z3.And(index>=0,index+bs<=length,z3.Or(z3.Not(causal),index+bs<=token+1))
    replacement=unsigned<bound
    solver=z3.Solver()
    # The inherited int32 position representation requires its clamped
    # sentinel and end arithmetic to fit, independent of this optimization.
    solver.add(raw>=-2**31,raw<2**31,length>=1,length<=2**31-2*bs,
               token>=0,token<length,original!=replacement)
    solver.set(timeout=30000)
    result=solver.check()
    assert result==z3.unsat,(bs,result,solver.model() if result==z3.sat else None)
    rows.append(dict(block_size=bs,raw_index='all int32',sequence_length=[1,2**31-2*bs],
                     token='all [0, sequence_length)',causal='both',counterexample='unsat'))

values=[z3.BitVec(f'v{i}',32) for i in range(8)]
bound=z3.BitVec('bound',32)
maximum=values[0]
for value in values[1:]:maximum=z3.If(z3.UGT(maximum,value),maximum,value)
solver=z3.Solver()
solver.add(z3.And(*[z3.ULT(v,bound) for v in values])!=z3.ULT(maximum,bound))
assert solver.check()==z3.unsat
report=dict(status='PASS',rows=rows,unsigned_maximum_equivalence='all uint32 values, unsat',
            note='Only complete valid blocks enter the fast branch; partial, future, negative and oversized indices retain the original fallback.')
with (HERE/'complete_predicate_proof.json').open('x') as f:
    json.dump(report,f,indent=2)
    f.write('\n')
print(json.dumps(report,indent=2))
