"""Assemble independently timed streaming one/two-query controls."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261008_resume8871/candidate_v6.py"


def main():
    source = BASE.read_text()
    template = (HERE / "pair_ilp_template.py").read_text()
    records = []
    for pair, width in ((1, 64), (2, 32), (2, 64), (2, 128)):
        # Audit the actual per-lane MFMA pointer offsets; no cross-query products.
        for ki in range(4):
            for kp in range(2):
                for pi in range(pair):
                    for kj in range(2):
                        assert ((pi * 2 + kj) * 2 + kp + 1) * 4 <= pair * 2 * 8
                        assert (ki * pair * 2 + pi * 2 + kp + 1) * 4 <= pair * 16 * 128 // 64
                        assert (pi * 2 + kj + 1) * 4 <= pair * 16 * 32 // 64
        for ki in range(2):
            for pi in range(pair):
                for vj in range(width // 16):
                    assert (pi * (width // 16) + vj + 1) * 4 <= pair * width // 4
                    assert (ki * pair + pi + 1) * 4 <= pair * 16 * 32 // 64
        result = source.replace("def _get_kernel(\n", template + "\n\ndef _get_kernel(\n", 1)
        old = "            attention = packed_builder(width=128, late=False, **common)"
        assert result.count(old) == 1
        result = result.replace(old, f"""            if mathcast_single and H == 1 and seq_len % {pair} == 0:
                attention = native_sparse_attention_pair_ilp(query_pair={pair}, width={width}, **common)
            else:
                attention = packed_builder(width=128, late=False, **common)""")
        ast.parse(result)
        path = HERE / f"pair_ilp_p{pair}_w{width}.py"
        with path.open("x") as handle:
            handle.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(),
                            query_pair=pair, output_width=width, local_pointer_bounds=True))
    (HERE / "pair_ilp_manifest.json").write_text(json.dumps(dict(base=str(BASE),
        base_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        mechanism="Interleave only independent products; stream K and V operands; same packing on every call.",
        scope="Default existing packed S1/D128/BS32 path, H1, sequence divisible by query_pair.",
        status="Research; requires numerical and device layout verification"), indent=2) + "\n")


if __name__ == "__main__":
    main()
