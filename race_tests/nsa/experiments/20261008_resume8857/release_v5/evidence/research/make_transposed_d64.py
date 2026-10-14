"""Test V^T P^T on current D64 paths, preserving QK and scalar conversions."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'baseline.py').read_text()
targets = {'_coalesced_block_loads_prim_mathcast', '_coalesced_block_loads_prim_oct8'}


def once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new, 1)


def transpose(fn, pair):
    fn = once(fn, 'a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1, warp_row_tiles=16, warp_col_tiles=VW,',
        'a_transposed=True, b_transposed=True, block_row_warps=1, block_col_warps=1, warp_row_tiles=VW, warp_col_tiles=16,')
    fn = once(fn, 'acc_o = T.alloc_fragment([G, VW], T.float32)',
        'acc_o = T.alloc_fragment([VW, G], T.float32)')
    fn = once(fn, '            O_reg = T.alloc_fragment([G, BV], T.float16)\n', '')
    fn = once(fn, '            T.annotate_layout({O_reg: T.Fragment([G, BV], forward_thread_fn=lambda i, d: i + d % 16 // 4 * 16, forward_index_fn=lambda i, d: d // 16 * 4 + d % 4)})\n', '')
    fn = once(fn, "acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'A')", "acc_s_cast: pv.make_mma_load_layout(acc_s_cast, 'B')")
    fn = once(fn, 'vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)',
        'vb = T.alloc_local([pv.warp_rows * pv.k_pack * pv.local_size_a], T.float16)')
    fn = once(fn, 'pv.mma(acc_s_cast, vb, acc_o, ki)', 'pv.mma(vb, acc_s_cast, acc_o, ki)')
    start = fn.index('                for cast_chunk in T.unroll(VW // 16):')
    end = fn.index('    return kernel', start)
    output = '''                output_tid = T.get_thread_binding()
                for output_slot in T.unroll(VW // 16):
                    for output_head in T.unroll(4):
                        Output[i_b, i_t, i_h * G + output_tid // 16 * 4 + output_head, vo * VW + output_slot * 16 + output_tid % 16] = acc_o[output_slot * 16 + output_tid % 16, output_tid // 16 * 4 + output_head]
'''
    if pair:
        output = '''                output_tid = T.get_thread_binding()
                output_raw = T.alloc_local([VW // 4], T.float16)
                for output_slot in T.unroll(VW // 16):
                    for output_head in T.unroll(4):
                        output_raw[output_slot * 4 + output_head] = acc_o[output_slot * 16 + output_tid % 16, output_tid // 16 * 4 + output_head]
                output_words = T.Tensor([VW // 8], T.uint32, data=output_raw.data, scope='local')
                output_pairs = T.alloc_local([VW // 8], T.uint32)
                output_halves = T.Tensor([VW // 4], T.float16, data=output_pairs.data, scope='local')
                for output_word in T.unroll(VW // 8):
                    neighbor = T.shfl_xor(output_words[output_word], 1, 64, 0xffffffffffffffff)
                    output_pairs[output_word] = T.if_then_else(output_tid % 2 == 0,
                        (output_words[output_word] & T.uint32(65535)) | ((neighbor & T.uint32(65535)) << 16),
                        (neighbor >> 16) | (output_words[output_word] & T.uint32(4294901760)))
                for output_slot in T.unroll(VW // 16):
                    for output_head in T.unroll(2):
                        for output_element in T.vectorized(2):
                            Output[i_b, i_t, i_h * G + output_tid // 16 * 4 + output_tid % 2 + output_head * 2, vo * VW + output_slot * 16 + output_tid % 16 // 2 * 2 + output_element] = output_halves[output_slot * 4 + output_head * 2 + output_element]
'''
    return fn[:start] + output + fn[end:]


for pair in (False, True):
    lines = base.splitlines(keepends=True)
    edits = []
    for node in ast.parse(base).body:
        if isinstance(node, ast.FunctionDef) and node.name in targets:
            start = node.lineno - 1
            edits.append((start, node.end_lineno, transpose(''.join(lines[start:node.end_lineno]), pair)))
    for start, end, fn in reversed(edits):
        lines[start:end] = [fn]
    result = ''.join(lines)
    ast.parse(result)
    path = HERE / f'd64_transposed_{"pair" if pair else "scalar"}.py'
    assert not path.exists()
    path.write_text(result)
    print(path)
