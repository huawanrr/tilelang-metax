"""Expose values constant within each wave using a lane-zero broadcast."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for parent in ('split_s8_w2_fp32', 'packed_waves2'):
        original = (HERE / f'{parent}.py').read_text()
        for kind in ('wave', 'indices'):
            source = original
            if kind == 'wave':
                source = replace_once(source, '            wave = T.get_thread_binding() // 64',
                    '            wave = T.shfl_sync(T.get_thread_binding() // 64, 0, 64, 0xffffffffffffffff)')
            elif parent.startswith('split_s8'):
                source = replace_once(source, '                indices[s] = Indices[b, token, h, wave * R + s]',
                    '                indices[s] = T.shfl_sync(Indices[b, token, h, wave * R + s], 0, 64, 0xffffffffffffffff)')
            else:
                source = replace_once(source, '            block = T.if_then_else(token < seq_len, Indices[b, token, h, 0], -1)',
                    '            block = T.shfl_sync(T.if_then_else(token < seq_len, Indices[b, token, h, 0], -1), 0, 64, 0xffffffffffffffff)')
            ast.parse(source)
            path = HERE / f'{parent}_uniform_{kind}.py'
            with path.open('x') as f:
                f.write(source)
            records.append(dict(path=path.name, parent=parent, kind=kind,
                sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'uniform_waves_assembly.json').write_text(json.dumps(records, indent=2) + '\n')


if __name__ == '__main__':
    main()
