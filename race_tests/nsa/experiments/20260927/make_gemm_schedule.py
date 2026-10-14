from pathlib import Path
base=Path('experiments/20260926/selected.py').read_text()
for mode in ['early_v','qshared','late','early_v_late']:
 s=base
 a=s.index('def native_sparse_attention_single_block(')
 b=s.index('\n\n@tilelang.jit',a)
 p=s[a:b]
 if 'early_v' in mode:
  x=p.index('                # Early V store (see the emitter kernel):')
  y=p.index('                if not late_normalize:',x)
  copy=p[x:y]
  p=p[:x]+p[y:]
  at=p.index('                if nmax:\n')
  p=p[:at]+copy+p[at:]
 if mode=='qshared':
  p=p.replace('''            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS''','''            if not (q_frag or kv_frag):
                T.copy(Q[i_b, i_t, i_h * G:(i_h+1)*G, :], Q_shared)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS''',1)
  x=p.index('                elif stage_regs:')
  y=p.index('                if is_causal:',x)
  body=p[x:y]
  body=body.replace('''                    if not (q_frag and q_preload):''','''                    if q_frag and not q_preload:''')
  body=body.replace('''                    if not q_frag:
                        T.copy(Q_reg, Q_shared)
''','')
  body=body.replace('''                    else:
                        T.copy(
                            Q[i_b, i_t, i_h * G : (i_h + 1) * G, :],
                            Q_shared,
                        )
''','')
  p=p[:x]+body+p[y:]
 s=s[:a]+p+s[b:]
 if 'late' in mode:
  s=s.replace('''    if q_preload is None:''','''    if S == 1 and D == 64 and block_size == 16:
        late_normalize = True
    if q_preload is None:''',1)
 import ast
 ast.parse(s)
 Path('experiments/20260927/gemm_'+mode+'.py').write_text(s)
