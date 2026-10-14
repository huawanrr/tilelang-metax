"""Synchronous S1 grouped attention: scan, reuse K/V, and write results in one CTA."""
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
                           tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def fused_group_attention(batch,heads,seq_len,dim,is_causal,block_size,groups,
                          scale_log2,threads=64,query_segment=256):
    H=heads//groups
    G=groups
    BS=block_size
    D=dim
    NB=tilelang.cdiv(seq_len,BS)
    QS=query_segment
    qk=TensorCoreIntrinEmitter(a_dtype=T.float16,b_dtype=T.float16,accum_dtype=T.float32,
        a_transposed=False,b_transposed=True,block_row_warps=1,block_col_warps=1,
        warp_row_tiles=G,warp_col_tiles=BS,chunk=D,k_pack=2)
    pv=TensorCoreIntrinEmitter(a_dtype=T.float16,b_dtype=T.float16,accum_dtype=T.float32,
        a_transposed=False,b_transposed=False,block_row_warps=1,block_col_warps=1,
        warp_row_tiles=G,warp_col_tiles=D,chunk=BS,k_pack=1)
    @T.prim_func
    def kernel(Q:T.Tensor([batch,seq_len,heads,D],T.float16),
               K:T.Tensor([batch,seq_len,H,D],T.float16),
               V:T.Tensor([batch,seq_len,H,D],T.float16),
               Idx:T.Tensor([batch,seq_len,H,1],T.int32),
               Out:T.Tensor([batch,seq_len,heads,D],T.float16)):
        with T.Kernel(NB+1,T.ceildiv(seq_len,QS),batch*H,threads=64) as (bucket,segment,bh):
            scan=T.alloc_shared([QS],T.int32)
            tokens=T.alloc_shared([QS],T.int32)
            match=T.alloc_fragment([QS],T.int32)
            q=T.alloc_fragment([G,D],T.float16)
            k=T.alloc_fragment([BS,D],T.float16)
            v=T.alloc_fragment([BS,D],T.float16)
            score=T.alloc_fragment([G,BS],T.float32)
            prob=T.alloc_fragment([G,BS],T.float16)
            out=T.alloc_fragment([G,D],T.float32)
            denom=T.alloc_fragment([G],T.float32)
            T.annotate_layout({q:qk.make_mma_load_layout(q,'A'),
                k:qk.make_mma_load_layout(k,'B'),v:pv.make_mma_load_layout(v,'B'),
                score:qk.make_mma_store_layout(score),prob:pv.make_mma_load_layout(prob,'A'),
                out:pv.make_mma_store_layout(out)})
            for t in T.Parallel(QS):
                token=segment*QS+t
                raw=T.if_then_else(token<seq_len,Idx[bh//H,token,bh%H,0],-1)
                dest=T.if_then_else(raw>=0 and raw<NB and (not is_causal or raw*BS<=token),raw,NB)
                match[t]=T.if_then_else(token<seq_len and dest==bucket,1,0)
            T.copy(match,scan)
            T.cumsum(scan)
            for t in T.Parallel(QS):
                if match[t]!=0:
                    tokens[scan[t]-1]=segment*QS+t
            count=scan[QS-1]
            if count>0:
                if bucket<NB:
                    T.copy(K[bh//H,bucket*BS:(bucket+1)*BS,bh%H,:],k)
                    T.copy(V[bh//H,bucket*BS:(bucket+1)*BS,bh%H,:],v)
                for ti in T.serial(count):
                    token=tokens[ti]
                    T.clear(out)
                    if bucket<NB:
                        T.copy(Q[bh//H,token,bh%H*G:(bh%H+1)*G,:],q)
                        for i,j in T.Parallel(G,BS):
                            pos=bucket*BS+j
                            score[i,j]=T.if_then_else(pos<seq_len and (not is_causal or pos<=token),0,-T.infinity(T.float32))
                        for ki in T.serial(D//32):
                            qk.mma(q,k,score,ki)
                        for i,j in T.Parallel(G,BS):
                            score[i,j]=T.exp2(T.min(score[i,j]*scale_log2,15.0))
                        T.copy(score,prob)
                        for ki in T.serial(BS//16):
                            pv.mma(prob,v,out,ki)
                        T.reduce_sum(score,denom,dim=1,clear=True)
                        for i,j in T.Parallel(G,D):
                            out[i,j]*=T.if_then_else(denom[i]>0,1.0/denom[i],0)
                    T.copy(out,Out[bh//H,token,bh%H*G:(bh%H+1)*G,:])
    return kernel
