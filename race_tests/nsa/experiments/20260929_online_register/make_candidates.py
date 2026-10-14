"""Apply the synchronous operand exchange to the online attention loop."""
import ast
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT / 'experiments/20260929_recheck'))
from make_shuffle_candidates import exchange, indent

base = (ROOT / 'experiments/20260929_candidate/nsa.py').read_text()
node = next(n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)
            and n.name == 'native_sparse_attention_online_emitter')
lines = base.splitlines(keepends=True)
original = ''.join(lines[node.decorator_list[0].lineno - 1:node.end_lineno])
for name, k_shuffle, v_vec, v_layout in (
    ('online_k', True, 0, 'original'),
    ('online_k_linear', True, 0, 'linear'),
    ('online_linear', False, 0, 'linear'),
    ('online_bank', False, 0, 'bank'),
    ('online_kv2', True, 2, 'original'),
    ('online_kv4', True, 4, 'original'),
):
    part = original.replace('def native_sparse_attention_online_emitter(',
                            'def native_sparse_attention_online_register(', 1)
    allocations = ['tid = T.get_thread_binding()']
    if k_shuffle:
        alloc, loads, body = exchange('ks', 64, 16, 8, 'K')
        allocations += alloc
        part = part.replace('                    T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)', indent(loads, 20))
        part = part.replace('                    T.copy(K_reg, K_shared)', indent(body, 20))
        part = part.replace('''                    for ki in T.serial(qk_steps):
                        qk.ldmatrix_b(kb, K_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)''', '''                    for ki in T.unroll(qk_steps):
                        for e in T.vectorized(8):
                            kb[e] = ks_mma[ki * 8 + e]
                        qk.mma(Q_reg, kb, acc_s, ki)''', 1)
    if v_vec:
        alloc, loads, body = exchange('vs', 64, 16, v_vec, 'V')
        allocations += alloc
        part = part.replace('''                    T.copy(
                        V[i_b, i_s : i_s + BS, i_h,
                          i_v * BV : (i_v + 1) * BV],
                        V_reg,
                    )''', indent(loads, 20))
        part = part.replace('                    T.copy(V_reg, V_shared)', indent(body, 20))
        part = part.replace('''                    for ki in T.serial(pv_steps):
                        pv.ldmatrix_b(vb, V_shared, ki)
                        pv.mma(acc_s_cast, vb, acc_o, ki)''', '''                    for ki in T.unroll(pv_steps):
                        for e in T.vectorized(16):
                            vb[e] = vs_mma[ki * 16 + e]
                        pv.mma(acc_s_cast, vb, acc_o, ki)''', 1)
    if v_layout != 'original':
        replacement = ('T.Layout([BS, BV], lambda j, d: (j, d))' if v_layout == 'linear' else
                       'T.Layout([BS, BV], lambda j, d: (j, ((d // 16) ^ (j // 4)) * 16 + d % 16))')
        part = part.replace('''tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    V_shared, vecSize=8)''', replacement, 1)
    part = part.replace('            Q_reg = T.alloc_fragment([G, BK], T.float16)',
                        indent(allocations, 12) + '\n            Q_reg = T.alloc_fragment([G, BK], T.float16)', 1)
    source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + part + '\n\n_KERNEL_CACHE = {}', 1)
    a = source.index('def _get_kernel(')
    host = source[a:].replace('        if d32_shuffle:\n', '''        if S > 1 and use_emitter_online:
            kernel = native_sparse_attention_online_register(
                selected_blocks=S, online_unroll=online_unroll, **common)
        elif d32_shuffle:
''', 1)
    source = source[:a] + host
    ast.parse(source)
    (HERE / f'{name}.py').write_text(source)
    print(name)
