"""Supply the one-element-per-lane cast loop's known layout explicitly."""
import ast
import hashlib
import json
from pathlib import Path

from make_cast_and_flags import BASE, HERE, ONLINE, SINGLE, edit_functions
from make_cast_v2 import transform


LOOP = ("for ci, cj in T.Parallel(G, 4, loop_layout=T.Fragment([G, 4], "
        "forward_thread_fn=lambda ri, rj: ri + rj * 16, "
        "forward_index_fn=lambda ri, rj: 0)):")


def explicit_cast(fn, name, output):
    result = transform(fn, name, output)
    count = result.count("for ci, cj in T.Parallel(G, 4):")
    assert count > 0
    return result.replace("for ci, cj in T.Parallel(G, 4):", LOOP)


def main():
    records = []
    for name, parent, names, output in (
        ("s8_cast_scalar_v3", HERE / "exp_folded.py", ONLINE, True),
        ("s8_cast_scalar_base_v3", BASE, ONLINE, True),
        ("packed_cast_scalar_v3", HERE / "exp_folded.py", ONLINE + (SINGLE,), True),
        ("packed_cast_scalar_base_v3", BASE, ONLINE + (SINGLE,), True),
        ("single_cast_prob_v3", BASE, (SINGLE,), False),
    ):
        result = edit_functions(parent.read_text(), names,
            lambda fn, n: explicit_cast(fn, n, output))
        ast.parse(result)
        path = HERE / (name + ".py")
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path), parent=str(parent), functions=names,
                            output=output, sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "cast_v3_assembly.json").write_text(json.dumps(dict(variants=records,
        reason="Explicit G x 4 layout: thread = query + lane_group * 16; one scalar per thread",
        unchanged_sync=True, unchanged_math=True), indent=2) + "\n")
    print("Generated", len(records), "explicit-layout cast probes")


if __name__ == "__main__":
    main()
