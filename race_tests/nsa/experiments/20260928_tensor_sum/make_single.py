"""Apply the same constant-one MMA denominator to the S1 emitter."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
tree = ast.parse(base)
node = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
            and n.name == 'native_sparse_attention_single_block_emitter')
lines = base.splitlines(keepends=True)
original = ''.join(lines[node.decorator_list[0].lineno - 1:node.end_lineno])
for position in ('before', 'after'):
    part = original.replace('def native_sparse_attention_single_block_emitter(', 'def single_tensor_sum(', 1)
    part = part.replace('    qk_steps = ', '''    psum = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=G, warp_col_tiles=16, chunk=BS, k_pack=1)
    qk_steps = ''', 1)
    part = part.replace('            acc_s = T.alloc_fragment', '''            acc_den = T.alloc_fragment([G, 16], T.float32)
            unit = T.alloc_local([4], T.float16)
            acc_s = T.alloc_fragment''', 1)
    part = part.replace('                acc_o: pv.make_mma_store_layout(acc_o),', '''                acc_o: pv.make_mma_store_layout(acc_o),
                acc_den: psum.make_mma_store_layout(acc_den),''', 1)
    part = part.replace('            T.fill(acc_o, 0)', '''            T.fill(acc_o, 0)
            T.fill(acc_den, 0)
            T.fill(unit, 1)''', 1)
    a = part.index('                if not late_normalize:')
    b = part.index('                T.copy(acc_s, acc_s_cast)', a)
    part = part[:a] + part[b:]
    a = part.index('                if late_normalize:')
    b = part.index('\n            T.copy(acc_o, Output[', a)
    part = part[:a] + '''                for i, j in T.Parallel(G, BV):
                    value = acc_den[i, j % 16 // 4 * 4]
                    acc_o[i, j] *= T.if_then_else(value > 0, 1.0 / value, 0.0)
''' + part[b:]
    part = part.replace('''            if not lane_reduce:
                T.fill(scores_sum, 0)
''', '')
    part = part.replace('            scores_sum = T.alloc_fragment([G], T.float32)\n', '')
    part = part.replace('            scores_inv_sum = T.alloc_fragment([G], T.float32)\n', '')
    original_call = '                    pv.mma(acc_s_cast, vb, acc_o, ki)'
    extra = '                    psum.mma(acc_s_cast, unit, acc_den, ki)'
    part = part.replace(original_call, extra + '\n' + original_call if position == 'before'
                        else original_call + '\n' + extra, 1)
    source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + part + '\n\n_KERNEL_CACHE = {}', 1)
    a = source.index('def _get_kernel(')
    host = source[a:].replace('''        if S == 1 and use_emitter:
''', '''        if S == 1 and use_emitter and D == 128 and block_size == 32:
            kernel = single_tensor_sum(late_normalize=late_normalize, kv_split=kv_split,
                direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif S == 1 and use_emitter:
''', 1)
    source = source[:a] + host
    ast.parse(source)
    name = f'single_sum_{position}.py'
    (HERE / name).write_text(source)
    print(name)
