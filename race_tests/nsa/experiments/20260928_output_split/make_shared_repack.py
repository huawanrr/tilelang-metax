"""Reuse K's physical shared allocation for packed V operand loads."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'baseline.py').read_text()
start = base.index('def native_sparse_attention_single_block_emitter(')
end = base.index('\n\n@tilelang.jit', start)
part = base[start:end]
part = part.replace('    qk, pv = _emitters', '''    per_phase = max(1, 64 // BK)
    max_phase = min(16 // per_phase, BK // 8)
    qk, pv = _emitters''', 1)
part = part.replace('            V_reg = T.alloc_fragment([BS, BV], T.float16)', '''            V_reg = T.alloc_fragment([BS, BV], T.float16)
            V_mma = T.alloc_fragment([BS, BV], T.float16)''')
part = part.replace('                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),', '''                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),
                V_mma: pv.make_mma_load_layout(V_mma, "B"),''')
offset = '''j // 16 * (BV // 32) * 512 + d // 32 * 512 + ((j % 16 // 4) * 16 + d % 16) * 8 + (d % 32 // 16) * 4 + j % 4'''
part = part.replace('''                    T.copy(V_reg, KV_shared)''', f'''                    for j, d in T.Parallel(BS, BV):
                        pos = {offset}
                        row = pos // BK
                        col = ((pos % BK // 8) ^ (row // per_phase % max_phase)) * 8 + pos % 8
                        KV_shared[row, col] = V_reg[j, d]''')
part = part.replace('''                vb = T.alloc_local(
                    [pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
                for ki in T.serial(pv_steps):
                    pv.ldmatrix_b(vb, V_shared, ki)
                    pv.mma(acc_s_cast, vb, acc_o, ki)''', f'''                for j, d in T.Parallel(BS, BV):
                    pos = {offset}
                    row = pos // BK
                    col = ((pos % BK // 8) ^ (row // per_phase % max_phase)) * 8 + pos % 8
                    V_mma[j, d] = KV_shared[row, col]
                for ki in T.serial(pv_steps):
                    pv.mma(acc_s_cast, V_mma, acc_o, ki)''')
part = part.replace('    head_kv = heads // groups', '    kv_split = False\n    head_kv = heads // groups', 1)
result = base[:start] + part + base[end:]
ast.parse(result)
(HERE / 'shared_repack.py').write_text(result)
