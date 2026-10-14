"""Wider synchronous QK loads using explicit fragment mappings, without backend changes."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
tree = ast.parse(base)
node = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
            and n.name == 'native_sparse_attention_single_block_emitter')
lines = base.splitlines(keepends=True)
original = ''.join(lines[node.decorator_list[0].lineno - 1:node.end_lineno])
for pack in (2, 4, 8):
    part = original.replace('def native_sparse_attention_single_block_emitter(',
                            'def single_block_wide_qk(', 1)
    part = part.replace('    head_kv = heads // groups',
                        f'    KP = {pack}\n    head_kv = heads // groups', 1)
    part = part.replace('qk, pv = _emitters(T.float16, T.float32, BS, BK)',
                        'qk, pv = _emitters(T.float16, T.float32, BS, BK, qk_k_pack=KP)', 1)
    part = part.replace('Q_reg: qk.make_mma_load_layout(Q_reg, "A"),', '''Q_reg: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: i + (d % (KP * 16) // (KP * 4)) * 16,
                    forward_index_fn=lambda i, d: d // (KP * 16) * (KP * 4) + d % (KP * 4)),''', 1)
    part = part.replace('''                        qk.ldmatrix_b(kb, KV_shared, ki)
                        qk.mma(Q_reg, kb, acc_s, ki)''', '''                        tid = T.get_thread_binding()
                        for j in T.serial(BS // 16):
                            for e in T.vectorized(KP * 4):
                                kb[j * KP * 4 + e] = KV_shared[
                                    j * 16 + tid % 16,
                                    ki * KP * 16 + (tid // 16) * KP * 4 + e]
                        qk.mma(Q_reg, kb, acc_s, ki)''', 1)
    assert 'qk.ldmatrix_b' not in part
    source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + part + '\n\n_KERNEL_CACHE = {}', 1)
    a = source.index('def _get_kernel(')
    host = source[a:].replace('''        if S == 1 and use_emitter:
''', '''        if S == 1 and use_emitter and D == 128 and block_size == 32:
            kernel = single_block_wide_qk(
                late_normalize=late_normalize, kv_split=kv_split,
                direct_k=False, lane_reduce=lane_reduce, **common)
        elif S == 1 and use_emitter:
''', 1)
    source = source[:a] + host
    ast.parse(source)
    name = f'qk_pack{pack}.py'
    (HERE / name).write_text(source)
    print(name)
