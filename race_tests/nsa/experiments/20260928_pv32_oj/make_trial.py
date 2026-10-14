"""Build an isolated OJ trial from the frozen next version and PV32 probe."""
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
probe = (ROOT / 'experiments/20260928_output_split/pv_tiles32.py').read_text()
assert hashlib.sha256(base.encode()).hexdigest() == '311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26'
assert hashlib.sha256(probe.encode()).hexdigest() == '0941ff6a46854a1e8aab3f6f5f93d768bf33260a60e97ef19d5ff47283bbf2a3'
start = probe.index('def native_sparse_attention_single_block_emitter(')
start = probe.rfind('@tilelang.jit(', 0, start)
end = probe.index('\n\n@tilelang.jit', start + 1)
kernel = probe[start:end].replace('def native_sparse_attention_single_block_emitter(',
                                'def native_sparse_attention_single_block_pv32(', 1)
doc_start = kernel.index('    """')
doc_end = kernel.index('"""', doc_start + 7) + 3
kernel = kernel[:doc_start] + '''    """OJ experiment: one QK, early normalization, four 32-column PV tiles.

    The dispatch limits this probe to S1/D128/BS32/G16 and >=4096 queries.
    Local performance is uncertain under contention; OJ feedback is pending.
    Each PV tile is written before reusing its accumulator for the next tile.
    """''' + kernel[doc_end:]
source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + kernel + '\n\n_KERNEL_CACHE = {}', 1)
start = source.index('def _get_kernel(')
host = source[start:]
host = host.replace('    key = (', '''    # Isolated trial of the three measured throughput shapes. The rule uses
    # only workload dimensions and preserves explicit alternate schedules.
    pv32_trial = (S == 1 and use_emitter and D == 128 and block_size == 32
        and grid >= 4096 and late_normalize and not kv_split)
    key = (''', 1)
host = host.replace('        prefetch_depth,\n    )', '        prefetch_depth,\n        pv32_trial,\n    )', 1)
host = host.replace('''        if S == 1 and use_emitter:
''', '''        if pv32_trial:
            kernel = native_sparse_attention_single_block_pv32(
                late_normalize=late_normalize, kv_split=kv_split,
                direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif S == 1 and use_emitter:
''', 1)
source = source[:start] + host
ast.parse(source)
(HERE / 'nsa.py').write_text(source)
print(HERE / 'nsa.py')
