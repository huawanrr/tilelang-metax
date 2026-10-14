from pathlib import Path

ROOT = Path(__file__).resolve().parent
template = '''# Local benchmark adapter; release code will use the same builder directly.
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import probe_support

def _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None, **options):
    return probe_support.kernel({kind!r}, {first}, {second}, B, seq_len, H, HQ, D, S,
                                block_size, is_causal, scale, **options)

def run_kernel(q, k, v, block_indices, output, B, seq_len, H, HQ, D, S, block_size, is_causal, scale):
    kernel = _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale)
    kernel(q, k, v, block_indices, output)
    return output
'''
for width, late in ((32, 0), (32, 1), (64, 0), (64, 1), (128, 1)):
    name = f'retune_single_w{width}_l{late}'
    (ROOT / (name + '.py')).write_text(template.format(kind='single', first=width, second=late))
    print(name)
for accumulators in (1, 2, 4):
    for prefetch in (1, 2, 4):
        name = f'retune_online_a{accumulators}_p{prefetch}'
        (ROOT / (name + '.py')).write_text(template.format(kind='online', first=accumulators, second=prefetch))
        print(name)
