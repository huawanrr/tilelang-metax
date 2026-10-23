"""Hoist S8's per-block validity checks when all selected blocks are complete.

The fallback is the original computation. The fast branch is selected from
the current block indices, including causal and sequence-tail bounds.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PARENT = ROOT / "experiments/20261014_resume8933/release_v12/submission.py"
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def expr(s):
    return ast.parse(s, mode="eval").body


def complete(index):
    return f"({index} >= 0 and {index} + BS <= seq_len and (not is_causal or {index} + BS <= i_t + 1))"


class Complete(ast.NodeTransformer):
    def visit_If(self, node):
        test = ast.unparse(node.test)
        if test == "scale_log2 > 0":
            return [self.visit(n) for n in node.body]
        if test.startswith("is_causal and i_s") and "+ BS > i_t + 1" in test:
            return ast.parse("T.clear(acc_s)").body
        if isinstance(node.test, ast.BoolOp) and isinstance(node.test.op, ast.And):
            terms = node.test.values
            if any("i_s" in ast.unparse(v) for v in terms) and any(
                "i_s" in ast.unparse(v) and ">= 0" in ast.unparse(v) for v in terms
            ):
                kept = [v for v in terms if "i_s" not in ast.unparse(v)]
                node.test = ast.BoolOp(op=ast.And(), values=kept) if len(kept) > 1 else kept[0] if kept else ast.Constant(True)
        return self.generic_visit(node)


def transform(fn, mode, assume):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    algorithm = next(n for n in scope.body if isinstance(n, ast.If)
        and ast.unparse(n.test) == "prefetch_depth == 1")
    if mode == "all":
        fast = Complete().visit(copy.deepcopy(algorithm))
        condition = "S == 8 and " + " and ".join(complete(f"indices[{i}]") for i in range(8))
        assumptions = ast.parse("\n".join(f"T.assume({complete(f'indices[{i}]')})" for i in range(8))).body if assume else []
        replacement = ast.If(test=expr(condition), body=assumptions + [fast], orelse=[algorithm])
        scope.body[scope.body.index(algorithm)] = replacement
    else:
        loop = next(n for n in algorithm.orelse if isinstance(n, ast.For))
        assert ast.unparse(loop.target) == "group"
        start = 4
        assert all(isinstance(n, ast.Assign) for n in loop.body[:start])
        original = loop.body[start:]
        fast = [Complete().visit(copy.deepcopy(n)) for n in original]
        condition = "S == 8 and " + " and ".join(
            f"(prefetch_depth <= {i} or {complete(f'i_s{i}')})" for i in range(4))
        assumptions = []
        if assume:
            assumptions = ast.parse("\n".join(
                f"if prefetch_depth > {i}:\n    T.assume({complete(f'i_s{i}')})" for i in range(4))).body
        loop.body[start:] = [ast.If(test=expr(condition), body=assumptions + fast, orelse=original)]
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = PARENT.read_text()
    for name in ("baseline.py", "control.py"):
        path = HERE / name
        if not path.exists():
            shutil.copy2(PARENT, path)
        assert path.read_text() == source
    cases = json.loads((ROOT / "experiments/20261014_resume8933/v12_cases.json").read_text())
    for b,t,h,c in [(2,2048,1,True),(8,512,1,True),(2,1024,2,True),(4,2048,1,True),(1,2048,2,False),(4,1025,1,True)]:
        cases[f"s8_b{b}_t{t}_h{h}_c{int(c)}"] = dict(B=b, SEQ_LEN=t, H=h, HQ=h*16, D=64, S=8, block_size=16, is_causal=c)
    with (HERE / "cases.json").open("x") as f:
        json.dump(cases,f,indent=2)
        f.write("\n")
    records = []
    for mode,assume in (("all",False),("all",True),("groups",False),("groups",True)):
        result = source
        for fn in ast.parse(source).body:
            if isinstance(fn,ast.FunctionDef) and fn.name in NAMES:
                result = result.replace(ast.get_source_segment(source,fn),transform(fn,mode,assume),1)
        compile(result,"probe.py","exec")
        path = HERE / f"complete_{mode}_a{int(assume)}.py"
        with path.open("x") as f:
            f.write(result)
        records.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),mode=mode,assume=assume))
    with (HERE / "complete_manifest.json").open("x") as f:
        json.dump(dict(parent=str(PARENT),parent_sha256=hashlib.sha256(source.encode()).hexdigest(),variants=records,
            scope="Two S8 mathcast builders; original fallback for partial/invalid/causal blocks, original packing and output; no checker disabled"),f,indent=2)
        f.write("\n")
    print("Generated",len(records),"complete-block guard probes")


if __name__ == "__main__":
    main()
