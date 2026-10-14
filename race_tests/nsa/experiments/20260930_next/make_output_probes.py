"""Collect PV tiles and compare direct versus coalesced shared output stores."""
from make_probes import once, save, extract
from make_q_variants import staged


if __name__ == '__main__':
    for with_q, shared, vw in ((True, False, 32), (True, True, 32),
                              (True, True, 64), (False, True, 32)):
        fn = staged() if with_q else extract('native_sparse_attention_pv32_sync')
        fn = once(fn, '    VW = min(32, BV)', f'    VW = min({vw}, BV)')
        fn = once(fn, '            acc_o = T.alloc_fragment([G, VW], T.float32)', '''            acc_o = T.alloc_fragment([G, VW], T.float32)
            O_reg = T.alloc_fragment([G, BV], T.float16)
            T.annotate_layout({O_reg: T.Fragment([G, BV],
                forward_thread_fn=lambda i, d: i + (d % 16 // 4) * 16,
                forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})''')
        fn = once(fn, '''                T.copy(acc_o, Output[
                    i_b, i_t, i_h * G : (i_h + 1) * G,
                    i_v * BV + vo * VW : i_v * BV + (vo + 1) * VW])''', '''                for i, d in T.Parallel(G, VW):
                    O_reg[i, vo * VW + d] = acc_o[i, d]
''')
        if shared:
            final = '''            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_reg, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])
'''
        else:
            final = '''            T.copy(O_reg, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])
'''
        fn = once(fn, '    return kernel', final + '\n    return kernel')
        save(f'output_{"q" if with_q else "plain"}_{"shared" if shared else "reg"}_{vw}', fn)
