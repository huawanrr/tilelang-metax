"""Explicit synchronous wave barriers for short online attention lists."""
import ast

from make_pair import BASE, HERE, ROOT, extract, replace_once


def make(linear, barrier_kind):
    if linear:
        src = (ROOT / 'experiments/20260929_online_register/online_linear.py').read_text()
        old = 'native_sparse_attention_online_register'
    else:
        src = BASE
        old = 'native_sparse_attention_online_emitter'
    fn = extract(src, old).replace(old, 'native_sparse_attention_online_wave')
    fn = replace_once(fn, '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
        '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,\n'
        '        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,')
    fn = replace_once(fn, '    head_kv = heads // groups',
        '    assert threads == 64 and groups == 16\n    head_kv = heads // groups')
    fn = replace_once(fn, '            scores_sum = T.alloc_fragment([G], T.float32)', '''            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})
            scores_sum = T.alloc_fragment([G], T.float32)''')
    barrier = 'T.sync_warp()' if barrier_kind == 'wave' else 'T.sync_threads()'
    fn = replace_once(fn, '                    for ki in T.serial(qk_steps):',
                      f'                    {barrier}\n                    for ki in T.serial(qk_steps):')
    fn = replace_once(fn, '                    T.copy(acc_s, acc_s_cast)',
                      f'                    T.copy(acc_s, acc_s_cast)\n                    {barrier}')
    begin = fn.index('            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)')
    end = fn.index('            T.copy(acc_o, Output[', begin)
    fn = fn[:begin] + '''            for i, lane in T.Parallel(G, 4):
                lane_sum[i, lane] = 0
                for k in T.unroll(BS // 16):
                    for j in T.unroll(4):
                        lane_sum[i, lane] += sum_acc[i, k * 16 + lane * 4 + j]
            for i, lane in T.Parallel(G, 4):
                lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                    1.0 / lane_sum[i, lane], 0.0)
            for i, j in T.Parallel(G, BV):
                acc_o[i, j] *= lane_sum[i, j % 16 // 4]

''' + fn[end:]
    result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}', 1)
    result = replace_once(result, '        if d32_shuffle:', '''        if S in (2, 4) and use_emitter_online:
            kernel = native_sparse_attention_online_wave(
                selected_blocks=S, online_unroll=online_unroll, **common)
        elif d32_shuffle:''')
    ast.parse(result)
    path = HERE / f'online_{"linear" if linear else "swizzle"}_{barrier_kind}.py'
    path.write_text(result)
    print(path.name)


if __name__ == '__main__':
    for linear in (False, True):
        for kind in ('block', 'wave'):
            make(linear, kind)
