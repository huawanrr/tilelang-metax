"""Build immutable probes from the user-confirmed 930 submission."""
import ast
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = (ROOT / 'experiments/20260930_candidate/nsa.py').read_text()


def extract(name):
    tree = ast.parse(BASE)
    node = next(n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == name)
    start = min([node.lineno] + [n.lineno for n in node.decorator_list]) - 1
    return '\n'.join(BASE.splitlines()[start:node.end_lineno]) + '\n'


def once(text, old, new):
    assert text.count(old) == 1, (old, text.count(old))
    return text.replace(old, new, 1)


def save(name, fn, condition='S == 1 and D == 128 and block_size == 32', call=''):
    fn = once(fn, 'def native_sparse_attention_pv32_sync(', 'def native_sparse_attention_probe(')
    result = once(BASE, '\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}')
    result = once(result, '        if joined_short:', f'''        if ({condition}) and groups == 16 and threads == 64 and not kv_frag and not kv_split:
            kernel = native_sparse_attention_probe(
                wave_sync=True, lane_reduce=True, {call}**common)
        elif joined_short:''')
    ast.parse(result)
    path = HERE / f'{name}.py'
    if path.exists():
        raise FileExistsError(path)
    path.write_text(result)
    print(path.name)


def stage_vec(vec):
    fn = extract('native_sparse_attention_pv32_sync')
    for dim in ('BK', 'BV'):
        fn = once(fn, f'(j * {dim} + d) // 8 % 64', f'(j * {dim} + d) // {vec} % 64')
        fn = once(fn, f'(j * {dim} + d) // 512 * 8 + d % 8',
                  f'(j * {dim} + d) // {64 * vec} * {vec} + d % {vec}')
    save(f'load_vec{vec}', fn)


def q_shared(early):
    fn = extract('native_sparse_attention_pv32_sync')
    fn = once(fn, '            Q_reg = T.alloc_fragment([G, BK], T.float16)', '''            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)''')
    fn = once(fn, '                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),', '''                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: (i * BK + d) // 8 % 64,
                    forward_index_fn=lambda i, d: (i * BK + d) // 512 * 8 + d % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),''')
    fn = once(fn, 'T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)',
              'T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)')
    seq = '''                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
'''
    if early:
        fn = once(fn, '                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)',
                  seq + '                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)')
    else:
        fn = once(fn, '                if not direct_k:\n', seq + '                if not direct_k:\n')
    save('q_shared_early' if early else 'q_shared_late', fn)


