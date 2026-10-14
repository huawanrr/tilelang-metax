"""Synchronous single-wave variants of the existing explicit emitters."""
import ast

from make_pair import BASE, HERE, extract, replace_once


NAMES = (
    'native_sparse_attention_single_block_emitter',
    'native_sparse_attention_single_vec16',
    'native_sparse_attention_single_linear_v',
    'native_sparse_attention_d32_shuffle',
    'native_sparse_attention_mid_shared_q',
)


def wave_function(name):
    fn = extract(BASE, name).replace(name, name + '_wave', 1)
    fn = replace_once(fn, '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
        '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,\n'
        '        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,')
    fn = replace_once(fn, '    head_kv = heads // groups',
        '    assert threads == 64 and groups == 16 and not kv_split\n'
        '    lane_reduce = True\n    head_kv = heads // groups')
    is_shared_q = name.endswith('mid_shared_q')
    is_shuffle = name.endswith('d32_shuffle')
    if is_shared_q:
        # Store both independent tiles before a common readiness barrier.
        fn = replace_once(fn, '                T.copy(Q_shared, Q_reg)\n', '')
        fn = replace_once(fn, '                # QK:',
            '                T.sync_warp()\n'
            '                T.copy(Q_shared, Q_reg)\n\n                # QK:')
    elif not is_shuffle:
        fn = replace_once(fn, '                # QK:',
            '                if not direct_k:\n                    T.sync_warp()\n\n                # QK:')
    if not is_shuffle:
        fn = replace_once(fn, '                # Early V store:',
            '                if not direct_k:\n                    T.sync_warp()\n\n                # Early V store:')
    fn = replace_once(fn, '                T.copy(acc_s, acc_s_cast)',
        '                T.copy(acc_s, acc_s_cast)\n                T.sync_warp()')
    return fn


if __name__ == '__main__':
    funcs = '\n\n'.join(wave_function(n) for n in NAMES)
    funcs += '\n\n' + extract((HERE / 'pv32_wave_sync.py').read_text(), 'native_sparse_attention_wave_pv')
    result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + funcs + '\n_KERNEL_CACHE = {}', 1)
    begin = result.index('def _get_kernel(')
    host = result[begin:]
    for name in NAMES:
        # The original builders remain available for explicit split-buffer calls.
        host = host.replace(f'kernel = {name}(', f'kernel = ({name} if kv_split else {name}_wave)(')
    host = host.replace('kernel = native_sparse_attention_single_block_pv32(',
                        'kernel = native_sparse_attention_wave_pv(')
    result = result[:begin] + host
    ast.parse(result)
    (HERE / 'single_wave.py').write_text(result)
    print('single_wave.py')
    # Probe the shared-Q emitter on the rest of the D64 grid range.
    shared = replace_once(result, '        if d32_shuffle:', '''        if S == 1 and D == 64 and block_size == 16 and groups == 16 and threads == 64 and not kv_frag and not kv_split and grid > 256:
            kernel = native_sparse_attention_mid_shared_q_wave(
                late_normalize=False, kv_split=False, direct_k=False,
                lane_reduce=True, **common)
        elif d32_shuffle:''')
    ast.parse(shared)
    (HERE / 'single_wave_shared_q.py').write_text(shared)
    print('single_wave_shared_q.py')
