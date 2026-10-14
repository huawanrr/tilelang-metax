from pathlib import Path
import ast
s=Path('experiments/20260927/qshared_selected.py').read_text()
a=s.index('def native_sparse_attention_online_packed(')
b=s.index('\n\n@tilelang.jit',a)
p=s[a:b]
p=p.replace('selected_blocks, scale_log2, threads=64, online_unroll=2,','selected_blocks, scale_log2, threads=64, online_unroll=2, dual_acc=False,',1)
p=p.replace('            acc_o = T.alloc_fragment([G, BV], T.float32)','            acc_o = T.alloc_fragment([G, BV], T.float32)\n            acc_o_alt = T.alloc_fragment([G, BV], T.float32)',1)
p=p.replace('                acc_o: pv.make_mma_store_layout(acc_o),','                acc_o: pv.make_mma_store_layout(acc_o),\n                acc_o_alt: pv.make_mma_store_layout(acc_o_alt),',1)
p=p.replace('            T.fill(acc_o, 0)','            T.fill(acc_o, 0)\n            if dual_acc:\n                T.fill(acc_o_alt, 0)',1)
p=p.replace('''                        pv.mma(acc_s_cast, V_reg, acc_o, ki)''','''                        if dual_acc and s % 2 != 0:
                            pv.mma(acc_s_cast, V_reg, acc_o_alt, ki)
                        else:
                            pv.mma(acc_s_cast, V_reg, acc_o, ki)''',1)
p=p.replace('''            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)''','''            if dual_acc:
                for i, j in T.Parallel(G, BV):
                    acc_o[i, j] += acc_o_alt[i, j]
            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)''',1)
s=s[:a]+p+s[b:]
a=s.index('def _get_kernel(')
b=s.index('\n\ndef _as_int32',a)
p=s[a:b]
p=p.replace('    key = (','''    # Separate alternating PV sums shorten the dependency chain for large S8 grids.
    # S16 and small grids lose throughput to the additional accumulator registers.
    dual_acc = S == 8 and use_emitter_online and grid >= 4096
    key = (''',1)
p=p.replace('        q_shared_preload,\n    )','        q_shared_preload,\n        dual_acc,\n    )',1)
p=p.replace('''            attention = native_sparse_attention_online_packed(
                selected_blocks=S, online_unroll=online_unroll, **common)''','''            attention = native_sparse_attention_online_packed(
                selected_blocks=S, online_unroll=online_unroll,
                dual_acc=dual_acc, **common)''',1)
s=s[:a]+p+s[b:]
ast.parse(s)
Path('experiments/20260927/round2.py').write_text(s)
