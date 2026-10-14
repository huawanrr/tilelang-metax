"""Stage Q/O for multiple queries together while retaining independent attention."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once
from make_small_candidate import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def indent(text, width):
    return ''.join(' ' * width + line if line.strip() else line
                   for line in text.splitlines(keepends=True))


def make_function(original):
    fn = extract(original, 'native_sparse_attention_single_packed_qo_v2')
    fn = replace_once(fn, 'native_sparse_attention_single_packed_qo_v2(',
                      'native_sparse_attention_packed_query_tiles(')
    fn = replace_once(fn, 'groups, scale_log2, threads=64, width=32, late=False):',
                      'groups, scale_log2, threads=64, width=32, late=False, queries=2, incremental=False, q_vec=4):')
    fn = replace_once(fn, '    H = heads // groups', '    M = G * queries\n    H = heads // groups')
    fn = replace_once(fn, 'with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):',
                      'with T.Kernel(T.ceildiv(seq_len, queries), batch * H, threads=threads) as (tile, bh):')
    for name, alloc in (('q_stage', 'fragment'), ('q_shared', 'shared'), ('output_reg', 'fragment')):
        fn = replace_once(fn, f'{name} = T.alloc_{alloc}([G, D], T.float16)',
                          f'{name} = T.alloc_{alloc}([M, D], T.float16)')
    fn = replace_once(fn, 'q_stage: T.Fragment([G, D],', 'q_stage: T.Fragment([M, D],')
    fn = replace_once(fn, '(qi * D + qd) // 4 % 64', '(qi * D + qd) // q_vec % 64')
    fn = replace_once(fn, '(qi * D + qd) // 256 * 4 + qd % 4',
                      '(qi * D + qd) // (64 * q_vec) * q_vec + qd % q_vec')
    fn = replace_once(fn, 'output_reg: T.Fragment([G, D],', 'output_reg: T.Fragment([M, D],')
    fn = replace_once(fn, 'lambda oi, od: oi + od % 16 // 4 * 16',
                      'lambda oi, od: oi % G + od % 16 // 4 * 16')
    fn = replace_once(fn, 'lambda oi, od: od // 16 * 4 + od % 4',
                      'lambda oi, od: oi // G * (D // 4) + od // 16 * 4 + od % 4')
    start = fn.index('            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)')
    body_start = fn.index('            block = Indices[b, token, h, 0]', start)
    tail_start = fn.index('            output_shared = T.alloc_shared', body_start)
    body = fn[body_start:tail_start]
    body = replace_once(body, 'block = Indices[b, token, h, 0]',
                        'block = T.if_then_else(token < seq_len, Indices[b, token, h, 0], -1)')
    body = replace_once(body, '''                T.copy(q_stage, q_shared)
                T.sync_warp()
                T.copy(q_shared, q)''',
                        '                T.copy(q_shared[query * G:(query + 1) * G, :], q)')
    body = replace_once(body, 'output_reg[oi, vo * W + od] = out[oi, od]',
                        'output_reg[query * G + oi, vo * W + od] = out[oi, od]')
    prelude = '''            for qi, qd in T.Parallel(M, D):
                q_stage[qi, qd] = T.if_then_else(
                    seq_len % queries == 0 or tile * queries + qi // G < seq_len,
                    Q[b, tile * queries + qi // G, h * G + qi % G, qd], T.float16(0))
            T.copy(q_stage, q_shared)
            T.sync_warp()
            for query in T.unroll(queries):
                token = tile * queries + query
'''
    incremental = '''                if incremental:
                    T.sync_warp()
                    T.copy(output_reg[query * G:(query + 1) * G, :],
                           q_shared[query * G:(query + 1) * G, :])
'''
    tail = '''            if not incremental:
                T.sync_warp()
                T.copy(output_reg, q_shared)
            T.sync_warp()
            for oi, od in T.Parallel(M, D):
                if seq_len % queries == 0 or tile * queries + oi // G < seq_len:
                    Output[b, tile * queries + oi // G, h * G + oi % G, od] = q_shared[oi, od]
    return kernel
'''
    fn = fn[:start] + prelude + indent(body, 4) + incremental + tail
    ast.parse(fn)
    return fn


def main():
    original = BASE.read_text()
    fn = make_function(original)
    with (HERE / 'query_tiles_template.py').open('x') as f:
        f.write(fn)
    records = []
    for queries, incremental, vec in ((2, False, 4), (2, True, 4), (2, True, 8), (4, True, 4)):
        source = replace_once(original, '\ndef _get_kernel(', '\n' + fn + '\n\ndef _get_kernel(')
        source = replace_once(source,
            'attention = native_sparse_attention_single_packed_qo_v2(width=128, late=False, **common)',
            f'attention = native_sparse_attention_packed_query_tiles(width=128, late=False, queries={queries}, incremental={incremental}, q_vec={vec}, **common)')
        ast.parse(source)
        name = f'query_tiles_q{queries}_incremental{int(incremental)}_vec{vec}'
        path = HERE / f'{name}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, queries=queries, incremental=incremental, q_vec=vec,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'query_tiles_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        mechanism='One shared Q/O tile spans multiple queries; QK, probabilities and PV remain independent for each query.',
        synchronization='One Q RAW barrier, per-query or bulk Q/O WAR barriers, and one final O RAW barrier.',
        packing='The original packing kernel is invoked on every public call.',
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
