"""Verify small/large packed kernels consume newly mutated Q/K/V every time."""
import json
import sys
from pathlib import Path
import torch
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
import nsa
from benchmark_nsa import make_inputs, sparse_reference, check_output
from verify_nsa import edge_indices

rows=[]
for b,t,h in [(2,37,2),(8,513,1)]:
 for causal in (False,True):
    case=dict(B=b,SEQ_LEN=t,H=h,HQ=h*16,D=64,S=8,block_size=16,is_causal=causal)
    q,k,v,idx=make_inputs(case,seed=27)
    idx=edge_indices(idx)
    fn=nsa.native_sparse_attention(b,h*16,t,64,causal,scale=None,block_size=16,groups=16,selected_blocks=8)
    output=torch.empty_like(q)
    for iteration in range(3):
        if iteration:
            nq,nk,nv,_=make_inputs(case,seed=27+iteration)
            q.copy_(nq);k.copy_(nk);v.copy_(nv)
        expected=sparse_reference(q,k,v,idx,16,causal,None)
        error=check_output(fn(q,k,v,idx),expected,'factory refresh')
        nsa.run_kernel(q,k,v,idx,output,b,t,h,h*16,64,8,16,causal,None)
        error=max(error,check_output(output,expected,'run_kernel refresh'))
        row=dict(config=case,iteration=iteration,error=error,status='PASS')
        rows.append(row)
        print(row,flush=True)
Path(__file__).with_name('refresh.json').write_text(json.dumps(rows,indent=2)+'\n')
print('PASS:',len(rows),'input refreshes, both interfaces',flush=True)
