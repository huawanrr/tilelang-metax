"""Check the FP32 MMA sum against independent FP64 arithmetic and the old wave sum."""
import hashlib
import json
from pathlib import Path

import numpy as np
import torch
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter

HERE = Path(__file__).resolve().parent


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def sum_kernel(n, use_mma):
    mma = TensorCoreIntrinEmitter(a_dtype=T.float32, b_dtype=T.float32,
        accum_dtype=T.float32, a_transposed=False, b_transposed=False,
        block_row_warps=1, block_col_warps=1, warp_row_tiles=16,
        warp_col_tiles=16, chunk=4, k_pack=1)

    @T.prim_func
    def kernel(A: T.Tensor([n, 16, 4], T.float32), C: T.Tensor([n, 16, 16], T.float32)):
        with T.Kernel(n, threads=64) as bx:
            a = T.alloc_fragment([16, 4], T.float32)
            b = T.alloc_local([1], T.float32)
            c = T.alloc_fragment([16, 16], T.float32)
            T.annotate_layout({a: T.Fragment([16, 4],
                forward_thread_fn=lambda i, k: i + k * 16,
                forward_index_fn=lambda i, k: 0),
                c: mma.make_mma_store_layout(c)})
            T.copy(A[bx, :, :], a)
            T.fill(b, 1.0)
            T.clear(c)
            if use_mma:
                mma.mma(a, b, c, 0)
            else:
                for i, k in T.Parallel(16, 4):
                    a[i, k] += T.shfl_xor(a[i, k], 32, 64, 18446744073709551615)
                    a[i, k] += T.shfl_xor(a[i, k], 16, 64, 18446744073709551615)
                for i, j in T.Parallel(16, 16):
                    c[i, j] = a[i, j // 4]
            T.copy(c, C[bx, :, :])
    return kernel


def vectors(seed):
    rng = np.random.default_rng(seed)
    count = 8192
    # Set every FP32 mantissa bit directly; a TF32/FP16 input truncation cannot
    # pass the single-nonzero identity checks.
    exponents = rng.integers(1, 248, size=(count, 4), dtype=np.uint32)
    bits = (exponents << 23) | rng.integers(0, 1 << 23, size=(count, 4), dtype=np.uint32)
    wide = bits.view(np.float32)
    near_one = (np.uint32(127 << 23) | rng.integers(0, 1 << 23,
                size=(count, 4), dtype=np.uint32)).view(np.float32)
    partials = np.exp(rng.uniform(-80, np.log(131072), size=(count, 4))).astype(np.float32)
    partials[rng.random((count, 4)) < 0.3] = 0
    subnormal = rng.integers(0, 1 << 23, size=(count, 4), dtype=np.uint32).view(np.float32)
    result = {"zeros": np.zeros((16, 4), dtype=np.float32),
              "near_one_full_mantissa": near_one,
              "softmax_partial_range": partials,
              "wide_positive_normals": wide,
              "subnormals_diagnostic": subnormal}
    for lane in range(4):
        x = np.zeros((count, 4), dtype=np.float32)
        x[:, lane] = wide[:, lane]
        result[f"single_nonzero_lane{lane}"] = x
    return result


@torch.no_grad()
def main():
    path = HERE / "fp32_sum_numeric.json"
    assert not path.exists(), path
    torch.backends.cuda.matmul.allow_tf32 = False
    report = dict(source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  reference="NumPy FP64 sum of original FP32 inputs, rounded once to FP32",
                  rows=[], status="running")
    for seed in (0, 61, 2026):
        for name, x in vectors(seed).items():
            n = len(x) // 16
            a = torch.from_numpy(x.reshape(n, 16, 4).copy()).to("cuda").contiguous()
            c = torch.empty((n, 16, 16), device="cuda", dtype=torch.float32)
            values, sources = [], []
            for use_mma in (False, True):
                kernel = sum_kernel(n, use_mma)
                c.fill_(float("nan"))
                kernel(a, c)
                torch.cuda.synchronize()
                values.append(c.cpu().numpy().reshape(-1, 16).copy())
                sources.append(hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest())
            old, new = values
            expected64 = x.astype(np.float64).sum(axis=1)
            expected = expected64.astype(np.float32)
            ulps = np.abs(new.view(np.int32).astype(np.int64) -
                          expected.view(np.int32).astype(np.int64)[:, None])
            error = np.abs(new.astype(np.float64) - expected64[:, None])
            denom = np.maximum(expected64[:, None], np.finfo(np.float32).tiny)
            row = dict(seed=seed, category=name, input_rows=len(x),
                input_sha256=hashlib.sha256(x.tobytes()).hexdigest(),
                finite=bool(np.isfinite(new).all()), max_ulp=int(ulps.max()),
                max_relative_error=float((error / denom).max()),
                all_columns_equal=bool((new == new[:, :1]).all()),
                old_new_bit_equal=bool(np.array_equal(old.view(np.uint32), new.view(np.uint32))),
                old_max_ulp=int(np.abs(old.view(np.int32).astype(np.int64) -
                    expected.view(np.int32).astype(np.int64)[:, None]).max()),
                device_source_sha256=sources)
            report["rows"].append(row)
            path.write_text(json.dumps(report, indent=2) + "\n")
            print(json.dumps(row), flush=True)
            assert row["finite"] and row["all_columns_equal"], row
            if name == "subnormals_diagnostic":
                # FTZ is backend dependent. Record it separately and require
                # the same behavior as the existing FAST_MATH wave path.
                assert row["old_new_bit_equal"], row
            else:
                assert row["max_ulp"] <= 3, row
                if name.startswith("single_nonzero") or name == "zeros":
                    assert row["max_ulp"] == 0, row
    report["status"] = "PASS"
    report["total_input_rows"] = sum(r["input_rows"] for r in report["rows"])
    path.write_text(json.dumps(report, indent=2) + "\n")
    print("PASS", report["total_input_rows"], flush=True)


if __name__ == "__main__":
    main()
