"""Screen raw block guards and static lookahead groups on the existing S8 kernels."""

import ast
import hashlib
import json
from pathlib import Path
import re
import shutil


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"
FUNCTIONS = (
    "native_sparse_attention_online_packed_batch_minor_o_v2",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2",
)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def modify(source, name, blocks, unroll):
    node = next(node for node in ast.parse(source).body
                if isinstance(node, ast.FunctionDef) and node.name == name)
    lines = source.splitlines(keepends=True)
    first = min([node.lineno] + [decorator.lineno for decorator in node.decorator_list]) - 1
    fn = "".join(lines[first:node.end_lineno])
    if unroll:
        old = "for group in T.serial(T.ceildiv(S, prefetch_depth)):"
        assert fn.count(old) == 1
        fn = fn.replace(old, "for group in T.unroll(T.ceildiv(S, prefetch_depth)):")
    if blocks:
        old = "indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS"
        assert fn.count(old) == 1
        fn = fn.replace(old, "indices[si] = BlockIndices[i_b, i_t, i_h, si]")
        for suffix in ("", "0", "1", "2", "3"):
            old_name, new_name = "i_s" + suffix, "block" + suffix
            fn = re.sub(r"\b" + old_name + r"\b", new_name, fn)
            assert f"{new_name} // BS" in fn
            fn = fn.replace(f"{new_name} // BS", new_name)
            fn = fn.replace(f"{new_name} < seq_len", f"{new_name} < T.ceildiv(seq_len, BS)")
            fn = fn.replace(f"{new_name} <= i_t", f"{new_name} <= i_t // BS")
            fn = fn.replace(f"{new_name} +", f"{new_name} * BS +")
    result = "".join(lines[:first]) + fn + "".join(lines[node.end_lineno:])
    ast.parse(result)
    return result


def main():
    for name in ("compare_family.py", "bracketed_multiseed.py", "family_cases.json", "inspect_resources.py"):
        target = HERE / name
        assert not target.exists(), target
        shutil.copyfile(ROOT / "experiments/20261003_continue" / name, target)
    for name in ("reference_mid.py", "reference_control.py"):
        target = HERE / name
        assert not target.exists(), target
        shutil.copyfile(BASE, target)
    source = BASE.read_text()
    originals = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    variants = []
    for label, blocks, unroll in (
        ("unroll", False, True), ("blocks", True, False), ("blocks_unroll", True, True),
    ):
        result = source
        for function in FUNCTIONS:
            result = modify(result, function, blocks, unroll)
        after = {n.name: ast.dump(n) for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert set(originals) == set(after)
        assert all(originals[n] == after[n] for n in originals if n not in FUNCTIONS)
        target = HERE / ("s8_" + label + ".py")
        with target.open("x") as output:
            output.write(result)
        variants.append(dict(path=str(target.relative_to(ROOT)), sha256=digest(target),
            block_number_guards=blocks, unroll_lookahead_groups=unroll))
    report = dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=digest(BASE),
        baseline_official_score=88.29, variants=variants, changed_functions=list(FUNCTIONS),
        scope="Existing default S8 output-staging paths, grid >= 4096",
        invariants="Unchanged packer, query/output layouts, synchronization, arithmetic order and public dispatch")
    with (HERE / "assembly.json").open("x") as output:
        output.write(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
