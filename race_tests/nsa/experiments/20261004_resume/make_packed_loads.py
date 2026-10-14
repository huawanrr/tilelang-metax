"""Change packed operand load width without changing data layout or arithmetic."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"
NAMES = (
    "native_sparse_attention_single_packed_qo_v2",
    "native_sparse_attention_online_packed_batch_minor_o_v2",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2",
)


class Coordinates(ast.NodeTransformer):
    def __init__(self, replacements):
        self.replacements = replacements

    def visit_Name(self, node):
        if isinstance(node.ctx, ast.Load) and node.id in self.replacements:
            return ast.parse(self.replacements[node.id], mode="eval").body
        return node


def transform(source, name, k_width, v_width):
    lines = source.splitlines(keepends=True)
    function = next(n for n in ast.parse(source).body
                    if isinstance(n, ast.FunctionDef) and n.name == name)
    start = min([function.lineno] + [d.lineno for d in function.decorator_list]) - 1
    fn = "".join(lines[start:function.end_lineno])
    tree = ast.parse(fn)
    edits = []
    counts = {"K": 0, "V": 0}
    for loop in ast.walk(tree):
        if not (isinstance(loop, ast.For) and isinstance(loop.iter, ast.Call)
                and isinstance(loop.iter.func, ast.Attribute)
                and loop.iter.func.attr == "Parallel" and len(loop.body) == 1
                and isinstance(loop.body[0], ast.Assign)):
            continue
        assignment = loop.body[0]
        if not (isinstance(assignment.value, ast.Subscript)
                and isinstance(assignment.value.value, ast.Name)
                and assignment.value.value.id in counts):
            continue
        operand = assignment.value.value.id
        width = k_width if operand == "K" else v_width
        if width is None:
            continue
        assert ast.unparse(loop.target) == "(j, d)"
        dimension = ast.unparse(loop.iter.args[1])
        e = f"(packed_word * {width} + packed_element)"
        if operand == "K":
            row = "(packed_slot % (BS // 16) * 16 + packed_tid % 16)"
            col = f"(packed_slot // (BS // 16) * 32 + packed_tid // 16 * 8 + {e})"
        else:
            row = f"(packed_slot // ({dimension} // 32) * 16 + packed_tid // 16 * 4 + {e} % 4)"
            col = f"(packed_slot % ({dimension} // 32) * 32 + packed_tid % 16 + {e} // 4 * 16)"
        replacement = Coordinates({"j": row, "d": col}).visit(copy.deepcopy(assignment))
        pad = " " * loop.col_offset
        code = (
            f"{pad}for packed_slot in T.unroll(BS * {dimension} // 512):\n"
            f"{pad}    for packed_word in T.unroll(8 // {width}):\n"
            f"{pad}        for packed_element in T.vectorized({width}):\n"
            f"{pad}            {ast.unparse(replacement)}\n"
        )
        edits.append((loop.lineno - 1, loop.end_lineno, code))
        counts[operand] += 1
    fn_lines = fn.splitlines(keepends=True)
    for begin, end, code in sorted(edits, reverse=True):
        fn_lines[begin:end] = [code]
    fn = "".join(fn_lines)
    tree = ast.parse(fn)
    kernel = next(n for n in ast.walk(tree)
                  if isinstance(n, ast.FunctionDef) and n.name == "kernel")
    scope = kernel.body[0]
    assert isinstance(scope, ast.With)
    first = scope.body[0]
    fn_lines = fn.splitlines(keepends=True)
    fn_lines.insert(first.lineno - 1, " " * first.col_offset + "packed_tid = T.get_thread_binding()\n")
    fn = "".join(fn_lines)
    ast.parse(fn)
    expected = {"K": 1, "V": 2} if name == NAMES[0] else {"K": 5, "V": 5}
    assert counts == {key: value if (k_width if key == "K" else v_width) else 0
                      for key, value in expected.items()}, counts
    return "".join(lines[:start]) + fn + "".join(lines[function.end_lineno:])


def prove_layouts():
    checked = []
    for bs in (16, 32):
        for dim in (32, 64, 128):
            for width in (2, 4, 8):
                for operand in ("K", "V"):
                    seen = set()
                    for tid in range(64):
                        for slot in range(bs * dim // 512):
                            for word in range(8 // width):
                                for element in range(width):
                                    e = word * width + element
                                    if operand == "K":
                                        j = slot % (bs // 16) * 16 + tid % 16
                                        d = slot // (bs // 16) * 32 + tid // 16 * 8 + e
                                        packed = (d // 32, j // 16, d % 32 // 8 * 16 + j % 16, d % 8)
                                        wanted = (slot // (bs // 16), slot % (bs // 16), tid, e)
                                    else:
                                        j = slot // (dim // 32) * 16 + tid // 16 * 4 + e % 4
                                        d = slot % (dim // 32) * 32 + tid % 16 + e // 4 * 16
                                        packed = (j // 16, d // 32, j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4)
                                        wanted = (slot // (dim // 32), slot % (dim // 32), tid, e)
                                    assert 0 <= j < bs and 0 <= d < dim
                                    assert packed == wanted and (j, d) not in seen
                                    seen.add((j, d))
                    assert len(seen) == bs * dim
                    checked.append(dict(bs=bs, dim=dim, width=width, operand=operand, elements=len(seen)))
    return checked


def main():
    source = BASE.read_text()
    originals = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for name, kw, vw in (("packed_k2", 2, None), ("packed_v2", None, 2),
                         ("packed_kv2", 2, 2), ("packed_kv4", 4, 4), ("packed_kv8", 8, 8)):
        result = source
        for function in NAMES:
            result = transform(result, function, kw, vw)
        current = {n.name: ast.dump(n) for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert all(originals[n] == current[n] for n in originals if n not in NAMES)
        path = HERE / (name + ".py")
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path.relative_to(ROOT)), k_width=kw, v_width=vw,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    report = dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
                  variants=records, layout_proof=prove_layouts(), changed_functions=NAMES,
                  unchanged_arithmetic=True, unchanged_synchronization=True,
                  unchanged_pack_kernel=True, unchanged_dispatch=True)
    with (HERE / "packed_loads_assembly.json").open("x") as f:
        f.write(json.dumps(report, indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