def waves(nw, vw=32):
    fn = extract('native_sparse_attention_pv32_sync')
    fn = once(fn, '    late_normalize = False', f'    late_normalize = False\n    NW = {nw}\n    M = NW * groups\n    wave_sync = True')
    fn = once(fn, '    VW = min(32, BV)', f'    VW = min({vw}, BV)')
    fn = once(fn, '    qk, pv = _emitters(T.float16, T.float32, BS, BK)', '''    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=BK, k_pack=2)''')
    fn = once(fn, '        block_row_warps=1, block_col_warps=1,',
              '        block_row_warps=NW, block_col_warps=1,')
    fn = once(fn, 'with T.Kernel(seq_len,', 'with T.Kernel(T.ceildiv(seq_len, NW),')
    fn = once(fn, '                      threads=threads)', '                      threads=64 * NW)')
    for buf in ('Q_reg', 'acc_s', 'acc_s_cast', 'acc_o', 'lane_sum'):
        fn = once(fn, f'{buf} = T.alloc_fragment([G,', f'{buf} = T.alloc_fragment([M,')
    fn = fn.replace('T.alloc_fragment([G]', 'T.alloc_fragment([M]')
    fn = once(fn, '            K_reg = T.alloc_fragment([BS, BK]',
              '            K_reg = T.alloc_fragment([NW, BS, BK]')
    fn = once(fn, '            V_reg = T.alloc_fragment([BS, BV]',
              '            V_reg = T.alloc_fragment([NW, BS, BV]')
    fn = fn.replace('[BS * VSTRIDE]', '[NW * BS * VSTRIDE]')
    fn = once(fn, '            tid = T.get_thread_binding()',
              '            tid = T.get_thread_binding() % 64\n            wave = T.get_thread_binding() // 64')
    fn = once(fn, 'T.Fragment([G, 4]', 'T.Fragment([M, 4]')
    fn = once(fn, 'forward_thread_fn=lambda i, j: i + j * 16,',
              'forward_thread_fn=lambda i, j: i // G * 64 + i % G + j * 16,')
    for buf, dim in [('K_reg', 'BK'), ('V_reg', 'BV')]:
        old = f'''{buf}: T.Fragment([BS, {dim}],
                    forward_thread_fn=lambda j, d: (j * {dim} + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * {dim} + d) // 512 * 8 + d % 8)'''
        new = f'''{buf}: T.Fragment([NW, BS, {dim}],
                    forward_thread_fn=lambda w, j, d: w * 64 + (j * {dim} + d) // 8 % 64,
                    forward_index_fn=lambda w, j, d: (j * {dim} + d) // 512 * 8 + d % 8)'''
        fn = once(fn, old, new)
    fn = once(fn, '            i_t, i_v, i_bh = bx, by, bz',
              '            i_t, i_v, i_bh = bx * NW + wave, by, bz')
    fn = once(fn, '            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)', '''            for m, d in T.Parallel(M, BK):
                Q_reg[m, d] = Q[i_b, bx * NW + m // G, i_h * G + m % G, d]''')
    fn = once(fn, '            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS', '''            i_s = T.if_then_else(i_t < seq_len,
                BlockIndices[i_b, i_t, i_h, 0] * BS, -BS)''')
    fn = once(fn, '''                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)''', '''                for w, j, d in T.Parallel(NW, BS, BK):
                    K_reg[w, j, d] = K[i_b, i_s + j, i_h, d]
                for w, j, d in T.Parallel(NW, BS, BV):
                    V_reg[w, j, d] = V[i_b, i_s + j, i_h, i_v * BV + d]''')
    fn = fn.replace('for j, d in T.Parallel(BS,', 'for w, j, d in T.Parallel(NW, BS,')
    fn = fn.replace('K_reg[j, d]', 'K_reg[w, j, d]').replace('V_reg[j, d]', 'V_reg[w, j, d]')
    fn = fn.replace('KV_shared[(j) * BK', 'KV_shared[w * BS * VSTRIDE + (j) * BK')
    fn = fn.replace('KV_shared[(j * 16 + tid % 16)', 'KV_shared[wave * BS * VSTRIDE + (j * 16 + tid % 16)')
    fn = once(fn, 'KV_shared[row * BK + col]', 'KV_shared[wave * BS * VSTRIDE + row * BK + col]')
    fn = fn.replace('T.Parallel(G,', 'T.Parallel(M,').replace('T.Parallel(G)', 'T.Parallel(M)')
    fn = once(fn, '''                T.copy(acc_o, Output[
                    i_b, i_t, i_h * G : (i_h + 1) * G,
                    i_v * BV + vo * VW : i_v * BV + (vo + 1) * VW])''', '''                for m, d in T.Parallel(M, VW):
                    Output[i_b, bx * NW + m // G, i_h * G + m % G,
                           i_v * BV + vo * VW + d] = acc_o[m, d]''')
    save(f'waves{nw}_pv{vw}', fn,
         'S == 1 and D in (32, 64, 128) and block_size in (16, 32, 64)')


if __name__ == '__main__':
    for v in (4, 16, 32):
        stage_vec(v)
    for early in (False, True):
        q_shared(early)
    for n, vw in ((1, 32), (2, 32), (4, 32), (2, 64)):
        waves(n, vw)
