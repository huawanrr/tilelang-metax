"""Make checked packed-buffer offsets explicitly 32-bit below a byte bound.

The original checked tensor ABI and payload are unchanged. A rank-one view
is local to the PrimFunc; all original validity guards remain. The 64-bit
view variant controls for the equivalent indexing rewrite itself.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
JOINT = "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint"
S8 = ("native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
      "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast")
TARGETS = (JOINT, *S8)


def expr(value):
    return ast.parse(value, mode="eval").body


def transform(original, bits):
    fn = copy.deepcopy(original)
    fn.name += f"_offset{bits}"
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    shapes = {}
    if original.name == JOINT:
        shapes["PackedKV"] = ["batch", "NB", "H", "2", "(D // 32) * (BS // 16)", "64", "8"]
    else:
        shapes["K"] = ["batch", "T.ceildiv(seq_len, BS)", "head_kv", "BK // 32", "BS // 16", "64", "8"]
        shapes["V"] = ["batch", "T.ceildiv(seq_len, BS)", "head_kv", "BS // 16", "BK // 32", "64", "8"]
    counts = dict.fromkeys(shapes, 0)

    class Rewrite(ast.NodeTransformer):
        def visit_Subscript(self, node):
            node = self.generic_visit(node)
            if not isinstance(node.value, ast.Name) or node.value.id not in shapes:
                return node
            name = node.value.id
            shape = shapes[name]
            assert isinstance(node.slice, ast.Tuple) and len(node.slice.elts) == len(shape)
            offset = ast.unparse(node.slice.elts[0])
            for index, extent in zip(node.slice.elts[1:], shape[1:]):
                offset = f"(({offset}) * ({extent}) + ({ast.unparse(index)}))"
            node.value = ast.Name(id=name + "_flat_offsets", ctx=ast.Load())
            node.slice = expr(f"T.cast({offset}, 'int{bits}')")
            counts[name] += 1
            return node

    scope.body = [Rewrite().visit(n) for n in scope.body]
    views = []
    for name, shape in shapes.items():
        extent = " * ".join(f"({v})" for v in shape)
        views.extend(ast.parse(f"{name}_flat_offsets = T.reshape({name}, [{extent}])").body)
    scope.body[:0] = views
    assert all(counts.values())
    return ast.unparse(ast.fix_missing_locations(fn)), counts


def prove():
    for bs, dim, nb, heads, batch in ((32, 128, 32, 1, 8), (16, 64, 64, 2, 4), (16, 64, 17, 3, 2)):
        plane = bs * dim
        assert batch * nb * heads * 2 * plane * 2 < 2**31
        k = {((d//32*(bs//16)+j//16)*64+d%32//8*16+j%16)*8+d%8 for j in range(bs) for d in range(dim)}
        v = {((j//16*(dim//32)+d//32)*64+j%16//4*16+d%16)*8+d%32//16*4+j%4 for j in range(bs) for d in range(dim)}
        assert k == v == set(range(plane))
        for b in range(batch):
            for block in range(nb):
                for h in range(heads):
                    for which in (0, 1):
                        base = (((b*nb+block)*heads+h)*2+which)*plane
                        assert 0 <= base and base+plane <= batch*nb*heads*2*plane < 2**30
    return "Complete packed K/V lane coverage; nonnegative byte offsets below 2**31"


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for bits in (64, 32):
        additions, changes = [], {}
        for name in TARGETS:
            code, counts = transform(functions[name], bits)
            additions.append(code)
            changes[name] = counts
        dispatch = copy.deepcopy(functions["_get_kernel"])
        class Select(ast.NodeTransformer):
            def visit_Name(self, node):
                if node.id in TARGETS and isinstance(node.ctx, ast.Load):
                    # Derived entirely from existing shape/default flags, which
                    # already participate in the dispatch's cache key.
                    condition = "(mathcast_single or mathcast_s8) and B * H * ((seq_len + block_size - 1) // block_size) * block_size * D * 4 < 2147483648"
                    return ast.IfExp(test=expr(condition), body=ast.Name(id=node.id+f"_offset{bits}", ctx=ast.Load()), orelse=node)
                return node
        dispatch = Select().visit(dispatch)
        result = source.replace(ast.get_source_segment(source, functions["_get_kernel"]),
            "\n\n".join(additions) + "\n\n" + ast.unparse(ast.fix_missing_locations(dispatch)), 1)
        updated = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert all(ast.dump(fn) == ast.dump(updated[name]) for name, fn in functions.items() if name != "_get_kernel")
        path = HERE / f"packed_offsets{bits}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(file=path.name, bits=bits, sha256=hashlib.sha256(result.encode()).hexdigest(), loads=changes))
    with (HERE / "packed_offsets_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
                       proof=prove(), checked_tensor_abi_unchanged=True, input_and_index_guards_unchanged=True,
                       arithmetic_and_barriers_unchanged=True, pack_and_payload_unchanged=True,
                       fallback="Original builder for explicit tuning or packed allocation >= 2 GiB"), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "packed offset-width probes")


if __name__ == "__main__":
    main()
