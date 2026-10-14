"""S1 inverse-index bucketing and batched attention (experimental)."""
import torch
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter


@tilelang.jit
def make_buckets(B, N, H, BS, causal):
    NB = tilelang.cdiv(N, BS)
    BN = tilelang.math.next_power_of_2(N)
    @T.prim_func
    def kernel(Indices: T.Tensor([B,N,H,1], T.int32),
               Sorted: T.Tensor([B,H,NB+1,N], T.int32),
               Counts: T.Tensor([B,H,NB+1], T.int32)):
        with T.Kernel(NB+1, B*H, threads=256) as (bucket,bh):
            scan = T.alloc_shared([BN], T.int32)
            mask = T.alloc_fragment([BN], T.int32)
            for t in T.Parallel(BN):
                raw = T.if_then_else(t<N, Indices[bh//H,t,bh%H,0], -1)
                dest = T.if_then_else(raw>=0 and raw<NB and (not causal or raw*BS<=t),raw,NB)
                mask[t] = T.if_then_else(t<N and dest==bucket,1,0)
            T.copy(mask,scan)
            T.cumsum(scan)
            for t in T.Parallel(BN):
                if mask[t] != 0:
                    Sorted[bh//H,bh%H,bucket,scan[t]-1] = t
            if T.get_thread_binding() == 0:
                Counts[bh//H,bh%H,bucket] = scan[BN-1]
    return kernel


@tilelang.jit
def make_schedule(B,N,H,BS,QT):
    NB=tilelang.cdiv(N,BS)
    NS=max(64,tilelang.math.next_power_of_2(NB+1))
    CAP=tilelang.cdiv(N,QT)+NB+1
    @T.prim_func
    def kernel(Counts: T.Tensor([B,H,NB+1],T.int32),
               Schedule: T.Tensor([B,H,CAP,3],T.int32)):
        with T.Kernel(B*H,threads=64) as bh:
            scan=T.alloc_shared([NS],T.int32)
            tid=T.get_thread_binding()
            for i in T.serial(T.ceildiv(CAP,64)):
                dst=i*64+tid
                if dst<CAP:
                    Schedule[bh//H,bh%H,dst,0]=-1
                    Schedule[bh//H,bh%H,dst,1]=-1
                    Schedule[bh//H,bh%H,dst,2]=-1
            for i in T.serial(NS//64):
                j=i*64+tid
                scan[j]=T.if_then_else(j<NB+1,T.ceildiv(Counts[bh//H,bh%H,j],QT),0)
            T.cumsum(scan)
            for i in T.serial(T.ceildiv(NB+1,64)):
                j=i*64+tid
                if j<NB+1:
                    count=Counts[bh//H,bh%H,j]
                    groups=T.ceildiv(count,QT)
                    for g in T.serial(groups):
                        dst=scan[j]-groups+g
                        Schedule[bh//H,bh%H,dst,0]=j
                        Schedule[bh//H,bh%H,dst,1]=g*QT
                        Schedule[bh//H,bh%H,dst,2]=T.min(QT,count-g*QT)
    return kernel


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH:True,
                           tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED:True})
def bucket_attention(B,N,H,D,BS,QT,causal,scale_log2):
    G=16
    M=G*QT
    NB=tilelang.cdiv(N,BS)
    CAP=tilelang.cdiv(N,QT)+NB+1
    qk=TensorCoreIntrinEmitter(a_dtype=T.float16,b_dtype=T.float16,accum_dtype=T.float32,
        a_transposed=False,b_transposed=True,block_row_warps=QT,block_col_warps=1,
        warp_row_tiles=16,warp_col_tiles=BS,chunk=D,k_pack=2)
    pv=TensorCoreIntrinEmitter(a_dtype=T.float16,b_dtype=T.float16,accum_dtype=T.float32,
        a_transposed=False,b_transposed=False,block_row_warps=QT,block_col_warps=1,
        warp_row_tiles=16,warp_col_tiles=D,chunk=BS,k_pack=1)
    @T.prim_func
    def kernel(Q:T.Tensor([B,N,H*G,D],T.float16),
               K:T.Tensor([B,N,H,D],T.float16),
               V:T.Tensor([B,N,H,D],T.float16),
               Sorted:T.Tensor([B,H,NB+1,N],T.int32),
               Schedule:T.Tensor([B,H,CAP,3],T.int32),
               Output:T.Tensor([B,N,H*G,D],T.float16)):
        with T.Kernel(CAP,B*H,threads=QT*64) as (bx,bh):
            q=T.alloc_fragment([M,D],T.float16)
            k=T.alloc_fragment([BS,D],T.float16)
            v=T.alloc_fragment([BS,D],T.float16)
            kv=T.alloc_shared([BS,D],T.float16)
            scores=T.alloc_fragment([M,BS],T.float32)
            prob=T.alloc_fragment([M,BS],T.float16)
            out=T.alloc_fragment([M,D],T.float32)
            denom=T.alloc_fragment([M],T.float32)
            kb=T.alloc_local([qk.warp_cols*qk.k_pack*qk.local_size_b],T.float16)
            vb=T.alloc_local([pv.warp_cols*pv.k_pack*pv.local_size_b],T.float16)
            T.annotate_layout({q:qk.make_mma_load_layout(q,'A'),
                kv:tilelang.maca.intrinsics.make_mma_swizzle_layout(kv,vecSize=8),
                scores:qk.make_mma_store_layout(scores),
                prob:pv.make_mma_load_layout(prob,'A'),
                out:pv.make_mma_store_layout(out)})
            bucket=Schedule[bh//H,bh%H,bx,0]
            start=Schedule[bh//H,bh%H,bx,1]
            count=Schedule[bh//H,bh%H,bx,2]
            wave=T.get_thread_binding()//64
            T.clear(out)
            if bucket>=0:
                token=T.if_then_else(wave<count,Sorted[bh//H,bh%H,bucket,start+wave],0)
                if bucket<NB:
                    for m,d in T.Parallel(M,D):
                        q[m,d]=T.if_then_else(m//G<count,Q[bh//H,token,bh%H*G+m%G,d],0)
                    T.copy(K[bh//H,bucket*BS:(bucket+1)*BS,bh%H,:],k)
                    T.copy(V[bh//H,bucket*BS:(bucket+1)*BS,bh%H,:],v)
                    T.copy(k,kv)
                    for m,j in T.Parallel(M,BS):
                        pos=bucket*BS+j
                        scores[m,j]=T.if_then_else(m//G<count and pos<N and (not causal or pos<=token),0,-T.infinity(T.float32))
                    for ki in T.serial(D//32):
                        qk.ldmatrix_b(kb,kv,ki)
                        qk.mma(q,kb,scores,ki)
                    T.copy(v,kv)
                    for m,j in T.Parallel(M,BS):
                        scores[m,j]=T.exp2(T.min(scores[m,j]*scale_log2,15.0))
                    T.copy(scores,prob)
                    for ki in T.serial(BS//16):
                        pv.ldmatrix_b(vb,kv,ki)
                        pv.mma(prob,vb,out,ki)
                    T.reduce_sum(scores,denom,dim=1)
                    for m,d in T.Parallel(M,D):
                        out[m,d]*=T.if_then_else(denom[m]>0,1.0/denom[m],0)
                for m,d in T.Parallel(M,D):
                    if m//G<count:
                        Output[bh//H,token,bh%H*G+m%G,d]=out[m,d]
    return kernel


class BucketKernel:
    def __init__(self,B,N,H,D,BS,causal,scale,QT=4):
        self.shapes=(B,H,tilelang.cdiv(N,BS)+1,N)
        self.schedule_shape=(B,H,tilelang.cdiv(N,QT)+tilelang.cdiv(N,BS)+1,3)
        self.first=make_buckets(B,N,H,BS,causal)
        self.second=make_schedule(B,N,H,BS,QT)
        self.attention=bucket_attention(B,N,H,D,BS,QT,causal,(D**-0.5 if scale is None else scale)*1.44269504)
    def __call__(self,q,k,v,indices,out):
        sorted_indices=torch.empty(self.shapes,device=q.device,dtype=torch.int32)
        counts=torch.empty(self.shapes[:-1],device=q.device,dtype=torch.int32)
        schedule=torch.empty(self.schedule_shape,device=q.device,dtype=torch.int32)
        self.first(indices,sorted_indices,counts)
        self.second(counts,schedule)
        self.attention(q,k,v,sorted_indices,schedule,out)
    def get_kernel_source(self):
        return self.first.get_kernel_source()+self.second.get_kernel_source()+self.attention.get_kernel_source()
