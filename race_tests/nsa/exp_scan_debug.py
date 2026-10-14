"""Diagnose scan-gather mismatches: which tokens, what kind of wrong."""
import sys

import torch
import nsa
from bench_oj import make_case
from exp_scan import make_scan

cfg = dict(B=2, T=256, H=1, HQ=16, D=128, S=1, bs=32, causal=True)
q, k, v, idx = make_case(cfg)
kw = dict(batch=cfg["B"], heads=cfg["HQ"], seq_len=cfg["T"], dim=cfg["D"],
          is_causal=cfg["causal"], scale=0.1, block_size=cfg["bs"],
          groups=cfg["HQ"] // cfg["H"], selected_blocks=cfg["S"])
opt = nsa.native_sparse_attention(**kw)
scan = make_scan(cfg["B"], cfg["T"], cfg["H"], cfg["HQ"], cfg["D"],
                 cfg["S"], cfg["bs"], cfg["causal"], chunk=16)
ref = opt(q, k, v, idx).float()
got = scan(q, k, v, idx).float()

err = (ref - got).abs().amax(dim=(2, 3))  # [B, T]
bad = (err > 2e-3).nonzero()
print(f"bad tokens: {bad.shape[0]} / {cfg['B'] * cfg['T']}")
for b, t in bad[:20].tolist():
    raw = idx[b, t, 0, 0].item()
    print(f"  b={b} t={t} blk={raw}  ref_norm={ref[b, t].norm():.3f} "
          f"got_norm={got[b, t].norm():.3f}  err={err[b, t]:.3f}  "
          f"zero_ref={ref[b, t].abs().max() < 1e-6} zero_got={got[b, t].abs().max() < 1e-6}")
# distribution of bad tokens by chunk-of-16
if bad.shape[0]:
    print("bad token ids:", bad[:64, 1].tolist())
