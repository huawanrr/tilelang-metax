from pathlib import Path
import ast
src=Path('experiments/20260926/direct_kv.py').read_text()
a=src.index('def native_sparse_attention_single_block_emitter(')
b=src.index('\n\n_KERNEL_CACHE',a)
part=src[a:b]
part=part.replace('    qk, pv = _emitters', '    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]\n    qk, pv = _emitters',1)
part=part.replace('        V: T.Tensor(kv_shape, T.float16),','        V: T.Tensor(packed_shape, T.float16),')
part=part.replace('''                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)''','''                for j, d in T.Parallel(BS, BV):
                    V_reg[j, d] = V[i_b, i_s // BS, i_h, j // 16,
                                    d // 32, (j % 16 // 4) * 16 + d % 16,
                                    (d % 32 // 16) * 4 + j % 4]''')
src=src[:a]+part+src[b:]
packer='''

@tilelang.jit
def pack_values(batch, seq_len, heads, dim, block_size):
    BS, D = block_size, dim
    @T.prim_func
    def kernel(
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS//16, D//32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=128) as (bs, h, b):
            tile = T.alloc_fragment([BS, D], T.float16)
            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], tile)
            for j, d in T.Parallel(BS, D):
                Packed[b, bs, h, j // 16, d // 32,
                       (j % 16 // 4) * 16 + d % 16,
                       (d % 32 // 16) * 4 + j % 4] = tile[j, d]
    return kernel
'''
pos=src.index('\n\n_KERNEL_CACHE')
src=src[:pos]+packer+src[pos:]
src=src.replace('''        _KERNEL_CACHE[key] = kernel''','''        if S == 1 and use_emitter:
            attention = kernel
            pack = pack_values(B, seq_len, H, D, block_size)
            def kernel(q, k, v, idx, output):
                packed = torch.empty((B, (seq_len + block_size - 1) // block_size,
                                      H, block_size // 16, D // 32, 64, 8),
                                     device=v.device, dtype=v.dtype)
                pack(v, packed)
                attention(q, k, packed, idx, output)
            kernel.get_kernel_source = lambda: pack.get_kernel_source() + attention.get_kernel_source()
        _KERNEL_CACHE[key] = kernel''')
ast.parse(src)
Path('experiments/20260926/packed_v.py').write_text(src)
