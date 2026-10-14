"""Test query grouping in the launch grid without changing an attention CTA."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once
from make_small_candidate import extract
from make_s8_value_lookahead import BASE, BUILDERS

HERE = Path(__file__).resolve().parent


def main():
    baseline = BASE.read_text()
    rows = []
    for group in (0, 4, 16):
        source = baseline
        for name in BUILDERS:
            old = extract(source, name)
            header = '''        with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):'''
            if group == 0:
                fn = replace_once(old, header,
                    '''        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):''')
            else:
                fn = replace_once(old, '    S = selected_blocks\n',
                    f'    S = selected_blocks\n    query_group = {group} if seq_len % {group} == 0 else 1\n')
                fn = replace_once(fn, header,
                    '''        with T.Kernel(seq_len * batch * head_kv, T.ceildiv(dim, BV),
                      threads=threads) as (bx, by):''')
                fn = replace_once(fn, '            i_t, i_v, i_bh = bx, by, bz\n',
                    '''            i_t = (bx // (batch * head_kv * query_group)) * query_group + bx % query_group
            i_v = by
            i_bh = (bx // query_group) % (batch * head_kv)
''')
            source = replace_once(source, old, fn)
        ast.parse(source)
        path = HERE / ('s8_grid_token.py' if group == 0 else f's8_grid_q{group}.py')
        with path.open('x') as f:
            f.write(source)
        rows.append(dict(path=path.name, query_group='all' if group == 0 else group,
                         sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 's8_grid_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=rows, cta_arithmetic_unchanged=True,
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
