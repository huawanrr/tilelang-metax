"""Layout-match matrix for extending the emitter path to all S==1 families.

For each family (BK in {32,64,128} x BS in {16,32,64}): the QK emitter
(C-store layout on [16,BS]) must equal the PV emitter's A-load layout
([16,BS]) for the elementwise f32->f16 cast between the stages.
"""
import sys

sys.path.insert(0, "/data/tilelang-metax/race_tests/nsa")
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter

f16, f32 = T.float16, T.float32
CAP = {}


def qk_step(cfg):
    bs, bk, kp = cfg
    e = TensorCoreIntrinEmitter(a_dtype=f16, b_dtype=f16, accum_dtype=f32,
        a_transposed=False, b_transposed=True, block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=bs, chunk=bk, k_pack=kp)
    frag = T.alloc_fragment([16, bs], f32)
    CAP[("qk", bs, bk, kp)] = str(e.make_mma_store_layout(frag))


def pv_step(cfg):
    bs, bk, kp = cfg
    e = TensorCoreIntrinEmitter(a_dtype=f16, b_dtype=f16, accum_dtype=f32,
        a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=bk, chunk=bs, k_pack=kp)
    frag = T.alloc_fragment([16, bs], f16)
    CAP[("pv", bs, bk, kp)] = str(e.make_mma_load_layout(frag, "A"))


QK = [(bs, bk, kp) for bs in (16, 32, 64) for bk in (32, 64, 128) for kp in (1, 2)]
PV = [(bs, bk, 1) for bs in (16, 32, 64) for bk in (32, 64, 128)]


@T.prim_func
def probe(x: T.Tensor((4,), f16)):
    with T.Kernel(1, threads=64) as _:
        list(map(qk_step, QK))
        list(map(pv_step, PV))
        x[0] = x[0]


tilelang.compile(probe, out_idx=None)
print("family (BK,BS) -> matching qk k_pack (pv uses k_pack=1)")
for bs in (16, 32, 64):
    for bk in (32, 64, 128):
        pv_key = ("pv", bs, bk, 1)
        if pv_key not in CAP:
            print(f"  BK{bk} BS{bs}: pv layout unavailable")
            continue
        hits = [kp for kp in (1, 2) if CAP.get(("qk", bs, bk, kp)) == CAP[pv_key]]
        print(f"  BK{bk:>3} BS{bs:>2}: {'MATCH at qk k_pack=' + str(hits) if hits else 'NO MATCH'}")
