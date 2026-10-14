"""Assemble independently measured kernels without changing baseline builders."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()


def get_function(path, name):
    return next(n for n in ast.parse((ROOT / path).read_text()).body
                if isinstance(n, ast.FunctionDef) and n.name == name)


class MaskScale(ast.NodeTransformer):
    def __init__(self, short=False):
        self.short = short

    def visit_Assign(self, node):
        if len(node.targets) != 1 or not isinstance(node.targets[0], ast.Subscript):
            return self.generic_visit(node)
        target = ast.unparse(node.targets[0].value)
        if self.short and target == 'starts' and isinstance(node.value, ast.BinOp):
            raw = ast.unparse(node.value.left)
            return ast.parse(f'''
_raw_block = {raw}
starts[si] = T.if_then_else(_raw_block >= 0 and _raw_block < (seq_len + IBS - 1) // IBS, _raw_block, -1) * IBS
''').body
        if target == 'acc_s' and isinstance(node.value, ast.Call) and ast.unparse(node.value.func) in ('T.exp', 'T.exp2'):
            pos = '_paired_pos_sel(j, starts, S, IBS)' if self.short else '_start_buffer_0[0] + j'
            condition = f'({pos}) >= 0 and ({pos}) < seq_len and (not is_causal or ({pos}) <= i_t)'
            return ast.parse(f'''
if scale_log2 > 0:
    {ast.unparse(node)}
else:
    {ast.unparse(node.targets[0])} = T.if_then_else({condition}, {ast.unparse(node.value)}, 0.0)
''').body[0]
        return self.generic_visit(node)


direct = get_function('directkv_template.py', 'native_sparse_attention_direct_kv')
linear = get_function('d128_blocks_exp.py', 'native_sparse_attention_linear_v_blocks')
linear.name = 'native_sparse_attention_linear_v_blocks_oct8'
linear = MaskScale().visit(linear)
short = get_function('cast_both_exp.py', 'native_sparse_attention_short_list')
short.name = 'native_sparse_attention_short_list_oct8'
short = MaskScale(short=True).visit(short)

new_functions = []
for fn in (direct, linear, short):
    ast.fix_missing_locations(fn)
    new_functions.append(ast.unparse(fn))
source = BASE.replace('def _get_kernel(', '\n\n'.join(new_functions) + '\n\ndef _get_kernel(', 1)
flags = '''    # Default-path specializations measured against the 2026-10-07 release.
    oct8_single = mathcast_defaults and groups == 16 and S == 1 and block_size == 16
    oct8_complete = oct8_single and seq_len % block_size == 0
    oct8_direct = oct8_complete and ((D == 32 and grid <= 192) or (D == 64 and grid <= 256))
    oct8_linear = oct8_complete and D == 128 and H == 1 and 128 < grid < 768
    oct8_coalesced = oct8_complete and D == 64 and seq_len >= 128 and 512 <= grid < 2304
    oct8_short = (mathcast_defaults and groups == 16 and D == 64 and block_size == 16
        and S == 2 and seq_len >= 64 and grid <= 1024)
    oct8_s4 = (mathcast_defaults and groups == 16 and D == 64 and block_size == 16
        and S == 4 and seq_len >= 128 and 768 <= grid <= 1536)

'''
source = source.replace('    key = (\n', flags + '    key = (\n', 1)
source = source.replace('        mathcast_s8, mathcast_single, mathcast_blocks,\n',
    '        mathcast_s8, mathcast_single, mathcast_blocks,\n        oct8_direct, oct8_linear, oct8_coalesced, oct8_short, oct8_s4,\n', 1)
branch = '''        if oct8_direct:
            kernel = native_sparse_attention_direct_kv(natural=True, late=D == 32, **common)
        elif oct8_linear:
            kernel = native_sparse_attention_linear_v_blocks_oct8(
                late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif oct8_coalesced:
            kernel = native_sparse_attention_coalesced_blocks_mathcast(q_vec=8, pv_width=128, **common)
        elif oct8_short:
            kernel = native_sparse_attention_short_list_oct8(
                selected_blocks=S, late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif oct8_s4:
            attention = native_sparse_attention_online_packed_batch_minor_o_v2_mathcast(
                selected_blocks=S, online_unroll=2, dual_acc=False, prefetch_depth=1, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif d32_compact:
'''
assert source.count('        if d32_compact:\n') == 1
source = source.replace('        if d32_compact:\n', branch)
ast.parse(source)
path = ROOT / 'candidate_v1.py'
path.write_text(source)
print(path)
