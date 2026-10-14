"""Add the validated small S8 specialization to the official 88.29 baseline."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'
PROBE = HERE.parent / '20261004_goal89/split_s8_w2_fp32_balanced.py'


def extract(source, name):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    begin = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return ''.join(source.splitlines(keepends=True)[begin:node.end_lineno])


def main():
    original = BASE.read_text()
    fn = extract(PROBE.read_text(), 'native_sparse_attention_split_blocks_packed')
    source = replace_once(original, '\ndef _get_kernel(', '\n' + fn + '\n\ndef _get_kernel(')
    source = replace_once(source, '    key = (\n', '''    # Two waves shorten the selected-list dependency chain for small launches.
    # Each invocation still packs its current K/V inputs, and the FP32 partial
    # numerators and denominators are merged before the final output cast.
    small_s8_split = (S == 8 and use_emitter_online and update_defaults
        and seq_len >= 128 and grid <= 512)

    key = (
''')
    source = replace_once(source,
        '        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks,\n',
        '        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks, small_s8_split,\n')
    source = replace_once(source, '        if d32_compact:\n', '''        if small_s8_split:
            attention = native_sparse_attention_split_blocks_packed(
                selected_blocks=S, waves=2, prefetch=1, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif d32_compact:
''')
    before = {n.name: ast.dump(n) for n in ast.parse(original).body if isinstance(n, ast.FunctionDef)}
    after = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    unchanged = [n for n in before if n != '_get_kernel']
    assert all(before[n] == after[n] for n in unchanged)
    path = HERE / 'candidate_small_s8.py'
    with path.open('x') as f:
        f.write(source)
    (HERE / 'candidate_small_s8_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        probe=str(PROBE), probe_sha256=hashlib.sha256(PROBE.read_bytes()).hexdigest(),
        candidate=path.name, candidate_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        unchanged_functions=unchanged,
        config=dict(selected_blocks=8, dim=64, block_size=16, groups=16,
                    seq_len_min=128, grid_max=512, waves=2, prefetch=1,
                    default_tuning_only=True),
        official_score=None,
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
