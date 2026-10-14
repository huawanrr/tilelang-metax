"""Research lower-bounded raw weights and polynomial exp2 on packed S8 only."""
import ast
import hashlib
import json
from pathlib import Path
import re

import numpy as np
from numpy.polynomial import Chebyshev, Polynomial

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/nsa.py"
BUILDERS = ("native_sparse_attention_online_packed",
            "native_sparse_attention_online_packed_batch_minor_o_v2",
            "native_sparse_attention_online_packed_quad_batch_minor_o_v2")


def main():
    source = BASE.read_text()
    lines = source.splitlines(keepends=True)
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    pattern = re.compile(r"T\.exp2\(\s*T\.min\(acc_s\[i, j\] \* scale_log2, 15\.0\)\)")
    records = []
    for mode in ("floor64", "floor80", "poly3", "poly4"):
        result = source
        metadata = {}
        if mode.startswith("poly"):
            degree = int(mode[-1])
            coeff = Chebyshev.interpolate(lambda x: 2.0 ** x, degree, domain=[0, 1]).convert(kind=Polynomial).coef
            coeff = coeff.astype(np.float32)
            xs = np.linspace(0, 1, 1000001, dtype=np.float64)
            values = np.polynomial.polynomial.polyval(xs, coeff)
            relative = np.max(np.abs(values / np.exp2(xs) - 1))
            expression = repr(float(coeff[-1]))
            for value in reversed(coeff[:-1]):
                expression = f"({expression} * fraction + {float(value)!r})"
            helper = f'''\ndef _packed_raw_exp2(x):
    bounded = T.max(x, T.float32(-64.0))
    exponent = T.cast(T.floor(bounded), T.int32)
    fraction = bounded - T.cast(exponent, T.float32)
    polynomial = {expression}
    factor = T.reinterpret((exponent + 127) << 23, T.float32)
    return polynomial * factor

'''
            result = result.replace("\ndef _get_kernel(", helper + "\ndef _get_kernel(", 1)
            replacement = "_packed_raw_exp2(T.min(acc_s[i, j] * scale_log2, 15.0))"
            metadata = dict(degree=degree, coefficients=[float(x) for x in coeff],
                sampled_relative_error_float64_eval=relative, sample_count=len(xs),
                note="Coefficient rounding included; this is not a GPU arithmetic error proof.")
        else:
            bound = -float(mode[5:])
            replacement = f"T.exp2(T.max(T.min(acc_s[i, j] * scale_log2, 15.0), {bound}))"
            metadata = dict(lower_exponent_bound=bound)
        changed = []
        for name in BUILDERS:
            node = functions[name]
            first = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
            old = "".join(lines[first:node.end_lineno])
            new, count = pattern.subn(replacement, old)
            assert count > 0 and result.count(old) == 1
            result = result.replace(old, new)
            changed.append(dict(function=name, expressions=count))
        ast.parse(result)
        path = HERE / f"s8_math_{mode}.py"
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            changed=changed, **metadata))
    (HERE / "s8_math_assembly.json").write_text(json.dumps(dict(baseline=str(BASE), variants=records,
        scope="Research only: unnormalized packed weights, FP16 PV inputs and FP32 denominator.",
        bound_note="At -64, added denominator mass <=128*2^-64 for S8/BS16. If any FP16 weight is nonzero, its pre-cast value >=2^-25; the relative denominator perturbation is <=2^-32. This bound excludes the existing upper clipping error and polynomial approximation."),
        indent=2) + "\n")
    print("Generated", len(records), "S8 math probes")


if __name__ == "__main__":
    main()
