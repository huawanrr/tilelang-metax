"""Append selected, measured builders to v6 and preserve every old builder."""
import argparse
import ast
import copy
import hashlib
import json
from pathlib import Path
import subprocess
import sys

from make_host_dispatch_cache import transform as host_cache

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


class Rename(ast.NodeTransformer):
    def __init__(self, names):
        self.names = names

    def visit_Name(self, node):
        node.id = self.names.get(node.id, node.id)
        return node

    def visit_FunctionDef(self, node):
        node.name = self.names.get(node.name, node.name)
        return self.generic_visit(node)


def functions(source):
    return {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--name", required=True)
    parser.add_argument("--components", default="host", help="Comma-separated host,large,multihead,tiny")
    args = parser.parse_args()
    selected = set(args.components.split(","))
    assert selected <= {"host", "large", "multihead", "tiny"}
    assert args.name.replace("_", "").isalnum()
    parent_path = HERE / "parent.py"
    source = parent_path.read_text()
    old = functions(source)
    dispatch = copy.deepcopy(old["_get_kernel"])
    additions, sources, scopes, names = [], {}, {}, {}

    def add(path, old_name, new_name, mapping=None):
        text = path.read_text()
        sources[str(path)] = hashlib.sha256(text.encode()).hexdigest()
        fn = copy.deepcopy(functions(text)[old_name])
        fn = Rename({old_name: new_name, **(mapping or {})}).visit(fn)
        ast.fix_missing_locations(fn)
        additions.append(fn)
        names[new_name] = dict(probe=str(path), function=old_name)

    if "large" in selected:
        prim = "_coalesced_block_loads_prim_fp32_sum"
        builder = "native_sparse_attention_coalesced_blocks_fp32_sum"
        add(HERE / "fp32_core.py", "_coalesced_block_loads_prim_mathcast", prim)
        add(parent_path, "native_sparse_attention_coalesced_blocks_mathcast", builder,
            {"_coalesced_block_loads_prim_mathcast": prim})
        scopes["fp32_large"] = "mathcast_blocks and (D == 128 or is_causal)"
        class Large(ast.NodeTransformer):
            def visit_Assign(self, node):
                if (len(node.targets) == 1 and isinstance(node.targets[0], ast.Name)
                    and node.targets[0].id == "builder" and isinstance(node.value, ast.Name)
                    and node.value.id == "native_sparse_attention_coalesced_blocks_mathcast"):
                    node.value = ast.parse(f"{builder} if fp32_large else native_sparse_attention_coalesced_blocks_mathcast", mode="eval").body
                return self.generic_visit(node)
        dispatch = Large().visit(dispatch)

    if "multihead" in selected:
        prim = "_coalesced_block_loads_prim_fp32_mask"
        builder = "native_sparse_attention_coalesced_blocks_fp32_mask"
        add(HERE / "fp32_mask_post.py", "_coalesced_block_loads_prim_oct8", prim)
        add(parent_path, "native_sparse_attention_coalesced_blocks_oct8", builder,
            {"_coalesced_block_loads_prim_oct8": prim})
        scopes["fp32_multih"] = "oct8_coalesced and H >= 2"
        class Multihead(ast.NodeTransformer):
            def visit_Call(self, node):
                if isinstance(node.func, ast.Name) and node.func.id == "native_sparse_attention_coalesced_blocks_oct8":
                    node.func = ast.parse(f"{builder} if fp32_multih else native_sparse_attention_coalesced_blocks_oct8", mode="eval").body
                return self.generic_visit(node)
        dispatch = Multihead().visit(dispatch)

    if "tiny" in selected:
        builder = "native_sparse_attention_q_preload_vfirst"
        add(HERE / "small_vfirst.py", "native_sparse_attention_q_preload", builder)
        scopes["tiny_vfirst"] = "preload_direct and D == 32"
        class Tiny(ast.NodeTransformer):
            def visit_Call(self, node):
                if isinstance(node.func, ast.Name) and node.func.id == "native_sparse_attention_q_preload":
                    node.func = ast.parse(f"{builder} if tiny_vfirst else native_sparse_attention_q_preload", mode="eval").body
                return self.generic_visit(node)
        dispatch = Tiny().visit(dispatch)

    key_index = next(i for i, n in enumerate(dispatch.body) if isinstance(n, ast.Assign)
                     and any(isinstance(t, ast.Name) and t.id == "key" for t in n.targets))
    key = dispatch.body[key_index]
    assert isinstance(key.value, ast.Tuple)
    key.value.elts += [ast.Name(name, ast.Load()) for name in scopes]
    dispatch.body[key_index:key_index] = ast.parse("\n".join(f"{k} = {v}" for k, v in scopes.items())).body
    ast.fix_missing_locations(dispatch)
    lines = source.splitlines(keepends=True)
    original = old["_get_kernel"]
    new_text = "\n\n".join(ast.unparse(fn) for fn in additions + [dispatch]) + "\n"
    lines[original.lineno-1:original.end_lineno] = [new_text]
    result = "".join(lines)
    if "host" in selected:
        result = host_cache(result)
    final = functions(result)
    kept = []
    for name, fn in old.items():
        if name != "_get_kernel":
            assert ast.dump(fn) == ast.dump(final[name]), name
            kept.append(name)
    assert sorted(set(final)-set(old)) == sorted(names)
    dev = HERE / f"{args.name}.py"
    sub = HERE / f"{args.name}_submission.py"
    manifest = HERE / f"{args.name}_manifest.json"
    assert not dev.exists() and not sub.exists() and not manifest.exists()
    with dev.open("x") as f:
        f.write(result)
    subprocess.run([sys.executable, str(ROOT / "experiments/20261007_exp_math/make_submission.py"),
                    str(dev), str(sub)], check=True)
    report = dict(parent=str(parent_path), parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
        components=sorted(selected), scope_expressions=scopes, appended_functions=names,
        unchanged_nondispatch_functions=kept, source_sha256=sources,
        development=str(dev), development_sha256=hashlib.sha256(dev.read_bytes()).hexdigest(),
        submission=str(sub), submission_sha256=hashlib.sha256(sub.read_bytes()).hexdigest(),
        status="assembled; actual submission validation and timing required")
    with manifest.open("x") as f:
        json.dump(report, f, indent=2)
        f.write("\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
