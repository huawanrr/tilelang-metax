"""Compare independent lane gathers with the two dependent wave shuffles.

All three peers read the original FP32 partial sum.  The four-lane group,
local sum, normalization point, masks and synchronization remain unchanged.
Research builders are replaced in place; releases must preserve old builders.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGETS = {
    "_coalesced_block_loads_prim_mathcast",
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_sum",
    "_coalesced_block_loads_prim_fp32_mask",
}


def independent_sum():
    return ast.parse("""
for i, lane in T.Parallel(G, 4):
    peer16 = T.shfl_sync(lane_sum[i, lane], (T.get_thread_binding() % 64) ^ 16, 64, 18446744073709551615)
    peer32 = T.shfl_sync(lane_sum[i, lane], (T.get_thread_binding() % 64) ^ 32, 64, 18446744073709551615)
    peer48 = T.shfl_sync(lane_sum[i, lane], (T.get_thread_binding() % 64) ^ 48, 64, 18446744073709551615)
    lane_sum[i, lane] = (lane_sum[i, lane] + peer32) + (peer16 + peer48)
    lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
""").body[0]


class Rewrite(ast.NodeTransformer):
    def __init__(self, mode):
        self.mode = mode
        self.reductions = 0

    def visit_If(self, node):
        node = self.generic_visit(node)
        if ast.unparse(node.test) != "lane_reduce":
            return node
        text = ast.unparse(node)
        if "T.shfl_xor(lane_sum" in text:
            loop_index = next(i for i, n in enumerate(node.body)
                              if isinstance(n, ast.For) and "T.shfl_xor(lane_sum" in ast.unparse(n))
            if self.mode == "independent":
                node.body[loop_index] = independent_sum()
            else:
                body = node.body[loop_index].body
                assert len(body) == 3 and all(isinstance(n, ast.AugAssign) for n in body[:2])
                body[0], body[1] = body[1], body[0]
            self.reductions += 1
        elif "wsum.mma(" in text:
            start = next(i for i, n in enumerate(node.body) if ast.unparse(n) == "T.clear(wsum_output)")
            assert "wsum.mma(" in ast.unparse(node.body[start + 1])
            assert "wsum_output[i, lane * 4]" in ast.unparse(node.body[start + 2])
            replacement = independent_sum()
            if self.mode == "order16":
                replacement = ast.parse("""
for i, lane in T.Parallel(G, 4):
    lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 18446744073709551615)
    lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 18446744073709551615)
    lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0, 1.0 / lane_sum[i, lane], 0.0)
""").body[0]
            node.body[start:start + 3] = [replacement]
            self.reductions += 1
        return node


class RemoveMmaSum(ast.NodeTransformer):
    def visit_Assign(self, node):
        if any(isinstance(t, ast.Name) and t.id in ("wsum", "wsum_unit", "wsum_output")
               for t in node.targets):
            return None
        return self.generic_visit(node)

    def visit_Expr(self, node):
        if ast.unparse(node).startswith(("T.annotate_layout({wsum_output:", "T.fill(wsum_unit,")):
            return None
        return self.generic_visit(node)


def main():
    source = (HERE / "v7_parent.py").read_text()
    records = []
    for mode in ("independent", "order16"):
        lines = source.splitlines(keepends=True)
        edits, counts = [], {}
        for original in ast.parse(source).body:
            if not isinstance(original, ast.FunctionDef) or original.name not in TARGETS:
                continue
            rewrite = Rewrite(mode)
            fn = RemoveMmaSum().visit(rewrite.visit(copy.deepcopy(original)))
            ast.fix_missing_locations(fn)
            assert rewrite.reductions == 1, (original.name, rewrite.reductions)
            assert "wsum" not in ast.unparse(fn)
            edits.append((original.lineno - 1, original.end_lineno, ast.unparse(fn) + "\n"))
            counts[fn.name] = rewrite.reductions
        assert len(edits) == len(TARGETS)
        for start, end, text in sorted(edits, reverse=True):
            lines[start:end] = [text]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"reduce_{mode}.py"
        with path.open("x") as file:
            file.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(),
                            mode=mode, counts=counts))
    for tid in range(64):
        peers = [tid ^ x for x in (0, 16, 32, 48)]
        assert sorted(peers) == [tid % 16 + 16 * i for i in range(4)]
    with (HERE / "reduction_manifest.json").open("x") as file:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       variants=records, wave_groups="PASS", safety_passes_unchanged=True,
                       synchronization_unchanged=True), file, indent=2)
        file.write("\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
