"""Balance live KV fragments, independent QK work, and output accumulators.

This revisits scheduling jointly: K lookahead alone, V lookahead alone and
QK interleaving previously failed while keeping the two output accumulators.
The new variants trade that second output tile for two prefetched V tiles.
All addresses, bounds, per-block arithmetic and output fences are retained.
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


def rename(node, old, new):
    class R(ast.NodeTransformer):
        def visit_Name(self, n):
            if n.id == old:
                return ast.copy_location(ast.Name(id=new, ctx=n.ctx), n)
            return n
    return R().visit(copy.deepcopy(node))


def transform(fn, depth, values, interleave, dual):
    fn = copy.deepcopy(fn)
    fn.name += "_pair_schedule"
    fn.body[:0] = ast.parse(f"assert selected_blocks == 8\nprefetch_depth = {depth}\ndual_acc = {dual}\n").body
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    outer = next(n for n in ast.walk(scope) if isinstance(n, ast.For)
                 and ast.unparse(n.target) == "group")
    kguards = [n for n in outer.body if isinstance(n, ast.If) and len(n.body) == 1]
    computes = [n for n in outer.body if isinstance(n, ast.If) and len(n.body) > 1]
    assert len(kguards) == len(computes) == 4
    for i in range(values):
        if i:
            scope.body[:0] = ast.parse(f"""
V_pair{i} = T.alloc_fragment([BS, BV], T.float16)
T.annotate_layout({{V_pair{i}: pv.make_mma_load_layout(V_pair{i}, "B")}})
""").body
        name = "V_reg" if i == 0 else f"V_pair{i}"
        computes[i].body = [rename(n, "V_reg", name) for n in computes[i].body]
        vload = computes[i].body.pop(0)
        assert f"{name}[j, d]" in ast.unparse(vload)
        kguards[i].body.append(vload)
    if interleave:
        assert depth == 2 and values == 2
        for i in range(2):
            scope.body[:0] = ast.parse(f"""
pair_scores{i} = T.alloc_fragment([G, BS], T.float32)
T.annotate_layout({{pair_scores{i}: qk.make_mma_store_layout(pair_scores{i})}})
""").body
        # Restrict the fast path to complete valid blocks. Remaining rows use
        # exactly the original masks and per-block algorithm.
        condition = " and ".join(f"i_s{i} >= 0 and i_s{i} + BS <= seq_len and (not is_causal or i_s{i} + BS <= i_t + 1)" for i in range(2))
        fast = ast.parse("T.clear(pair_scores0)\nT.clear(pair_scores1)").body
        loop = ast.parse("for ki in T.serial(qk_steps):\n    pass").body[0]
        loop.body = []
        for i in range(2):
            body = computes[i].body
            assert len(body) == 6 and "qk.mma" in ast.unparse(body[1])
            loop.body += [rename(n, "acc_s", f"pair_scores{i}") for n in body[1].body]
        fast.append(loop)
        for i in range(2):
            body = computes[i].body
            exp = body[2]
            assert isinstance(exp, ast.If) and ast.unparse(exp.test) == "scale_log2 > 0"
            fast += [rename(n, "acc_s", f"pair_scores{i}") for n in exp.body]
            fast += [rename(n, "acc_s", f"pair_scores{i}") for n in body[3:]]
        selected = ast.If(test=ast.parse(condition, mode="eval").body,
                          body=fast, orelse=copy.deepcopy(computes[:2]))
        first = outer.body.index(computes[0])
        outer.body[first:] = [selected] + computes[2:]
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    settings = [(4, 0, False, False), (2, 0, False, False),
                (2, 2, False, False), (2, 2, True, False), (2, 2, True, True)]
    for depth, values, interleave, dual in settings:
        result = source
        additions = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in NAMES:
                continue
            additions.append(transform(fn, depth, values, interleave, dual))
            marker = f"                    online_builder = {fn.name}\n"
            assert result.count(marker) == 1
            result = result.replace(marker, f"                    online_builder = {fn.name}_pair_schedule\n", 1)
        assert len(additions) == 2
        at = result.index("def _get_kernel(")
        result = result[:at] + "\n\n".join(additions) + "\n\n" + result[at:]
        ast.parse(result)
        path = HERE / f"s8_k{depth}_v{values}_i{int(interleave)}_a{int(dual)}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            key_depth=depth, value_depth=values, interleave=interleave, dual_acc=dual))
    (HERE / "s8_pairs_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        note="Single output accumulator changes only the FP32 association of partial PV results; reference checks required"), indent=2) + "\n")
    print("Generated", len(records), "paired S8 schedules", flush=True)


if __name__ == "__main__":
    main()
