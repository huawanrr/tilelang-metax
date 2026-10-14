"""Independent-reference checks for new small-grid direct-K dispatch boundaries."""
import sys
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from verify_nsa import check_case, edge_indices
from experiment_bench import load_module
m=load_module(sys.argv[1] if len(sys.argv)>1 else 'experiments/20260926/selected.py')
rows=[]
for d,cutoff in [(32,512),(64,256),(128,128)]:
 for b,t,h in [(1,37,2),(1,cutoff,1),(1,cutoff+1,1)]:
  for causal in (True,False):
   case=dict(B=b,SEQ_LEN=t,H=h,HQ=h*16,D=d,S=1,block_size=16,is_causal=causal)
   e=check_case(m,case,37,None,edge_indices)
   row=dict(config=case,max_abs_error=e,status='PASS')
   rows.append(row)
   print(row,flush=True)
Path(__file__).with_name('selected_edges.json').write_text(json.dumps(rows,indent=2)+'\n')
print('PASS',len(rows),'cases; both interfaces',flush=True)
