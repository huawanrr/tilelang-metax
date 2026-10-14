"""Combine tiled PV with independent synchronous K and V shared layouts."""
from pathlib import Path
import ast

from make_pair import BASE, HERE, extract, replace_once


def make(width, vector):
    old = 'native_sparse_attention_single_linear_v'
    fn = extract(BASE, old).replace(old, 'native_sparse_attention_pv_layout')
    fn = replace_once(fn, '    head_kv = heads // groups', '    late_normalize = False\n    head_kv = heads // groups')
    fn = replace_once(fn, '    qk, pv = _emitters(T.float16, T.float32, BS, BK)', f'''    VW = min({width}, BV)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=VW, chunk=BS, k_pack=1)''')
    fn = fn.replace('acc_o = T.alloc_fragment([G, BV]', 'acc_o = T.alloc_fragment([G, VW]')
    if vector:
        fn = fn.replace('BK // 4)', f'BK // {vector})')
        fn = replace_once(fn, 'KV_shared[(j) * BK + (d)] = V_reg[j, d]',
            f'KV_shared[j * BK + ((d // {vector}) ^ ((j // VPHASE) % VMAX)) * {vector} + d % {vector}] = V_reg[j, d]')
        index = f'row * BK + ((col // {vector}) ^ ((row // VPHASE) % VMAX)) * {vector} + col % {vector}'
    else:
        index = 'row * BK + col'
    begin = fn.index('                vb = T.alloc_local(')
    end = fn.index('\n    return kernel', begin)
    fn = fn[:begin] + f'''
            vb = T.alloc_local(
                [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            for vo in T.unroll(BV // VW):
                T.clear(acc_o)
                if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):
                    for ki in T.serial(pv_steps):
                        for j in T.serial(VW // 16):
                            for e in T.serial(4):
                                row = ki * 16 + tid // 16 * 4 + e
                                col = vo * VW + j * 16 + tid % 16
                                vb[j * 4 + e] = KV_shared[{index}]
                        pv.mma(acc_s_cast, vb, acc_o, ki)
                T.copy(acc_o, Output[
                    i_b, i_t, i_h * G : (i_h + 1) * G,
                    i_v * BV + vo * VW : i_v * BV + (vo + 1) * VW])
''' + fn[end:]
    result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}', 1)
    result = replace_once(result, '        if d32_shuffle:', '''        if S == 1 and use_emitter and D == 128 and block_size == 32 and not kv_split:
            kernel = native_sparse_attention_pv_layout(
                late_normalize=False, kv_split=False, direct_k=False,
                lane_reduce=True, **common)
        elif d32_shuffle:''')
    ast.parse(result)
    path = HERE / f'pv{width}_v{vector}.py'
    path.write_text(result)
    print(path.name)


if __name__ == '__main__':
    for width, vector in ((16, 0), (32, 0), (64, 0), (128, 0), (32, 16), (32, 8)):
        make(width, vector)
