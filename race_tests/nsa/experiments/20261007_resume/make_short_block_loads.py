"""Read complete selected blocks through typed views in the existing short-list kernels."""
import ast
import hashlib
import json
from pathlib import Path
from make_s8_schedule import region, replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def transform(fn, width):
    tree = ast.parse(fn)
    replacements = []
    for value, frag, dim in (('K', 'K_reg', 'BK'), ('V', 'V_reg', 'BV')):
        loops = [n for n in ast.walk(tree) if isinstance(n, ast.For)
                 and ast.unparse(n.iter) == f'T.Parallel(BS, {dim})'
                 and any(isinstance(child, ast.Subscript) and isinstance(child.value, ast.Name)
                         and child.value.id == value for child in ast.walk(n))]
        assert len(loops) == 1, (value, len(loops))
        old = region(fn, loops[0])
        pad = ' ' * loops[0].col_offset
        v = value.lower()
        text = f'''for {v}_block in T.unroll(S):
    {v}_raw = starts[{v}_block] // IBS
    if {v}_raw >= 0 and {v}_raw < seq_len // IBS:
        for {v}_slot in T.unroll(IBS * {dim} // 512):
            for {v}_word in T.unroll(8 // {width}):
                for {v}_element in T.vectorized({width}):
                    {frag}[{v}_block * IBS + ({v}_slot * 512 + tid * 8) // {dim},
                           tid % ({dim} // 8) * 8 + {v}_word * {width} + {v}_element] = {value}_blocks[
                        i_b, {v}_raw, ({v}_slot * 512 + tid * 8) // {dim}, i_h,
                        tid % ({dim} // 8) * 8 + {v}_word * {width} + {v}_element]
    else:
        for {v}_slot in T.unroll(IBS * {dim} // 512):
            for {v}_element in T.vectorized(8):
                {frag}[{v}_block * IBS + ({v}_slot * 512 + tid * 8) // {dim},
                       tid % ({dim} // 8) * 8 + {v}_element] = T.float16(0)
'''
        replacements.append((old, ''.join(pad + line + '\n' for line in text.splitlines())))
    for old, new in replacements:
        fn = replace_once(fn, old, new)
    fn = replace_once(fn, '            tid = T.get_thread_binding()\n',
        '''            tid = T.get_thread_binding()
            K_blocks = T.reshape(K, [batch, seq_len // IBS, IBS, head_kv, dim])
            V_blocks = T.reshape(V, [batch, seq_len // IBS, IBS, head_kv, dim])
''')
    ast.parse(fn)
    return fn


def main():
    baseline = BASE.read_text()
    records = []
    for width in (2, 4, 8):
        source = baseline
        names = []
        for name in ('native_sparse_attention_short_list', 'native_sparse_attention_short_list_qo_v2'):
            node = next(n for n in ast.parse(baseline).body if isinstance(n, ast.FunctionDef) and n.name == name)
            fn = region(baseline, node, decorated=True)
            new_name = name + '_blocks'
            transformed = transform(fn, width).replace(name, new_name)
            source = replace_once(source, '\ndef _get_kernel(', '\n' + transformed + '\n\ndef _get_kernel(')
            names.append(new_name)
        old = '''            short_builder = (native_sparse_attention_short_list_qo_v2 if short_qo_v2
                             else native_sparse_attention_short_list)'''
        new = old + '''
            if block_size == 16 and D == 64 and seq_len % block_size == 0:
                short_builder = (native_sparse_attention_short_list_qo_v2_blocks if short_qo_v2
                                 else native_sparse_attention_short_list_blocks)'''
        source = replace_once(source, old, new)
        path = HERE / f'short_block_loads_v{width}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, fp16_load_width=width, added_builders=names,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'short_block_loads_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, note='Each selected full block is validated before typed vector loads. Invalid tiles are explicitly zero-filled; all original score masks and synchronization remain.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
