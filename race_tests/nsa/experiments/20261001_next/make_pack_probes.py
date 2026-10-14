"""Compare coalesced packed-V writes on the new D128/BS32 path."""
from make_probes import PACKED, once, change_function, packed_probe, write


def packing_probe(shared_vec=None, threads=128):
    def modify(fn):
        fn = once(fn, 'threads=128', f'threads={threads}')
        # Start from the compiler-selected contiguous load layout of the
        # original K and V registers. Only packed V's destination is changed.
        allocation = '''            packed_v = T.alloc_fragment([BS, D], T.float16)
            T.annotate_layout({packed_v: T.Fragment([BS, D],
                forward_thread_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                    + (pj % 16 // 4) * 16 + pd % 16) % THREADS),
                forward_index_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                    + (pj % 16 // 4) * 16 + pd % 16) // THREADS * 8
                    + (pd % 32 // 16) * 4 + pj % 4))})
'''.replace('THREADS', str(threads))
        if shared_vec is not None:
            allocation += f'''            v_shared = T.alloc_shared([BS, D], T.float16)
            T.annotate_layout({{v_shared:
                tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize={shared_vec})}})
'''
        fn = once(fn, '            ktile = T.alloc_fragment([BS, D], T.float16)',
                  allocation + '            ktile = T.alloc_fragment([BS, D], T.float16)')
        if shared_vec is not None:
            fn = once(fn, '            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], tile)',
                      '''            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], tile)
            T.copy(tile, v_shared)
            T.copy(v_shared, packed_v)''')
        else:
            fn = once(fn, '            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], tile)',
                      '            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], packed_v)')
        fn = once(fn, '(d % 32 // 16) * 4 + j % 4] = tile[j, d]',
                  '(d % 32 // 16) * 4 + j % 4] = packed_v[j, d]')
        return fn
    # The probe keeps every attention path fixed. This pack builder is shared
    # by packed S1 and S8, so end-to-end measurements cover both if requested.
    return change_function(packed_probe(qvec=4), 'native_sparse_attention_pack_kv', modify)


if __name__ == '__main__':
    for name, kwargs in (
        ('pack_v_direct', dict()),
        ('pack_v_shared4', dict(shared_vec=4)),
        ('pack_v_shared8', dict(shared_vec=8)),
        ('pack_v_shared4_t64', dict(shared_vec=4, threads=64)),
    ):
        write(name, packing_probe(**kwargs))
