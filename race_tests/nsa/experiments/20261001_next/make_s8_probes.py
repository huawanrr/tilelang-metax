"""Stage Q and/or O on the existing packed online kernels."""
import json
from make_probes import BASE, HERE, once, change_function, with_flags, write


def online_staging(source=BASE, q=True, o=True, scheduler=None):
    def modify(fn):
        fn = once(fn, '        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
                  '''        tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
        tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,''')
        if q:
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
        if o:
            war = '            T.sync_warp()\n' if q else ''
            fn = once(fn, '''            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])''',
                      '''            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: T.Fragment([G, BV],
                    forward_thread_fn=lambda oi, od: oi + (od % 16 // 4) * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            T.copy(acc_o, O_reg)
''' + war + '''            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])''')
        if scheduler:
            fn = with_flags(fn, scheduler)
        return fn
    for name in ('native_sparse_attention_online_packed',
                 'native_sparse_attention_online_packed_batch_minor',
                 'native_sparse_attention_online_packed_quad_batch_minor'):
        source = change_function(source, name, modify)
    return source


if __name__ == '__main__':
    for name, kwargs in (
        ('s8_qo', dict()), ('s8_q', dict(o=False)), ('s8_o', dict(q=False)),
        ('s8_qo_ilp', dict(scheduler='ilp')),
    ):
        write(name, online_staging(**kwargs))
    path = HERE / 'family_cases.json'
    cases = json.loads(path.read_text())
    for b, t, h in ((8,1024,1),(4,512,1),(1,4096,1),(1,8192,1),
                    (8,512,1),(1,1024,4),(2,1024,2),(4,1024,2),
                    (1,512,1),(1,1024,1),(1,2048,1),(1,1536,1),
                    (16,256,1),(1,256,16),(8,128,1)):
        cases[f's8_b{b}_t{t}_h{h}'] = dict(B=b, SEQ_LEN=t, H=h, HQ=h*16,
                                          D=64, S=8, block_size=16, is_causal=True)
    path.write_text(json.dumps(cases, indent=2)+'\n')
