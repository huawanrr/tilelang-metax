"""Store all 16 operand halves of one lane together in the packed buffers."""
import ast
import re

from make_probes import BASE, HERE, once, extract


PACK = '''
@tilelang.jit
def native_sparse_attention_pack_lanes(batch, seq_len, heads, dim, block_size):
    assert dim == 64 and block_size == 16
    BS, BK = block_size, dim
    NB = T.ceildiv(seq_len, BS)
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, dim], T.float16),
        V: T.Tensor([batch, seq_len, heads, dim], T.float16),
        PK: T.Tensor(KSHAPE, T.float16),
        PV: T.Tensor(VSHAPE, T.float16),
    ):
        with T.Kernel(NB, heads, batch, threads=128) as (blk, h, b):
            for j, d in T.Parallel(BS, BK):
                KSTORE = K[b, blk * BS + j, h, d]
            for j, d in T.Parallel(BS, BK):
                VSTORE = V[b, blk * BS + j, h, d]
    return kernel


def _make_lane_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    def run(Q, K, V, Indices, Output):
        NB = tilelang.cdiv(seq_len, block_size)
        PK = torch.empty(KHOST, device=K.device, dtype=K.dtype)
        PV = torch.empty(VHOST, device=V.device, dtype=V.dtype)
        pack(K, V, PK, PV)
        attention(Q, PK, PV, Indices, Output)
    return run
'''


if __name__ == '__main__':
    names = ('native_sparse_attention_online_packed',
             'native_sparse_attention_online_packed_batch_minor',
             'native_sparse_attention_online_packed_quad_batch_minor')
    for kl, vl in ((True, False), (False, True), (True, True)):
        kshape = '[batch, NB, heads, 64, 16]' if kl else '[batch, NB, heads, 2, 1, 64, 8]'
        vshape = '[batch, NB, heads, 64, 16]' if vl else '[batch, NB, heads, 1, 2, 64, 8]'
        pack = PACK.replace('KSHAPE', kshape).replace('VSHAPE', vshape)
        pack = pack.replace('KHOST', kshape.replace('[', '(').replace(']', ')'))
        pack = pack.replace('VHOST', vshape.replace('[', '(').replace(']', ')'))
        kcoord = '(d % 32 // 8) * 16 + j % 16, d // 32 * 8 + d % 8' if kl else 'd // 32, j // 16, (d % 32 // 8) * 16 + j % 16, d % 8'
        vcoord = '(j % 16 // 4) * 16 + d % 16, d // 16 * 4 + j % 4' if vl else 'j // 16, d // 32, (j % 16 // 4) * 16 + d % 16, (d % 32 // 16) * 4 + j % 4'
        pack = pack.replace('KSTORE', f'PK[b, blk, h, {kcoord}]').replace('VSTORE', f'PV[b, blk, h, {vcoord}]')
        fns = []
        for name in names:
            fn = once(extract(name), name + '(', name + '_lanes(')
            if kl:
                fn = once(fn, '    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8]',
                          '    packed_k_shape = [batch, T.ceildiv(seq_len, BS), head_kv, 64, 16]')
                fn, count = re.subn(r'K\[i_b, (i_s\w*) // BS, i_h, d // 32,\s+j // 16, \(d % 32 // 8\) \* 16 \+ j % 16, d % 8\]',
                                   r'K[i_b, \1 // BS, i_h, ' + kcoord + ']', fn)
                assert count == 5
            if vl:
                fn = once(fn, '    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, BS // 16, BK // 32, 64, 8]',
                          '    packed_shape = [batch, T.ceildiv(seq_len, BS), head_kv, 64, 16]')
                fn, count = re.subn(r'V\[i_b, (i_s\w*) // BS, i_h, j // 16,\s+d // 32, \(j % 16 // 4\) \* 16 \+ d % 16,\s+\(d % 32 // 16\) \* 4 \+ j % 4\]',
                                   r'V[i_b, \1 // BS, i_h, ' + vcoord + ']', fn)
                assert count == 5
            fns.append(fn)
        result = once(BASE, '\n_KERNEL_CACHE = {}', '\n' + pack + '\n'.join(fns) + '\n_KERNEL_CACHE = {}')
        a = result.index('        elif S >= 8 and use_emitter_online:')
        b = a + re.search(r'^        elif', result[a + 1:], re.MULTILINE).start() + 1
        original = result[a:b]
        branch = original.replace('elif S >= 8 and use_emitter_online:', 'elif S == 8 and use_emitter_online:')
        for name in reversed(names):
            branch = branch.replace(name + '(', name + '_lanes(')
        branch = branch.replace('native_sparse_attention_pack_kv(', 'native_sparse_attention_pack_lanes(')
        branch = branch.replace('_make_packed_attention(', '_make_lane_attention(')
        result = result[:a] + branch + original + result[b:]
        ast.parse(result)
        p = HERE / f'lane_pack_k{int(kl)}v{int(vl)}.py'
        if p.exists():
            raise FileExistsError(p)
        p.write_text(result)
        print(p.name)
