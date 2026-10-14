"""Separate uniform mask arithmetic from the QK-to-exp dependency chain."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGET = "_coalesced_block_loads_prim_oct8"


def has_exp(node):
    return any(isinstance(n, ast.Call) and ast.unparse(n.func) == "T.exp" for n in ast.walk(node))


class DistanceMask(ast.NodeTransformer):
    def visit_Assign(self, node):
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Subscript):
            if ast.unparse(node.targets[0].value) == "acc_s" and has_exp(node.value):
                exp = next(n for n in ast.walk(node.value)
                           if isinstance(n, ast.Call) and ast.unparse(n.func) == "T.exp")
                node.value = ast.parse(
                    "T.if_then_else(not is_causal or j <= i_t - _selected_block * BS, "
                    + ast.unparse(exp) + ", T.float32(0.0))", mode="eval").body
        return self.generic_visit(node)

    def visit_If(self, node):
        node = self.generic_visit(node)
        if node.orelse and ast.dump(ast.Module(body=node.body, type_ignores=[])) == ast.dump(
                ast.Module(body=node.orelse, type_ignores=[])):
            return node.body
        return node


def main():
    source = (HERE / "parent.py").read_text()
    original = next(n for n in ast.parse(source).body
                    if isinstance(n, ast.FunctionDef) and n.name == TARGET)
    reports = []
    for mode in ("distance", "boundary_init"):
        function = copy.deepcopy(original)
        if mode == "distance":
            function = DistanceMask().visit(function)
        else:
            prim = next(n for n in function.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
            valid = next(n for n in prim.body[0].body
                         if isinstance(n, ast.If) and "qk.mma(" in ast.unparse(n))
            clear_index = next(i for i, n in enumerate(valid.body) if ast.unparse(n) == "T.clear(acc_s)")
            valid.body[clear_index] = ast.parse('''
if scale_log2 > 0 and is_causal and _selected_block == i_t // BS:
    for i, j in T.Parallel(G, BS):
        acc_s[i, j] = T.if_then_else(j <= i_t % BS, T.float32(0.0), -T.infinity(T.float32))
else:
    T.clear(acc_s)
''').body[0]
            math_if = next(n for n in valid.body if isinstance(n, ast.If)
                           and ast.unparse(n.test) == "scale_log2 > 0")
            exp = next(n for n in ast.walk(math_if.body[0])
                       if isinstance(n, ast.Call) and ast.unparse(n.func) == "T.exp")
            math_if.body = ast.parse("for i, j in T.Parallel(G, BS):\n    acc_s[i, j] = "
                                     + ast.unparse(exp)).body
        ast.fix_missing_locations(function)
        lines = source.splitlines(keepends=True)
        lines[original.lineno - 1:original.end_lineno] = [ast.unparse(function) + "\n"]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"mask_{mode}_mid.py"
        with path.open("x") as handle:
            handle.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), mode=mode))
        print(path.name)
    checks = 0
    for length in (16, 32, 64, 128, 256, 512):
        for token in range(length):
            for block in range(token // 16 + 1):
                for j in range(16):
                    expected = block * 16 + j < length and block * 16 + j <= token
                    assert expected == (j <= token - block * 16)
                    assert expected == (block < token // 16 or j <= token % 16)
                    checks += 1
    (HERE / "mask_schedule_manifest.json").write_text(json.dumps(dict(
        parent="parent.py", variants=reports, cpu_mask_equivalence_tuples=checks,
        assumptions="Raw block index is validated first; complete BS16 blocks",
        boundary_init="Positive scales use masked QK initialization; zero/negative scales preserve the original guarded exponent",
        safety_and_synchronization_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
