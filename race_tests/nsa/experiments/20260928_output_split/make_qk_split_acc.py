"""Break S1's D-reduction MMA chain into independent partial QK sums."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'baseline.py').read_text()
start = base.index('def native_sparse_attention_single_block_emitter(')
end = base.index('\n\n@tilelang.jit', start)
for ways in (2, 4):
    part = base[start:end]
    decl = ''.join(f'            acc_qk{k} = T.alloc_fragment([G, BS], T.float32)\n' for k in range(1, ways))
    anno = ''.join(f'                acc_qk{k}: qk.make_mma_store_layout(acc_qk{k}),\n' for k in range(1, ways))
    part = part.replace('            acc_s = T.alloc_fragment', decl + '            acc_s = T.alloc_fragment', 1)
    part = part.replace('                acc_s: qk.make_mma_store_layout(acc_s),', anno + '                acc_s: qk.make_mma_store_layout(acc_s),', 1)
    a = part.index('                for ki in T.serial(qk_steps):')
    b = part.index('\n                # Early V store:', a)
    code = ''.join(f'                T.clear(acc_qk{k})\n' for k in range(1, ways))
    code += '                for ki in T.unroll(qk_steps):\n'
    code += '                    if not direct_k:\n                        qk.ldmatrix_b(kb, KV_shared, ki)\n'
    for k in range(ways):
        buffer = 'acc_s' if k == 0 else f'acc_qk{k}'
        code += f'                    {"if" if k == 0 else "elif"} ki % {ways} == {k}:\n'
        code += f'                        qk.mma(Q_reg, K_reg if direct_k else kb, {buffer}, ki)\n'
    part = part[:a] + code + part[b:]
    key = '                for i, j in T.Parallel(G, BS):\n                    acc_s[i, j] = T.exp2'
    addition = '                for i, j in T.Parallel(G, BS):\n'
    addition += ''.join(f'                    acc_s[i, j] += acc_qk{k}[i, j]\n' for k in range(1, ways))
    assert part.count(key) == 1
    part = part.replace(key, addition + key)
    result = base[:start] + part + base[end:]
    ast.parse(result)
    (HERE / f'qk_acc{ways}.py').write_text(result)
