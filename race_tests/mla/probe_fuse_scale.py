import sys, time
import torch
import mla2

mla2._CFG.update(kv_path='shared', softmax='nmax', fuse_merge=True, spin=True)
b, h, d, p = 1, 16, 512, 64
n = 2048
g = torch.Generator(device='cuda').manual_seed(0)
kw = dict(device='cuda', dtype=torch.float16, generator=g)
xs = (torch.randn(b,h,d,**kw), torch.randn(b,h,p,**kw), torch.randn(b,n,1,d,**kw), torch.randn(b,n,1,p,**kw))
q,qp,kv,kp = xs
ref = torch.empty_like(q)
kk = kv[0,:,0].float()
sc = (q[0].float() @ kk.T + qp[0].float() @ kp[0,:,0].float().T)
ref[0] = torch.softmax(sc*(d+p)**-0.5,-1) @ kk
out = torch.empty_like(q)

for ns in (2, 4, 8, 16, 32, 64):
    mla2._COUNTER_CACHE.clear()
    mla2._KERNEL_CACHE.clear()
    # monkey-patch the split selection to force this ns
    orig = mla2._select_num_split
    mla2._select_num_split = lambda batch, kv_ctx, block_n, target_ctas=104: ns
    t0 = time.time()
    try:
        counter = torch.zeros(b, 2, device='cuda', dtype=torch.int32)
        kernel = mla2.flashattn_fused(b, h, 1, n, d, p, 32, 16, ns, (d+p)**-0.5)
        kernel(*xs, out, counter)
        torch.cuda.synchronize()
        dt = time.time()-t0
        err = (out.float()-ref.float()).abs()
        print(f'ns={ns:3d} (grid {b*ns:3d} CTAs): {dt:6.2f}s  max_abs={err.max().item():.2e}', flush=True)
    except Exception as e:
        print(f'ns={ns:3d}: EXC {str(e)[:80]}', flush=True)
    mla2._select_num_split = orig
