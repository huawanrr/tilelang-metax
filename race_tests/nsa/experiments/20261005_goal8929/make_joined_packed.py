"""Build independent research variants without touching historical sources."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/submission.py'


def replace_once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def main():
    original = BASE.read_text()
    template = (HERE / 'joined_packed_template.py').read_text()
    template = template[template.index('@tilelang.jit'):]
    records = []
    for stage, early in ((False, False), (True, False), (False, True)):
        source = replace_once(original, '\ndef _get_kernel(', '\n' + template + '\n\ndef _get_kernel(')
        branch = f'''        elif S in (4, 8) and use_emitter_online:
            attention = native_sparse_attention_joined_packed(
                selected_blocks=S, output_stage={stage}, early_v={early}, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif joined_short:
'''
        source = replace_once(source, '        elif joined_short:\n', branch)
        ast.parse(source)
        path = HERE / f'joined_packed_stage{int(stage)}_early{int(early)}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, output_stage=stage, early_v=early,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'joined_packed_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        math='Full concatenated QK, FP32 exponential and denominator, FP16 probabilities, FP32 PV and final normalization.',
        bounds='Validate raw block indices before K/V addresses; masks retain causal, tail, invalid and repeated-index semantics.',
        synchronization='All operands stay in registers; optional output shared staging has an explicit wave barrier.',
        packing='Unmodified and executed on every public invocation.',
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
