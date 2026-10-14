"""Reuse one wave and its fragments for independent queries in a serial loop."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {"_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
           "native_sparse_attention_single_packed_qo_v2_mathcast"}


def main():
    source = BASE.read_text()
    reports = []
    for count, order in ((2, "adjacent"), (4, "adjacent"), (2, "strided"), (4, "strided")):
        lines = source.splitlines(keepends=True)
        edits = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            end = fn.end_lineno
            prim = next(n for n in fn.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
            launch = prim.body[0]
            assert isinstance(launch, ast.With)
            context = launch.items[0]
            assert ast.unparse(context.context_expr.args[0]) == "seq_len"
            token = context.optional_vars.elts[0].id
            context.context_expr.args[0] = ast.parse(f"T.ceildiv(seq_len, {count})", mode="eval").body
            context.optional_vars.elts[0].id = "query_cta"
            expression = (f"query_cta * {count} + query_step" if order == "adjacent" else
                          f"query_cta + query_step * T.ceildiv(seq_len, {count})")
            assignment = ast.parse(f"{token} = {expression}").body[0]
            # O's shared reads must finish before any shared storage is reused
            # for the next query, even when its sparse block is invalid.
            body = copy.deepcopy(launch.body) + ast.parse("T.sync_warp()").body
            guarded = ast.If(test=ast.parse(f"{token} < seq_len", mode="eval").body, body=body, orelse=[])
            launch.body = [ast.For(target=ast.Name(id="query_step", ctx=ast.Store()),
                iter=ast.parse(f"T.serial({count})", mode="eval").body,
                body=[assignment, guarded], orelse=[])]
            ast.fix_missing_locations(fn)
            edits.append((start, end, ast.unparse(fn) + "\n"))
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"serial_query_{count}_{order}.py"
        with path.open("x") as f:
            f.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            queries_per_cta=count, order=order))
        print(path.name)
    (HERE / "serial_query_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=reports, additional_sync="Wave WAR fence after every output read from shared",
        arithmetic_unchanged=True, queries_independent=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
