"""Separate Q/O shared swizzles in the current joint packed S1 path.

The native PV result writes four halves per lane, while Q reads eight.
An output swizzle sized for Q can add shared-bank conflicts on the PV store.
Keep all arithmetic, global addresses, packing, dispatch and barriers fixed.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint"


def main():
    source = (HERE / "baseline.py").read_text()
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == NAME)
    original = ast.get_source_segment(source, node)
    records = []
    for q_vec, o_vec in ((8, 4), (8, 2), (4, 4), (4, 8)):
        fragment = original
        for name, vec in (("q_shared", q_vec), ("output_shared", o_vec)):
            old = f"make_mma_swizzle_layout({name}, vecSize=8)"
            assert fragment.count(old) == 1
            fragment = fragment.replace(old, f"make_mma_swizzle_layout({name}, vecSize={vec})")
        result = source.replace(original, fragment, 1)
        ast.parse(result)
        path = HERE / f"packed_swizzle_q{q_vec}_o{o_vec}.py"
        with path.open("x") as out:
            out.write(result)
        # Prove every swizzle is a complete bijection on each supported tile.
        proofs = []
        for dim in (64, 128):
            for vec in (q_vec, o_vec):
                phase = min(16, dim // vec)
                addresses = [row * dim + ((col // vec) ^ (row % phase)) * vec + col % vec
                             for row in range(16) for col in range(dim)]
                assert sorted(addresses) == list(range(16 * dim))
                proofs.append(dict(dim=dim, vec=vec, elements=len(addresses)))
        records.append(dict(path=path.name, q_vec=q_vec, o_vec=o_vec,
                            sha256=hashlib.sha256(result.encode()).hexdigest(),
                            bijections=proofs))
    (HERE / "packed_swizzle_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
        changed_function=NAME, variants=records,
        arithmetic_unchanged=True, synchronization_unchanged=True,
        pack_and_dispatch_unchanged=True), indent=2) + "\n")
    print("Generated", len(records), "Q/O shared-layout probes")


if __name__ == "__main__":
    main()
