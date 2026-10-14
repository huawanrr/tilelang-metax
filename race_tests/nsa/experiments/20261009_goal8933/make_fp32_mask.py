"""Retest boundary-only masking after replacing the denominator reduction."""
import ast
import copy
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE / "fp32_core.py"
HELPER = HERE.parent / "20261008_resume8871/make_boundary_mask_probes.py"
spec = importlib.util.spec_from_file_location("nsa_boundary_transform", HELPER)
helper = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helper)
TARGETS = {"native_sparse_attention_linear_v_blocks_oct8", "_coalesced_block_loads_prim_oct8"}


def main():
    source = PARENT.read_text()
    records = []
    for mode in ("post", "split"):
        lines = source.splitlines(keepends=True)
        edits = []
        for function in ast.parse(source).body:
            if not isinstance(function, ast.FunctionDef) or function.name not in TARGETS:
                continue
            start = min([function.lineno] + [d.lineno for d in function.decorator_list]) - 1
            kernel = next(n for n in function.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
            scope = next(n for n in kernel.body if isinstance(n, ast.With))
            valid = next(n for n in scope.body if isinstance(n, ast.If) and "qk.mma(" in ast.unparse(n))
            for index, child in enumerate(valid.body):
                if "T.infinity(" in ast.unparse(child):
                    valid.body[index] = ast.parse("T.clear(acc_s)").body[0]
            old = next(n for n in valid.body if helper.exponent(n))
            unmasked = helper.Rewrite("acc_s", "i_t", False).visit(copy.deepcopy(old))
            unmasked = unmasked if isinstance(unmasked, list) else [unmasked]
            condition = ast.parse("is_causal and _selected_block == i_t // BS", mode="eval").body
            if mode == "post":
                mask = ast.parse("""
for i, j in T.Parallel(G, BS):
    acc_s[i, j] = T.if_then_else(j <= i_t % BS, acc_s[i, j], T.float32(0.0))
""").body
                replacement = unmasked + [ast.If(test=condition, body=mask, orelse=[])]
            else:
                masked = helper.Rewrite("acc_s", "i_t", True).visit(copy.deepcopy(old))
                masked = masked if isinstance(masked, list) else [masked]
                replacement = [ast.If(test=condition, body=masked, orelse=unmasked)]
            index = valid.body.index(old)
            valid.body[index:index+1] = replacement
            ast.fix_missing_locations(function)
            edits.append((start, function.end_lineno, ast.unparse(function) + "\n"))
        assert len(edits) == len(TARGETS)
        for start, end, value in reversed(edits):
            lines[start:end] = [value]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"fp32_mask_{mode}.py"
        with path.open("x") as output:
            output.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "fp32_mask_manifest.json").open("x") as output:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       helper=str(HELPER), helper_sha256=hashlib.sha256(HELPER.read_bytes()).hexdigest(),
                       variants=records, original_sync_and_fp32_sum_unchanged=True), output, indent=2)
        output.write("\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
