"""Retain the 929 Q/K shared allocation reuse with explicit barriers."""
import ast

from make_pair import BASE, HERE, extract, replace_once


if __name__ == '__main__':
    old = 'native_sparse_attention_mid_shared_q'
    for kind in ('block', 'wave'):
        fn = extract(BASE, old).replace(old, 'native_sparse_attention_shared_q_reuse', 1)
        fn = replace_once(fn, '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
            '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,\n'
            '        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,')
        fn = replace_once(fn, '    head_kv = heads // groups',
            '    assert threads == 64 and groups == 16 and not kv_split and not direct_k\n'
            '    lane_reduce = True\n    head_kv = heads // groups')
        sync = 'T.sync_warp()' if kind == 'wave' else 'T.sync_threads()'
        fn = replace_once(fn, '                T.copy(Q_stage, Q_shared)',
            f'                T.copy(Q_stage, Q_shared)\n                {sync}')
        fn = replace_once(fn, '                T.copy(Q_shared, Q_reg)',
            f'                T.copy(Q_shared, Q_reg)\n                {sync}')
        fn = replace_once(fn, '                # QK:',
            f'                {sync}\n\n                # QK:')
        fn = replace_once(fn, '                # Early V store:',
            f'                {sync}\n\n                # Early V store:')
        fn = replace_once(fn, '                T.copy(acc_s, acc_s_cast)',
            f'                T.copy(acc_s, acc_s_cast)\n                {sync}')
        result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}', 1)
        result = replace_once(result, '        if d32_shuffle:', '''        if S == 1 and D == 64 and block_size == 16 and groups == 16 and threads == 64 and not kv_frag and not kv_split and grid > 256:
            kernel = native_sparse_attention_shared_q_reuse(
                late_normalize=False, kv_split=False, direct_k=False,
                lane_reduce=True, **common)
        elif d32_shuffle:''')
        ast.parse(result)
        path = HERE / f'shared_q_reuse_{kind}.py'
        path.write_text(result)
        print(path.name)
