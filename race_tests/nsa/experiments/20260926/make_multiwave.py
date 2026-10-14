from pathlib import Path
import ast
src=Path('experiments/20260926/baseline.py').read_text()
a=src.index('def native_sparse_attention_single_block_emitter(');b=src.index('\n\n_KERNEL_CACHE',a)
p=src[a:b]
p=p.replace('    qk, pv = _emitters(T.float16, T.float32, BS, BK)', '''    NW = 2
    M = G * NW
    qk = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True, block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=BK, k_pack=2)
    pv = TensorCoreIntrinEmitter(a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False, block_row_warps=NW, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BV, chunk=BS, k_pack=1)''')
p=p.replace('with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,\n                      threads=threads)', 'with T.Kernel(T.ceildiv(seq_len, NW), T.ceildiv(dim, BV), batch * head_kv,\n                      threads=64*NW)')
p=p.replace('T.alloc_fragment([G,','T.alloc_fragment([M,').replace('T.alloc_fragment([G]','T.alloc_fragment([M]')
p=p.replace('K_reg = T.alloc_fragment([BS, BK]', 'K_reg = T.alloc_fragment([NW, BS, BK]').replace('V_reg = T.alloc_fragment([BS, BV]', 'V_reg = T.alloc_fragment([NW, BS, BV]')
p=p.replace('KV_shared = T.alloc_shared([BS, BK]', 'KV_shared = T.alloc_shared([NW, BS, BK]')
p=p.replace('''            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)''','''            V_shared = KV_shared''')
p=p.replace('''                KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    KV_shared, vecSize=8),''','''                K_reg: T.Fragment([NW,BS,BK],
                    forward_thread_fn=lambda w,j,d: w*64 + (j*BK+d)//8%64,
                    forward_index_fn=lambda w,j,d: (j*BK+d)//512*8+d%8),
                V_reg: T.Fragment([NW,BS,BV],
                    forward_thread_fn=lambda w,j,d: w*64 + (j*BV+d)//8%64,
                    forward_index_fn=lambda w,j,d: (j*BV+d)//512*8+d%8),
                KV_shared: T.Layout([NW,BS,BK], lambda w,j,d:
                    w*BS*BK + j*BK + ((d//8) ^ (j%(BK//8)))*8+d%8),''')
a0=p.index('            if kv_split:\n                _layout');b0=p.index('            T.annotate_layout',a0)
p=p[:a0]+p[b0:]
p=p.replace('            i_t, i_v, i_bh = bx, by, bz','''            wave = T.get_thread_binding() // 64
            i_t, i_v, i_bh = bx * NW + wave, by, bz''')
p=p.replace('''            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)''','''            for m, d in T.Parallel(M, BK):
                Q_reg[m,d] = Q[i_b,bx*NW+m//G,i_h*G+m%G,d]''')
p=p.replace('''                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)
                T.copy(V[i_b, i_s : i_s + BS, i_h,
                         i_v * BV : (i_v + 1) * BV], V_reg)''','''                for w, j, d in T.Parallel(NW, BS, BK):
                    K_reg[w,j,d] = K[i_b,i_s+j,i_h,d]
                for w, j, d in T.Parallel(NW, BS, BV):
                    V_reg[w,j,d] = V[i_b,i_s+j,i_h,d]''')
a0=p.index('                if kv_split:\n                    # Separate V tile');b0=p.index('\n                if is_causal',a0)
p=p[:a0]+p[b0:]
p=p.replace('T.Parallel(G,','T.Parallel(M,').replace('T.Parallel(G)','T.Parallel(M)')
p=p.replace('qk.ldmatrix_b(kb, KV_shared, ki)', 'qk.ldmatrix_b(kb, KV_shared[wave,0:BS,0:BK], ki)')
p=p.replace('pv.ldmatrix_b(vb, V_shared, ki)', 'pv.ldmatrix_b(vb, V_shared[wave,0:BS,0:BV], ki)')
p=p.replace('''            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])''','''            for m, d in T.Parallel(M, BV):
                Output[i_b,bx*NW+m//G,i_h*G+m%G,d] = acc_o[m,d]''')
src=src[:a]+p+src[b:]
ast.parse(src)
Path('experiments/20260926/multiwave2.py').write_text(src)
