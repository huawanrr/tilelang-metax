"""Build shared-atomic scheduling probes on the preserved NSA next version."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
previous = (ROOT / 'experiments/20260926/bucket_kernels.py').read_text()
start = previous.index('@tilelang.jit(pass_configs=')
end = previous.index('\n\nclass BucketKernel:', start)
original_attention = previous[start:end]
prepare = (HERE / 'prepare_kernel.py').read_text()
for queries in (2, 4):
    for single in (False, True):
        attention = original_attention
        if single:
            attention = attention.replace('block_row_warps=QT', 'block_row_warps=1')
            attention = attention.replace('warp_row_tiles=16', 'warp_row_tiles=M')
            attention = attention.replace('threads=QT*64', 'threads=64')
            attention = attention.replace('            wave=T.get_thread_binding()//64',
                '            token_ids=T.alloc_local([QT],T.int32)')
            attention = attention.replace('''                token=T.if_then_else(wave<count,Sorted[bh//H,bh%H,bucket,start+wave],0)''',
                '''                for w in T.unroll(QT):
                    token_ids[w]=T.if_then_else(w<count,Sorted[bh//H,bh%H,bucket,start+w],0)''')
            attention = attention.replace('Q[bh//H,token,', 'Q[bh//H,token_ids[m//G],')
            attention = attention.replace('pos<=token)', 'pos<=token_ids[m//G])')
            attention = attention.replace('Output[bh//H,token,', 'Output[bh//H,token_ids[m//G],')
        source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + prepare + '\n\n' + attention + '\n\n_KERNEL_CACHE = {}', 1)
        start = source.index('def _get_kernel(')
        host = source[start:]
        host = host.replace('''        if S == 1 and use_emitter:
''', f'''        if S == 1 and groups == 16 and D == 128 and block_size == 32:
            prepare = prepare_buckets(B, seq_len, H, block_size, {queries}, is_causal)
            attention = bucket_attention(B, seq_len, H, D, block_size, {queries}, is_causal, scale_log2)
            kernel = _make_bucket_attention(prepare, attention, B, seq_len, H, block_size, {queries})
        elif S == 1 and use_emitter:
''', 1)
        source = source[:start] + host
        ast.parse(source)
        name = f'bucket_q{queries}_' + ('single' if single else 'multi') + '.py'
        (HERE / name).write_text(source)
        print(name)
