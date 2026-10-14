"""Build synchronous short-list kernels, preserving the 929 release."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = (ROOT / 'experiments/20260929_candidate/nsa.py').read_text()


def extract(source, name):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return '\n'.join(source.splitlines()[start:node.end_lineno]) + '\n'


def replace_once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new, 1)


def make_pair(linear, late):
    old_name = 'native_sparse_attention_single_linear_v' if linear else 'native_sparse_attention_single_block_emitter'
    fn = extract(BASE, old_name).replace(old_name, 'native_sparse_attention_short_list')
    fn = replace_once(fn, '    threads=64,\n', '    selected_blocks, threads=64,\n')
    fn = replace_once(fn, '    G, BS = groups, block_size', '    G, IBS, S = groups, block_size, selected_blocks\n    BS = IBS * S')
    fn = replace_once(fn, 'head_kv, 1], T.int32)', 'head_kv, S], T.int32)')
    fn = replace_once(fn, '            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS', '''            starts = T.alloc_local([S], T.int32)
            for si in T.unroll(S):
                starts[si] = BlockIndices[i_b, i_t, i_h, si] * IBS''')
    begin = fn.index('            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):')
    end = fn.index('                if not direct_k:', begin)
    fn = fn[:begin] + '''            if T.bool(True):
                for j, d in T.Parallel(BS, BK):
                    kpos = _paired_pos_sel(j, starts, S, IBS)
                    K_reg[j, d] = T.if_then_else(kpos >= 0 and kpos < seq_len and d < dim,
                        K[i_b, kpos, i_h, d], T.float16(0))
                for j, d in T.Parallel(BS, BV):
                    vpos = _paired_pos_sel(j, starts, S, IBS)
                    V_reg[j, d] = T.if_then_else(vpos >= 0 and vpos < seq_len and d < dim,
                        V[i_b, vpos, i_h, d], T.float16(0))
''' + fn[end:]
    begin = fn.index('                if is_causal and i_s + BS > i_t + 1:')
    end = fn.index('                # QK:', begin)
    fn = fn[:begin] + '''                for i, j in T.Parallel(G, BS):
                    pos = _paired_pos_sel(j, starts, S, IBS)
                    acc_s[i, j] = T.if_then_else(
                        pos >= 0 and pos < seq_len and (not is_causal or pos <= i_t),
                        T.float32(0), -T.infinity(T.float32))

''' + fn[end:]
    # One combined tile, with the normalizer either before or after PV.
    result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}', 1)
    result = replace_once(result, '        if d32_shuffle:', f'''        if S in (2, 4) and use_emitter_online:
            kernel = native_sparse_attention_short_list(
                selected_blocks=S, late_normalize={late}, lane_reduce=True,
                kv_split=False, direct_k=False, **common)
        elif d32_shuffle:''')
    ast.parse(result)
    path = HERE / f'pair_{"linear" if linear else "swizzle"}_{"late" if late else "early"}.py'
    path.write_text(result)
    print(path.name)


if __name__ == '__main__':
    for linear in (False, True):
        for late in (False, True):
            make_pair(linear, late)
