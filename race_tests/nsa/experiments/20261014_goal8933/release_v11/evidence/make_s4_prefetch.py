"""Move next-block loads across computation after their old values are consumed."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_staged_sparse_blocks"


def change(fn, before_qk):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    loop = next(n for n in scope.body if isinstance(n, ast.For)
                and ast.unparse(n.iter).startswith("T.unroll(S, unroll_factor="))
    assert len(loop.body) == 4
    block, producer, prefetch, consumer = loop.body
    assert ast.unparse(block) == "block = blocks[s]"
    assert isinstance(producer, ast.If) and isinstance(prefetch, ast.If) and isinstance(consumer, ast.If)
    assert ast.dump(producer.test) == ast.dump(consumer.test)
    vi = next(i for i, n in enumerate(producer.body) if ast.unparse(n) == "T.copy(v, v_shared)")
    if before_qk:
        vcopy = producer.body.pop(vi)
        sync = next(i for i, n in enumerate(producer.body) if ast.unparse(n) == "T.sync_warp()")
        producer.body.insert(sync, vcopy)
        cut = sync + 2
    else:
        cut = vi + 1
    consumer.body = producer.body[cut:] + consumer.body
    producer.body = producer.body[:cut]
    # Prefetch stays outside the current-block validity guard. Invalid slots
    # followed by valid slots must still load the next block.
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    fn = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
    records = []
    for before_qk in (False, True):
        revised = source.replace(ast.get_source_segment(source, fn), change(fn, before_qk), 1)
        ast.parse(revised)
        path = HERE / ("s4_prefetch_before_qk.py" if before_qk else "s4_prefetch_before_exp.py")
        with path.open("x") as out:
            out.write(revised)
        records.append(dict(path=path.name, before_qk=before_qk,
            sha256=hashlib.sha256(revised.encode()).hexdigest()))
    with (HERE / "s4_prefetch_manifest.json").open("x") as out:
        json.dump(dict(variants=records, baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
            synchronization="All existing wave fences retained; next-block register loads follow consumption of old K/V",
            validity="Current-block and next-block validity checks remain independent"), out, indent=2)
        out.write("\n")
    print("Generated two S4 prefetch probes", flush=True)


if __name__ == "__main__":
    main()
