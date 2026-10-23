"""Test aligned integer views for synchronous packed K/V reads.

Every word is decoded back to its original half bits. The original guards and
per-call packing stay in place. A plain-load variant separates view/decode
effects from the read-only cache hint.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


class Words(ast.NodeTransformer):
    def __init__(self, names, bits, readonly):
        self.names = names
        self.bits = bits
        self.lanes = bits // 16
        self.readonly = readonly
        self.count = 0

    def visit_Subscript(self, node):
        if (isinstance(node.ctx, ast.Load) and isinstance(node.value, ast.Name)
                and node.value.id in self.names):
            assert isinstance(node.slice, ast.Tuple)
            indices = [ast.unparse(index) for index in node.slice.elts]
            last = indices[-1]
            indices[-1] = f"({last}) // {self.lanes}"
            load = f"{node.value.id}_word_view[{', '.join(indices)}]"
            if self.readonly:
                load = f"T.__ldg({load})"
            decoded = (f'T.reinterpret("float16", T.Cast("uint16", '
                       f'({load}) >> ((({last}) % {self.lanes}) * 16)))')
            self.count += 1
            return ast.copy_location(ast.parse(decoded, mode="eval").body, node)
        return self.generic_visit(node)


def change(fn, bits, readonly):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    arguments = {arg.arg: arg.annotation for arg in kernel.args.args}
    names = {"PackedKV"} if "PackedKV" in arguments else {"K", "V"}
    transform = Words(names, bits, readonly)
    fn = transform.visit(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    aliases = []
    for name in sorted(names):
        shape = copy.deepcopy(arguments[name].args[0])
        if isinstance(shape, ast.List):
            assert isinstance(shape.elts[-1], ast.Constant) and shape.elts[-1].value == 8
            shape.elts[-1] = ast.Constant(value=8 // (bits // 16))
            shape_text = ast.unparse(shape)
        else:
            assert isinstance(shape, ast.Name) and shape.id in {"packed_k_shape", "packed_shape"}
            shape_text = f"{shape.id}[:-1] + [{8 // (bits // 16)}]"
        aliases.extend(ast.parse(
            f'{name}_word_view = T.view({name}, {shape_text}, "uint{bits}")').body)
    scope.body[:0] = aliases
    fn.decorator_list = []
    return ast.unparse(ast.fix_missing_locations(fn)), transform.count


def main():
    source = (HERE / "baseline.py").read_text()
    functions = [fn for fn in ast.parse(source).body
                 if isinstance(fn, ast.FunctionDef) and fn.name in NAMES]
    assert len(functions) == len(NAMES)
    rows = []
    for bits, readonly in ((32, False), (32, True), (64, True)):
        result = source
        edits = {}
        for fn in functions:
            changed, count = change(fn, bits, readonly)
            original = ast.get_source_segment(source, fn)
            assert result.count(original) == 1
            result = result.replace(original, changed, 1)
            edits[fn.name] = count
        compile(result, "packed_word_loads", "exec")
        path = HERE / f"packed_words{bits}_{'cached' if readonly else 'plain'}.py"
        with path.open("x") as out:
            out.write(result)
        rows.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                         bits=bits, readonly=readonly, changed_loads=edits))
    with (HERE / "packed_word_loads_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       variants=rows, status="unvalidated probe"), out, indent=2)
        out.write("\n")
    print("Generated", len(rows), "packed word load probes")


if __name__ == "__main__":
    main()
