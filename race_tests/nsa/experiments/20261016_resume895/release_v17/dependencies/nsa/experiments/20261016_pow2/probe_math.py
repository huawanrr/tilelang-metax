"""Check whether public pow(2, x) avoids exp2f library range handling."""
import hashlib
import json
from pathlib import Path

import numpy as np
import torch
import tilelang
import tilelang.language as T

HERE = Path(__file__).resolve().parent


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True})
def exponent(size, mode):
    @T.prim_func
    def kernel(X: T.Tensor([size], "float32"), Y: T.Tensor([size], "float32")):
        with T.Kernel(T.ceildiv(size, 128), threads=128) as bx:
            for i in T.Parallel(128):
                if bx * 128 + i < size:
                    value = X[bx * 128 + i]
                    if mode == 0:
                        Y[bx * 128 + i] = T.exp2(value)
                    elif mode == 1:
                        Y[bx * 128 + i] = T.pow(T.float32(2.0), value)
                    else:
                        Y[bx * 128 + i] = T.exp(value * 0.6931471805599453)
    return kernel


def main():
    assert not (HERE / "math.json").exists()
    torch.backends.cuda.matmul.allow_tf32 = False
    values = np.concatenate([np.linspace(-150, 16, 1000001, dtype=np.float32),
                             np.array([-np.inf, -150, -149, -148, -127, -126, -125, -24, 0, 15], dtype=np.float32)])
    x = torch.from_numpy(values).cuda()
    y = torch.empty_like(x)
    reference = np.exp2(values.astype(np.float64))
    normal = values >= -126
    rows, baseline = [], None
    for mode, name in enumerate(("exp2", "pow2", "exp")):
        kernel = exponent(len(values), mode)
        kernel(x, y)
        actual = y.cpu().numpy().copy()
        if baseline is None:
            baseline = actual
        relative = np.abs(actual[normal].astype(np.float64) / reference[normal] - 1)
        source = kernel.get_kernel_source()
        (HERE / f"math_{name}.cpp").write_text(source)
        differences = np.flatnonzero(actual != baseline)
        row = dict(mode=name, max_normal_relative_error=float(relative.max()),
                   differing_elements_from_exp2=int(len(differences)),
                   max_abs_difference_from_exp2=float(np.abs(actual-baseline).max()),
                   underflow_difference_count=int(np.sum(actual[~normal] != baseline[~normal])),
                   has_powf="powf(" in source, source_sha256=hashlib.sha256(source.encode()).hexdigest())
        if len(differences):
            j=int(differences[0]);row["first_difference"]=dict(input=float(values[j]), baseline=float(baseline[j]), actual=float(actual[j]))
        rows.append(row)
        print(row, flush=True)
    report = dict(inputs=len(values), rows=rows, status="PASS",
                  source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
    (HERE / "math.json").write_text(json.dumps(report, indent=2) + "\n")
    assert rows[1]["max_normal_relative_error"] < 1e-6


if __name__ == "__main__":
    main()
