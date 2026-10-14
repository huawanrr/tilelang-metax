from pathlib import Path
import ast
s=Path('experiments/20260926/online_packed_indices.py').read_text()
a=s.index('def native_sparse_attention_online_emitter(');b=s.index('\n\ndef _emitters',a)
p=s[a:b]
p=p.replace('G, BS = groups, block_size','G, BS = groups, block_size * 2')
p=p.replace('T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16','T.ceildiv(seq_len, block_size), head_kv, BK // 32, block_size // 16')
p=p.replace('T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32','T.ceildiv(seq_len, block_size), head_kv, block_size // 16, BK // 32')
p=p.replace('indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS','indices[si] = BlockIndices[i_b, i_t, i_h, si] * block_size')
a0=p.index('            for s in T.unroll(S, unroll_factor=online_unroll):')
b0=p.index('            T.reduce_sum(sum_acc, scores_sum',a0)
p=p[:a0]+'''            for s in T.unroll(S // 2, unroll_factor=online_unroll):
                first = indices[s*2]
                second = indices[s*2+1]
                for j, d in T.Parallel(BS, BK):
                    pos = T.if_then_else(j < block_size, first, second)
                    ok = pos >= 0 and pos < seq_len and (not is_causal or pos <= i_t)
                    safe_block = T.max(0, T.min(pos // block_size, T.ceildiv(seq_len, block_size)-1))
                    K_reg[j, d] = T.if_then_else(ok,
                        K[i_b, safe_block, i_h, d//32, (j%block_size)//16,
                          d%32//8*16+j%16, d%8], 0)
                for j, d in T.Parallel(BS, BV):
                    pos = T.if_then_else(j < block_size, first, second)
                    ok = pos >= 0 and pos < seq_len and (not is_causal or pos <= i_t)
                    safe_block = T.max(0, T.min(pos // block_size, T.ceildiv(seq_len, block_size)-1))
                    V_reg[j, d] = T.if_then_else(ok,
                        V[i_b, safe_block, i_h, (j%block_size)//16, d//32,
                          j%16//4*16+d%16, d%32//16*4+j%4], 0)
                for i,j in T.Parallel(G,BS):
                    pos = T.if_then_else(j < block_size, first, second) + j%block_size
                    acc_s[i,j] = T.if_then_else(pos>=0 and pos<seq_len and
                        (not is_causal or pos<=i_t), 0, neg_inf)
                for ki in T.serial(qk_steps):
                    qk.mma(Q_reg, K_reg, acc_s, ki)
                for i,j in T.Parallel(G,BS):
                    acc_s[i,j] = T.exp2(T.min(acc_s[i,j]*scale_log2,15.0))
                    sum_acc[i,j] += acc_s[i,j]
                T.copy(acc_s,acc_s_cast)
                for ki in T.serial(pv_steps):
                    pv.mma(acc_s_cast,V_reg,acc_o,ki)

'''+p[b0:]
s=s[:a]+p+s[b:]
ast.parse(s)
Path('experiments/20260926/online_pair2.py').write_text(s)
