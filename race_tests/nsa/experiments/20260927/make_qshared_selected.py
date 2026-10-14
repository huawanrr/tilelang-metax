from pathlib import Path
import ast
s=Path('experiments/20260926/selected.py').read_text()
a=s.index('def native_sparse_attention_single_block(')
b=s.index('\n\n@tilelang.jit',a)
p=s[a:b]
p=p.replace('    q_preload=False,','    q_preload=False,\n    q_shared_preload=False,',1)
p=p.replace('    head_kv = heads // groups','    preload_shared_q = q_shared_preload and not (q_frag or kv_frag)\n    head_kv = heads // groups',1)
p=p.replace('''            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS''','''            if preload_shared_q:
                # On small grids, issue Q before waiting for the selected-block index.
                T.copy(Q[i_b, i_t, i_h * G:(i_h+1)*G, :], Q_shared)
            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS''',1)
x=p.index('                elif stage_regs:')
y=p.index('                if is_causal:',x)
body=p[x:y]
body=body.replace('''                    if not (q_frag and q_preload):''','''                    if not (q_frag and q_preload) and not preload_shared_q:''')
body=body.replace('''                    if not q_frag:
                        T.copy(Q_reg, Q_shared)''','''                    if not q_frag and not preload_shared_q:
                        T.copy(Q_reg, Q_shared)''')
body=body.replace('''                    else:
                        T.copy(
                            Q[i_b, i_t, i_h * G : (i_h + 1) * G, :],
                            Q_shared,
                        )''','''                    elif not preload_shared_q:
                        T.copy(
                            Q[i_b, i_t, i_h * G : (i_h + 1) * G, :],
                            Q_shared,
                        )''')
p=p[:x]+body+p[y:]
s=s[:a]+p+s[b:]
a=s.index('def _get_kernel(')
b=s.index('\n\ndef _as_int32',a)
p=s[a:b]
p=p.replace('    scale_log2 =', '''    q_shared_preload = (S == 1 and D == 64 and block_size == 16
        and groups == 16 and threads == 64 and 256 < grid <= 1024
        and stage_regs and q_preload and not q_frag and not kv_frag)
    scale_log2 =''',1)
p=p.replace('''        direct_k,
    )''','''        direct_k,
        q_shared_preload,
    )''',1)
p=p.replace('''                q_preload=q_preload,
                **common,''','''                q_preload=q_preload,
                q_shared_preload=q_shared_preload,
                **common,''',1)
s=s[:a]+p+s[b:]
ast.parse(s)
assert s.count('q_shared_preload=False')==1
Path('experiments/20260927/qshared_selected.py').write_text(s)
