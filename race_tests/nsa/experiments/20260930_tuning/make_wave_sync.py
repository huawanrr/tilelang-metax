"""Compare explicit block and wave barriers for a single 64-lane MACA wave.

Every shared K write/read, K-read/V-write, and V-write/read dependency has
an explicit barrier. Only this builder opts out of automatic insertion.
Data-race checking and memory bounds checks remain enabled.
"""
import ast

from make_pair import BASE, HERE, extract, replace_once


def make(kind):
    source = (HERE / 'pv32_v0.py').read_text()
    fn = extract(source, 'native_sparse_attention_pv_layout').replace(
        'native_sparse_attention_pv_layout', 'native_sparse_attention_wave_pv')
    fn = replace_once(fn, '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
        '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,\n'
        '        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,')
    fn = replace_once(fn, '    late_normalize = False',
        '    assert threads == 64 and groups == 16\n    late_normalize = False')
    barrier = 'T.sync_warp()' if kind == 'wave' else 'T.sync_threads()'
    fn = replace_once(fn, '                # QK:', f'                {barrier}\n\n                # QK:')
    fn = replace_once(fn, '                # Early V store:', f'                {barrier}\n\n                # Early V store:')
    fn = replace_once(fn, '                T.copy(acc_s, acc_s_cast)',
        f'                T.copy(acc_s, acc_s_cast)\n                {barrier}')
    result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}', 1)
    result = replace_once(result, '        if d32_shuffle:', '''        if S == 1 and use_emitter and D == 128 and block_size == 32 and not kv_split:
            kernel = native_sparse_attention_wave_pv(
                late_normalize=False, kv_split=False, direct_k=False,
                lane_reduce=True, **common)
        elif d32_shuffle:''')
    ast.parse(result)
    path = HERE / f'pv32_{kind}_sync.py'
    path.write_text(result)
    print(path.name)


if __name__ == '__main__':
    for kind in ('block', 'wave'):
        make(kind)
