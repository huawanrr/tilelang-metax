"""Isolate packed S1 changes and use an explicit joint-KV tensor layout."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_single_guard import transform as merge_guard

HERE = Path(__file__).resolve().parent
ATTENTION = "native_sparse_attention_single_packed_qo_v2_mathcast"
PACKERS = {
    "native_sparse_attention_pack_kv_bs32_tiles",
    "native_sparse_attention_pack_kv_bs32_direct",
    "native_sparse_attention_pack_kv_bs32_shared",
}


def expr(text):
    return ast.parse(text, mode="eval").body


class JointAccess(ast.NodeTransformer):
    def __init__(self, names):
        self.names = names
        self.count = [0, 0]

    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        if not isinstance(node.value, ast.Name) or node.value.id not in self.names:
            return node
        plane = self.names[node.value.id]
        assert len(node.slice.elts) == 7
        b, nb, h, x, y, lane, element = node.slice.elts
        merged = ast.BinOp(left=ast.BinOp(left=x, op=ast.Mult(),
            right=expr("BS // 16" if plane == 0 else "D // 32")), op=ast.Add(), right=y)
        node.value = ast.Name(id="PackedKV", ctx=ast.Load())
        node.slice = ast.Tuple(elts=[b, nb, h, ast.Constant(plane), merged, lane, element], ctx=ast.Load())
        self.count[plane] += 1
        return node


def joint(fn, is_pack):
    fn = copy.deepcopy(fn)
    fn.name += "_block_joint"
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    args = kernel.args.args
    names = {"K": 0, "V": 1}
    if is_pack:
        outputs = [a.arg for a in args if a.arg not in ("K", "V")]
        assert len(outputs) == 2
        names = dict(zip(outputs, (0, 1)))
    selected = [i for i, a in enumerate(args) if a.arg in names]
    assert len(selected) == 2 and selected[1] == selected[0] + 1
    new_arg = ast.arg(arg="PackedKV", annotation=expr(
        "T.Tensor([batch, NB, H, 2, (D // 32) * (BS // 16), 64, 8], T.float16)"))
    kernel.args.args = args[:selected[0]] + [new_arg] + args[selected[1] + 1:]
    at = fn.body.index(kernel)
    fn.body[at:at] = ast.parse("D = dim\nBS = block_size\nH = " +
        ("heads" if is_pack else "heads // groups") + "\nNB = T.ceildiv(seq_len, BS)\n").body
    transform = JointAccess(names)
    kernel.body = [transform.visit(n) for n in kernel.body]
    assert all(transform.count), (fn.name, transform.count)
    return ast.unparse(ast.fix_missing_locations(fn))


def mma_sum(fn):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    at = fn.body.index(kernel)
    fn.body[at:at] = ast.parse('''
packed_sum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32",
    a_transposed=False, b_transposed=False, block_row_warps=1, block_col_warps=1,
    warp_row_tiles=16, warp_col_tiles=16, chunk=4, k_pack=1)
''').body
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body[:0] = ast.parse('''
packed_sum_one = T.alloc_local([1], T.float32)
packed_sum_out = T.alloc_fragment([G, 16], T.float32)
packed_lane_sum = T.alloc_fragment([G, 4], T.float32)
T.annotate_layout({packed_sum_out: packed_sum.make_mma_store_layout(packed_sum_out),
    packed_lane_sum: T.Fragment([G, 4], forward_thread_fn=lambda si, sj: si + sj * 16,
        forward_index_fn=lambda si, sj: 0)})
T.fill(packed_sum_one, 1.0)
''').body
    guard = next(n for n in scope.body if isinstance(n, ast.If) and ast.unparse(n.test) == "valid")
    norm = next(n for n in guard.body if isinstance(n, ast.If) and ast.unparse(n.test) == "not late")
    norm.body = ast.parse('''
for i, lane in T.Parallel(G, 4):
    packed_lane_sum[i, lane] = 0.0
    for chunk in T.unroll(BS // 16):
        for j in T.unroll(4):
            packed_lane_sum[i, lane] += scores[i, chunk * 16 + lane * 4 + j]
T.clear(packed_sum_out)
packed_sum.mma(packed_lane_sum, packed_sum_one, packed_sum_out, 0)
for i, lane in T.Parallel(G, 4):
    packed_lane_sum[i, lane] = T.if_then_else(packed_sum_out[i, lane * 4] > 0,
        1.0 / packed_sum_out[i, lane * 4], 0.0)
for i, j in T.Parallel(G, BS):
    scores[i, j] *= packed_lane_sum[i, j % 16 // 4]
''').body
    return fn


def main():
    source = (HERE / "baseline.py").read_text()
    nodes = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for use_joint, guard, mma in ((False, True, False), (True, False, False),
                                  (True, True, False), (False, False, True),
                                  (True, True, True)):
        function = copy.deepcopy(nodes[ATTENTION])
        if mma:
            function = mma_sum(function)
        decorators = function.decorator_list
        if guard:
            function = ast.parse(merge_guard(function, False)).body[0]
            function.decorator_list = decorators
        additions = []
        revised = source
        if use_joint:
            additions = [joint(function, False)]
            additions.extend(joint(nodes[name], True) for name in sorted(PACKERS))
            additions.append('''def _make_block_joint_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    shape = (batch, (seq_len + block_size - 1) // block_size, heads, 2,
             (dim // 32) * (block_size // 16), 64, 8)
    def run(Q, K, V, BlockIndices, Output):
        packed = torch.empty(shape, dtype=Q.dtype, device=Q.device)
        pack(K, V, packed)
        attention(Q, packed, BlockIndices, Output)
    return run
''')
            old = ast.get_source_segment(source, nodes["_get_kernel"])
            dispatch = copy.deepcopy(nodes["_get_kernel"])
            branch = next(n for n in ast.walk(dispatch) if isinstance(n, ast.If)
                          and ast.unparse(n.test) == "packed_qo")
            class Rename(ast.NodeTransformer):
                def visit_Name(self, n):
                    if n.id == ATTENTION:
                        return ast.copy_location(ast.Name(id=n.id + "_block_joint", ctx=n.ctx), n)
                    if n.id in PACKERS:
                        return ast.copy_location(ast.IfExp(test=expr("mathcast_single"),
                            body=ast.Name(id=n.id + "_block_joint", ctx=ast.Load()), orelse=n), n)
                    if n.id == "_make_packed_attention":
                        return ast.copy_location(ast.IfExp(test=expr("mathcast_single"),
                            body=expr("_make_block_joint_attention"), orelse=n), n)
                    return n
            branch.body = [Rename().visit(n) for n in branch.body]
            revised = revised.replace(old, "\n\n".join(additions) + "\n\n" +
                                      ast.unparse(ast.fix_missing_locations(dispatch)), 1)
        else:
            # Keep the existing decorator text once when replacing the function.
            function.decorator_list = []
            revised = revised.replace(ast.get_source_segment(source, nodes[ATTENTION]),
                ast.unparse(ast.fix_missing_locations(function)), 1)
        ast.parse(revised)
        name = f"bs32_j{int(use_joint)}_g{int(guard)}_m{int(mma)}.py"
        with (HERE / name).open("x") as out:
            out.write(revised)
        records.append(dict(path=name, joint=use_joint, guard=guard, mma=mma,
            sha256=hashlib.sha256(revised.encode()).hexdigest()))
    with (HERE / "bs32_focus_manifest.json").open("x") as out:
        json.dump(dict(baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
            scope="Existing default packed S1 path only; explicit parameters and all S4/S8 ABIs retained",
            joint_layout="[B, NB, H, K-or-V, merged-MMA-tile, lane, element]; no input cache"), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "BS32 probes", flush=True)


if __name__ == "__main__":
    main()
