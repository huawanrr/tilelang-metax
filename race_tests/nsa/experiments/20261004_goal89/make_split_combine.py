"""Separate shared-bank conflicts, partial precision, and merge traffic in S8."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for waves in (2, 4):
        original = (HERE / f'split_s8_w{waves}_p1.py').read_text()
        for mode in ('swizzle', 'fp32', 'direct'):
            source = original
            if mode in ('fp32', 'direct'):
                source = replace_once(source, '''            for m in T.Parallel(M):
                inv[m] = T.if_then_else(denom[m] > 0, 1.0 / denom[m], 0.0)
            for m, d in T.Parallel(M, D):
                out[m, d] *= inv[m]
''', '')
            if mode in ('swizzle', 'fp32'):
                source = replace_once(source, '            T.copy(out, partial)',
                    f'''            T.annotate_layout({{partial:
                tilelang.maca.intrinsics.make_mma_swizzle_layout(partial, vecSize={8 if mode == 'swizzle' else 4})}})
            T.copy(out, partial)''')
                if mode == 'fp32':
                    source = replace_once(source, '            partial = T.alloc_shared([M, D], T.float16)',
                                          '            partial = T.alloc_shared([M, D], T.float32)')
                    num = '(' + ' + '.join(f'partial[{w} * G + i, d]' for w in range(waves)) + ')'
                    old_num = '(' + ' + '.join(f'T.cast(partial[{w} * G + i, d], T.float32) * denominators[{w} * G + i]' for w in range(waves)) + ')'
                    source = replace_once(source, old_num, num)
            else:
                node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
                            and n.name == 'native_sparse_attention_split_blocks_packed')
                lines = source.splitlines(keepends=True)
                body = ''.join(lines[node.lineno - 1:node.end_lineno])
                tail = body[body.index('            partial = T.alloc_shared'):body.index('    return kernel')]
                den = '(denom[m] + ' + ' + '.join(f'denominators[{w} * G + m]' for w in range(waves - 1)) + ')'
                num = '(out[m, d] + ' + ' + '.join(f'partial[{w} * G + m, d]' for w in range(waves - 1)) + ')'
                replacement = f'''            partial = T.alloc_shared([(NW - 1) * G, D], T.float32)
            denominators = T.alloc_shared([(NW - 1) * G], T.float32)
            T.annotate_layout({{partial:
                tilelang.maca.intrinsics.make_mma_swizzle_layout(partial, vecSize=4)}})
            for m, d in T.Parallel(M, D):
                if m >= G:
                    partial[m - G, d] = out[m, d]
            for m in T.Parallel(M):
                if m >= G:
                    denominators[m - G] = denom[m]
            T.sync_threads()
            for m, d in T.Parallel(M, D):
                if m < G:
                    Output[b, token, h * G + m, d] = T.if_then_else({den} > 0, {num} / {den}, 0.0)
'''
                source = replace_once(source, tail, replacement)
            ast.parse(source)
            path = HERE / f'split_s8_w{waves}_{mode}.py'
            with path.open('x') as f:
                f.write(source)
            records.append(dict(path=path.name, waves=waves, mode=mode,
                sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'split_combine_assembly.json').write_text(json.dumps(records, indent=2) + '\n')


if __name__ == '__main__':
    main()
