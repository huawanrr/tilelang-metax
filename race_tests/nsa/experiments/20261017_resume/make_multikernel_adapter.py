"""Use one checked TileLang adapter for unchanged pack + attention launches.

Intermediate buffers remain per-call Torch allocations through out_idx. They
are explicit PrimFunc parameters, not T.alloc_global workspaces, so graph
storage ownership and stream-aware allocation follow the existing adapter.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
JOINT = "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint"
S8 = (
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
)


def expr(text):
    return ast.parse(text, mode="eval").body


def prefix_packer(pack, replacements):
    """Keep all pack expressions, changing only local names and KV head count."""
    local_names = {n.id for n in ast.walk(pack) if isinstance(n, ast.Name) and isinstance(n.ctx, ast.Store)}
    for n in ast.walk(pack):
        if isinstance(n, ast.Lambda):
            local_names.update(a.arg for a in n.args.args)
    mapping = {name: "pk_" + name for name in local_names}
    mapping.update(replacements)
    class Rewrite(ast.NodeTransformer):
        def visit_Name(self, n):
            if n.id == "heads":
                return ast.copy_location(expr("heads // groups"), n)
            if n.id in mapping:
                return ast.copy_location(ast.Name(id=mapping[n.id], ctx=n.ctx), n)
            return n
        def visit_arg(self, n):
            if n.arg in mapping:
                n.arg = mapping[n.arg]
            return n
    rewritten = Rewrite().visit(copy.deepcopy(pack))
    kernel = next(n for n in rewritten.body if isinstance(n, ast.FunctionDef))
    prelude = [n for n in rewritten.body if not isinstance(n, (ast.FunctionDef, ast.Return))]
    return prelude, kernel.body


def merged_builder(attention, pack, is_joint):
    fn = copy.deepcopy(attention)
    fn.name += "_one_adapter"
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    old_args = {n.arg: copy.deepcopy(n) for n in kernel.args.args}
    indices = "Indices" if is_joint else "BlockIndices"
    if is_joint:
        scratch = [old_args["PackedKV"]]
        pack_aliases = {}
    else:
        class RenameOperands(ast.NodeTransformer):
            def visit_Name(self, n):
                if n.id in ("K", "V"):
                    return ast.copy_location(ast.Name(id="Packed" + n.id, ctx=n.ctx), n)
                return n
        kernel.body = [RenameOperands().visit(n) for n in kernel.body]
        scratch = [old_args["K"], old_args["V"]]
        scratch[0].arg, scratch[1].arg = "PackedK", "PackedV"
        pack_aliases = {"Packed": "PackedV"}
    raw_args = [ast.arg(arg=name, annotation=expr(
        "T.Tensor([batch, seq_len, heads // groups, dim], T.float16)")) for name in ("K", "V")]
    kernel.args.args = [old_args["Q"], *raw_args, old_args[indices], old_args["Output"], *scratch]
    prelude, pack_body = prefix_packer(pack, pack_aliases)
    fn.body[fn.body.index(kernel):fn.body.index(kernel)] = prelude
    kernel.body = pack_body + kernel.body
    decorator = fn.decorator_list[0]
    assert isinstance(decorator, ast.Call)
    assert not any(k.arg == "out_idx" for k in decorator.keywords)
    decorator.keywords.append(ast.keyword(arg="out_idx", value=expr("[5]" if is_joint else "[5, 6]")))
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    funcs = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    additions = [merged_builder(funcs[JOINT], funcs["native_sparse_attention_pack_kv_bs32_tiles_block_joint"], True)]
    additions += [merged_builder(funcs[name], funcs["native_sparse_attention_pack_kv"], False) for name in S8]
    dispatch = copy.deepcopy(funcs["_get_kernel"])
    packed = next(n for n in ast.walk(dispatch) if isinstance(n, ast.If) and ast.unparse(n.test) == "packed_qo")
    old = copy.deepcopy(packed.body)
    packed.body = [ast.If(test=expr("mathcast_single and grid >= 4096 and tiled_pack"),
        body=ast.parse(f"kernel = {JOINT}_one_adapter(width=128, late=False, **common)").body, orelse=old)]
    online = next(n for n in ast.walk(dispatch) if isinstance(n, ast.If) and ast.unparse(n.test) == "S >= 8 and use_emitter_online")
    old = copy.deepcopy(online.body)
    online.body = [ast.If(test=expr("mathcast_s8"), body=ast.parse(f"""
online_builder = {S8[1]}_one_adapter if grid >= 8192 else {S8[0]}_one_adapter
kernel = online_builder(selected_blocks=S, online_unroll=online_unroll,
    dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)
""").body, orelse=old)]
    result = source.replace(ast.get_source_segment(source, funcs["_get_kernel"]),
        "\n\n".join(additions) + "\n\n" + ast.unparse(ast.fix_missing_locations(dispatch)), 1)
    ast.parse(result)
    path = HERE / "multikernel_adapter.py"
    with path.open("x") as out:
        out.write(result)
    (HERE / "multikernel_adapter_manifest.json").write_text(json.dumps(dict(
        parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
        path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
        method="Single checked TVM FFI adapter, unchanged two sequential device launches",
        scratch="Per-call adapter-created Torch tensors through out_idx; no tensor cache, no T.alloc_global workspace",
        scope="Existing default joint/tiled BS32 S1 and default large mathcast S8 only",
        requires_validation="Both interfaces, graph storage, input updates, explicit fallbacks, actual binary, public-call and graph timing"), indent=2) + "\n")
    print("Generated one checked-adapter probe for", len(additions), "builders")


if __name__ == "__main__":
    main()
