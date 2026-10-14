"""Eliminate the pack launch from the two-wave short S8 path."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent


def main():
    original = (HERE / 'split_s8_w2_fp32.py').read_text()
    nodes = {n.name: n for n in ast.parse(original).body if isinstance(n, ast.FunctionDef)}
    node = nodes['native_sparse_attention_split_blocks_packed']
    lines = original.splitlines(keepends=True)
    first = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    before, fn, after = ''.join(lines[:first]), ''.join(lines[first:node.end_lineno]), ''.join(lines[node.end_lineno:])
    fn = replace_once(fn, '        K: T.Tensor([batch, NB, H, D // 32, BS // 16, 64, 8], T.float16),',
                      '        K: T.Tensor([batch, seq_len, H, D], T.float16),')
    fn = replace_once(fn, '        V: T.Tensor([batch, NB, H, BS // 16, D // 32, 64, 8], T.float16),',
                      '        V: T.Tensor([batch, seq_len, H, D], T.float16),')
    fn = replace_once(fn, '            v = T.alloc_fragment([NW, BS, D], T.float16)',
        '''            v = T.alloc_fragment([NW, BS, D], T.float16)
            v_stage = T.alloc_fragment([NW, BS, D], T.float16)
            v_shared = T.alloc_shared([NW * BS, D], T.float16)
            T.annotate_layout({v_stage: T.Fragment([NW, BS, D],
                forward_thread_fn=lambda sw, sj, sd: sw * 64 + (sj * D + sd) // 8 % 64,
                forward_index_fn=lambda sw, sj, sd: (sj * D + sd) // 512 * 8 + sd % 8)})
            # DIRECT_V_LAYOUT''')
    for r in (0, 1):
        fn = replace_once(fn, f'''K[b, raw{r}, h, d // 32, j // 16,
                            d % 32 // 8 * 16 + j % 16, d % 8]''' if r == 0 else
            '''K[b, raw1, h, d // 32, j // 16,
                                d % 32 // 8 * 16 + j % 16, d % 8]''',
            f'T.if_then_else(raw{r} * BS + j < seq_len, K[b, raw{r} * BS + j, h, d], T.float16(0))')
    fn = replace_once(fn, '''                        for w, j, d in T.Parallel(NW, BS, D):
                            v[w, j, d] = V[b, raw, h, j // 16, d // 32,
                                j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]''',
        '''                        for w, j, d in T.Parallel(NW, BS, D):
                            v_stage[w, j, d] = T.if_then_else(raw * BS + j < seq_len,
                                V[b, raw * BS + j, h, d], T.float16(0))
                        T.sync_warp()
                        for w, j, d in T.Parallel(NW, BS, D):
                            v_shared[w * BS + j, d] = v_stage[w, j, d]
                        T.sync_warp()
                        for w, j, d in T.Parallel(NW, BS, D):
                            v[w, j, d] = v_shared[w * BS + j, d]''')
    fn = replace_once(fn, '            T.copy(out, partial)',
                      '            T.sync_threads()\n            T.copy(out, partial)')
    after = replace_once(after, '''        elif S == 8 and use_emitter_online:
            attention = native_sparse_attention_split_blocks_packed(
                selected_blocks=S, waves=2, prefetch=1, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)''',
        '''        elif S == 8 and use_emitter_online:
            kernel = native_sparse_attention_split_blocks_packed(
                selected_blocks=S, waves=2, prefetch=1, **common)''')
    records = []
    for layout in ('linear', 'swizzle4', 'swizzle8'):
        annotation = ('            T.annotate_layout({v_shared: T.Layout([NW * BS, D], lambda vi, vd: vi * D + vd)})'
                      if layout == 'linear' else
                      f'            T.annotate_layout({{v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize={layout[-1]})}})')
        source = before + replace_once(fn, '            # DIRECT_V_LAYOUT', annotation) + after
        ast.parse(source)
        path = HERE / f'split_s8_directkv_{layout}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            layout=layout, K='Direct synchronous register loads', V='Synchronous wave-local shared staging',
            partials='FP32', launches=1, sync='Two wave barriers per valid block, CTA barriers before and after shared partials'))
    (HERE / 'split_directkv_assembly.json').write_text(json.dumps(records, indent=2) + '\n')


if __name__ == '__main__':
    main()
