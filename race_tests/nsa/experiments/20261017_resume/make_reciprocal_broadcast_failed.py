"""Compute each head's unchanged reciprocal on one lane, then broadcast it."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
DIRECT = (
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_single_packed_qo_v2_mathcast",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
)
HELPERS = (
    ("_coalesced_block_loads_prim_fp32_sum", "native_sparse_attention_coalesced_blocks_fp32_sum"),
    ("_coalesced_block_loads_prim_boundary_v8", "native_sparse_attention_coalesced_blocks_boundary_v8"),
)


def nodes(source):
    return ast.parse(source).body


def expr(source):
    return ast.parse(source, mode="eval").body


def transform(original, mode):
    fn = copy.deepcopy(original)
    fn.name += "_reciprocal_broadcast"
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body[:0] = nodes("reciprocal_owner_value = T.alloc_local([1], T.float32)")
    count = 0
    owner = "T.get_thread_binding() < 16" if mode == "contiguous" else "T.get_thread_binding() // 16 == T.get_thread_binding() % 4"
    source_lane = "T.get_thread_binding() % 16" if mode == "contiguous" else "T.get_thread_binding() % 16 + T.get_thread_binding() % 4 * 16"

    class Index(ast.NodeTransformer):
        def visit_Name(self, node):
            if node.id == "i":
                return expr("T.get_thread_binding() % 16")
            if node.id == "lane":
                return expr("T.get_thread_binding() // 16")
            return node

    class Change(ast.NodeTransformer):
        def visit_For(self, node):
            nonlocal count
            node = self.generic_visit(node)
            if (ast.unparse(node.iter) not in ("T.Parallel(G)", "T.Parallel(G, 4)") or
                    len(node.body) != 1 or not isinstance(node.body[0], ast.Assign)):
                return node
            assignment = node.body[0]
            destination = ast.unparse(assignment.targets[0])
            if destination not in ("inv[i]", "inv_sum[i]", "scores_inv_sum[i]", "lane_sum[i, lane]"):
                return node
            if not any(isinstance(v, ast.BinOp) and isinstance(v.op, ast.Div) for v in ast.walk(assignment.value)):
                return node
            count += 1
            value = ast.unparse(Index().visit(copy.deepcopy(assignment.value)))
            prelude = nodes(f'''
reciprocal_owner_value[0] = 0.0
if {owner}:
    reciprocal_owner_value[0] = {value}
reciprocal_from_owner = T.shfl_sync(reciprocal_owner_value[0], {source_lane}, 64, 18446744073709551615)
''')
            assignment.value = ast.Name(id="reciprocal_from_owner", ctx=ast.Load())
            return prelude + [node]

        def visit_Call(self, node):
            node = self.generic_visit(node)
            if isinstance(node.func, ast.Name) and node.func.id in ("_emitters", "TensorCoreIntrinEmitter"):
                for i, a in enumerate(node.args):
                    if ast.unparse(a) in ("T.float16", "T.float32"):
                        node.args[i] = ast.Constant(ast.unparse(a).split(".")[1])
                for k in node.keywords:
                    if k.arg in ("a_dtype", "b_dtype", "accum_dtype") and ast.unparse(k.value) in ("T.float16", "T.float32"):
                        k.value = ast.Constant(ast.unparse(k.value).split(".")[1])
            return node
    fn = Change().visit(fn)
    assert count > 0, original.name
    return fn, count


def proof():
    for mode in ("contiguous", "spread"):
        owners = [tid for tid in range(64) if (tid < 16 if mode == "contiguous" else tid // 16 == tid % 4)]
        assert len(owners) == 16
        assert sorted(tid % 16 for tid in owners) == list(range(16))
        for tid in range(64):
            source = tid % 16 if mode == "contiguous" else tid % 16 + tid % 4 * 16
            assert source in owners and source % 16 == tid % 16
    return "Exactly one owner per head, all four consumer lanes receive that head's value"


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    selections = set(DIRECT) | {wrapper for _, wrapper in HELPERS}
    for mode in ("contiguous", "spread"):
        additions, changes = [], {}
        for name in (*DIRECT, *(helper for helper, _ in HELPERS)):
            fn, changes[name] = transform(functions[name], mode)
            additions.append(ast.unparse(ast.fix_missing_locations(fn)))
        for helper, wrapper in HELPERS:
            fn = copy.deepcopy(functions[wrapper])
            fn.name += "_reciprocal_broadcast"
            for n in ast.walk(fn):
                if isinstance(n, ast.Name) and n.id == helper:
                    n.id += "_reciprocal_broadcast"
            additions.append(ast.unparse(ast.fix_missing_locations(fn)))
        dispatch = copy.deepcopy(functions["_get_kernel"])
        position = next(i for i,n in enumerate(dispatch.body) if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "key")
        dispatch.body[position:position] = nodes("broadcast_reciprocal = mathcast_defaults and groups == 16 and grid >= 4096")
        key = next(n for n in dispatch.body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "key")
        key.value.elts.append(ast.Name(id="broadcast_reciprocal", ctx=ast.Load()))
        class Select(ast.NodeTransformer):
            def visit_Name(self, node):
                if node.id in selections and isinstance(node.ctx, ast.Load):
                    return ast.IfExp(test=ast.Name(id="broadcast_reciprocal", ctx=ast.Load()),
                        body=ast.Name(id=node.id+"_reciprocal_broadcast", ctx=ast.Load()), orelse=node)
                return node
        dispatch = Select().visit(dispatch)
        result = source.replace(ast.get_source_segment(source, functions["_get_kernel"]),
            "\n\n".join(additions) + "\n\n" + ast.unparse(ast.fix_missing_locations(dispatch)), 1)
        updated = {n.name:n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert all(ast.dump(fn) == ast.dump(updated[name]) for name,fn in functions.items() if name != "_get_kernel")
        dest = HERE / f"reciprocal_broadcast_{mode}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, mode=mode, transformed_loops=changes, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "reciprocal_broadcast_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
                       owner_proof=proof(), unchanged_reciprocal_formula=True,
                       unchanged_denominator_and_normalization=True,
                       original_builders_and_explicit_tuning_fallback=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "reciprocal broadcast probes")


if __name__ == "__main__":
    main()
