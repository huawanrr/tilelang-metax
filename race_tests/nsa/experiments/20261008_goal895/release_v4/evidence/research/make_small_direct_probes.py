"""Explore output width and QK packing without modifying the frozen v4."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'candidate_v4.py').read_text()
tree = ast.parse(base)
node = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
            and n.name == 'native_sparse_attention_direct_kv')
lines = base.splitlines(keepends=True)
template = ''.join(lines[min(d.lineno for d in node.decorator_list) - 1:node.end_lineno])


def replace_once(source, before, after):
    assert source.count(before) == 1, (before, source.count(before))
    return source.replace(before, after, 1)


split = replace_once(template, 'def native_sparse_attention_direct_kv(',
                     'def native_sparse_attention_small_split(')
split = replace_once(split, 'natural=True, late=False):',
                     'natural=True, late=False, width=32, qk_k_pack=2):')
split = replace_once(split, '    G, BS, D = (groups, block_size, dim)',
                     '    G, BS, D = (groups, block_size, dim)\n'
                     '    W = width\n'
                     '    assert D % W == 0 and W in (16, 32, 64)')
split = replace_once(split, '    qk, pv = _emitters(T.float16, T.float32, BS, D)',
                     '    qk, _ = _emitters(T.float16, T.float32, BS, D, qk_k_pack=qk_k_pack)\n'
                     '    _, pv = _emitters(T.float16, T.float32, BS, W)')
split = replace_once(split, 'with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):',
                     'with T.Kernel(seq_len, D // W, batch * H, threads=threads) as (token, output_tile, bh):')
for name, dtype in [('v', 'T.float16'), ('out', 'T.float32'), ('result', 'T.float16')]:
    m = 'BS' if name == 'v' else 'G'
    split = replace_once(split, f'{name} = T.alloc_fragment([{m}, D], {dtype})',
                         f'{name} = T.alloc_fragment([{m}, W], {dtype})')
split = replace_once(split,
    'for j, d in T.Parallel(BS, D):\n                    v[j, d] = V_blocks[b, block, j, h, d]',
    'for j, d in T.Parallel(BS, W):\n                    v[j, d] = V_blocks[b, block, j, h, output_tile * W + d]')
split = replace_once(split, 'T.serial(D // 32)', 'T.serial(D // (16 * qk_k_pack))')
split = replace_once(split, 'T.Parallel(G, D)', 'T.Parallel(G, W)')
split = replace_once(split, 'T.unroll(D // 16)', 'T.unroll(W // 16)')
split = replace_once(split, 'T.copy(result, Output[b, token, h * G:(h + 1) * G, :])',
                     'T.copy(result, Output[b, token, h * G:(h + 1) * G, output_tile * W:(output_tile + 1) * W])')
(HERE / 'small_direct_template.py').write_text(split)

variants = [(32, 2, False), (32, 2, True), (64, 1, False), (64, 1, True), (32, 1, False)]
for width, pack, late in variants:
    source = replace_once(base, 'def _get_kernel(', split + '\n\ndef _get_kernel(')
    source = replace_once(source,
        '            kernel = native_sparse_attention_direct_kv(natural=True, late=D == 32, **common)',
        '            if D == 64:\n'
        f'                kernel = native_sparse_attention_small_split(natural=True, late={late}, width={width}, qk_k_pack={pack}, **common)\n'
        '            else:\n'
        '                kernel = native_sparse_attention_direct_kv(natural=True, late=D == 32, **common)')
    ast.parse(source)
    name = f'small_direct_w{width}_kp{pack}_l{int(late)}.py'
    target = HERE / name
    assert not target.exists(), target
    target.write_text(source)
    print(name)

ieee = replace_once(template, 'def native_sparse_attention_direct_kv(',
                   'def native_sparse_attention_small_ieee(')
assert ieee.count('1.0 / lane_sum[i, lane]') == 2
ieee = ieee.replace('1.0 / lane_sum[i, lane]', 'T.ieee_frcp(lane_sum[i, lane])')
source = replace_once(base, 'def _get_kernel(', ieee + '\n\ndef _get_kernel(')
source = replace_once(source,
    '            kernel = native_sparse_attention_direct_kv(natural=True, late=D == 32, **common)',
    '            kernel = native_sparse_attention_small_ieee(natural=True, late=D == 32, **common)')
target = HERE / 'small_direct_ieee.py'
assert not target.exists(), target
ast.parse(source)
target.write_text(source)
print(target.name)
