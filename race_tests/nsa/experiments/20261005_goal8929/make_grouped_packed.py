"""Limit concatenation to two/four tiles to reduce register pressure."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/submission.py'


def main():
    original = BASE.read_text()
    template = (HERE / 'grouped_packed_template.py').read_text()
    template = template[template.index('@tilelang.jit'):]
    records = []
    for joined, stage, early in ((2, False, False), (2, True, False),
                                  (4, True, False), (2, True, True)):
        source = replace_once(original, '\ndef _get_kernel(', '\n' + template + '\n\ndef _get_kernel(')
        branch = f'''        elif S in (4, 8) and use_emitter_online:
            attention = native_sparse_attention_grouped_packed(
                selected_blocks=S, output_stage={stage}, early_v={early},
                joined_blocks={joined}, batch_minor=(S == 8 and grid >= 4096), **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif joined_short:
'''
        source = replace_once(source, '        elif joined_short:\n', branch)
        ast.parse(source)
        path = HERE / f'grouped_packed_j{joined}_stage{int(stage)}_early{int(early)}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, joined=joined, output_stage=stage, early_v=early,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'grouped_packed_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        math='Accumulate FP32 denominators and numerators for groups of disjoint selected positions, then normalize once.',
        masks='Raw block guard before loads, tail and causal masks for scores, zero K/V for invalid selections.',
        packing='Unchanged public-call packing cost is included.',
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
