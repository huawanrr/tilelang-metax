"""Reduce the live K tile on v11's BS32 joint-buffer path."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / "20261014_goal8933/candidate_v11_final_submission.py"
NAME = "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint"


def nodes(source):
    return ast.parse(source).body


def transform(fn, qwidth, kchunk, vfirst):
    fn = copy.deepcopy(fn)
    text = ast.unparse(fn)
    old = "(qi * D + qd) // 4 % 64"
    assert old in text
    text = text.replace(old, f"(qi * D + qd) // {qwidth} % 64")
    text = text.replace("(qi * D + qd) // 256 * 4 + qd % 4",
                        f"(qi * D + qd) // {64 * qwidth} * {qwidth} + qd % {qwidth}")
    fn = ast.parse(text).body[0]
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    guard = next(n for n in scope.body if isinstance(n, ast.If) and ast.unparse(n.test) == "valid")
    if kchunk < 128:
        count = kchunk // 32
        scope.body[:0] = nodes("\n".join(
            f"k_stream{i} = T.alloc_local([BS // 16 * 8], T.float16)" for i in range(count)))
        kload = next(n for n in guard.body if isinstance(n, ast.For)
                     and "k[j, d] = PackedKV" in ast.unparse(n))
        guard.body.remove(kload)
        loop_index = next(i for i, n in enumerate(guard.body) if isinstance(n, ast.For)
                          and ast.unparse(n.iter) == "T.serial(D // 32)")
        lines = [f"for block_step in T.serial(D // {kchunk}):"]
        for i in range(count):
            lines += ["    for tile in T.unroll(BS // 16):",
                      "        for element in T.vectorized(8):",
                      f"            k_stream{i}[tile * 8 + element] = PackedKV[b, block, h, 0, (block_step * {count} + {i}) * (BS // 16) + tile, T.get_thread_binding(), element]"]
        for i in range(count):
            lines += [f"    qk.mma(q, k_stream{i}, scores, block_step * {count} + {i})"]
        guard.body[loop_index:loop_index + 1] = nodes("\n".join(lines))
    if vfirst:
        load = next(n for n in guard.body if isinstance(n, ast.For)
                    and "v[j, d] = PackedKV" in ast.unparse(n))
        guard.body.remove(load)
        guard.body.insert(0, load)
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = PARENT.read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == "fc2d1f22d6bf769e7ef72c8c346ac586fbe85c2009bf171366dc8c883873d32e"
    for name in ("baseline.py", "control.py"):
        with (HERE / name).open("x") as out:
            out.write(source)
    fn = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
    old = ast.get_source_segment(source, fn)
    records = []
    for qw, kc, vf in ((8,128,False),(16,128,False),(4,32,False),(4,64,False),
                       (8,32,False),(8,64,False),(8,128,True)):
        # Preserve the parent's decorator by replacing only the function span.
        changed = transform(fn, qw, kc, vf)
        parsed = ast.parse(changed).body[0]
        changed = ast.get_source_segment(changed, parsed)
        result = source.replace(old, changed, 1)
        ast.parse(result)
        path = HERE / f"bs32_q{qw}_k{kc}_v{int(vf)}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            qwidth=qw, kchunk=kc, vfirst=vf))
    report = dict(parent=str(PARENT), parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                  changed_function=NAME, variants=records)
    (HERE / "bs32_stream_manifest.json").write_text(json.dumps(report, indent=2) + "\n")
    cases = json.loads((HERE.parent / "20261014_goal8933/validation_v11_final/cases.json").read_text())
    (HERE / "cases.json").write_text(json.dumps(cases, indent=2) + "\n")
    print("Generated", len(records), "BS32 variants")


if __name__ == "__main__":
    main()
