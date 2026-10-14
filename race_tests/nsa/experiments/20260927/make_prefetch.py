"""Synchronous shared-to-register fragment scheduling variants."""
from pathlib import Path
base=Path('experiments/20260926/selected.py').read_text()
for mode in ['k','v','kv','vlate']:
 s=base
 a=s.index('def native_sparse_attention_single_block_emitter(')
 b=s.index('\n\n@tilelang.jit',a)
 p=s[a:b]
 if mode in ('k','kv'):
  p=p.replace('            K_reg = T.alloc_fragment([BS, BK], T.float16)', '            K_reg = T.alloc_fragment([BS, BK], T.float16)\n            K_mma = T.alloc_fragment([BS, BK], T.float16)')
  p=p.replace('                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),','                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),\n                K_mma: qk.make_mma_load_layout(K_mma, "B"),')
  p=p.replace('                for ki in T.serial(qk_steps):','                if not direct_k:\n                    T.copy(KV_shared, K_mma)\n                for ki in T.serial(qk_steps):',1)
  p=p.replace('''                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)''','''                        qk.mma(Q_reg, K_mma, acc_s, ki)''')
 if mode in ('v','kv','vlate'):
  p=p.replace('            V_reg = T.alloc_fragment([BS, BV], T.float16)','            V_reg = T.alloc_fragment([BS, BV], T.float16)\n            V_mma = T.alloc_fragment([BS, BV], T.float16)')
  p=p.replace('                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),','                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),\n                V_mma: pv.make_mma_load_layout(V_mma, "B"),')
  copy='''                if kv_split:
                    T.copy(V_shared, V_mma)
                else:
                    T.copy(KV_shared, V_mma)
'''
  if mode=='vlate':
   p=p.replace('                for ki in T.serial(pv_steps):',copy+'                for ki in T.serial(pv_steps):',1)
  else:
   p=p.replace('''                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2''',copy+'''                for i, j in T.Parallel(G, BS):
                    acc_s[i, j] = T.exp2''',1)
  p=p.replace('''                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)''','''                    pv.mma(acc_s_cast, V_mma, acc_o, ki)''')
 import ast
 s=s[:a]+p+s[b:]
 ast.parse(s)
 Path('experiments/20260927/prefetch_'+mode+'.py').write_text(s)
