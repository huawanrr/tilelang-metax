"""Interleave QK steps for runtime-proven full S8 block groups.

Earlier grouped experiments completed each QK separately, under individual
guards. Here a joint runtime guard permits alternating independent MMA
accumulators at each reduction step. The original path handles partial or
invalid blocks. K lookahead, PV accumulator association and output stay intact.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def rename_score(node, index):
    return ast.parse(ast.unparse(node).replace("acc_s[", f"qk_interleave{index}[")
                     .replace(", acc_s,", f", qk_interleave{index},")) .body[0]


def transform(fn, size, vfirst):
    fn = copy.deepcopy(fn)
    fn.name += "_interleaved"
    fn.body.insert(0, ast.parse("assert selected_blocks == 8 and prefetch_depth == 4").body[0])
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    for i in range(size):
        scope.body[:0] = ast.parse(f"""
qk_interleave{i} = T.alloc_fragment([G, BS], T.float32)
T.annotate_layout({{qk_interleave{i}: qk.make_mma_store_layout(qk_interleave{i})}})
""").body
    outer = next(n for n in ast.walk(scope) if isinstance(n, ast.For)
                 and ast.unparse(n.target) == "group")
    guards = [n for n in outer.body if isinstance(n, ast.If) and len(n.body) > 1]
    assert len(guards) == 4
    for guard in guards:
        assert len(guard.body) == 7
        assert "V_reg[j, d]" in ast.unparse(guard.body[0])
        assert "qk.mma" in ast.unparse(guard.body[2])
        assert "pv.mma" in ast.unparse(guard.body[6])
    replacements = []
    for start in range(0, 4, size):
        ids = list(range(start, start + size))
        cond = " and ".join(f"i_s{i} >= 0 and i_s{i} + BS <= seq_len and (not is_causal or i_s{i} + BS <= i_t + 1)" for i in ids)
        fast = []
        if vfirst:
            fast.append(copy.deepcopy(guards[start].body[0]))
        for j in range(size):
            fast += ast.parse(f"T.clear(qk_interleave{j})").body
        mma_loop = ast.parse("for ki in T.serial(qk_steps):\n    pass").body[0]
        mma_loop.body = []
        for j, i in enumerate(ids):
            original = guards[i].body[2]
            assert ast.unparse(original.iter) == "T.serial(qk_steps)"
            mma_loop.body += [rename_score(n, j) for n in original.body]
        fast.append(mma_loop)
        for j, i in enumerate(ids):
            original = guards[i].body
            if not (vfirst and j == 0):
                fast.append(copy.deepcopy(original[0]))
            exp = original[3]
            assert ast.unparse(exp.test) == "scale_log2 > 0"
            # Full-block validity makes the extra nonpositive-scale mask
            # identically true, without changing the exponent or clipping.
            fast += [rename_score(n, j) for n in exp.body]
            fast += [rename_score(n, j) for n in original[4:]]
        replacements.append(ast.If(test=ast.parse(cond, mode="eval").body,
            body=fast, orelse=copy.deepcopy(guards[start:start + size])))
    first = outer.body.index(guards[0])
    assert outer.body[first:] == guards
    outer.body[first:] = replacements
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for size, vfirst in ((2, True), (2, False), (4, True)):
        result = source
        additions = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in NAMES:
                continue
            additions.append(transform(fn, size, vfirst))
            marker = f"                    online_builder = {fn.name}\n"
            assert result.count(marker) == 1
            result = result.replace(marker, f"                    online_builder = {fn.name}_interleaved\n", 1)
        assert len(additions) == 2
        position = result.index("def _get_kernel(")
        result = result[:position] + "\n\n".join(additions) + "\n\n" + result[position:]
        ast.parse(result)
        path = HERE / f"s8_interleave{size}_v{int(vfirst)}.py"
        with path.open("x") as file:
            file.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(), group=size, vfirst=vfirst))
    (HERE / "s8_interleave_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        dispatch="Existing default mathcast_s8 paths", fallback="Original per-block computation"), indent=2) + "\n")
    print("Generated", len(records), "interleaved S8 probes", flush=True)


if __name__ == "__main__":
    main()
