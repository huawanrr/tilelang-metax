"""Combine the measured Q-load and Q-shared-layout improvements."""
from make_probes import once, save
from make_q_variants import staged


if __name__ == '__main__':
    for vec, swizzle, pv in ((4, 4, 32), (4, 4, 64), (4, 8, 64),
                             (4, 2, 32), (4, 0, 32), (2, 4, 32),
                             (16, 4, 32), (16, 4, 64)):
        fn = staged()
        fn = once(fn, '(i * BK + d) // 8 % 64', f'(i * BK + d) // {vec} % 64')
        fn = once(fn, '(i * BK + d) // 512 * 8 + d % 8',
                  f'(i * BK + d) // {64 * vec} * {vec} + d % {vec}')
        shared = (f'tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize={swizzle})'
                  if swizzle else 'T.Layout([G, BK], lambda i, d: i * BK + d)')
        fn = once(fn, 'tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8)', shared)
        fn = once(fn, '    VW = min(32, BV)', f'    VW = min({pv}, BV)')
        save(f'qv{vec}_s{swizzle}_pv{pv}', fn)
