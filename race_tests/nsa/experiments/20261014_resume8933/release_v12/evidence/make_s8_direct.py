"""Keep S8 register lookahead while loading current K/V without a pack launch."""
import ast
import copy
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
NAMES = (
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
)


def nodes(source):
    return ast.parse(source).body


class Loads(ast.NodeTransformer):
    def __init__(self, shared_v, swizzle):
        self.shared_v = shared_v
        self.swizzle = swizzle

    def visit_Subscript(self, node):
        if not isinstance(node.ctx, ast.Load) or not isinstance(node.value, ast.Name) or node.value.id not in ("K", "V"):
            return self.generic_visit(node)
        assert isinstance(node.slice, ast.Tuple)
        values = node.slice.elts
        start = ast.unparse(values[1])
        assert re.fullmatch(r"i_s[0-3]? // BS", start), start
        start = start.split(" //")[0]
        tensor = node.value.id
        return ast.parse(f'T.if_then_else({start} + j < seq_len, {tensor}[i_b, {start} + j, i_h, d], T.float16(0.0))', mode="eval").body

    def visit_For(self, node):
        text = ast.unparse(node)
        if not self.shared_v or not text.startswith("for j, d in T.Parallel(BS, BV):") or "V_reg[j, d] = V[" not in text:
            return self.generic_visit(node)
        assignment = node.body[0]
        assert isinstance(assignment, ast.Assign) and isinstance(assignment.value, ast.Subscript)
        start = ast.unparse(assignment.value.slice.elts[1]).split(" //")[0]
        return nodes(f'''
T.copy(V[i_b, {start}:{start} + BS, i_h, :], V_linear)
T.sync_warp()
T.copy(V_linear, V_shared_direct)
T.sync_warp()
T.copy(V_shared_direct, V_reg)
''')


def builder(fn, shared_v, swizzle):
    fn = copy.deepcopy(fn)
    fn.name += "_direct_v12"
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    for arg in kernel.args.args:
        if arg.arg in ("K", "V"):
            assert isinstance(arg.annotation, ast.Call)
            arg.annotation.args[0] = ast.Name(id="kv_shape", ctx=ast.Load())
    fn = Loads(shared_v, swizzle).visit(fn)
    if shared_v:
        kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
        scope = next(n for n in kernel.body if isinstance(n, ast.With))
        declaration = '''
V_linear = T.alloc_fragment([BS, BV], T.float16)
V_shared_direct = T.alloc_shared([BS, BV], T.float16)
T.annotate_layout({V_linear: T.Fragment([BS, BV],
    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8)})
'''
        if swizzle:
            declaration += 'T.annotate_layout({V_shared_direct: tilelang.maca.intrinsics.make_mma_swizzle_layout(V_shared_direct, vecSize=4)})\n'
        else:
            declaration += 'T.annotate_layout({V_shared_direct: T.Layout([BS, BV], lambda j, d: j * BV + d)})\n'
        scope.body[:0] = nodes(declaration)
    return ast.unparse(ast.fix_missing_locations(fn))


def dispatch(fn, depth):
    fn = copy.deepcopy(fn)
    block = next(n for n in ast.walk(fn) if isinstance(n, ast.If)
                 and ast.unparse(n.test) == "S >= 8 and use_emitter_online")
    for node in ast.walk(block):
        if isinstance(node, ast.Assign) and len(node.targets) == 1 and ast.unparse(node.targets[0]) == "online_builder":
            if isinstance(node.value, ast.Name) and node.value.id in NAMES:
                node.value.id += "_direct_v12"
        if isinstance(node, ast.Call) and isinstance(node.func, ast.Name) and node.func.id == "online_builder":
            for keyword in node.keywords:
                if keyword.arg == "prefetch_depth":
                    keyword.value = ast.parse(f"{depth} if mathcast_s8 else prefetch_depth", mode="eval").body
    assert ast.unparse(block.body[-2]).startswith("pack = native_sparse_attention_pack_kv(")
    assert ast.unparse(block.body[-1]).startswith("kernel = _make_packed_attention(")
    wrapper = nodes("if mathcast_s8:\n    kernel = attention\nelse:\n    pass")[0]
    wrapper.orelse = block.body[-2:]
    block.body[-2:] = [wrapper]
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name:n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for shared_v, swizzle, depth in ((False,False,4),(True,True,4),(True,True,2),(True,False,4)):
        result = source
        additions = "\n\n".join(builder(functions[name], shared_v, swizzle) for name in NAMES)
        old_dispatch = ast.get_source_segment(source, functions["_get_kernel"])
        result = result.replace(old_dispatch, additions + "\n\n" + dispatch(functions["_get_kernel"], depth), 1)
        ast.parse(result)
        path = HERE / f"s8_direct_v{int(shared_v)}_s{int(swizzle)}_p{depth}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            shared_v=shared_v, swizzle=swizzle, prefetch_depth=depth))
    (HERE / "s8_direct_manifest.json").write_text(json.dumps(dict(
        parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        scope="Existing default mathcast_s8 paths", launches=1,
        arithmetic="Original per-block arithmetic and accumulator association",
        safety="Raw K/V tails zero-filled; V shared reuse has both RAW and WAR wave fences"), indent=2) + "\n")
    print("Generated",len(records),"S8 direct K/V variants")


if __name__ == "__main__":
    main()
