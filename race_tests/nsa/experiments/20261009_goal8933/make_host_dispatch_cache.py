"""Cache the compiled callable before recomputing the full host dispatch."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def transform(source):
    tree = ast.parse(source)
    fn = next(n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == "_get_kernel")
    args = [a.arg for a in fn.args.args]
    keys = ["'raw_arguments'"] + [
        "None if scale is None else float(scale)" if name == "scale" else
        "int(bool(is_causal))" if name == "is_causal" else name for name in args]
    prefix = ast.parse("""
# Only shape, scale and tuning arguments enter this cache. Its values are
# compiled callables; every invocation still reads the current Q/K/V/indices.
entry_key = (%s,)
entry_kernel = _KERNEL_CACHE.get(entry_key)
if entry_kernel is not None:
    return entry_kernel
""" % ", ".join(keys)).body
    has_doc = isinstance(fn.body[0], ast.Expr) and isinstance(fn.body[0].value, ast.Constant)
    fn.body[int(has_doc):int(has_doc)] = prefix
    assert isinstance(fn.body[-1], ast.Return) and ast.unparse(fn.body[-1].value) == "kernel"
    fn.body[-1:-1] = ast.parse("_KERNEL_CACHE[entry_key] = kernel").body
    ast.fix_missing_locations(fn)
    lines = source.splitlines(keepends=True)
    lines[fn.lineno-1:fn.end_lineno] = [ast.unparse(fn) + "\n"]
    result = "".join(lines)
    ast.parse(result)
    return result


def main():
    parent = HERE / "parent.py"
    result = transform(parent.read_text())
    path = HERE / "host_dispatch_cache.py"
    with path.open("x") as output:
        output.write(result)
    record = dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(),
                  parent_sha256=hashlib.sha256(parent.read_bytes()).hexdigest(),
                  purpose="Reduce repeated Python dispatch overhead; device kernels unchanged",
                  cached_values="Compiled callables only; no tensor inputs, outputs or tensor addresses")
    with (HERE / "host_dispatch_cache_manifest.json").open("x") as output:
        json.dump(record, output, indent=2)
        output.write("\n")
    print(json.dumps(record, indent=2))


if __name__ == "__main__":
    main()
