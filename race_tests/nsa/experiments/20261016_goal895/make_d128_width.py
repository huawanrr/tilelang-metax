"""Compare 64-column PV tiles within existing complete-block D128 builders."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    rows = []
    for name in ("coalesced", "boundary_q8"):
        original = (HERE / f"dispatch_{name}.py").read_text()
        builder = ("native_sparse_attention_coalesced_blocks_oct8" if name == "coalesced"
                   else "native_sparse_attention_coalesced_blocks_boundary_v8")
        old = f"            kernel = {builder}(q_vec=8, pv_width=128, **common)\n"
        assert original.count(old) == 1
        result = original.replace(old, f"            kernel = {builder}(q_vec=8, pv_width=64, **common)\n", 1)
        path = HERE / f"dispatch_{name}_pv64.py"
        with path.open("x") as out:
            out.write(result)
        rows.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                         parent_sha256=hashlib.sha256(original.encode()).hexdigest(), pv_width=64))
    with (HERE / "d128_width_manifest.json").open("x") as out:
        json.dump(rows, out, indent=2)
        out.write("\n")


if __name__ == "__main__":
    main()
