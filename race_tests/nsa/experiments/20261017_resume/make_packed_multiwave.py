"""Independent queries per CTA on the current joint packed S1 path.

The historical 20260926 multiwave prototype used the older direct/shared path.
Here all Q/O ownership and synchronization remain within each independent wave.
No data-dependent schedule, additional launch, or K/V reuse is introduced.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_packed_multiwave"


def proof(waves, qvec):
    dimensions = {"q_stage": (16, 128), "output": (16, 128), "k": (32, 128), "v": (32, 128)}
    for name, (rows, cols) in dimensions.items():
        seen = set()
        for w in range(waves):
            for row in range(rows):
                for col in range(cols):
                    if name in ("q_stage", "output"):
                        vec = qvec if name == "q_stage" else 8
                        lane = (row * cols + col) // vec % 64
                        index = (row * cols + col) // (64 * vec) * vec + col % vec
                    elif name == "k":
                        lane = col % 32 // 8 * 16 + row % 16
                        index = (col // 32 * 2 + row // 16) * 8 + col % 8
                    else:
                        lane = row % 16 // 4 * 16 + col % 16
                        index = (row // 16 * 4 + col // 32) * 8 + col % 32 // 16 * 4 + row % 4
                    entry = (w * 64 + lane, index)
                    assert entry not in seen and entry[0] // 64 == w
                    seen.add(entry)
        assert len(seen) == waves * rows * cols
        assert max(x[1] for x in seen) + 1 == rows * cols // 64
    return "All Q/output/K/V ownership mappings are bijective and wave-local."


def main():
    source = (HERE / "baseline.py").read_text()
    template = (HERE / "packed_multiwave_template.py").read_text()
    assert source.count("    key = (B, seq_len,") == 1
    records = []
    for waves, qvec in ((1, 4), (2, 4), (4, 4), (2, 8), (4, 8)):
        impl = template.replace("waves=2, q_vec=4,", f"waves={waves}, q_vec={qvec},")
        result = source.replace("def _get_kernel(", impl + "\n\ndef _get_kernel(", 1)
        flag = "    packed_multiwave = mathcast_single and grid >= 4096\n"
        result = result.replace("    key = (B, seq_len,", flag + "    key = (B, seq_len,", 1)
        result = result.replace("small_coalesced_blocks, s2_wave_output)\n", "small_coalesced_blocks, s2_wave_output, packed_multiwave)\n", 1)
        assert result.count("            attention = packed_builder(width=128, late=False, **common)") == 1
        result = result.replace(
            "            attention = packed_builder(width=128, late=False, **common)",
            f"            attention = ({NAME} if packed_multiwave else packed_builder)(width=128, late=False, **common)", 1)
        ast.parse(result)
        dest = HERE / f"packed_multiwave_w{waves}_q{qvec}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            waves=waves, qvec=qvec, mapping_proof=proof(waves, qvec)))
    with (HERE / "packed_multiwave_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
                       pack_and_public_interfaces_unchanged=True,
                       current_input_and_fp32_order_preserved=True,
                       explicit_tuning_fallbacks_preserved=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "independent-wave probes")


if __name__ == "__main__":
    main()
