"""Combine coalesced Q/O with packing of the current K/V inputs for S1."""
from pathlib import Path

from make_probes import BASE, HERE, ROOT, once
from make_followup_probes import save


def main():
    fn = (ROOT / 'experiments/20260928_packed_pv/single_packed_template.py').read_text()
    fn = once(fn, '    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,',
        '    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,\n'
        '    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,')
    fn = once(fn, 'def single_packed_pv(', 'def single_packed_qo(')
    fn = once(fn, '    G, BS, D = groups, block_size, dim',
        '    assert groups == 16 and threads == 64 and dim in (64, 128) and block_size in (16, 32)\n'
        '    G, BS, D = groups, block_size, dim')
    fn = once(fn, '            q = T.alloc_fragment([G, D], T.float16)',
        '''            q = T.alloc_fragment([G, D], T.float16)
            q_stage = T.alloc_fragment([G, D], T.float16)
            q_shared = T.alloc_shared([G, D], T.float16)
            output_reg = T.alloc_fragment([G, D], T.float16)
            T.annotate_layout({
                q_stage: T.Fragment([G, D],
                    forward_thread_fn=lambda qi, qd: (qi * D + qd) // 8 % 64,
                    forward_index_fn=lambda qi, qd: (qi * D + qd) // 512 * 8 + qd % 8),
                q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(q_shared, vecSize=8),
                output_reg: T.Fragment([G, D],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
            })''')
    fn = once(fn, '            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)',
        '            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)')
    marker = '                for i, j in T.Parallel(G, BS):\n                    scores[i, j] = T.if_then_else('
    fn = once(fn, marker,
        '''                T.copy(q_stage, q_shared)
                T.sync_warp()
                T.copy(q_shared, q)
''' + marker)
    fn = once(fn, '                T.copy(out, Output[b, token, h * G:(h + 1) * G, vo * W:(vo + 1) * W])',
        '''                for oi, od in T.Parallel(G, W):
                    output_reg[oi, vo * W + od] = out[oi, od]
            output_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({output_shared:
                tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)})
            T.sync_warp()
            T.copy(output_reg, output_shared)
            T.sync_warp()
            T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])''')
    result = once(BASE, '\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}')
    result = once(result, '        if joined_short:',
        '''        if (S == 1 and D in (64, 128) and block_size in (16, 32)
                and groups == 16 and threads == 64 and not kv_frag and not kv_split):
            attention = single_packed_qo(width=128, late=False, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif joined_short:''')
    save('packed_qo_pv128', result)


if __name__ == '__main__':
    main()
