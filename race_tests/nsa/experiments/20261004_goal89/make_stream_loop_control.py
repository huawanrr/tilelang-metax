"""Keep the Q/K slice loop rolled to test its actual register lifetime."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for prefetch in (1, 2):
        parent = HERE / f"bs32_qkstream_p{prefetch}.py"
        source = parent.read_text()
        old = f"                for kg in T.unroll(D // (32 * {prefetch})):"
        new = f"                for kg in T.unroll(D // (32 * {prefetch}), unroll_factor=1):"
        source = replace_once(source, old, new)
        ast.parse(source)
        path = HERE / f"bs32_qkstream_p{prefetch}_rolled.py"
        with path.open("x") as f:
            f.write(source)
        records.append(dict(path=path.name, parent=parent.name,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "stream_loop_control_assembly.json").write_text(json.dumps(records, indent=2) + "\n")


if __name__ == "__main__":
    main()
