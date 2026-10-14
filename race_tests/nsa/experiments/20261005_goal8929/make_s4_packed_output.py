"""Apply the existing packed output builder to the four-block family."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once
from make_small_candidate import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def main():
    original = BASE.read_text()
    batch_name = 'native_sparse_attention_online_packed_batch_minor_o_v2'
    token_name = 'native_sparse_attention_online_packed_token_o'
    token_fn = extract(original, batch_name).replace(batch_name, token_name)
    token_fn = replace_once(token_fn,
        '''with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):''',
        '''with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):''')
    records = []
    for prefetch, batch_minor, dual in ((1, False, False), (2, False, False),
                                        (4, False, False), (2, True, False),
                                        (2, False, True)):
        source = replace_once(original, '\ndef _get_kernel(', '\n' + token_fn + '\n\ndef _get_kernel(')
        builder = batch_name if batch_minor else token_name
        branch = f'''        elif S == 4 and use_emitter_online:
            attention = {builder}(
                selected_blocks=S, prefetch_depth={prefetch}, dual_acc={dual},
                online_unroll=online_unroll, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif joined_short:
'''
        source = replace_once(source, '        elif joined_short:\n', branch)
        ast.parse(source)
        name = f's4_output_pf{prefetch}_batch{int(batch_minor)}_dual{int(dual)}'
        path = HERE / f'{name}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, prefetch=prefetch, batch_minor=batch_minor, dual=dual,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 's4_packed_output_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        builder='The existing packed S8 builder supports S4 as well; new token order retains its arithmetic and explicit output barrier.',
        packing='Recomputed from current K/V inputs every invocation, included in timing.',
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
