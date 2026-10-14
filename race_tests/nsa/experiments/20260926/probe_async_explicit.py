"""Isolate MACA async copy correctness across tile layout and transfer count."""
import sys
from pathlib import Path
import torch
import tilelang
import tilelang.language as T

@tilelang.jit(out_idx=[1])
def probe(rows, cols, swizzle, split, extra_sync):
    @T.prim_func
    def kernel(A:T.Tensor((rows,cols),T.float16), O:T.Tensor((rows,cols),T.float16)):
        with T.Kernel(1,threads=64):
            S=T.alloc_shared((rows,cols),T.float16)
            bar=T.alloc_maca_barrier()
            if swizzle:
                T.annotate_layout({S:tilelang.maca.intrinsics.make_mma_swizzle_layout(S,vecSize=8)})
            if split:
                for i in T.serial(rows//4):
                    T.maca_async_copy(A[i*4:(i+1)*4,:],S[i*4:(i+1)*4,:],barrier=bar)
                    T.maca_barrier_arrive_and_wait(bar)
            else:
                for step in T.serial(rows*cols//512):
                    row=(step*64+T.get_thread_binding())//(cols//8)
                    col=((T.get_thread_binding()%(cols//8)) ^ ((row//max(1,64//cols))%min(16//max(1,64//cols),cols//8)))*8
                    T.call_intrin(T.float16,tilelang.tvm.ir.Op.get("tl.maca_memcpy_async"),
                                  T.access_ptr(S[row,col],"w",8),
                                  T.access_ptr(A[row,col],"r",8),16,bar[0],annotations={"barrier_type":tilelang.tvm.tir.StringImm("b128vectype")})
                T.maca_barrier_arrive_and_wait(bar)
            if extra_sync:
                T.sync_threads()
            T.copy(S,O)
    return kernel

for rows,cols in [(16,32),(16,64),(32,128)]:
 for swizzle,split,extra in [(True,False,False)]:
    k=probe(rows,cols,swizzle,split,extra)
    tag=f'{rows}_{cols}_{swizzle}_{split}_{extra}'
    Path(__file__).with_name('probe_async_explicit_'+tag+'.cpp').write_text(k.get_kernel_source())
    x=torch.arange(rows*cols,device='cuda',dtype=torch.float32).reshape(rows,cols).half()
    y=k(x)
    print(tag,'mismatch',int((x!=y).sum()),'output row0',y[0,:16].tolist(),flush=True)
