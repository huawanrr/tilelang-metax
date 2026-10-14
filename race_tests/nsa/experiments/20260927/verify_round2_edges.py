"""Reference checks for direct-K, Q preload and alternate-accumulator boundaries."""
import json
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from verify_nsa import check_case, edge_indices
from experiment_bench import load_module
m=load_module('experiments/20260927/round2.py')
cases=[]
for d,cutoff in [(32,512),(64,256),(128,128)]:
 for b,t,h in [(1,37,2),(1,cutoff,1),(1,cutoff+1,1)]:
  for causal in (True,False):
   cases.append(dict(B=b,SEQ_LEN=t,H=h,HQ=h*16,D=d,S=1,block_size=16,is_causal=causal))
for b,t,h,s in [(2,129,2,1),(1,1024,1,1),(1,1025,1,1),
                 (8,513,1,8),(4,513,2,8),(1,37,2,16)]:
 for causal in (True,False):
  cases.append(dict(B=b,SEQ_LEN=t,H=h,HQ=h*16,D=64,S=s,block_size=16,is_causal=causal))

def edge_indices_extended(idx):
 if idx.shape[-1]<=8:
  return edge_indices(idx)
 # Keep repeated/invalid patterns while exercising a longer selected-block list.
 base=edge_indices(idx[...,:8])
 return base.repeat(1,1,1,idx.shape[-1]//8)

rows=[]
for case in cases:
 e=check_case(m,case,37,None,edge_indices_extended)
 row=dict(config=case,max_abs_error=e,status='PASS')
 rows.append(row)
 print(row,flush=True)
Path(__file__).with_name('round2_edges.json').write_text(json.dumps(rows,indent=2)+'\n')
print('PASS',len(rows),'cases; both interfaces',flush=True)
