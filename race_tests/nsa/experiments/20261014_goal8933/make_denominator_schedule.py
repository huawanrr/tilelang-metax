"""Test normalization placement on the current FP32-MMA denominator path.

The FP16 denominator variants sum exactly the same rounded raw weights
used by PV, while retaining FP32 accumulation and FP32 normalization.
They are research probes, not a decision to weaken the error requirements.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {"_coalesced_block_loads_prim_fp32_mask", "_coalesced_block_loads_prim_boundary_v8"}


def transform(fn, mode):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    first = next(n for n in scope.body if isinstance(n, ast.If) and "_selected_block >= 0" in ast.unparse(n.test))
    normal = next(n for n in first.body if isinstance(n, ast.If) and ast.unparse(n.test) == "not late_normalize")
    first.body.remove(normal)
    output_loop = next(n for n in scope.body if isinstance(n, ast.For) and ast.unparse(n.target) == "vo")
    pv_guard = next(n for n in output_loop.body if isinstance(n, ast.If))
    if mode == "fp32_late":
        # Preserve the original full-precision reduction and inverse; move it
        # after PV, with only the final scaling redirected onto the output.
        normal.body.pop()  # old acc_s *= inverse
        pv_guard.body.append(normal)
    else:
        assert mode in ("fp16_before", "fp16_after", "fp16_newton")
        assign = next(n for n in fn.body if isinstance(n, ast.Assign)
                      and ast.unparse(n.targets[0]) == "wsum")
        for kw in assign.value.keywords:
            if kw.arg in ("a_dtype", "b_dtype"):
                kw.value = ast.Constant("float16")
            if kw.arg == "chunk":
                kw.value = ast.Name(id="BS", ctx=ast.Load())
        unit = next(n for n in scope.body if isinstance(n, ast.Assign)
                    and ast.unparse(n.targets[0]) == "wsum_unit")
        unit.value = ast.parse("T.alloc_local([4], T.float16)", mode="eval").body
        mma = ast.parse("T.clear(wsum_output)\nwsum.mma(acc_s_cast, wsum_unit, wsum_output, 0)").body
        if mode == "fp16_after":
            pv_guard.body += mma
        else:
            # Keep the original shared RAW fence last in the producer guard.
            first.body[-1:-1] = mma
        reciprocal = "_denom_newton2(wsum_output[i, lane * 4])" if mode == "fp16_newton" else "1.0 / wsum_output[i, lane * 4]"
        pv_guard.body += ast.parse(f"""
for i, lane in T.Parallel(G, 4):
    lane_sum[i, lane] = T.if_then_else(wsum_output[i, lane * 4] > 0,
                                      {reciprocal}, 0.0)
""").body
    pv_guard.body += ast.parse("""
for i, j in T.Parallel(G, VW):
    acc_o[i, j] *= lane_sum[i, j % 16 // 4]
""").body
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for mode in ("fp32_late", "fp16_before", "fp16_after", "fp16_newton"):
        result = source
        changed = []
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in NAMES:
                result = result.replace(ast.get_source_segment(source, fn), transform(fn, mode), 1)
                changed.append(fn.name)
        assert len(changed) == 2
        if mode == "fp16_newton":
            helper = '''def _denom_newton2(value):
    y = T.reinterpret("float32", T.uint32(2129859011) - T.reinterpret("uint32", value))
    y = y * (2.0 - value * y)
    y = y * (2.0 - value * y)
    return y

'''
            at = result.index("def _clamped_load_base(")
            result = result[:at] + helper + result[at:]
        ast.parse(result)
        path = HERE / f"denom_{mode}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, mode=mode, sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE / "denominator_schedule_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        note="Same validity and masks; late scaling uses FP16 raw weights for PV. Numeric and throughput checks required."), indent=2) + "\n")
    print("Generated", len(records), "denominator schedules", flush=True)


if __name__ == "__main__":
    main()
