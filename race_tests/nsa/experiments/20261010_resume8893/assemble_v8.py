"""Append confirmed builders to the recovered v7 without changing old builders."""
import argparse
import ast
import copy
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def functions(source):
    return {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}


class Rename(ast.NodeTransformer):
    def __init__(self, names):
        self.names = names

    def visit_Name(self, node):
        node.id = self.names.get(node.id, node.id)
        return node

    def visit_FunctionDef(self, node):
        node.name = self.names.get(node.name, node.name)
        return self.generic_visit(node)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--name", required=True)
    parser.add_argument("--d128", choices=("same", "parent", "vec4", "exp_vec4"), default="same")
    parser.add_argument("--multihead-q4", action="store_true")
    parser.add_argument("--mid", choices=("none", "independent", "vec4"), default="none")
    args = parser.parse_args()
    assert args.name.replace("_", "").isalnum()
    parent = HERE / "v7_parent.py"
    baseline = HERE / "baseline.py"
    source = parent.read_text()
    old = functions(source)
    additions, origins = [], {}

    def add(path, original_name, new_name, mapping=None):
        fn = copy.deepcopy(functions(path.read_text())[original_name])
        fn = Rename({original_name: new_name, **(mapping or {})}).visit(fn)
        ast.fix_missing_locations(fn)
        additions.append(fn)
        origins[new_name] = dict(probe=str(path), probe_sha256=digest(path), function=original_name)

    def add_family(path, prim_name, tag):
        prim, builder = f"_coalesced_block_loads_prim_{tag}_v8", f"native_sparse_attention_coalesced_blocks_{tag}_v8"
        add(path, prim_name, prim)
        add(parent, "native_sparse_attention_coalesced_blocks_fp32_sum", builder,
            {"_coalesced_block_loads_prim_fp32_sum": prim})
        return builder

    large = add_family(HERE / "large_boundary_exp.py", "_coalesced_block_loads_prim_fp32_sum", "boundary")
    d128 = None
    if args.d128 == "parent":
        d128 = "native_sparse_attention_coalesced_blocks_fp32_sum"
    elif args.d128 != "same":
        probe = "loads_vec4.py" if args.d128 == "vec4" else "large_boundary_exp_vec4.py"
        d128 = add_family(HERE / probe, "_coalesced_block_loads_prim_fp32_sum", "d128_load")
    mid = None
    if args.mid != "none":
        probe = "reduce_independent.py" if args.mid == "independent" else "loads_vec4.py"
        mid = add_family(HERE / probe, "_coalesced_block_loads_prim_oct8", "mid")

    dispatch = copy.deepcopy(old["_get_kernel"])
    large_expr = ast.parse(f"{d128} if D == 128 else {large}" if d128 else large, mode="eval").body

    class Dispatch(ast.NodeTransformer):
        def visit_Name(self, node):
            if node.id == "native_sparse_attention_coalesced_blocks_fp32_sum":
                return copy.deepcopy(large_expr)
            return node

        def visit_Call(self, node):
            node = self.generic_visit(node)
            if (isinstance(node.func, ast.IfExp) and isinstance(node.func.test, ast.Name)
                    and node.func.test.id == "fp32_multih"):
                if mid:
                    node.func = ast.IfExp(ast.Name("mid_v8", ast.Load()), ast.Name(mid, ast.Load()), node.func)
                if args.multihead_q4:
                    kw = next(k for k in node.keywords if k.arg == "q_vec")
                    kw.value = ast.parse("4 if fp32_multih and not is_causal else 8", mode="eval").body
            return node

    dispatch = Dispatch().visit(dispatch)
    if mid:
        index = next(i for i, n in enumerate(dispatch.body) if isinstance(n, ast.Assign)
                     and any(isinstance(t, ast.Name) and t.id == "key" for t in n.targets))
        dispatch.body[index].value.elts.append(ast.Name("mid_v8", ast.Load()))
        dispatch.body[index:index] = ast.parse("mid_v8 = oct8_coalesced and H == 1 and is_causal").body
    ast.fix_missing_locations(dispatch)
    lines = source.splitlines(keepends=True)
    original = old["_get_kernel"]
    lines[original.lineno - 1:original.end_lineno] = ["\n\n".join(
        ast.unparse(fn) for fn in additions + [dispatch]) + "\n"]
    result = "".join(lines)
    new = functions(result)
    for name, fn in old.items():
        if name != "_get_kernel":
            assert ast.dump(fn) == ast.dump(new[name]), name
    original_v6 = functions(baseline.read_text())
    for name, fn in original_v6.items():
        if name != "_get_kernel":
            assert ast.dump(fn) == ast.dump(new[name]), name
    # The complete-argument callable cache is inherited unchanged from v7.
    assert [ast.dump(n) for n in old["_get_kernel"].body[:3]] == [ast.dump(n) for n in dispatch.body[:3]]
    assert sorted(set(new)-set(old)) == sorted(origins)
    dev = HERE / f"{args.name}.py"
    sub = HERE / f"{args.name}_submission.py"
    manifest_path = HERE / f"{args.name}_manifest.json"
    assert not dev.exists() and not sub.exists() and not manifest_path.exists()
    with dev.open("x") as file:
        file.write(result)
    subprocess.run([sys.executable, str(ROOT / "experiments/20261007_exp_math/make_submission.py"),
                    str(dev), str(sub)], check=True)
    manifest = dict(status="assembled; final submission validation required", command=sys.argv,
        official_baseline=str(baseline), official_baseline_sha256=digest(baseline), official_score=88.93,
        parent=str(parent), parent_sha256=digest(parent), development=str(dev), development_sha256=digest(dev),
        submission=str(sub), submission_sha256=digest(sub), appended_functions=origins,
        unchanged_parent_functions=[k for k in old if k != "_get_kernel"],
        unchanged_v6_functions=[k for k in original_v6 if k != "_get_kernel"],
        options=dict(d128=args.d128, multihead_q4=args.multihead_q4, mid=args.mid),
        scope=dict(large="Existing default large complete-block family: causal D64" +
                   (" and D128" if args.d128 != "parent" else "; D128 retains v7"),
                   multihead_q4="Existing medium D64/H>=2/noncausal path" if args.multihead_q4 else None,
                   mid="Existing medium D64/H==1/causal path" if mid else None),
        inherited="v7 FP32 medium multihead reduction/mask, tiny D32 load order and complete-argument compiled-callable cache",
        caches="Compiled callables only; current tensor data read on every invocation")
    with manifest_path.open("x") as file:
        json.dump(manifest, file, indent=2)
        file.write("\n")
    print(json.dumps(manifest, indent=2))


if __name__ == "__main__":
    main()
