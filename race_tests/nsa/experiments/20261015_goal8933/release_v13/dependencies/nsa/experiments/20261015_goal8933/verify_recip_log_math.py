"""Check GPU reciprocals against FP64 arithmetic across normal denominators."""
import argparse
import ast
import hashlib
import json
from pathlib import Path

import numpy as np
import torch
import tilelang
import tilelang.language as T

from make_recip_log import MODES

HERE = Path(__file__).resolve().parent


def direct(value):
    return 1.0 / value


def newton2(value):
    y = T.reinterpret("float32", T.uint32(2129859011) - T.reinterpret("uint32", value))
    y = y * (2.0 - value * y)
    y = y * (2.0 - value * y)
    return y


def exp2_log2(value):
    return T.exp2(-T.log2(value))


def exp_log(value):
    return T.exp(-T.log(value))


def exp_log2(value):
    return T.exp(-T.log2(value) * 0.6931471805599453)


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
    # Bind the numerical test to the exact probe generator expressions.
    functions = {fn.name: fn for fn in ast.parse(Path(__file__).read_text()).body
                 if isinstance(fn, ast.FunctionDef)}
    for name, expression in MODES.items():
        assert ast.dump(functions[name].body[0].value) == ast.dump(
            ast.parse(expression.format(value="value"), mode="eval").body)
    rng = np.random.default_rng(20261015)
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
    report = dict(
        command=__import__("sys").argv,
        source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        generator_sha256=hashlib.sha256((HERE / "make_recip_log.py").read_bytes()).hexdigest(),
        inputs=len(values), exhaustive_mantissa_exponent=127,
        sampled_exponent_bits=[1, 179], acceptance_bound=2e-5,
        note="Positive normal FP32 denominators plus zero/negative guards; FP64 CPU reciprocal reference.",
        rows=[], status="running",
    )
    for name in ("direct", "newton2", "exp2_log2", "exp_log", "exp_log2"):
        kernel = build(globals()[name], len(values))
        kernel(x, y)
        actual = y.cpu().numpy().copy()
        relative = np.abs(actual[3:].astype(np.float64) * positive64 - 1.0)
        worst = int(np.argmax(relative))
        passed = bool(np.equal(actual[:3], 0).all()
                      and np.isfinite(actual).all() and (actual[3:] > 0).all()
                      and relative.max() < report["acceptance_bound"])
        row = dict(
            mode=name, passed=passed, max_relative_error=float(relative.max()),
            central_max_relative_error=float(relative[central].max()),
            worst_input=float(values[3 + worst]), worst_output=float(actual[3 + worst]),
            device_source_sha256=hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest(),
        )
        (output.parent / f"{output.stem}_{name}.cpp").write_text(kernel.get_kernel_source())
        report["rows"].append(row)
        output.write_text(json.dumps(report, indent=2) + "\n")
        print(row, flush=True)
    report["status"] = "PASS" if all(row["passed"] for row in report["rows"]) else "FAIL"
    output.write_text(json.dumps(report, indent=2) + "\n")
    assert report["status"] == "PASS"


if __name__ == "__main__":
    main()
