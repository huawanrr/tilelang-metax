"""Read Q and K MMA operands together from shared memory in each K step."""
import ast

from make_pair import BASE, HERE, extract, replace_once


if __name__ == '__main__':
    src = (HERE / 'single_wave_shared_q.py').read_text()
    old = 'native_sparse_attention_mid_shared_q_wave'
    for vec in (0, 8, 16):
        fn = extract(src, old).replace(old, 'native_sparse_attention_qk_shared_wave', 1)
        fn = replace_once(fn, '                T.copy(Q_shared, Q_reg)\n', '')
        fn = replace_once(fn, '                kb = T.alloc_local(', '''                qa = T.alloc_local(
                    [qk.warp_rows * qk.k_pack * qk.local_size_a], T.float16)
                kb = T.alloc_local(''')
        fn = replace_once(fn, '                        qk.mma(Q_reg, kb, acc_s, ki)',
            '                        qk.ldmatrix_a(qa, Q_shared, ki)\n'
            '                        qk.mma(qa, kb, acc_s, ki)')
        if vec:
            fn = replace_once(fn, '    VMAX = min(16 // VPHASE, BK // 4)',
                              f'    VMAX = min(16 // VPHASE, BK // {vec})')
            fn = replace_once(fn, 'KV_shared[(j) * BK + (d)] = V_reg[j, d]',
                f'KV_shared[j * BK + ((d // {vec}) ^ ((j // VPHASE) % VMAX)) * {vec} + d % {vec}] = V_reg[j, d]')
            fn = replace_once(fn, 'vb[j * 4 + e] = KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]',
                f'''row = ki * 16 + tid // 16 * 4 + e
                            col = j * 16 + tid % 16
                            vb[j * 4 + e] = KV_shared[row * BK + ((col // {vec}) ^ ((row // VPHASE) % VMAX)) * {vec} + col % {vec}]''')
        result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}', 1)
        result = replace_once(result, '        if d32_shuffle:', '''        if S == 1 and D == 64 and block_size == 16 and groups == 16 and threads == 64 and not kv_frag and not kv_split and grid > 256:
            kernel = native_sparse_attention_qk_shared_wave(
                late_normalize=False, kv_split=False, direct_k=False,
                lane_reduce=True, **common)
        elif d32_shuffle:''')
        ast.parse(result)
        path = HERE / f'qk_shared_wave_v{vec}.py'
        path.write_text(result)
        print(path.name)
