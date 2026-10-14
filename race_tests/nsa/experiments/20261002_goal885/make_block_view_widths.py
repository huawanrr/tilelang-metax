"""Check whether larger scalar words or fully unrolled half reads improve pairs."""
import ast
import hashlib
import json
from pathlib import Path

from make_register_qk import function, once


HERE = Path(__file__).resolve().parent


def main():
    records = []
    for label, base in (("quad_loads", "pair_loads"),
                        ("unrolled_scalar_loads", "scalar_loads")):
        path = HERE / f"coalesced_block_view_{base}.py"
        source = path.read_text()
        original = function(source, "_coalesced_block_view_prim")
        part = original
        for name in ("k", "v"):
            if label == "quad_loads":
                part = once(part, f"for {name}_pair in T.unroll(4):",
                            f"for {name}_pair in T.unroll(2):")
                part = once(part, f"for {name}_element in T.vectorized(2):",
                            f"for {name}_element in T.vectorized(4):")
                assert part.count(f"{name}_pair * 2") == 2
                part = part.replace(f"{name}_pair * 2", f"{name}_pair * 4")
            else:
                part = once(part, f"for {name}_element in T.serial(8):",
                            f"for {name}_element in T.unroll(8):")
        result = once(source, original, part)
        ast.parse(result)
        output = HERE / f"coalesced_block_view_{label}.py"
        assert not output.exists(), output
        output.write_text(result)
        records.append(dict(path=output.name, sha256=hashlib.sha256(output.read_bytes()).hexdigest(),
                            baseline=path.name, baseline_sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
        print(output.name)
    (HERE / "block_view_widths_assembly.json").write_text(json.dumps(dict(variants=records), indent=2) + "\n")


if __name__ == "__main__":
    main()
