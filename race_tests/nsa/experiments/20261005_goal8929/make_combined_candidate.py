"""Combine small S8 and single-head S4 improvements for broader validation."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once
from make_small_candidate import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def main():
    parent = HERE / 'candidate_small_s8.py'
    source = parent.read_text()
    probe = HERE / 's4_output_pf2_batch0_dual0.py'
    fn = extract(probe.read_text(), 'native_sparse_attention_online_packed_token_o')
    # Validate the original index before multiplying by BS. All negative and
    # oversized indices remain invalid, including values whose product wraps.
    fn = replace_once(fn,
        'indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS',
        'indices[si] = T.min(T.max(BlockIndices[i_b, i_t, i_h, si], -1), T.ceildiv(seq_len, BS)) * BS')
    source = replace_once(source, '\ndef _get_kernel(', '\n' + fn + '\n\ndef _get_kernel(')
    source = replace_once(source, '    key = (\n', '''    # Packing amortizes its launch for this single-head S4 family. Increase
    # the synchronous K lookahead as the grid supplies more independent work.
    s4_packed = (S == 4 and use_emitter_online and update_defaults and H == 1
        and seq_len >= 256 and grid >= 512)
    s4_prefetch = 4 if grid >= 3072 else (2 if grid >= 1536 else 1)

    key = (
''')
    source = replace_once(source,
        '        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks, small_s8_split,\n',
        '        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks, small_s8_split, s4_packed, s4_prefetch,\n')
    source = replace_once(source, '        elif d32_compact:\n', '''        elif s4_packed:
            attention = native_sparse_attention_online_packed_token_o(
                selected_blocks=S, prefetch_depth=s4_prefetch, dual_acc=False,
                online_unroll=online_unroll, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif d32_compact:
''')
    before = {n.name: ast.dump(n) for n in ast.parse(BASE.read_text()).body if isinstance(n, ast.FunctionDef)}
    after = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    unchanged = [n for n in before if n != '_get_kernel']
    assert all(before[n] == after[n] for n in unchanged)
    path = HERE / 'candidate_combined_v1.py'
    with path.open('x') as f:
        f.write(source)
    (HERE / 'candidate_combined_v1_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        parent=str(parent), parent_sha256=hashlib.sha256(parent.read_bytes()).hexdigest(),
        candidate=path.name, candidate_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        unchanged_functions=unchanged,
        s8_config=dict(seq_len_min=128, grid_max=512, waves=2, prefetch=1),
        s4_config=dict(heads_kv=1, seq_len_min=256, grid_min=512,
                       prefetch2_grid_min=1536, prefetch4_grid_min=3072,
                       raw_indices_clamped_before_multiplication=True),
        default_tuning_only=True, official_score=None,
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
