"""Collapse valid-block predicates while retaining signed address variables."""
import ast
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
OLD = HERE.parent / "20261008_resume8871"
BASE = OLD / "candidate_v6.py"
spec = importlib.util.spec_from_file_location("nsa_raw_guard_generator", OLD / "make_s8_raw_index_probes.py")
raw = importlib.util.module_from_spec(spec)
spec.loader.exec_module(raw)
S8 = raw.TARGETS
SINGLE = {"native_sparse_attention_q_preload", "native_sparse_attention_direct_kv",
          "_coalesced_block_loads_prim_oct8", "_coalesced_block_loads_prim_mathcast"}


def index(node):
    return isinstance(node, ast.Name) and (node.id in ("block", "_selected_block") or re.fullmatch(r"i_s[0-3]?", node.id))


def expression(text):
    return ast.parse(text, mode="eval").body


class Guards(ast.NodeTransformer):
    def __init__(self, scoped):
        self.scoped = scoped
        self.count = 0

    def visit_If(self, node):
        self.generic_visit(node)
        test = node.test
        if not isinstance(test, ast.BoolOp) or not isinstance(test.op, ast.And):
            return node
        values = test.values
        lows = [(i, x) for i, x in enumerate(values) if isinstance(x, ast.Compare)
                and index(x.left) and len(x.ops) == 1 and isinstance(x.ops[0], ast.GtE)
                and ast.unparse(x.comparators[0]) == "0"]
        if len(lows) != 1:
            return node
        low_idx, low = lows[0]
        name = ast.unparse(low.left)
        highs = [(i, x) for i, x in enumerate(values) if isinstance(x, ast.Compare)
                 and ast.unparse(x.left) == name and len(x.ops) == 1 and isinstance(x.ops[0], ast.Lt)]
        causals = [(i, x) for i, x in enumerate(values) if isinstance(x, ast.BoolOp)
                   and isinstance(x.op, ast.Or) and len(x.values) == 2
                   and ast.unparse(x.values[0]) == "not is_causal"
                   and isinstance(x.values[1], ast.Compare) and ast.unparse(x.values[1].left) == name
                   and isinstance(x.values[1].ops[0], ast.LtE)]
        assert len(highs) == len(causals) == 1, (name, ast.unparse(test))
        high_idx, high = highs[0]
        causal_idx, causal = causals[0]
        upper = ast.unparse(high.comparators[0])
        causal_upper = ast.unparse(causal.values[1].comparators[0])
        assert causal_upper in ("token // BS", "i_t // BS")
        limit = f"T.if_then_else(is_causal, {causal_upper} + 1, {upper})"
        guard = expression(f"T.cast({name}, T.uint32) < T.cast({limit}, T.uint32)")
        new_values = [x for i, x in enumerate(values) if i not in (low_idx, high_idx, causal_idx)]
        new_values.append(guard)
        node.test = ast.BoolOp(op=ast.And(), values=new_values) if len(new_values) > 1 else new_values[0]
        if self.scoped:
            proven = ast.BoolOp(op=ast.And(), values=[low, high, causal])
            node.body.insert(0, ast.Expr(value=ast.Call(func=ast.Attribute(value=ast.Name(id="T", ctx=ast.Load()),
                attr="assume", ctx=ast.Load()), args=[proven], keywords=[])))
        self.count += 1
        return node


def proof():
    import z3
    block, nb, token_block = z3.Ints("block nb token_block")
    result = []
    for causal in (False, True):
        unsigned = z3.If(block < 0, block + 2**32, block)
        original = z3.And(block >= 0, block < nb, block <= token_block if causal else True)
        rewritten = unsigned < (token_block + 1 if causal else nb)
        solver = z3.Solver()
        solver.add(block >= -2**31, block < 2**31, nb > 0, nb < 2**31,
                   token_block >= 0, token_block < nb, original != rewritten)
        status = solver.check()
        assert status == z3.unsat, status
        result.append(dict(causal=causal, inequivalence=str(status),
                           domain="all int32 indices; 0 < NB < 2^31; 0 <= token//BS < NB"))
    return result


def main():
    proofs = proof()
    source = BASE.read_text()
    records = []
    for scoped in (False, True):
        lines = source.splitlines(keepends=True)
        edits, counts = [], {}
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in S8 | SINGLE:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            end = fn.end_lineno
            transformed = copy.deepcopy(fn)
            if fn.name in S8:
                transformed = raw.RawBlock(unsigned=False).visit(transformed)
            rewrite = Guards(scoped)
            transformed = rewrite.visit(transformed)
            assert rewrite.count > 0, fn.name
            ast.fix_missing_locations(transformed)
            edits.append((start, end, ast.unparse(transformed) + "\n"))
            counts[fn.name] = rewrite.count
        for start, end, replacement in reversed(edits):
            lines[start:end] = [replacement]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"unsigned_guard_{'scoped' if scoped else 'plain'}.py"
        with path.open("x") as handle:
            handle.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(),
                            changed_conditions=counts, scoped_proven_assumptions=scoped))
    (HERE / "unsigned_guard_manifest.json").write_text(json.dumps(dict(base=str(BASE),
        base_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        proof=proofs, status="research; all safety passes retained; GPU validation pending"), indent=2) + "\n")


if __name__ == "__main__":
    main()
