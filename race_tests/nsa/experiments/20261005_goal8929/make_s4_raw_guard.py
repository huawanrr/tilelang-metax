"""Keep selected block numbers unscaled until their range has been checked."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once
from make_small_candidate import extract

HERE = Path(__file__).resolve().parent


def guarded_builder(source):
    name = 'native_sparse_attention_online_packed_token_o'
    old = extract(source, name)
    new = replace_once(old,
        'indices[si] = T.min(T.max(BlockIndices[i_b, i_t, i_h, si], -1), T.ceildiv(seq_len, BS)) * BS',
        'indices[si] = BlockIndices[i_b, i_t, i_h, si]')
    # i_s now denotes a block number. Multiplication is only evaluated inside
    # the valid-block branch, so extreme int32 indices cannot wrap into data.
    for index in ('i_s', 'i_s0', 'i_s1', 'i_s2', 'i_s3'):
        new = new.replace(f'{index} < seq_len', f'{index} < T.ceildiv(seq_len, BS)')
        new = new.replace(f'{index} <= i_t)', f'{index} <= i_t // BS)')
        new = new.replace(f'{index} // BS,', f'{index},')
        new = new.replace(f'{index} + BS', f'{index} * BS + BS')
        new = new.replace(f'{index} + j', f'{index} * BS + j')
    assert '* BS' in new and 'T.min(T.max(BlockIndices' not in new
    return replace_once(source, old, new)


def main():
    parent = HERE / 'candidate_combined_v1.py'
    source = guarded_builder(parent.read_text())
    # These are probes: force each schedule across the same single-head S4
    # family. Production dispatch is chosen from the measured general ranges.
    source = replace_once(source,
        'and seq_len >= 256 and grid >= 512)', 'and seq_len >= 256)')
    records = []
    for depth in (1, 2, 4):
        text = replace_once(source,
            's4_prefetch = 4 if grid >= 3072 else (2 if grid >= 1536 else 1)',
            f's4_prefetch = {depth}')
        ast.parse(text)
        path = HERE / f's4_raw_pf{depth}.py'
        with path.open('x') as f:
            f.write(text)
        records.append(dict(path=path.name, prefetch=depth,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 's4_raw_guard_assembly.json').write_text(json.dumps(dict(
        parent=str(parent), parent_sha256=hashlib.sha256(parent.read_bytes()).hexdigest(),
        variants=records, raw_block_check_before_address=True,
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
