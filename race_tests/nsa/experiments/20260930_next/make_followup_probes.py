"""Immutable follow-up probes for synchronous staging and packed attention."""
import ast
from pathlib import Path

from make_probes import BASE, HERE, once


def extract(source, name):
    tree = ast.parse(source)
    node = next(n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == name)
    first = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return '\n'.join(source.splitlines()[first:node.end_lineno]) + '\n'


def save(name, source):
    ast.parse(source)
    path = HERE / (name + '.py')
    if path.exists():
        raise FileExistsError(path)
    path.write_text(source)
    print(path.name)


def qos():
    source = (HERE / 'qo_q8s8_o8_pv128.py').read_text()
    fn = extract(source, 'native_sparse_attention_probe')
    vload = '''                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)
'''
    without = once(fn, vload, '')
    before_mask = '                if is_causal and i_s + BS > i_t + 1:'
    before_store = '''                # Early V store: the copy's barrier wait overlaps the'''
    for name, marker in [('qo_v_after_k_store', before_mask), ('qo_v_after_qk', before_store)]:
        changed = once(without, marker, vload + marker)
        save(name, once(source, fn, changed))

    # For a whole number of blocks, the existing aligned start is valid iff
    # it is at most seq_len - BS. This gives bounds inference a tighter fact.
    changed = fn.replace('i_s >= 0 and i_s < seq_len and',
        'i_s >= 0 and i_s < (seq_len - BS + 1 if seq_len % BS == 0 else seq_len) and')
    assert changed != fn
    save('qo_aligned_bounds', once(source, fn, changed))

    tail_start = fn.index('            vb = T.alloc_local(')
    tail_end = fn.index('            O_shared = T.alloc_shared', tail_start)
    old_tail = fn[tail_start:tail_end]
    new_tail = '''                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    for j in T.serial(VW // 16):
                        for e in T.serial(4):
                            row = ki * 16 + tid // 16 * 4 + e
                            col = j * 16 + tid % 16
                            vb[j * 4 + e] = KV_shared[row * BK + col]
                    pv.mma(acc_s_cast, vb, acc_o, ki)
            T.copy(acc_o, O_reg)

'''
    changed = once(fn, old_tail, new_tail)
    save('qo_join_valid', once(source, fn, changed))
    changed = changed.replace('i_s >= 0 and i_s < seq_len and',
        'i_s >= 0 and i_s < (seq_len - BS + 1 if seq_len % BS == 0 else seq_len) and')
    save('qo_join_aligned', once(source, fn, changed))


def online():
    names = ('native_sparse_attention_online_packed',
             'native_sparse_attention_online_packed_batch_minor',
             'native_sparse_attention_online_packed_quad_batch_minor')
    for stage_q, stage_o in ((True, False), (False, True), (True, True)):
        builders = []
        for name in names:
            fn = extract(BASE, name)
            fn = once(fn, name + '(', name + '_qo(')
            fn = once(fn, '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
                '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,\n'
                '        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,')
            fn = once(fn, '    head_kv = heads // groups',
                '    assert threads == 64 and groups == 16 and dim == 64 and block_size == 16\n'
                '    head_kv = heads // groups')
            if stage_q:
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
                    '''            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)
            T.copy(Q_stage, Q_shared)
            T.sync_warp()
            T.copy(Q_shared, Q_reg)''')
            if stage_o:
                old = '''            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])'''
                new = '''            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: pv.make_mma_store_layout(O_reg),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            T.copy(acc_o, O_reg)
'''
                if stage_q:
                    new += '            T.sync_warp()\n'
                new += '''            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])'''
                fn = once(fn, old, new)
            builders.append(fn)
        result = once(BASE, '\n_KERNEL_CACHE = {}', '\n' + '\n'.join(builders) + '\n_KERNEL_CACHE = {}')
        start = result.index('        elif S >= 8 and use_emitter_online:')
        end = result.index('        elif S > 1 and use_emitter_online:', start)
        branch = result[start:end]
        for name in reversed(names):
            branch = branch.replace(name + '(', name + '_qo(')
        result = result[:start] + branch + result[end:]
        save(f'online_q{int(stage_q)}o{int(stage_o)}', result)


if __name__ == '__main__':
    qos()
    online()
