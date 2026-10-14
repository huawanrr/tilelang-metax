"""Expose independent QK accumulation chains on the currently packed paths."""
import ast
import hashlib
import json
from pathlib import Path
import re
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"
NAMES = ("native_sparse_attention_single_packed_qo_v2",
         "native_sparse_attention_online_packed_batch_minor_o_v2",
         "native_sparse_attention_online_packed_quad_batch_minor_o_v2")


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def once(source, old, new):
    assert source.count(old) == 1, old
    return source.replace(old, new)


def transform(source, name, parts):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    fn = "".join(lines[start:node.end_lineno])
    score = "scores" if name == NAMES[0] else "acc_s"
    ways = parts if name == NAMES[0] else min(parts, 2)
    declaration = f"            {score} = T.alloc_fragment([G, BS], T.float32)\n"
    fn = once(fn, declaration,
        "".join(f"            qk_partial_{i} = T.alloc_fragment([G, BS], T.float32)\n" for i in range(1, ways)) + declaration)
    layout = f"                {score}: qk.make_mma_store_layout({score}),\n"
    fn = once(fn, layout,
        "".join(f"                qk_partial_{i}: qk.make_mma_store_layout(qk_partial_{i}),\n" for i in range(1, ways)) + layout)
    pattern = re.compile(r"(?P<pad> +)for ki in T.serial\((?P<bound>D // 32|qk_steps)\):\n"
        r"(?P=pad)    qk.mma\((?P<q>q|Q_reg), (?P<k>k|K_reg[123]?), (?P<s>scores|acc_s), ki\)\n")

    def replacement(match):
        pad, bound, q, k, s = [match[group] for group in ("pad", "bound", "q", "k", "s")]
        result = "".join(f"{pad}T.clear(qk_partial_{i})\n" for i in range(1, ways))
        result += f"{pad}for ki in T.unroll({bound}):\n"
        if ways == 1:
            result += f"{pad}    qk.mma({q}, {k}, {s}, ki)\n"
        else:
            for i in range(ways):
                result += f"{pad}    {'if' if i == 0 else 'elif'} ki % {ways} == {i}:\n"
                target = s if i == 0 else f"qk_partial_{i}"
                result += f"{pad}        qk.mma({q}, {k}, {target}, ki)\n"
            result += f"{pad}for qk_row, qk_col in T.Parallel(G, BS):\n"
            for i in range(1, ways):
                result += f"{pad}    {s}[qk_row, qk_col] += qk_partial_{i}[qk_row, qk_col]\n"
        return result

    fn, count = pattern.subn(replacement, fn)
    assert count == (1 if name == NAMES[0] else 5), (name, count)
    ast.parse(fn)
    return "".join(lines[:start]) + fn + "".join(lines[node.end_lineno:])


def main():
    assert digest(BASE) == json.loads(BASE.with_name("release_manifest.json").read_text())["source_sha256"]["nsa.py"]
    for name in ("compare_family.py", "bracketed_multiseed.py", "inspect_resources.py", "family_cases.json"):
        target = HERE / name
        assert not target.exists()
        shutil.copyfile(ROOT / "experiments/20261003_query_loop" / name, target)
    for name in ("reference_mid.py", "reference_control.py"):
        target = HERE / name
        assert not target.exists()
        shutil.copyfile(BASE, target)
    source = BASE.read_text()
    original = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for name, parts in (("qk_unroll", 1), ("qk_split2", 2), ("qk_split4", 4)):
        result = source
        for function in NAMES:
            result = transform(result, function, parts)
        current = {n.name: ast.dump(n) for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert all(original[name] == current[name] for name in original if name not in NAMES)
        path = HERE / (name + ".py")
        with path.open("x") as output:
            output.write(result)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=digest(path),
            s1_parts=parts, s8_parts=min(parts, 2), changed_functions=NAMES))
    report = dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=digest(BASE), variants=records,
        mechanism="Split QK D-reduction into independent accumulators on the current packed K/V paths",
        prior_context="Earlier split-accumulator study used shared K/V staging; current packed path has different dependency chains",
        arithmetic_note="Every product retained; reassociation changes only FP32 summation order; reference checks required",
        unchanged_synchronization=True, goal_complete=False)
    with (HERE / "assembly.json").open("x") as output:
        output.write(json.dumps(report, indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
