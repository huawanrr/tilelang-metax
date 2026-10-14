"""Distribute the selected-list positions cyclically between waves."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for parent in ('split_s8_w2_fp32', 'split_s8_w2_direct', 'split_s8_w4_fp32',
                   'split_s8_directkv_swizzle4'):
        original = (HERE / f'{parent}.py').read_text()
        source = replace_once(original, '                indices[s] = Indices[b, token, h, wave * R + s]',
                              '                indices[s] = Indices[b, token, h, s * NW + wave]')
        ast.parse(source)
        path = HERE / f'{parent}_balanced.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, parent=parent,
            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    proof = []
    for waves in (2, 4):
        positions = [[s * waves + w for s in range(8 // waves)] for w in range(waves)]
        assert sorted(p for group in positions for p in group) == list(range(8))
        proof.append(dict(waves=waves, positions=positions, every_selected_block_once=True))
    (HERE / 'balanced_split_assembly.json').write_text(json.dumps(dict(variants=records, partition_proof=proof), indent=2) + '\n')


if __name__ == '__main__':
    main()
