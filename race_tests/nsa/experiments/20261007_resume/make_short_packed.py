"""Test per-call K/V packing for two selected blocks with existing math paths."""
import ast
import hashlib
import json
from pathlib import Path
from make_s8_schedule import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def main():
    original = BASE.read_text()
    template = (HERE.parent / '20261005_goal8929/grouped_packed_template.py').read_text()
    records = []
    for name, builder, kwargs in (
            ('online1', 'native_sparse_attention_online_packed',
             'online_unroll=2, dual_acc=False, prefetch_depth=1'),
            ('online2', 'native_sparse_attention_online_packed',
             'online_unroll=2, dual_acc=False, prefetch_depth=2'),
            ('stage1', 'native_sparse_attention_online_packed_batch_minor_o_v2',
             'online_unroll=2, dual_acc=False, prefetch_depth=1'),
            ('stage2', 'native_sparse_attention_online_packed_batch_minor_o_v2',
             'online_unroll=2, dual_acc=False, prefetch_depth=2'),
            ('group', 'native_sparse_attention_grouped_packed',
             'joined_blocks=2, output_stage=True, early_v=False, batch_minor=False'),
            ('group_early', 'native_sparse_attention_grouped_packed',
             'joined_blocks=2, output_stage=True, early_v=True, batch_minor=False')):
        source = original
        if name.startswith('group'):
            source = replace_once(source, '\ndef _get_kernel(', '\n' + template + '\n\ndef _get_kernel(')
        branch = f'''        if S == 2 and D == 64 and block_size == 16 and update_defaults:
            attention = {builder}(selected_blocks=S, {kwargs}, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif d32_compact:'''
        source = replace_once(source, '        if d32_compact:', branch)
        ast.parse(source)
        path = HERE / f'short_packed_{name}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, builder=builder, arguments=kwargs,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'short_packed_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, selected_blocks=2, every_call_packs_current_inputs=True
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
