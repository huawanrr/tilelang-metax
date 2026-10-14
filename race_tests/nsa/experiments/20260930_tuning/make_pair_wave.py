"""Apply explicit warp synchronization to the combined short-list kernel."""
import ast

from make_pair import HERE, extract, replace_once


if __name__ == '__main__':
    for late in (False, True):
        src = (HERE / f'pair_linear_{"late" if late else "early"}.py').read_text()
        old = extract(src, 'native_sparse_attention_short_list')
        fn = replace_once(old, '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
            '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,\n'
            '        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,')
        fn = replace_once(fn, '    head_kv = heads // groups',
            '    assert threads == 64 and groups == 16 and not kv_split and not direct_k\n'
            '    lane_reduce = True\n    head_kv = heads // groups')
        fn = replace_once(fn, '                # QK:',
                          '                T.sync_warp()\n\n                # QK:')
        fn = replace_once(fn, '                # Early V store:',
                          '                T.sync_warp()\n\n                # Early V store:')
        fn = replace_once(fn, '                T.copy(acc_s, acc_s_cast)',
                          '                T.copy(acc_s, acc_s_cast)\n                T.sync_warp()')
        result = replace_once(src, old, fn)
        ast.parse(result)
        path = HERE / f'pair_wave_{"late" if late else "early"}.py'
        path.write_text(result)
        print(path.name)
