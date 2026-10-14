"""Combine coalesced Q staging and output writeback, preserving each probe."""
import ast

from make_probes import HERE, once, save


def output_base():
    source = (HERE / 'output_q_shared_64.py').read_text()
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == 'native_sparse_attention_probe')
    return once('\n'.join(source.splitlines()[node.decorator_list[0].lineno - 1:node.end_lineno]) + '\n',
                'def native_sparse_attention_probe(', 'def native_sparse_attention_pv32_sync(')


if __name__ == '__main__':
    for qvec, qsw, osw, vw in ((4, 8, 8, 64), (4, 8, 8, 32), (4, 8, 8, 128),
                              (8, 8, 8, 128), (4, 4, 8, 64), (4, 8, 0, 64),
                              (4, 8, 4, 64), (4, 8, 16, 64)):
        fn = output_base()
        fn = once(fn, '(i * BK + d) // 8 % 64', f'(i * BK + d) // {qvec} % 64')
        fn = once(fn, '(i * BK + d) // 512 * 8 + d % 8',
                  f'(i * BK + d) // {64 * qvec} * {qvec} + d % {qvec}')
        fn = once(fn, 'make_mma_swizzle_layout(Q_shared, vecSize=8)',
                  f'make_mma_swizzle_layout(Q_shared, vecSize={qsw})')
        out_layout = (f'tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize={osw})'
                      if osw else 'T.Layout([G, BV], lambda oi, od: oi * BV + od)')
        fn = once(fn, 'tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)', out_layout)
        fn = once(fn, '    VW = min(64, BV)', f'    VW = min({vw}, BV)')
        save(f'qo_q{qvec}s{qsw}_o{osw}_pv{vw}', fn,
             'S == 1 and D in (64, 128) and block_size in (16, 32, 64)')
