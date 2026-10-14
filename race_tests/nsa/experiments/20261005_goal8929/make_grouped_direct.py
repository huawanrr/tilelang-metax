"""Read K directly and stage grouped V tiles, avoiding a separate packing launch."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/submission.py'


def make_template():
    source = (HERE / 'grouped_packed_template.py').read_text()
    source = source[source.index('@tilelang.jit'):]
    source = source.replace('native_sparse_attention_grouped_packed', 'native_sparse_attention_grouped_direct')
    source = replace_once(source, '    early_v=False, joined_blocks=2, batch_minor=False,',
                          '    early_v=False, joined_blocks=2, batch_minor=False, shared_vec=4,')
    source = replace_once(source,
        '        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),',
        '        K: T.Tensor([batch, seq_len, H, D], T.float16),')
    source = replace_once(source,
        '        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),',
        '        V: T.Tensor([batch, seq_len, H, D], T.float16),')
    source = replace_once(source,
        '            v = T.alloc_fragment([N, D], T.float16)',
        '''            v = T.alloc_fragment([N, D], T.float16)
            v_stage = T.alloc_fragment([N, D], T.float16)
            v_shared = T.alloc_shared([N, D], T.float16)''')
    source = replace_once(source,
        "                v: pv.make_mma_load_layout(v, 'B'),",
        '''                v: pv.make_mma_load_layout(v, 'B'),
                v_stage: T.Fragment([N, D],
                    forward_thread_fn=lambda vj, vd: (vj * D + vd) // 8 % 64,
                    forward_index_fn=lambda vj, vd: (vj * D + vd) // 512 * 8 + vd % 8),
                v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=shared_vec),''')
    source = replace_once(source,
        'K[b, raw, h, d // 32, 0, d % 32 // 8 * 16 + j % BS, d % 8]',
        'K[b, raw * BS + j % BS, h, d]')
    source = source.replace(
        'raw >= 0 and raw < NB and (not is_causal or raw <= token // BS)',
        'raw >= 0 and raw < NB and raw * BS + j % BS < seq_len\n'
        '                        and (not is_causal or raw <= token // BS)')
    tree = ast.parse(source)
    edits = []
    for node in ast.walk(tree):
        if not isinstance(node, ast.For):
            continue
        stores = [n for n in ast.walk(node) if isinstance(n, ast.Assign)
                  and any(isinstance(t, ast.Subscript) and isinstance(t.value, ast.Name)
                          and t.value.id == 'v' for t in n.targets)]
        if len(stores) != 1 or node.col_offset != 20:
            continue
        code = '''                    for j, d in T.Parallel(N, D):
                        raw = indices[group * joined_blocks + j // BS]
                        v_stage[j, d] = T.if_then_else(
                            raw >= 0 and raw < NB and raw * BS + j % BS < seq_len
                            and (not is_causal or raw <= token // BS),
                            V[b, raw * BS + j % BS, h, d], T.float16(0))
                    T.sync_warp()
                    T.copy(v_stage, v_shared)
                    T.sync_warp()
                    T.copy(v_shared, v)
'''
        edits.append((node.lineno - 1, node.end_lineno, code))
    assert len(edits) == 2
    lines = source.splitlines(keepends=True)
    for begin, end, code in sorted(edits, reverse=True):
        lines[begin:end] = [code]
    source = ''.join(lines)
    source = replace_once(source, '                T.copy(out_half, shared)',
                          '                T.sync_warp()\n                T.copy(out_half, shared)')
    ast.parse(source)
    return source


def main():
    original = BASE.read_text()
    template = make_template()
    with (HERE / 'grouped_direct_template.py').open('x') as f:
        f.write(template)
    records = []
    for joined, stage, vec in ((2, False, 4), (2, True, 4), (2, True, 8), (4, True, 4)):
        source = replace_once(original, '\ndef _get_kernel(', '\n' + template + '\n\ndef _get_kernel(')
        branch = f'''        elif S == 4 and use_emitter_online:
            kernel = native_sparse_attention_grouped_direct(
                selected_blocks=S, output_stage={stage}, joined_blocks={joined},
                shared_vec={vec}, **common)
        elif joined_short:
'''
        source = replace_once(source, '        elif joined_short:\n', branch)
        ast.parse(source)
        path = HERE / f'grouped_direct_j{joined}_stage{int(stage)}_vec{vec}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, joined=joined, output_stage=stage, shared_vec=vec,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'grouped_direct_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        math='The same grouped FP32 numerator and denominator; no global packed buffers.',
        bounds='Raw indices, partial tails, and causal start are checked before each K/V read.',
        synchronization='Wave barriers protect the V shared RAW/WAR edges and reuse for output staging.',
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
