"""Revisit layout break-even points after the FP16 conversion improvement."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()


def write(name, text):
    ast.parse(text)
    (ROOT / (name + '.py')).write_text(text)
    print(name)


for depth in (1, 2, 4):
    for dual in (False, True):
        branch = f'''        if mathcast_defaults and groups == 16 and S == 4 and D == 64 and block_size == 16:
            attention = native_sparse_attention_online_packed_batch_minor_o_v2_mathcast(
                selected_blocks=S, online_unroll=2, dual_acc={dual}, prefetch_depth={depth}, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif d32_compact:
'''
        assert BASE.count('        if d32_compact:\n') == 1
        write(f's4_packed_p{depth}_a{int(dual)}', BASE.replace('        if d32_compact:\n', branch))

for exponent in (False, True):
    name = 'cast_both_exp' if exponent else 'cast_both'
    source = (ROOT / (name + '.py')).read_text()
    old = 'and (S == 2 or (S == 4 and seq_len >= 128 and grid <= 384)))'
    assert source.count(old) == 1
    write(f's4_joined_e{int(exponent)}', source.replace(old, 'and (S == 2 or (S == 4 and seq_len >= 128)))'))

for minimum in (256, 512):
    source = BASE
    old = '(D == 64 and block_size == 16 and grid >= 2304)'
    assert source.count(old) == 1
    write(f'd64_coalesced_{minimum}', source.replace(old, f'(D == 64 and block_size == 16 and grid >= {minimum})'))
