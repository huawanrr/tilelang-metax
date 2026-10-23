import os, sys, time
import torch
import mla2

b, h, n, d, p = 1, 16, 2048, 512, 64
t0 = time.time()
kernel, counter = mla2._get_fused_kernel(b, h, 1, n, d, p)
print(f'compiled in {time.time()-t0:.1f}s')
g = torch.Generator(device='cuda').manual_seed(0)
kw = dict(device='cuda', dtype=torch.float16, generator=g)
xs = (torch.randn(b,h,d,**kw), torch.randn(b,h,p,**kw), torch.randn(b,n,1,d,**kw), torch.randn(b,n,1,p,**kw))
out = torch.empty_like(xs[0])
counter.zero_()
kernel(*xs, out, counter)
torch.cuda.synchronize()
# reference
q, qp, kv, kp = xs
ref = torch.empty_like(q)
kk = kv[0,:,0].float()
sc = (q[0].float() @ kk.T + qp[0].float() @ kp[0,:,0].float().T)
ref[0] = torch.softmax(sc*(d+p)**-0.5,-1) @ kk
err = (out.float()-ref.float()).abs()
print(f'max_abs={err.max().item():.2e}')
