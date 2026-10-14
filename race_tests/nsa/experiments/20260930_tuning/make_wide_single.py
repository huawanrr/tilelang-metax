"""Test wide Q loads and matching K shared access in D64/D128 single blocks."""
import ast

from make_pair import BASE, HERE, extract, replace_once


def make(pack, kvec):
    old = 'native_sparse_attention_single_linear_v'
    fn = extract(BASE, old).replace(old, 'native_sparse_attention_wide_single')
    fn = replace_once(fn, '    head_kv = heads // groups', f'    KP = {pack}\n    head_kv = heads // groups')
    fn = replace_once(fn, '    qk, pv = _emitters(T.float16, T.float32, BS, BK)',
                      '    qk, pv = _emitters(T.float16, T.float32, BS, BK, qk_k_pack=KP)')
    fn = replace_once(fn, 'Q_reg: qk.make_mma_load_layout(Q_reg, "A"),', '''Q_reg: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: i + (d % (KP * 16) // (KP * 4)) * 16,
                    forward_index_fn=lambda i, d: d // (KP * 16) * (KP * 4) + d % (KP * 4)),''')
    fn = replace_once(fn, '    KMAX = min(16 // KPHASE, BK // 8)', f'    KMAX = min(16 // KPHASE, BK // {kvec})')
    fn = replace_once(fn, 'KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]',
                      f'KV_shared[j * BK + ((d // {kvec}) ^ ((j // KPHASE) % KMAX)) * {kvec} + d % {kvec}] = K_reg[j, d]')
    begin = fn.index('                        for j in T.serial(BS // 16):')
    end = fn.index('                        qk.mma(Q_reg, kb, acc_s, ki)', begin)
    fn = fn[:begin] + f'''                        for j in T.serial(BS // 16):
                            for e in T.vectorized(KP * 4):
                                row = j * 16 + tid % 16
                                col = ki * KP * 16 + tid // 16 * KP * 4 + e
                                kb[j * KP * 4 + e] = KV_shared[row * BK +
                                    ((col // {kvec}) ^ ((row // KPHASE) % KMAX)) * {kvec} + col % {kvec}]
''' + fn[end:]
    result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}', 1)
    result = replace_once(result, '        if d32_shuffle:', '''        if S == 1 and groups == 16 and threads == 64 and not kv_frag and not kv_split and D >= 64 and block_size == 16:
            kernel = native_sparse_attention_wide_single(
                late_normalize=False, kv_split=False, direct_k=False,
                lane_reduce=True, **common)
        elif d32_shuffle:''')
    ast.parse(result)
    path = HERE / f'wide{pack}_k{kvec}.py'
    path.write_text(result)
    print(path.name)


if __name__ == '__main__':
    for pack, kvec in ((2, 8), (4, 8), (4, 16)):
        make(pack, kvec)
