from pathlib import Path
import ast
base=Path('experiments/20260926/baseline.py').read_text()
for mode in ['k','kv_reuse','kv_split']:
 s=base;a=s.index('def native_sparse_attention_single_block_emitter(');b=s.index('\n\n_KERNEL_CACHE',a);p=s[a:b]
 if mode=='kv_split':
    p=p.replace('    head_kv = heads // groups','    kv_split = True\n    head_kv = heads // groups',1)
 p=p.replace('            Q_reg = T.alloc_fragment', '            bar = T.alloc_maca_barrier()\n            Q_reg = T.alloc_fragment',1)
 p=p.replace('''                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)''','''                T.maca_async_copy(K[i_b,i_s:i_s+BS,i_h,:], KV_shared, barrier=bar)''')
 p=p.replace('                T.copy(K_reg, KV_shared)\n','')
 if mode!='k':
    p=p.replace('''                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)\n''','')
    p=p.replace('''                    T.copy(V_reg, V_shared)''','''                    T.maca_async_copy(V[i_b,i_s:i_s+BS,i_h,:], V_shared, barrier=bar)''')
 p=p.replace('''                for ki in T.serial(qk_steps):''','''                T.maca_barrier_arrive_and_wait(bar)
                for ki in T.serial(qk_steps):''',1)
 if mode=='kv_reuse':
    p=p.replace('''                    T.copy(V_reg, KV_shared)''','''                    T.maca_async_copy(V[i_b,i_s:i_s+BS,i_h,:], KV_shared, barrier=bar)''')
    p=p.replace('''                for ki in T.serial(pv_steps):''','''                T.maca_barrier_arrive_and_wait(bar)
                for ki in T.serial(pv_steps):''',1)
 s=s[:a]+p+s[b:];ast.parse(s);Path('experiments/20260926/async_'+mode+'.py').write_text(s)
for mode in ['k','kv']:
 s=base;a=s.index('def native_sparse_attention_online_emitter(');b=s.index('\n\ndef _emitters',a);p=s[a:b]
 p=p.replace('            Q_reg = T.alloc_fragment', '            bar = T.alloc_maca_barrier()\n            Q_reg = T.alloc_fragment',1)
 p=p.replace('''                    T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)''','''                    T.maca_async_copy(K[i_b,i_s:i_s+BS,i_h,:], K_shared, barrier=bar)''')
 p=p.replace('                    T.copy(K_reg, K_shared)\n','')
 if mode=='kv':
    p=p.replace('''                    T.copy(
                        V[i_b, i_s : i_s + BS, i_h,
                          i_v * BV : (i_v + 1) * BV],
                        V_reg,
                    )''','''                    T.maca_async_copy(V[i_b,i_s:i_s+BS,i_h,:], V_shared, barrier=bar)''')
    p=p.replace('                    T.copy(V_reg, V_shared)\n','')
 p=p.replace('''                    for ki in T.serial(qk_steps):''','''                    T.maca_barrier_arrive_and_wait(bar)
                    for ki in T.serial(qk_steps):''',1)
 s=s[:a]+p+s[b:];ast.parse(s);Path('experiments/20260926/async_online_'+mode+'.py').write_text(s)
