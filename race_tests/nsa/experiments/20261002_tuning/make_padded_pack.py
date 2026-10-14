"""Probe block strides in packed K/V; every invocation fills the live payload."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE / 'pack_v_shared4_t256_sync1.py').read_text()


def once(source, a, b):
    assert source.count(a) == 1, (a, source.count(a))
    return source.replace(a, b)


def extract(source, name):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return ''.join(lines[start:node.end_lineno])


for pad in (0, 1, 2, 4):
    pack = extract(BASE, 'native_sparse_attention_pack_kv')
    pack = once(pack, 'def native_sparse_attention_pack_kv(', 'def native_sparse_attention_pack_kv_padded(')
    pack = once(pack, '    BS, D = block_size, dim',
                f'    BS, D = block_size, dim\n    PAD = {pad}\n    NT = (D // 32) * (BS // 16)')
    pack = once(pack, 'heads, D//32, BS//16, 64, 8]', 'heads, NT + PAD, 64, 8]')
    pack = once(pack, 'heads, BS//16, D//32, 64, 8]', 'heads, NT + PAD, 64, 8]')
    pack = once(pack, 'PackedK[b, bs, h, d // 32, j // 16,',
                'PackedK[b, bs, h, d // 32 * (BS // 16) + j // 16,')
    pack = once(pack, 'Packed[b, bs, h, j // 16, d // 32,',
                'Packed[b, bs, h, j // 16 * (D // 32) + d // 32,')
    if pad:
        pack = once(pack, '    return kernel',
            '''            for p, lane, e in T.Parallel(PAD, 64, 8):
                PackedK[b, bs, h, NT + p, lane, e] = T.float16(0)
                Packed[b, bs, h, NT + p, lane, e] = T.float16(0)
    return kernel''')
    attn = extract(BASE, 'native_sparse_attention_single_packed_qo')
    attn = once(attn, 'def native_sparse_attention_single_packed_qo(',
                'def native_sparse_attention_single_packed_qo_padded(')
    attn = once(attn, '    NB = tilelang.cdiv(seq_len, BS)',
                f'    NB = tilelang.cdiv(seq_len, BS)\n    PAD = {pad}\n    NT = (D // 32) * (BS // 16)')
    attn = once(attn, 'H, D // 32, BS // 16, 64, 8]', 'H, NT + PAD, 64, 8]')
    attn = once(attn, 'H, BS // 16, D // 32, 64, 8]', 'H, NT + PAD, 64, 8]')
    attn = once(attn, 'K[b, block, h, d // 32, j // 16,',
                'K[b, block, h, d // 32 * (BS // 16) + j // 16,')
    attn = once(attn, 'V[b, block, h, j // 16, d // 32,',
                'V[b, block, h, j // 16 * (D // 32) + d // 32,')
    attn = once(attn, 'V[b, block, h, j // 16, vo * (W // 32) + d // 32,',
                'V[b, block, h, j // 16 * (D // 32) + vo * (W // 32) + d // 32,')
    closure = extract(BASE, '_make_packed_attention')
    closure = once(closure, 'def _make_packed_attention(', 'def _make_padded_attention(')
    closure = once(closure, '    k_shape = (batch, blocks, heads, dim // 32, block_size // 16, 64, 8)',
                   f'    k_shape = (batch, blocks, heads, (dim // 32) * (block_size // 16) + {pad}, 64, 8)')
    closure = once(closure, '    v_shape = (batch, blocks, heads, block_size // 16, dim // 32, 64, 8)',
                   '    v_shape = k_shape')
    source = once(BASE, '\ndef _get_kernel(', '\n' + pack + '\n\n' + attn + '\n\n' + closure + '\n\ndef _get_kernel(')
    source = once(source,
        '''        if packed_qo:
            attention = native_sparse_attention_single_packed_qo(width=128, late=False, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)''',
        '''        if packed_qo:
            attention = native_sparse_attention_single_packed_qo_padded(width=128, late=False, **common)
            pack = native_sparse_attention_pack_kv_padded(B, seq_len, H, D, block_size)
            kernel = _make_padded_attention(pack, attention, B, seq_len, H, D, block_size)''')
    ast.parse(source)
    dest = HERE / f'packed_stride_pad{pad}.py'
    if dest.exists():
        raise FileExistsError(dest)
    dest.write_text(source)
    print(dest.name)
