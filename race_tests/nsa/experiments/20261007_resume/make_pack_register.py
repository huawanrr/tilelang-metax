"""Build register transpose packing probes and prove the bit permutation."""
import ast
import hashlib
import json
from pathlib import Path
from make_s8_schedule import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def proof():
    # Values encode original (row, column), so no numerical tolerance is used.
    values = [[lane * 8 + e for e in range(8)] for lane in range(64)]
    for rbit, lbit in ((0, 2), (1, 3), (2, 1)):
        before = [row[:] for row in values]
        for lane in range(64):
            for reg in range(8):
                src_lane = (lane & ~(1 << lbit)) | (((reg >> rbit) & 1) << lbit)
                src_reg = (reg & ~(1 << rbit)) | (((lane >> lbit) & 1) << rbit)
                values[lane][reg] = before[src_lane][src_reg]
    seen = set()
    for lane in range(64):
        dest = (lane & 48) | ((lane & 4) >> 2) | ((lane & 8) >> 2) | ((lane & 2) << 1) | ((lane & 1) << 3)
        for reg in range(8):
            row = dest // 16 * 4 + reg % 4
            col = dest % 16 + reg // 4 * 16
            assert values[lane][reg] == row * 32 + col
            seen.add((row, col))
    assert len(seen) == 512
    return dict(status='PASS', exact_elements=512, exchange_steps=[[0, 2], [1, 3], [2, 1]])


def main():
    baseline = BASE.read_text()
    template = (HERE / 'pack_register_template.py').read_text()
    records = []
    for threads in (64, 128, 256):
        source = replace_once(baseline, '\ndef _get_kernel(', '\n' + template + '\n\ndef _get_kernel(')
        source = replace_once(source, '            pack = pack_builder(B, seq_len, H, D, block_size)',
                              f'            pack = native_sparse_attention_pack_register(B, seq_len, H, D, block_size, {threads})')
        source = replace_once(source, '            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)',
                              f'            pack = native_sparse_attention_pack_register(B, seq_len, H, D, block_size, {threads})')
        ast.parse(source)
        path = HERE / f'pack_register_t{threads}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, threads=threads,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'pack_register_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, layout_proof=proof(), attention_unchanged=True,
        note='Per-call synchronous packing with lossless uint32 shuffle transpose; no shared buffer or cross-call input caching.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
