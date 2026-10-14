# Local benchmark adapter; final release must inline the measured builder.
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import multiwave_support
def _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None, **options):
    return multiwave_support.get(4, False, B, seq_len, H, HQ, D, S, block_size, is_causal, scale, **options)
def run_kernel(q, k, v, block_indices, output, B, seq_len, H, HQ, D, S, block_size, is_causal, scale):
    _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale)(q, k, v, block_indices, output)
    return output
