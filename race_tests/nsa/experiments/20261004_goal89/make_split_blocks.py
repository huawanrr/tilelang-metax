"""Split the eight selected blocks across waves and merge normalized partials."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/submission.py'


def main():
    records = []
    original = BASE.read_text()
    template = (HERE / 'split_blocks_template.py').read_text()
    template = template[template.index('@tilelang.jit'):]
    for waves in (2, 4):
        den = '(' + ' + '.join(f'denominators[{w} * G + i]' for w in range(waves)) + ')'
        num = '(' + ' + '.join(f'T.cast(partial[{w} * G + i, d], T.float32) * denominators[{w} * G + i]' for w in range(waves)) + ')'
        kernel = replace_once(template,
            '                # MAKE_SPLIT_BLOCKS_COMBINE\n                result[i, d] = T.float16(0)',
            f'                result[i, d] = T.if_then_else({den} > 0, {num} / {den}, 0.0)')
        for prefetch in (1, 2):
            source = replace_once(original, '\ndef _get_kernel(', '\n' + kernel + '\n\ndef _get_kernel(')
            branch = f'''        elif S == 8 and use_emitter_online:
            attention = native_sparse_attention_split_blocks_packed(
                selected_blocks=S, waves={waves}, prefetch={prefetch}, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif S >= 8 and use_emitter_online:
'''
            source = replace_once(source, '        elif S >= 8 and use_emitter_online:\n', branch)
            ast.parse(source)
            path = HERE / f'split_s8_w{waves}_p{prefetch}.py'
            with path.open('x') as f:
                f.write(source)
            records.append(dict(path=path.name, waves=waves, prefetch=prefetch,
                sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'split_s8_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=records,
        math='Each wave sums a disjoint subset. Its FP32 denominator and normalized FP16 output are merged with denominator weights.',
        packing='Unchanged and paid on every call', synchronization='One CTA barrier protects partial outputs and denominators'), indent=2) + '\n')


if __name__ == '__main__':
    main()
