from pathlib import Path
import ast
base=Path('experiments/20260926/baseline.py').read_text()
a=base.index('def native_sparse_attention_online_emitter(')
b=base.index('\n\ndef _emitters',a)
part=base[a:b]
for name in ['indices','direct_k','packed_kv']:
 p=part
 if name=='indices':
    p=p.replace('''            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)''','''            indices = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)''')
    p=p.replace('i_s = BlockIndices[i_b, i_t, i_h, s] * BS','i_s = indices[s]')
 else:
    p=p.replace('Q_reg: qk.make_mma_load_layout(Q_reg, "A"),','Q_reg: qk.make_mma_load_layout(Q_reg, "A"),\n                K_reg: qk.make_mma_load_layout(K_reg, "B"),')
    p=p.replace('                    T.copy(K_reg, K_shared)\n','')
    p=p.replace('                        qk.ldmatrix_b(kb, K_shared, ki)\n','')
    p=p.replace('qk.mma(Q_reg, kb, acc_s, ki)','qk.mma(Q_reg, K_reg, acc_s, ki)')
 if name=='packed_kv':
    p=p.replace('    qk, pv = _emitters', '''    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]
    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]
    qk, pv = _emitters''',1)
    p=p.replace('K: T.Tensor(kv_shape, T.float16)', 'K: T.Tensor(packed_k_shape, T.float16)')
    p=p.replace('V: T.Tensor(kv_shape, T.float16)', 'V: T.Tensor(packed_shape, T.float16)')
    p=p.replace('Q_reg: qk.make_mma_load_layout(Q_reg, "A"),','Q_reg: qk.make_mma_load_layout(Q_reg, "A"),\n                V_reg: pv.make_mma_load_layout(V_reg, "B"),')
    p=p.replace('                    T.copy(V_reg, V_shared)\n','')
    p=p.replace('                        pv.ldmatrix_b(vb, V_shared, ki)\n','')
    p=p.replace('pv.mma(acc_s_cast, vb, acc_o, ki)','pv.mma(acc_s_cast, V_reg, acc_o, ki)')
    p=p.replace('                    T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)', '''                    for j, d in T.Parallel(BS, BK):
                        K_reg[j, d] = K[i_b, i_s // BS, i_h, d // 32,
                                        j // 16, (d % 32 // 8) * 16 + j % 16, d % 8]''')
    p=p.replace('''                    T.copy(
                        V[i_b, i_s : i_s + BS, i_h,
                          i_v * BV : (i_v + 1) * BV],
                        V_reg,
                    )''','''                    for j, d in T.Parallel(BS, BV):
                        V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                        d // 32, (j % 16 // 4) * 16 + d % 16,
                                        (d % 32 // 16) * 4 + j % 4]''')
 src=base[:a]+p+base[b:]
 if name=='packed_kv':
    packed=Path('experiments/20260926/packed_kv.py').read_text()
    begin=packed.index('\n\n@tilelang.jit\ndef pack_values')
    end=packed.index('\n\n_KERNEL_CACHE',begin)
    pos=src.index('\n\n_KERNEL_CACHE')
    src=src[:pos]+packed[begin:end]+src[pos:]
    begin=packed.index('        if S == 1 and use_emitter:\n            attention = kernel')
    end=packed.index('        _KERNEL_CACHE[key] = kernel',begin)
    wrap=packed[begin:end].replace('if S == 1 and use_emitter:', 'if S > 1 and use_emitter_online:')
    src=src.replace('        _KERNEL_CACHE[key] = kernel',wrap+'        _KERNEL_CACHE[key] = kernel')
 ast.parse(src)
 Path('experiments/20260926/online_'+name+'.py').write_text(src)
