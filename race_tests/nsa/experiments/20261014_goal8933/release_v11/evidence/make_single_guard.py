"""Keep QK, softmax and PV in a single block-uniform validity branch.

The current generic PV-width loop repeats the same validity predicate after
softmax. Moving that loop into the producer branch removes the second test
and initializes the FP16 output only on the invalid path. Shared-memory
fences and the floating-point expressions are unchanged.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
COALESCED = {
    "_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_sum", "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
}
PACKED = "native_sparse_attention_single_packed_qo_v2_mathcast"


def transform(fn, likely):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    packed = fn.name == PACKED
    condition = "valid" if packed else "_selected_block >= 0"
    first = next(n for n in scope.body if isinstance(n, ast.If) and condition in ast.unparse(n.test))
    loop = next(n for n in scope.body if isinstance(n, ast.For) and ast.unparse(n.target) == "vo")
    repeated = next(n for n in loop.body if isinstance(n, ast.If) and condition in ast.unparse(n.test))
    assert ast.dump(repeated.test) == ast.dump(first.test)
    at = loop.body.index(repeated)
    loop.body[at:at+1] = repeated.body
    if not packed:
        vb = next(n for n in scope.body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "vb")
        scope.body.remove(vb)
        first.body.append(vb)
        init = next(n for n in scope.body if ast.unparse(n) == "T.fill(acc_o, 0)")
        scope.body.remove(init)
    scope.body.remove(loop)
    first.body.append(loop)
    first.orelse = ast.parse("T.clear(output_reg)" if packed else "T.clear(O_reg)").body
    if likely:
        first.test = ast.Call(func=ast.Attribute(value=ast.Name(id="T", ctx=ast.Load()), attr="likely", ctx=ast.Load()), args=[first.test], keywords=[])
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for likely in (False, True):
        result = source
        changed = []
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in COALESCED | {PACKED}:
                result = result.replace(ast.get_source_segment(source, fn), transform(fn, likely), 1)
                changed.append(fn.name)
        assert len(changed) == 6
        ast.parse(result)
        path = HERE / f"single_guard_l{int(likely)}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(), likely=likely))
    (HERE / "single_guard_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        control_flow="Identical producer and consumer guards merged; invalid output is the same FP16 zero."), indent=2) + "\n")
    print("Generated two single-guard variants", flush=True)


if __name__ == "__main__":
    main()
