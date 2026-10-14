"""Group independent queries within one wave, retaining every shared dependency."""
import ast
import hashlib
import json
from pathlib import Path
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


def indent(source, count):
    return "".join(" "*count + line if line.strip() else line for line in source.splitlines(keepends=True))


def transform(source, name, count, kind):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    fn = "".join(lines[start:node.end_lineno])
    if name == NAMES[0]:
        fn = once(fn, "with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):",
            f"with T.Kernel(T.ceildiv(seq_len, {count}), batch * H, threads=threads) as (query_group, bh):")
        marker = "            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)\n"
        prelude, body = fn.split(marker)
        body = marker + body
        tail = "            output_shared = T.alloc_shared([G, D], T.float16)\n"
        output_at = body.index(tail)
        output_end = body.index("            T.sync_warp()", output_at)
        # Q and O have the same swizzle. Their existing WAR barrier protects
        # reuse within a query; the loop back edge gets its own WAR barrier.
        body = body[:output_at] + body[output_end:]
        prelude += "            output_shared = q_shared\n"
        query = "token"
    else:
        fn = once(fn, "with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,\n                      threads=threads) as (bz, by, bx):",
            f"with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), T.ceildiv(seq_len, {count}),\n                      threads=threads) as (bz, by, query_group):")
        fn = once(fn, "            i_t, i_v, i_bh = bx, by, bz\n", "            i_v, i_bh = by, bz\n")
        marker = "            indices = T.alloc_local([S], T.int32)\n"
        prelude, body = fn.split(marker)
        prelude += marker
        output_at = body.index("            O_reg = T.alloc_fragment([G, BV], T.float16)\n")
        output_end = body.index("            T.copy(acc_o, O_reg)", output_at)
        prelude += body[output_at:output_end]
        body = body[:output_at] + body[output_end:]
        query = "i_t"
    assert body.count("    return kernel") == 1
    body, suffix = body.split("    return kernel")
    body = body.rstrip() + "\n"
    fn = (prelude + f"            for query_offset in T.{kind}({count}):\n"
        + f"                {query} = query_group * {count} + query_offset\n"
        + f"                if {query} < seq_len:\n" + indent(body, 8)
        + f"                if query_offset + 1 < {count}:\n"
        + "                    T.sync_warp()\n\n    return kernel" + suffix)
    ast.parse(fn)
    return "".join(lines[:start]) + fn + "".join(lines[node.end_lineno:])


def main():
    parent = json.loads(BASE.with_name("release_manifest.json").read_text())
    assert digest(BASE) == parent["source_sha256"]["nsa.py"]
    for name in ("compare_family.py", "bracketed_multiseed.py", "inspect_resources.py", "family_cases.json"):
        target = HERE / name
        assert not target.exists()
        shutil.copyfile(ROOT / "experiments/20261003_output_lane" / name, target)
    for name in ("reference_mid.py", "reference_control.py"):
        target = HERE / name
        assert not target.exists()
        shutil.copyfile(BASE, target)
    source = BASE.read_text()
    original = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    variants = []
    for count in (2, 4):
        for kind in ("serial", "unroll"):
            result = source
            for name in NAMES:
                result = transform(result, name, count, kind)
            after = {n.name: ast.dump(n) for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
            assert all(original[name] == after[name] for name in original if name not in NAMES)
            path = HERE / f"query{count}_{kind}.py"
            with path.open("x") as output:
                output.write(result)
            variants.append(dict(path=str(path.relative_to(ROOT)), sha256=digest(path),
                queries_per_cta=count, loop=kind, changed_functions=NAMES))
    proof = []
    for count in (2, 4):
        for length in (1, 2, 3, 4, 5, 15, 16, 17, 37, 511, 512, 513, 1023, 1024, 1025):
            seen = [group*count+offset for group in range((length+count-1)//count)
                    for offset in range(count) if group*count+offset < length]
            assert seen == list(range(length))
            proof.append(dict(queries_per_cta=count, length=length, complete_unique_queries=True))
    report = dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=digest(BASE), variants=variants,
        query_coverage=proof, extra_sync="Full-wave O read to next Q/O write WAR barrier at loop back edge",
        user_feedback="The previous version did not improve the official 88.29 score; exact version clarification pending",
        previous_goal_turn="progress: produced a validated candidate; flat OJ feedback now shifts focus to known expensive OJ families",
        goal_complete=False)
    with (HERE / "assembly.json").open("x") as output:
        output.write(json.dumps(report, indent=2) + "\n")
    print(json.dumps(dict(variants=variants, coverage_cases=len(proof)), indent=2))


if __name__ == "__main__":
    main()
