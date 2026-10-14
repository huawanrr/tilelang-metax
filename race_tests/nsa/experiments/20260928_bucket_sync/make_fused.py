"""Fuse local inverse-index grouping into one attention launch."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
template = (HERE / 'fused_template.py').read_text()
for qt, cq in ((2, 128), (4, 128), (4, 256), (4, 512)):
    source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + template + '\n\n_KERNEL_CACHE = {}', 1)
    a = source.index('def _get_kernel(')
    host = source[a:].replace('''        if S == 1 and use_emitter:
''', f'''        if S == 1 and groups == 16 and D == 128 and block_size == 32 and threads == 64:
            kernel = fused_bucket_attention(B, seq_len, H, D, block_size, {qt}, {cq}, is_causal, scale_log2)
        elif S == 1 and use_emitter:
''', 1)
    source = source[:a] + host
    ast.parse(source)
    name = f'fused_q{qt}_c{cq}.py'
    (HERE / name).write_text(source)
    print(name)
