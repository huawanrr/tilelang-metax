"""Expose packing tiles in the launch grid to avoid serial per-wave tile loops."""
import ast
import hashlib
import json
from pathlib import Path
from make_s8_schedule import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def main():
    original = BASE.read_text()
    template = (HERE / 'pack_register_template.py').read_text()
    records = []
    for threads, flat in ((512, False), (64, True), (128, True), (256, True)):
        fn = template
        if flat:
            fn = replace_once(fn,
                'with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=threads) as (block, h, b):',
                '''with T.Kernel(T.ceildiv(seq_len, BS) * T.ceildiv(NT, NW), heads, batch, threads=threads) as (block_tile, h, b):
            block = block_tile // T.ceildiv(NT, NW)
            tile_group = block_tile % T.ceildiv(NT, NW)''')
            fn = replace_once(fn, 'for group in T.unroll(T.ceildiv(NT, NW), unroll_factor=1):',
                              'for group in T.unroll(1):')
            fn = replace_once(fn, '                tile = group * NW + wave',
                              '                tile = tile_group * NW + wave')
        source = replace_once(original, '\ndef _get_kernel(', '\n' + fn + '\n\ndef _get_kernel(')
        source = replace_once(source, '            pack = pack_builder(B, seq_len, H, D, block_size)',
                              f'            pack = native_sparse_attention_pack_register(B, seq_len, H, D, block_size, {threads})')
        source = replace_once(source, '            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)',
                              f'            pack = native_sparse_attention_pack_register(B, seq_len, H, D, block_size, {threads})')
        ast.parse(source)
        path = HERE / f'pack_tiles_{"flat" if flat else "block"}{threads}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, threads=threads, flat=flat,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'pack_tiles_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, attention_unchanged=True, exchange_from='pack_register_template.py'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
