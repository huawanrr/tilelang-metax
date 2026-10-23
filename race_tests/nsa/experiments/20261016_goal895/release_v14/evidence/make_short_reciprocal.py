"""Compare one reciprocal refinement with the current two-step S2/S4 helper.

The biased coefficient minimizes worst relative error of one refinement over
positive normal FP32 inputs. This is an explicitly approximate probe; the
original end-to-end tolerance and positive-denominator guards stay unchanged.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
NAMES = {"native_sparse_attention_short_list_oct8_sum_v11",
         "native_sparse_attention_staged_sparse_blocks_sum_v11"}


def cpu_error(constant, coefficient):
    maximum = 0.0
    minimum_signed, maximum_signed = 1.0, -1.0
    count = 0
    inputs = [(np.uint32(127 << 23) + np.arange(begin, begin + (1 << 16), dtype=np.uint32))
              for begin in range(0, 1 << 23, 1 << 16)]
    rng = np.random.default_rng(20261016)
    for exponent in range(1, 180):
        mantissas = rng.integers(0, 1 << 23, size=2048, dtype=np.uint32)
        mantissas[:3] = [0, 1, (1 << 23) - 1]
        inputs.append(np.uint32(exponent << 23) + mantissas)
    for bits in inputs:
        x = bits.view(np.float32)
        initial = (np.uint32(constant) - bits).view(np.float32)
        estimate = np.float32(initial * np.float32(np.float32(coefficient) - np.float32(x * initial)))
        relative = x.astype(np.float64) * estimate.astype(np.float64) - 1.0
        assert np.isfinite(estimate).all() and (estimate > 0).all()
        maximum = max(maximum, float(np.abs(relative).max()))
        minimum_signed = min(minimum_signed, float(relative.min()))
        maximum_signed = max(maximum_signed, float(relative.max()))
        count += len(bits)
    assert maximum < 0.003
    return dict(inputs=count, max_relative_error=maximum,
                signed_error_range=[minimum_signed, maximum_signed],
                exhaustive_unit_mantissas=True, sampled_exponent_bits=[1, 179],
                arithmetic="CPU FP32 non-fused; GPU check required before adoption")


class Rename(ast.NodeTransformer):
    def visit_Name(self, node):
        if node.id == "_small_newton2":
            return ast.copy_location(ast.Name(id="_short_reciprocal_trial", ctx=node.ctx), node)
        return node


def main():
    source = (HERE / "baseline.py").read_text()
    rows = []
    for name, constant, coefficient in (
        ("newton1", 0x7EF311C3, 2.0),
        ("minimax1", 0x7EF33409, 2.001281261444092),
    ):
        result = source
        changed = []
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in NAMES:
                transformed = Rename().visit(copy.deepcopy(fn))
                transformed.decorator_list = []
                result = result.replace(ast.get_source_segment(source, fn),
                                        ast.unparse(ast.fix_missing_locations(transformed)), 1)
                changed.append(fn.name)
        assert len(changed) == 2
        helper = f'''def _short_reciprocal_trial(value):
    initial = T.reinterpret("float32", T.uint32({constant}) - T.reinterpret("uint32", value))
    return initial * ({coefficient!r} - value * initial)

'''
        at = result.index("def _small_newton2(")
        result = result[:at] + helper + result[at:]
        ast.parse(result)
        path = HERE / f"short_{name}.py"
        with path.open("x") as out:
            out.write(result)
        rows.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                         constant=constant, coefficient=coefficient,
                         changed_functions=changed, cpu_math=cpu_error(constant, coefficient)))
    with (HERE / "short_reciprocal_manifest.json").open("x") as out:
        json.dump(dict(baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       variants=rows, end_to_end_tolerance_unchanged=True), out, indent=2)
        out.write("\n")
    for row in rows:
        print(row["path"], row["cpu_math"]["max_relative_error"])


if __name__ == "__main__":
    main()
