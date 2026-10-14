"""Apply full-block boundary masking to the large coalesced family.

The previous boundary-mask study only changed the medium oct8 builder.
These probes retain the large builder's FP32 sum and all synchronization.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGET = "_coalesced_block_loads_prim_fp32_sum"


def main():
    source = (HERE / "v7_parent.py").read_text()
    original = next(n for n in ast.parse(source).body
                    if isinstance(n, ast.FunctionDef) and n.name == TARGET)
    records = []
    for mode in ("post", "exp"):
        fn = copy.deepcopy(original)
        kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
        valid = next(n for n in kernel.body[0].body
                     if isinstance(n, ast.If) and "qk.mma(" in ast.unparse(n))
        init = next(i for i, n in enumerate(valid.body) if "T.infinity(" in ast.unparse(n))
        valid.body[init] = ast.parse("T.clear(acc_s)").body[0]
        exponent = next(i for i, n in enumerate(valid.body)
                        if isinstance(n, ast.If) and ast.unparse(n.test) == "scale_log2 > 0")
        expr = ("T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))" if mode == "post" else
                "T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))")
        valid.body[exponent:exponent + 1] = ast.parse(f"""
for i, j in T.Parallel(G, BS):
    acc_s[i, j] = {expr}
if is_causal and _selected_block == i_t // BS:
    for i, j in T.Parallel(G, BS):
        acc_s[i, j] = T.if_then_else(j <= i_t % BS, acc_s[i, j], T.float32(0.0))
""").body
        ast.fix_missing_locations(fn)
        lines = source.splitlines(keepends=True)
        lines[original.lineno - 1:original.end_lineno] = [ast.unparse(fn) + "\n"]
        result = "".join(lines)
        path = HERE / f"large_boundary_{mode}.py"
        with path.open("x") as file:
            file.write(result)
        records.append(dict(path=str(path), mode=mode, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "large_mask_manifest.json").open("x") as file:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       variants=records, synchronization_unchanged=True,
                       safety_passes_unchanged=True,
                       assumptions=["Complete BS16 blocks", "Validated raw index", "Causal block <= token // BS"]),
                  file, indent=2)
        file.write("\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
