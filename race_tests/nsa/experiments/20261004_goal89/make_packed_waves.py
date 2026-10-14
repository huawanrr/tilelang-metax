"""Keep packed BS32 math and put independent queries in separate CTA waves."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/submission.py'


def replace_once(source, old, new):
    assert source.count(old) == 1, (old[:90], source.count(old))
    return source.replace(old, new)


def main():
    source = BASE.read_text()
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
                and n.name == 'native_sparse_attention_single_packed_qo_v2')
    lines = source.splitlines(keepends=True)
    begin = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    original = ''.join(lines[begin:node.end_lineno])
    records = []
    for waves in (2, 4, 8):
        fn = original
        fn = replace_once(fn, '    G, BS, D = groups, block_size, dim',
                          f'    G, BS, D = groups, block_size, dim\n    NW = {waves}\n    M = NW * G')
        fn = replace_once(fn, "    qk, _ = _emitters(T.float16, T.float32, BS, D)",
            '''    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=D, k_pack=2)''')
        fn = replace_once(fn, '        block_row_warps=1, block_col_warps=1,',
                          '        block_row_warps=NW, block_col_warps=1,')
        fn = replace_once(fn, '        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):',
            '''        with T.Kernel(T.ceildiv(seq_len, NW), batch * H, threads=threads * NW) as (tile, bh):
            wave = T.get_thread_binding() // 64
            token = tile * NW + wave''')
        fn = fn.replace('[G,', '[M,').replace('[G]', '[M]')
        fn = fn.replace('T.Parallel(G,', 'T.Parallel(M,').replace('T.Parallel(G)', 'T.Parallel(M)')
        fn = fn.replace('T.alloc_fragment([BS,', 'T.alloc_fragment([NW, BS,')
        fn = replace_once(fn, 'forward_thread_fn=lambda qi, qd: (qi * D + qd) // 4 % 64,',
            'forward_thread_fn=lambda qi, qd: qi // G * 64 + (qi % G * D + qd) // 4 % 64,')
        fn = replace_once(fn, 'forward_index_fn=lambda qi, qd: (qi * D + qd) // 256 * 4 + qd % 4),',
            'forward_index_fn=lambda qi, qd: (qi % G * D + qd) // 256 * 4 + qd % 4),')
        fn = replace_once(fn, 'forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,',
            'forward_thread_fn=lambda oi, od: oi // G * 64 + oi % G + od % 16 // 4 * 16,')
        fn = replace_once(fn, "                k: qk.make_mma_load_layout(k, 'B'),", '''                k: T.Fragment([NW, BS, D],
                    forward_thread_fn=lambda kw, kj, kd: kw * 64 + kd % 32 // 8 * 16 + kj % 16,
                    forward_index_fn=lambda kw, kj, kd: (kd // 32 * (BS // 16) + kj // 16) * 8 + kd % 8),''')
        fn = replace_once(fn, "                v: pv.make_mma_load_layout(v, 'B'),", '''                v: T.Fragment([NW, BS, W],
                    forward_thread_fn=lambda vw, vj, vd: vw * 64 + vj % 16 // 4 * 16 + vd % 16,
                    forward_index_fn=lambda vw, vj, vd: (vj // 16 * (W // 32) + vd // 32) * 8 + vd % 32 // 16 * 4 + vj % 4),''')
        fn = replace_once(fn, '            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)',
            '''            for qi, qd in T.Parallel(M, D):
                q_stage[qi, qd] = T.if_then_else(tile * NW + qi // G < seq_len,
                    Q[b, tile * NW + qi // G, h * G + qi % G, qd], T.float16(0))''')
        fn = replace_once(fn, '            block = Indices[b, token, h, 0]',
            '            block = T.if_then_else(token < seq_len, Indices[b, token, h, 0], -1)')
        fn = fn.replace('T.Parallel(BS, D)', 'T.Parallel(NW, BS, D)')
        fn = fn.replace('T.Parallel(BS, W)', 'T.Parallel(NW, BS, W)')
        fn = fn.replace('for j, d in T.Parallel(NW,', 'for w, j, d in T.Parallel(NW,')
        fn = fn.replace('k[j, d] =', 'k[w, j, d] =').replace('v[j, d] =', 'v[w, j, d] =')
        fn = replace_once(fn, '            T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])',
            '''            output_global = T.alloc_fragment([M, D], T.float16)
            T.annotate_layout({output_global: T.Fragment([M, D],
                forward_thread_fn=lambda gm, gd: gm // G * 64 + (gm % G * D + gd) // 8 % 64,
                forward_index_fn=lambda gm, gd: (gm % G * D + gd) // 512 * 8 + gd % 8)})
            T.copy(output_shared, output_global)
            for oi, od in T.Parallel(M, D):
                if tile * NW + oi // G < seq_len:
                    Output[b, tile * NW + oi // G, h * G + oi % G, od] = output_global[oi, od]''')
        result = ''.join(lines[:begin]) + fn + ''.join(lines[node.end_lineno:])
        ast.parse(result)
        path = HERE / f'packed_waves{waves}.py'
        with path.open('x') as out:
            out.write(result)
        records.append(dict(path=path.name, waves=waves, sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'packed_waves_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, changes=['Only the existing packed BS32 attention builder',
        'Each 64-lane wave owns its Q/K/V/fragments/shared rows and output query',
        'Original packing and host dispatch retained', 'Three wave barriers retained']), indent=2) + '\n')


if __name__ == '__main__':
    main()
