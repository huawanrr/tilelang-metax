"""Protect the joined short-list kernel with wave barriers; probe Q/O staging."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE.parent / '20261001_final/nsa.py').read_text()
NAME = 'native_sparse_attention_short_list'
node = next(n for n in ast.parse(BASE).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
lines = BASE.splitlines(keepends=True)
start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
original = ''.join(lines[start:node.end_lineno])


def once(source, a, b):
    assert source.count(a) == 1, (a, source.count(a))
    return source.replace(a, b)


for qstage, ostage, extend in ((False, False, False), (True, False, False),
                              (False, True, False), (True, True, False),
                              (True, True, True)):
    fn = once(original,
        '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
        '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,\n'
        '        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,')
    fn = once(fn, '    head_kv = heads // groups',
              '    assert threads == 64 and groups == 16 and not direct_k and not kv_split\n'
              '    head_kv = heads // groups')
    fn = once(fn, '                kb = T.alloc_local(',
              '                T.sync_warp()\n                kb = T.alloc_local(')
    fn = once(fn,
        '                for j, d in T.Parallel(BS, BV):\n'
        '                    KV_shared[(j) * BK + (d)] = V_reg[j, d]',
        '                T.sync_warp()\n'
        '                for j, d in T.Parallel(BS, BV):\n'
        '                    KV_shared[(j) * BK + (d)] = V_reg[j, d]')
    fn = once(fn, '                T.copy(acc_s, acc_s_cast)',
              '                T.copy(acc_s, acc_s_cast)\n                T.sync_warp()')
    if qstage:
        fn = once(fn, '            Q_reg = T.alloc_fragment([G, BK], T.float16)',
            '''            Q_reg = T.alloc_fragment([G, BK], T.float16)
            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            T.annotate_layout({
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda qi, qd: (qi * BK + qd) // 8 % 64,
                    forward_index_fn=lambda qi, qd: (qi * BK + qd) // 512 * 8 + qd % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
            })''')
        fn = once(fn, '            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)',
                  '            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)')
        fn = once(fn, '                if not direct_k:',
            '''                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
                if not direct_k:''')
    if ostage:
        fn = once(fn,
            '''            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])''',
            '''            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: T.Fragment([G, BV],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            T.copy(acc_o, O_reg)
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])''')
    source = ''.join(lines[:start]) + fn + ''.join(lines[node.end_lineno:])
    if extend:
        source = once(source, 'or (S == 4 and seq_len >= 128 and grid <= 384)',
                      'or (S == 4 and seq_len >= 128)')
    ast.parse(source)
    dest = HERE / f'short_wave_q{int(qstage)}o{int(ostage)}_s4{int(extend)}.py'
    if dest.exists():
        raise FileExistsError(dest)
    dest.write_text(source)
    print(dest.name)
