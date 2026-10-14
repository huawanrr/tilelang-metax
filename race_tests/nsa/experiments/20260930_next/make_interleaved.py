"""Pack K and V into adjacent cache-line portions for synchronous lookahead."""
import ast
import re

from make_probes import BASE, HERE, once, extract


PACK = '''
@tilelang.jit
def native_sparse_attention_pack_interleaved(batch, seq_len, heads, dim, block_size):
    assert dim == 64 and block_size == 16
    BS, BK = block_size, dim
    NB = T.ceildiv(seq_len, BS)
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, dim], T.float16),
        V: T.Tensor([batch, seq_len, heads, dim], T.float16),
        Packed: T.Tensor([batch, NB, heads, 2, 64, 16], T.float16),
    ):
        with T.Kernel(NB, heads, batch, threads=128) as (blk, h, b):
            for j, d in T.Parallel(BS, BK):
                Packed[b, blk, h, d // 32, d % 32 // 8 * 16 + j, d % 8] = K[b, blk * BS + j, h, d]
            for j, d in T.Parallel(BS, BK):
                Packed[b, blk, h, d // 32, j // 4 * 16 + d % 16, 8 + d % 32 // 16 * 4 + j % 4] = V[b, blk * BS + j, h, d]
    return kernel


def _make_interleaved_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    def run(Q, K, V, Indices, Output):
        packed = torch.empty((batch, tilelang.cdiv(seq_len, block_size), heads, 2, 64, 16),
                             device=K.device, dtype=K.dtype)
        pack(K, V, packed)
        attention(Q, packed, packed, Indices, Output)
    return run
'''


if __name__ == '__main__':
    fns = []
    for name in ('native_sparse_attention_online_packed',
                 'native_sparse_attention_online_packed_batch_minor',
                 'native_sparse_attention_online_packed_quad_batch_minor'):
        fn = extract(name)
        fn = once(fn, name + '(', name + '_interleaved(')
        fn = once(fn, '    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]',
                  '    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, 2, 64, 16]')
        fn = once(fn, '    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]',
                  '    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, 2, 64, 16]')
        old_k = r'K\[i_b, (i_s\w*) // BS, i_h, d // 32,\s+j // 16, \(d % 32 // 8\) \* 16 \+ j % 16, d % 8\]'
        old_v = r'V\[i_b, (i_s\w*) // BS, i_h, j // 16,\s+d // 32, \(j % 16 // 4\) \* 16 \+ d % 16,\s+\(d % 32 // 16\) \* 4 \+ j % 4\]'
        fn, nk = re.subn(old_k,
            r'K[i_b, \1 // BS, i_h, d // 32, (d % 32 // 8) * 16 + j % 16, d % 8]', fn)
        fn, nv = re.subn(old_v,
            r'V[i_b, \1 // BS, i_h, d // 32, (j % 16 // 4) * 16 + d % 16, 8 + (d % 32 // 16) * 4 + j % 4]', fn)
        assert nk == nv == 5, (name, nk, nv)
        fns.append(fn)
    for mode in ('interleaved', 'interleaved_prefetch2'):
        result = once(BASE, '\n_KERNEL_CACHE = {}', '\n' + PACK + '\n'.join(fns) + '\n_KERNEL_CACHE = {}')
        a = result.index('        elif S >= 8 and use_emitter_online:')
        b = a + re.search(r'^        elif', result[a + 1:], re.MULTILINE).start() + 1
        branch = result[a:b]
        branch = branch.replace('native_sparse_attention_pack_kv(', 'native_sparse_attention_pack_interleaved(')
        branch = branch.replace('_make_packed_attention(', '_make_interleaved_attention(')
        for name in ('native_sparse_attention_online_packed_quad_batch_minor',
                     'native_sparse_attention_online_packed_batch_minor',
                     'native_sparse_attention_online_packed'):
            branch = branch.replace(name + '(', name + '_interleaved(')
        if mode.endswith('prefetch2'):
            branch = branch.replace('prefetch_depth=prefetch_depth', 'prefetch_depth=2')
        result = result[:a] + branch + result[b:]
        ast.parse(result)
        p = HERE / f'{mode}.py'
        p.write_text(result)
        print(p.name)
