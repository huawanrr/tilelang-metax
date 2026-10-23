"""Check the exact reciprocal helpers over every mantissa and normal exponents."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np
import torch
import tilelang
import tilelang.language as T

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parents[1]))
from experiment_bench import load_module


def build(helper, size):
    @tilelang.jit(execution_backend="cython", pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True})
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
    output = HERE / "newton_gpu_math.json"
    assert not output.exists(), output
    rng = np.random.default_rng(20261014)
    exponents = np.arange(1, 180, dtype=np.uint32)
    random_mantissas = rng.integers(0, 1 << 23, (179, 2048), dtype=np.uint32)
    random_mantissas[:, :3] = [0, 1, (1 << 23) - 1]
    bits = np.concatenate([np.array([0], dtype=np.uint32),
        np.arange(1 << 23, dtype=np.uint32) | np.uint32(127 << 23),
        ((exponents[:, None] << np.uint32(23)) | random_mantissas).ravel()])
    values = bits.view(np.float32)
    x = torch.from_numpy(values).cuda()
    y = torch.empty_like(x)
    report = dict(inputs=len(values), exhaustive_mantissa_exponent=127, sampled_exponents=[1, 179],
                  acceptance_bound=7e-6, rows=[])
    previous = None
    for path, name in ((HERE.parent / "20261013_goal8933/reciprocal_v2_newton2.py", "_newton_denominator_reciprocal"),
                       (HERE / "small_nr2.py", "_small_newton2")):
        module = load_module(str(path))
        kernel = build(getattr(module, name), len(values))
        kernel(x, y)
        actual = y.cpu().numpy().copy()
        relative = np.abs(actual[1:].astype(np.float64) * values[1:].astype(np.float64) - 1.0)
        assert actual[0] == 0 and np.isfinite(actual).all() and (actual[1:] > 0).all()
        assert relative.max() < report["acceptance_bound"], float(relative.max())
        row = dict(module=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            helper=name, max_relative_error=float(relative.max()),
            device_source_sha256=hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest(),
            library=str(kernel.adapter.libpath))
        if previous is not None:
            row["bitwise_equal_to_old_helper"] = bool(np.array_equal(actual, previous))
        previous = actual
        report["rows"].append(row)
        output.write_text(json.dumps(report, indent=2) + "\n")
        print(name, row, flush=True)
    report["status"] = "PASS"
    output.write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
