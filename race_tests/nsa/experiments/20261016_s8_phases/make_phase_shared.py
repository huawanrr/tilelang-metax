"""Move exact per-thread S8 weights to shared memory with explicit fences."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def transform(original):
    fn = copy.deepcopy(original)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    allocation = next(n for n in scope.body if isinstance(n, ast.Assign)
                      and ast.unparse(n.targets[0]) == "phase_weights")
    assert ast.unparse(allocation.value.func) == "T.alloc_fragment"
    allocation.value.func.attr = "alloc_shared"
    layout = next(n for n in scope.body if isinstance(n, ast.Expr)
                  and ast.unparse(n).startswith("T.annotate_layout({phase_weights:"))
    index = scope.body.index(layout)
    scope.body[index:index + 1] = ast.parse("""
T.annotate_layout({phase_weights: T.Layout([S, G, BS],
    lambda ps, pi, pj: (ps * 64 + pi + pj // 4 * 16) * 4 + pj % 4)})
""").body
    start = next(i for i, n in enumerate(scope.body) if isinstance(n, ast.Assign)
                 and ast.unparse(n.targets[0]) == "phase_v_position0")
    scope.body[start:start] = ast.parse("T.sync_warp()").body
    # Permit the compiler to reuse the shared allocation only after all readers finish.
    end = max(i for i, n in enumerate(scope.body) if isinstance(n, ast.If)
              and "phase_v_position7" in ast.unparse(n.test) and "pv.mma" in ast.unparse(n))
    scope.body[end + 1:end + 1] = ast.parse("T.sync_warp()").body
    return ast.unparse(ast.fix_missing_locations(fn))


def prove_layout():
    addresses = []
    for step in range(8):
        for head in range(16):
            for column in range(16):
                thread = head + column // 4 * 16
                index = (step * 64 + thread) * 4 + column % 4
                addresses.append(index)
                assert thread % 16 == head
                assert thread // 16 * 4 + column % 4 == column
    assert sorted(addresses) == list(range(2048))
    return dict(elements=2048, bytes=4096, same_thread_read_write=True,
                address_bijection=True, explicit_raw_and_war_fences=True)


def main():
    records = []
    for kdepth, vdepth in ((4, 1), (2, 2)):
        parent = HERE / f"phase_k{kdepth}_v{vdepth}.py"
        source = parent.read_text()
        functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
        result = source
        for name in sorted(NAMES):
            original = ast.get_source_segment(source, functions[name])
            result = result.replace(original, transform(functions[name]), 1)
        updated = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert {n for n in functions if ast.dump(functions[n]) != ast.dump(updated[n])} == NAMES
        path = HERE / f"phase_shared_k{kdepth}_v{vdepth}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(file=path.name, parent=parent.name,
                            parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                            sha256=hashlib.sha256(result.encode()).hexdigest(),
                            proof=prove_layout()))
    with (HERE / "phase_shared_manifest.json").open("x") as out:
        json.dump(dict(status="unvalidated shared-weight probes", variants=records), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "shared-weight phase probes; address and thread ownership PASS")


if __name__ == "__main__":
    main()
