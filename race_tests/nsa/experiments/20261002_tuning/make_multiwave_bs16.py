"""Place independent BS16 queries in separate waves of one CTA.

All shared allocations have the same 16-row stride per wave, so barriers
protect only data owned by the calling wave, including allocation reuse.
"""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE.parent / '20261001_final/nsa.py').read_text()
node = next(n for n in ast.parse(BASE).body if isinstance(n, ast.FunctionDef) and n.name == '_coalesced_qo_prim')
lines = BASE.splitlines(keepends=True)
start = node.lineno - 1
original = ''.join(lines[start:node.end_lineno])


def once(source, a, b):
    assert source.count(a) == 1, (a, source.count(a))
    return source.replace(a, b)


for nw in (2, 4, 8):
    fn = once(original, '    G, BS = groups, block_size',
              f'    G, BS = groups, block_size\n    NW = {nw}\n    M = G * NW\n    assert BS == G == 16')
    fn = once(fn, '    qk, pv = _emitters(T.float16, T.float32, BS, BK)',
        '''    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=BK, k_pack=2)''')
    fn = once(fn, '        block_row_warps=1, block_col_warps=1,',
              '        block_row_warps=NW, block_col_warps=1,')
    fn = once(fn, '        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,\n'
                  '                      threads=threads) as (bx, by, bz):',
                  '        with T.Kernel(T.ceildiv(seq_len, NW), T.ceildiv(dim, BV), batch * head_kv,\n'
                  '                      threads=threads * NW) as (bx, by, bz):')
    fn = fn.replace('T.alloc_fragment([G,', 'T.alloc_fragment([M,')
    fn = fn.replace('T.alloc_fragment([G]', 'T.alloc_fragment([M]')
    fn = fn.replace('T.alloc_shared([G,', 'T.alloc_shared([M,')
    fn = fn.replace('T.Fragment([G,', 'T.Fragment([M,')
    fn = fn.replace('T.Parallel(G,', 'T.Parallel(M,').replace('T.Parallel(G)', 'T.Parallel(M)')
    fn = fn.replace('T.alloc_fragment([BS,', 'T.alloc_fragment([NW, BS,')
    fn = once(fn, 'T.alloc_shared([BS * VSTRIDE]', 'T.alloc_shared([NW * BS * VSTRIDE]')
    fn = once(fn, 'KV_shared: T.Layout([BS * VSTRIDE], lambda i: i)',
              'KV_shared: T.Layout([NW * BS * VSTRIDE], lambda i: i)')
    fn = once(fn, '            tid = T.get_thread_binding()',
              '            full_tid = T.get_thread_binding()\n'
              '            wave = full_tid // 64\n            tid = full_tid % 64')
    fn = once(fn, 'forward_thread_fn=lambda i, d: i + (d % 16 // 4) * 16,',
              'forward_thread_fn=lambda i, d: i // G * 64 + i % G + (d % 16 // 4) * 16,')
    fn = once(fn, 'forward_thread_fn=lambda i, j: i + j * 16,',
              'forward_thread_fn=lambda i, j: i // G * 64 + i % G + j * 16,')
    fn = once(fn, 'forward_thread_fn=lambda i, d: (i * BK + d) // q_vec % 64,',
              'forward_thread_fn=lambda i, d: i // G * 64 + (i % G * BK + d) // q_vec % 64,')
    fn = once(fn, 'forward_index_fn=lambda i, d: (i * BK + d) // (64 * q_vec) * q_vec + d % q_vec)',
              'forward_index_fn=lambda i, d: (i % G * BK + d) // (64 * q_vec) * q_vec + d % q_vec)')
    for reg, width in (('K_reg', 'BK'), ('V_reg', 'BV')):
        fn = once(fn, f'''                {reg}: T.Fragment([BS, {width}],
                    forward_thread_fn=lambda j, d: (j * {width} + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * {width} + d) // 512 * 8 + d % 8),''',
            f'''                {reg}: T.Fragment([NW, BS, {width}],
                    forward_thread_fn=lambda w, j, d: w * 64 + (j * {width} + d) // 8 % 64,
                    forward_index_fn=lambda w, j, d: (j * {width} + d) // 512 * 8 + d % 8),''')
    fn = once(fn, '            i_t, i_v, i_bh = bx, by, bz',
              '            i_t, i_v, i_bh = bx * NW + wave, by, bz')
    fn = once(fn, '            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)',
        '''            for m, d in T.Parallel(M, BK):
                Q_stage[m, d] = T.if_then_else(bx * NW + m // G < seq_len,
                    Q[i_b, bx * NW + m // G, i_h * G + m % G, d], T.float16(0))''')
    fn = once(fn, '            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS',
        '''            i_s = T.if_then_else(i_t < seq_len,
                BlockIndices[i_b, i_t, i_h, 0] * BS, -BS)''')
    fn = once(fn, '''                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)''',
        '''                for w, j, d in T.Parallel(NW, BS, BK):
                    K_reg[w, j, d] = T.if_then_else(i_s + j < seq_len,
                        K[i_b, i_s + j, i_h, d], T.float16(0))
                for w, j, d in T.Parallel(NW, BS, BV):
                    V_reg[w, j, d] = T.if_then_else(i_s + j < seq_len,
                        V[i_b, i_s + j, i_h, i_v * BV + d], T.float16(0))''')
    fn = once(fn, '''                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]''',
        '''                    for w, j, d in T.Parallel(NW, BS, BK):
                        KV_shared[(w * BS + j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[w, j, d]''')
    fn = once(fn, 'kb[j * 8 + e] = KV_shared[(j * 16 + tid % 16) * BK',
              'kb[j * 8 + e] = KV_shared[(wave * BS + j * 16 + tid % 16) * BK')
    fn = once(fn, '''                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]''',
        '''                for w, j, d in T.Parallel(NW, BS, BV):
                    KV_shared[(w * BS + j) * BK + d] = V_reg[w, j, d]''')
    fn = once(fn, 'vb[j * 4 + e] = KV_shared[row * BK + col]',
              'vb[j * 4 + e] = KV_shared[(wave * BS + row) * BK + col]')
    fn = once(fn, '            O_shared = T.alloc_shared([M, BV], T.float16)',
        '''            O_shared = T.alloc_shared([M, BV], T.float16)
            O_global = T.alloc_fragment([M, BV], T.float16)
            T.annotate_layout({O_global: T.Fragment([M, BV],
                forward_thread_fn=lambda om, od: om // G * 64 + (om % G * BV + od) // 8 % 64,
                forward_index_fn=lambda om, od: (om % G * BV + od) // 512 * 8 + od % 8)})''')
    fn = once(fn, '            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])',
        '''            T.copy(O_shared, O_global)
            for m, d in T.Parallel(M, BV):
                if bx * NW + m // G < seq_len:
                    Output[i_b, bx * NW + m // G, i_h * G + m % G, d] = O_global[m, d]''')
    source = ''.join(lines[:start]) + fn + ''.join(lines[node.end_lineno:])
    ast.parse(source)
    dest = HERE / f'coalesced_waves{nw}.py'
    if dest.exists():
        raise FileExistsError(dest)
    dest.write_text(source)
    print(dest.name)
