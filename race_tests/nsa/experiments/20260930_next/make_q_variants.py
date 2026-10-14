"""Probe Q staging schedules and output tiles without changing old sources."""
import ast

from make_probes import HERE, once, save


def staged():
    source = (HERE / 'q_shared_late.py').read_text()
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == 'native_sparse_attention_probe')
    lines = source.splitlines()
    fn = '\n'.join(lines[node.decorator_list[0].lineno - 1:node.end_lineno]) + '\n'
    return once(fn, 'def native_sparse_attention_probe(', 'def native_sparse_attention_pv32_sync(')


if __name__ == '__main__':
    base = staged()
    for width in (16, 64, 128):
        save(f'q_shared_pv{width}', once(base, '    VW = min(32, BV)', f'    VW = min({width}, BV)'))
    for vec in (4, 16):
        fn = once(base, '(i * BK + d) // 8 % 64', f'(i * BK + d) // {vec} % 64')
        fn = once(fn, '(i * BK + d) // 512 * 8 + d % 8',
                  f'(i * BK + d) // {64 * vec} * {vec} + d % {vec}')
        save(f'q_load_vec{vec}', fn)
    for vec in (4, 16):
        fn = once(base, 'make_mma_swizzle_layout(Q_shared, vecSize=8)',
                  f'make_mma_swizzle_layout(Q_shared, vecSize={vec})')
        save(f'q_swizzle{vec}', fn)
    fn = once(base, '''                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
''', '                T.copy(Q_stage, Q_shared)\n')
    fn = once(fn, '''                # QK: Q_reg is already''',
              '''                T.copy(Q_shared, Q_reg)

                # QK: Q_reg is already''')
    save('q_shared_parallel', fn)
    fn = once(fn, '                T.copy(Q_shared, Q_reg)\n', '')
    fn = once(fn, '                for ki in T.serial(qk_steps):', '''                qa = T.alloc_local([8], T.float16)
                for ki in T.serial(qk_steps):
                    for e in T.vectorized(8):
                        qa[e] = Q_shared[tid % 16, ki * 32 + tid // 16 * 8 + e]''')
    fn = fn.replace('qk.mma(Q_reg, kb, acc_s, ki)', 'qk.mma(qa, kb, acc_s, ki)')
    save('q_shared_stream', fn)
