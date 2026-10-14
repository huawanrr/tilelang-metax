from pathlib import Path
import ast
packer='''

@tilelang.jit
def pack_queries(batch, seq_len, heads, dim, groups):
    H, G, D = heads, groups, dim
    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, H*G, D], T.float16),
        PackedQ: T.Tensor([batch, seq_len, H, D//32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, 4), H, batch, threads=256) as (bx, h, b):
            tile = T.alloc_fragment([4, G, D], T.float16)
            T.copy(Q[b, bx * 4 : (bx + 1) * 4, h*G:(h+1)*G, :], tile)
            for t, g, d in T.Parallel(4, G, D):
                PackedQ[b, bx*4+t, h, d//32, d%32//8*16+g, d%8] = tile[t,g,d]
    return kernel
'''
for name in ['baseline','packed_kv']:
    src=Path('experiments/20260926/'+name+'.py').read_text()
    a=src.index('def native_sparse_attention_single_block_emitter(')
    b=src.index('\n\n_KERNEL_CACHE',a) if name=='baseline' else src.index('\n\n@tilelang.jit\ndef pack_values',a)
    p=src[a:b]
    p=p.replace('    qk, pv = _emitters', '    packed_q_shape = [batch, seq_len, head_kv, BK // 32, 64, 8]\n    qk, pv = _emitters',1)
    p=p.replace('        Q: T.Tensor(q_shape, T.float16),','        Q: T.Tensor(packed_q_shape, T.float16),')
    p=p.replace('            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)', '''            for g, d in T.Parallel(G, BK):
                Q_reg[g,d] = Q[i_b,i_t,i_h,d//32,d%32//8*16+g,d%8]''')
    src=src[:a]+p+src[b:]
    pos=src.index('\n\n_KERNEL_CACHE')
    src=src[:pos]+packer+src[pos:]
    if name=='baseline':
        src=src.replace('''        _KERNEL_CACHE[key] = kernel''','''        if S == 1 and use_emitter:
            attention = kernel
            pack_q = pack_queries(B, seq_len, H, D, groups)
            def kernel(q, k, v, idx, output):
                packed_q = torch.empty((B, seq_len, H, D // 32, 64, 8),
                                       device=q.device, dtype=q.dtype)
                pack_q(q, packed_q)
                attention(packed_q, k, v, idx, output)
            kernel.get_kernel_source = lambda: pack_q.get_kernel_source() + attention.get_kernel_source()
        _KERNEL_CACHE[key] = kernel''')
    else:
        src=src.replace('            pack = pack_values', '            pack_q = pack_queries(B, seq_len, H, D, groups)\n            pack = pack_values')
        src=src.replace('''                attention(q, packed_k, packed, idx, output)''','''                packed_q = torch.empty((B, seq_len, H, D // 32, 64, 8),
                                       device=q.device, dtype=q.dtype)
                pack_q(q, packed_q)
                attention(packed_q, packed_k, packed, idx, output)''')
    ast.parse(src)
    Path('experiments/20260926/qpack_'+name+'.py').write_text(src)
