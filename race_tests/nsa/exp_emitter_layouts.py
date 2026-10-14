"""Probe: which (qk C-store, pv A-load) emitter configs produce the SAME
fragment layout, so the f32->f16 cast between the two mma stages can be a
plain elementwise T.copy without a layout conflict?  Layout objects must be
created inside a prim_func trace (T.alloc_fragment needs the builder scope).
"""
import sys

import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter

f16, f32 = T.float16, T.float32

QK_CFGS = [(kp, chunk) for kp in (1, 2) for chunk in (32, 64, 128)
           if chunk % (kp * 16) == 0]
PV_CFGS = [(kp, chunk) for kp in (1, 2) for chunk in (16, 32)
           if chunk % (kp * 16) == 0]

CAPTURE = {}


def qk_step(cfg):
    kp, chunk = cfg
    qk = TensorCoreIntrinEmitter(
        a_dtype=f16, b_dtype=f16, accum_dtype=f32,
        a_transposed=False, b_transposed=True,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=32, chunk=chunk, k_pack=kp,
    )
    frag = T.alloc_fragment([16, 32], f32)
    CAPTURE[("qk", kp, chunk)] = str(qk.make_mma_store_layout(frag))


def pv_step(cfg):
    kp, chunk = cfg
    pv = TensorCoreIntrinEmitter(
        a_dtype=f16, b_dtype=f16, accum_dtype=f32,
        a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=128, chunk=chunk, k_pack=kp,
    )
    frag = T.alloc_fragment([16, 32], f16)
    CAPTURE[("pv", kp, chunk)] = str(pv.make_mma_load_layout(frag, "A"))


def build_probe():
    @T.prim_func
    def probe(x: T.Tensor((4,), f16)):
        with T.Kernel(1, threads=64) as _:
            # list(map(...)) so the eager builder does not rewrite the loops
            list(map(qk_step, QK_CFGS))
            list(map(pv_step, PV_CFGS))
            x[0] = x[0]

    return probe


kern = tilelang.compile(build_probe(), out_idx=None)
print("=== qk C-store layouts ===")
for (t, kp, chunk), lay in CAPTURE.items():
    if t == "qk":
        print(f"k_pack={kp} chunk={chunk}: {lay[:170]}")
print("=== pv A-load layouts ===")
for (t, kp, chunk), lay in CAPTURE.items():
    if t == "pv":
        print(f"k_pack={kp} chunk={chunk}: {lay[:170]}")
print("=== matches ===")
found = False
for (t1, kp1, c1), l1 in CAPTURE.items():
    for (t2, kp2, c2), l2 in CAPTURE.items():
        if t1 == "qk" and t2 == "pv" and l1 == l2:
            print(f"MATCH: qk(k_pack={kp1}, chunk={c1}) == pv(k_pack={kp2}, chunk={c2})")
            found = True
if not found:
    print("no exact match among probed configs")
