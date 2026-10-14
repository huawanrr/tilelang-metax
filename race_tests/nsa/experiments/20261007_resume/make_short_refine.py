"""Refine the guarded short-list loads and test register exchange for K."""
import ast
import hashlib
import json
from pathlib import Path
from make_s8_schedule import region, replace_once

HERE = Path(__file__).resolve().parent


def fix_guard(fn):
    old = '                starts[si] = BlockIndices[i_b, i_t, i_h, si] * IBS'
    if old in fn:
        fn = replace_once(fn, old,
            '                starts[si] = T.min(T.max(BlockIndices[i_b, i_t, i_h, si], -1), T.ceildiv(seq_len, IBS)) * IBS')
    return fn


def full_mask(fn):
    tree = ast.parse(fn)
    loop = next(n for n in ast.walk(tree) if isinstance(n, ast.For)
                and any(isinstance(c, ast.Assign) and isinstance(c.targets[0], ast.Subscript)
                        and ast.unparse(c.targets[0]) == 'acc_s[i, j]'
                        and isinstance(c.value, ast.Call) and ast.unparse(c.value.func) == 'T.if_then_else'
                        for c in n.body))
    old = region(fn, loop)
    new = '''                limits = T.alloc_local([2], T.int32)
                limits[0] = starts[0]
                limits[1] = starts[0]
                for limit_slot in T.unroll(1, S):
                    limits[0] = T.min(limits[0], starts[limit_slot])
                    limits[1] = T.max(limits[1], starts[limit_slot])
                if limits[0] >= 0 and limits[1] + IBS <= (T.min(seq_len, i_t + 1) if is_causal else seq_len):
                    T.clear(acc_s)
                else:
''' + ''.join('    ' + s for s in old.splitlines(keepends=True))
    return replace_once(fn, old, new)


def k_exchange(fn, width):
    tree = ast.parse(fn)
    loop = next(n for n in ast.walk(tree) if isinstance(n, ast.For) and ast.unparse(n.target) == 'k_block')
    old = region(fn, loop)
    new = f'''                k_words = T.alloc_local([S, BK // 32, 4], T.uint32)
                k_half = T.Tensor([S, BK // 32, 8], T.float16, data=k_words.data, scope="local")
                for k_block in T.unroll(S):
                    k_raw = starts[k_block] // IBS
                    if k_raw >= 0 and k_raw < seq_len // IBS:
                        for k_chunk in T.unroll(BK // 32):
                            for k_part in T.unroll(8 // {width}):
                                for e in T.vectorized({width}):
                                    k_half[k_block, k_chunk, k_part * {width} + e] = K_blocks[
                                        i_b, k_raw, tid // 4, i_h, k_chunk * 32 + tid % 4 * 8 + k_part * {width} + e]
                    else:
                        for k_chunk in T.unroll(BK // 32):
                            for k_word in T.unroll(4):
                                k_words[k_block, k_chunk, k_word] = 0
'''
    fn = replace_once(fn, old, new)
    tree = ast.parse(fn)
    stores = [n for n in ast.walk(tree) if isinstance(n, ast.If) and ast.unparse(n.test) == 'not direct_k'
              and any(isinstance(s, ast.Subscript) and isinstance(s.ctx, ast.Store)
                      and ast.unparse(s).startswith('KV_shared[') for s in ast.walk(n))]
    assert len(stores) == 1
    fn = replace_once(fn, region(fn, stores[0]), '')
    tree = ast.parse(fn)
    loop = next(n for n in ast.walk(tree) if isinstance(n, ast.For)
                and ast.unparse(n.iter) == 'T.serial(qk_steps)')
    fn = replace_once(fn, region(fn, loop), '''                for ki in T.serial(qk_steps):
                    for k_block in T.unroll(S):
                        for k_word in T.unroll(4):
                            kb_words[k_block * 4 + k_word] = T.shfl_sync(
                                k_words[k_block, ki, k_word], tid % 16 * 4 + tid // 16,
                                64, 0xffffffffffffffff)
                    qk.mma(Q_reg, kb, acc_s, ki)
''')
    fn = replace_once(fn,
        '''                kb = T.alloc_local(
                    [qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)''',
        '''                kb_words = T.alloc_local([S * 4], T.uint32)
                kb = T.Tensor([S * 8], T.float16, data=kb_words.data, scope="local")''')
    if '_qo_' in fn.split('def ', 1)[1].split('(', 1)[0]:
        tree = ast.parse(fn)
        barriers = sorted([n for n in ast.walk(tree) if isinstance(n, ast.Expr)
                           and isinstance(n.value, ast.Call) and ast.unparse(n.value.func) == 'T.sync_warp'],
                          key=lambda n: n.lineno)
        assert len(barriers) == 7
        lines = fn.splitlines(keepends=True)
        for barrier in (barriers[1], barriers[2]):
            lines[barrier.lineno-1] = ''
        fn = ''.join(lines)
    ast.parse(fn)
    return fn


def main():
    records = []
    options = [('guard2', 2, False, False), ('guard8', 8, False, False),
               ('full2', 2, True, False), ('full8', 8, True, False),
               ('shuffle2', 2, False, True), ('shuffle8', 8, False, True)]
    for label, width, full, shuffle in options:
        parent = HERE / f'short_block_loads_v{width}.py'
        source = parent.read_text()
        for name in ('native_sparse_attention_short_list_blocks', 'native_sparse_attention_short_list_qo_v2_blocks'):
            node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
            old = region(source, node, decorated=True)
            fn = fix_guard(old)
            if full:
                fn = full_mask(fn)
            if shuffle:
                fn = k_exchange(fn, width)
            source = replace_once(source, old, fn)
        ast.parse(source)
        path = HERE / f'short_refine_{label}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, parent=str(parent), fp16_load_width=width,
                            full_score_fast_branch=full, k_register_exchange=shuffle,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'short_refine_assembly.json').write_text(json.dumps(dict(
        variants=records, index_guard='Original block is clamped before multiplication.',
        synchronization='Register K versions retain Q RAW, Q/V WAR, V RAW, V/O WAR, O RAW barriers in staged builders; automatic synchronization stays enabled in the original unstaged builder.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
