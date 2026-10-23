"""Compare exact probe expressions with a FP64 positive reciprocal reference."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import sys

import numpy as np
import torch
import tilelang
import tilelang.language as T

from prepare import HELPERS

HERE = Path(__file__).resolve().parent


def direct(value):
    return 1.0 / value


def rsqrt(value):
    root_inv = T.rsqrt(value)
    return root_inv * root_inv


def ieee_rsqrt(value):
    root_inv = T.ieee_frsqrt(value)
    return root_inv * root_inv


def build(helper, size):
    @tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True})
    def probe():
        @T.prim_func
        def kernel(X: T.Tensor([size], "float32"), Y: T.Tensor([size], "float32")):
            with T.Kernel(T.ceildiv(size, 128), threads=128) as bx:
                for i in T.Parallel(128):
                    if bx * 128 + i < size:
                        value = X[bx * 128 + i]
                        Y[bx * 128 + i] = T.if_then_else(value > 0, helper(value), 0.0)
        return kernel
    return probe()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    output = Path(args.output)
    assert not output.exists(), output
    functions = {fn.name: fn for fn in ast.parse(Path(__file__).read_text()).body
                 if isinstance(fn, ast.FunctionDef)}
    for name, helper in HELPERS.items():
        assert [ast.dump(node) for node in functions[name].body] == [
            ast.dump(node) for node in ast.parse(helper).body[0].body]
    rng = np.random.default_rng(20261016)
    exponents = np.arange(1, 180, dtype=np.uint32)
    mantissas = rng.integers(0, 1 << 23, (len(exponents), 2048), dtype=np.uint32)
    mantissas[:, :3] = [0, 1, (1 << 23) - 1]
    bits = np.concatenate([
        np.array([0, 0x80000000, 0xBF800000], dtype=np.uint32),
        np.arange(1 << 23, dtype=np.uint32) | np.uint32(127 << 23),
        ((exponents[:, None] << np.uint32(23)) | mantissas).ravel(),
    ])
    values = bits.view(np.float32)
    x = torch.from_numpy(values).cuda()
    y = torch.empty_like(x)
    positive64 = values[3:].astype(np.float64)
    central = (positive64 >= 2.0**-24) & (positive64 <= 2.0**23)
    report = dict(command=sys.argv, inputs=len(values), exhaustive_mantissa_exponent=127,
                  sampled_exponent_bits=[1, 179], acceptance_bound=1e-6,
                  source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  generator_sha256=hashlib.sha256((HERE / "prepare.py").read_bytes()).hexdigest(),
                  note="Positive normal FP32 denominators; original zero and negative guards; FP64 CPU reciprocal reference.",
                  rows=[], status="running")
    for name in ("direct", "rsqrt", "ieee_rsqrt"):
        kernel = build(globals()[name], len(values))
        kernel(x, y)
        actual = y.cpu().numpy().copy()
        relative = np.abs(actual[3:].astype(np.float64) * positive64 - 1.0)
        worst = int(np.argmax(relative))
        passed = bool(np.equal(actual[:3], 0).all() and np.isfinite(actual).all()
                      and (actual[3:] > 0).all() and relative.max() < report["acceptance_bound"])
        row = dict(mode=name, passed=passed, max_relative_error=float(relative.max()),
                   central_max_relative_error=float(relative[central].max()),
                   worst_input=float(values[3 + worst]), worst_output=float(actual[3 + worst]),
                   device_source_sha256=hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest())
        (output.parent / f"{output.stem}_{name}.cpp").write_text(kernel.get_kernel_source())
        report["rows"].append(row)
        output.write_text(json.dumps(report, indent=2) + "\n")
        print(row, flush=True)
    report["status"] = "PASS" if all(row["passed"] for row in report["rows"]) else "FAIL"
    output.write_text(json.dumps(report, indent=2) + "\n")
    assert report["status"] == "PASS"


if __name__ == "__main__":
    main()
