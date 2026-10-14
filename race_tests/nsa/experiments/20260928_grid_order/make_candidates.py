"""Change CTA traversal while keeping each query's arithmetic unchanged."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
targets = ('native_sparse_attention_single_block_emitter', 'native_sparse_attention_online_packed')
for mode in ('reverse', 'batch_minor', 'batch_minor_reverse'):
    source = base
    for name in targets:
        a = source.index('def ' + name + '(')
        b = source.index('\n\n@tilelang.jit', a)
        part = source[a:b]
        if 'batch_minor' in mode:
            old = '''with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):'''
            new = '''with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):'''
            assert old in part, name
            part = part.replace(old, new, 1)
        if 'reverse' in mode:
            old = '            i_t, i_v, i_bh = bx, by, bz'
            assert old in part, name
            part = part.replace(old, '            i_t, i_v, i_bh = seq_len - 1 - bx, by, bz', 1)
        source = source[:a] + part + source[b:]
    ast.parse(source)
    (HERE / f'{mode}.py').write_text(source)
    print(mode)
