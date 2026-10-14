# Local benchmark adapter; release code will use the same builder directly.
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import probe_support

def _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None, **options):
    return probe_support.kernel('online', 2, 2, B, seq_len, H, HQ, D, S,
                                block_size, is_causal, scale, **options)

def run_kernel(q, k, v, block_indices, output, B, seq_len, H, HQ, D, S, block_size, is_causal, scale):
    kernel = _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale)
    kernel(q, k, v, block_indices, output)
    return output
