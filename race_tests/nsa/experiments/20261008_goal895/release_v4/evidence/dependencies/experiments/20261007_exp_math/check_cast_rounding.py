"""Check scalar fragment casts at FP16 ties, subnormals, overflow and NaNs."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

import numpy as np
import torch
import tilelang
import tilelang.language as T


@tilelang.jit
def convert(tiles, scalar):
    layout = T.Fragment([16, 64],
        forward_thread_fn=lambda i, j: i + j % 16 // 4 * 16,
        forward_index_fn=lambda i, j: j // 16 * 4 + j % 4)
    @T.prim_func
    def kernel(X: T.Tensor([tiles, 16, 64], T.float32), Y: T.Tensor([tiles, 16, 64], T.float16)):
        with T.Kernel(tiles, threads=64) as block:
            x = T.alloc_fragment([16, 64], T.float32)
            y = T.alloc_fragment([16, 64], T.float16)
            T.annotate_layout({x: layout, y: layout})
            T.copy(X[block, :, :], x)
            if scalar:
                for chunk in T.unroll(4):
                    for element in T.unroll(4):
                        y[T.get_thread_binding() % 16, chunk * 16 + T.get_thread_binding() // 16 * 4 + element] = x[T.get_thread_binding() % 16, chunk * 16 + T.get_thread_binding() // 16 * 4 + element]
            else:
                T.copy(x, y)
            T.copy(y, Y[block, :, :])
    return kernel


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    half_bits = np.arange(65536, dtype=np.uint16)
    all_half = half_bits.view(np.float16).astype(np.float32)
    lo = np.arange(0x7BFF, dtype=np.uint16).view(np.float16).astype(np.float32)
    hi = np.arange(1, 0x7C00, dtype=np.uint16).view(np.float16).astype(np.float32)
    ties = (lo + hi) * np.float32(0.5)
    tie_values = np.concatenate((ties, np.nextafter(ties, np.float32(-np.inf)),
                                 np.nextafter(ties, np.float32(np.inf))))
    overflow = np.array([65520.0, -65520.0], dtype=np.float32)
    rng = np.random.default_rng(20261007)
    random_bits = rng.integers(0, 2**32, size=262144, dtype=np.uint32).view(np.float32)
    values = np.concatenate((all_half, tie_values, -tie_values, overflow,
        np.nextafter(overflow, np.float32(-np.inf)), np.nextafter(overflow, np.float32(np.inf)),
        random_bits))
    count = len(values)
    values = np.pad(values, (0, (-len(values)) % 1024))
    with np.errstate(over="ignore", invalid="ignore"):
        reference = values.astype(np.float16)
    x = torch.from_numpy(values).cuda().reshape(-1, 16, 64)
    report = dict(command=sys.argv, values=count, padded_values=len(values),
                  source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), rows=[])
    expected_bits = reference.view(np.uint16)
    finite_or_inf = ~np.isnan(reference)
    outputs = []
    for scalar in (False, True):
        kernel = convert(x.shape[0], scalar)
        y = torch.empty(x.shape, dtype=torch.float16, device="cuda")
        kernel(x, y)
        actual = y.cpu().numpy().reshape(-1)
        different = finite_or_inf & (actual.view(np.uint16) != expected_bits)
        nan_mismatch = np.isnan(actual) != np.isnan(reference)
        row = dict(scalar=scalar, bit_mismatches_excluding_nan=int(different.sum()),
                   nan_classification_mismatches=int(nan_mismatch.sum()),
                   device_source_sha256=hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest())
        if different.any():
            index = np.flatnonzero(different)[:20]
            row["examples"] = [dict(input_bits=int(values.view(np.uint32)[i]),
                actual_bits=int(actual.view(np.uint16)[i]), expected_bits=int(expected_bits[i])) for i in index]
        report["rows"].append(row)
        outputs.append(actual.copy())
        Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    report["scalar_vector_bit_mismatches_excluding_nan"] = int(
        (finite_or_inf & (outputs[0].view(np.uint16) != outputs[1].view(np.uint16))).sum())
    report["passed"] = all(r["bit_mismatches_excluding_nan"] == 0 and
                            r["nan_classification_mismatches"] == 0 for r in report["rows"])
    Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))
    if not report["passed"]:
        raise AssertionError("FP16 conversion differs from the independent NumPy RN reference")


if __name__ == "__main__":
    main()
