# Local benchmark adapter.
import sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
import d128_split_support

def _get_kernel(B,seq_len,H,HQ,D,S,block_size,is_causal,scale=None,**options):
    return d128_split_support.get(64,B,seq_len,H,HQ,D,S,block_size,is_causal,scale,**options)

def run_kernel(q,k,v,block_indices,output,B,seq_len,H,HQ,D,S,block_size,is_causal,scale):
    _get_kernel(B,seq_len,H,HQ,D,S,block_size,is_causal,scale)(q,k,v,block_indices,output)
    return output
