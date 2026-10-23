"""Screen accurate degree-3/4 exp2 polynomials against the native SFU path.

The exponent is range-reduced into an integer power of two and a fraction
in [0, 1]. The original upper clipping and masked-zero behavior remain.
The benchmark tolerance is unchanged; these are approximate research probes.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "_coalesced_block_loads_prim_oct8", "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_fp32_sum", "_coalesced_block_loads_prim_boundary_v8",
    "native_sparse_attention_q_preload", "native_sparse_attention_q_preload_vfirst",
    "native_sparse_attention_short_list_oct8_sum_v11", "native_sparse_attention_staged_sparse_blocks_sum_v11",
}


class Rewrite(ast.NodeTransformer):
    def __init__(self):
        self.count = 0

    def visit_Call(self, node):
        node = self.generic_visit(node)
        if isinstance(node.func, ast.Attribute) and isinstance(node.func.value, ast.Name) and node.func.value.id == "T":
            if node.func.attr in ("exp", "exp2"):
                self.count += 1
                argument = node.args[0]
                if node.func.attr == "exp":
                    argument = ast.BinOp(left=argument, op=ast.Mult(), right=ast.Constant(1.4426950408889634))
                return ast.Call(func=ast.Name(id="_exp2_polynomial_v12", ctx=ast.Load()), args=[argument], keywords=[])
        return node


def main():
    source = (HERE / "baseline.py").read_text()
    samples = np.linspace(0.0, 1.0, 32769)
    check = np.linspace(0.0, 1.0, 1048577)
    records = []
    for degree in (3, 4):
        fit = np.polynomial.Chebyshev.fit(samples, np.exp2(samples), degree, domain=[0, 1])
        coefficients = fit.convert(kind=np.polynomial.Polynomial).coef.astype(np.float32)
        actual = np.polynomial.polynomial.polyval(check.astype(np.float32), coefficients)
        relative = np.abs(actual.astype(np.float64) / np.exp2(check) - 1.0)
        assert relative.max() < (2e-4 if degree == 3 else 1e-5), (degree, relative.max())
        helper = ["def _exp2_polynomial_v12(value):",
                  "    bounded = T.max(value, -126.0)",
                  "    exponent = T.floor(bounded)",
                  "    fraction = bounded - exponent",
                  f"    polynomial = T.float32({float(coefficients[-1])!r})"]
        for coefficient in reversed(coefficients[:-1]):
            helper.append(f"    polynomial = polynomial * fraction + T.float32({float(coefficient)!r})")
        helper += ['    power = T.reinterpret("float32", T.Cast("uint32", exponent + 127.0) << 23)',
                   '    return T.if_then_else(value >= -126.0, polynomial * power, T.float32(0.0))', ""]
        result = source
        changes = {}
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in NAMES:
                continue
            rewriter = Rewrite()
            changed = rewriter.visit(copy.deepcopy(fn))
            changed.decorator_list = []
            if rewriter.count:
                changes[fn.name] = rewriter.count
                result = result.replace(ast.get_source_segment(source, fn), ast.unparse(ast.fix_missing_locations(changed)), 1)
        position = result.index("def _clamped_load_base(")
        result = result[:position] + "\n".join(helper) + "\n\n" + result[position:]
        ast.parse(result)
        path = HERE / f"exp_poly{degree}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            degree=degree, coefficients=coefficients.tolist(), changes=changes,
                            cpu_fraction_samples=len(check), max_relative_error=float(relative.max())))
    (HERE / "exp_polynomial_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        gpu_numerical_validation="pending", unchanged_test_tolerance=dict(atol=0.01,rtol=0.01)), indent=2) + "\n")
    print([(r["degree"],r["max_relative_error"]) for r in records])


if __name__ == "__main__":
    main()
