"""Probe row-preserving V shared-memory permutations in the current S2 kernel.

K and V reuse the allocation as before. Both V writes and MMA operand reads
use the same bijection. No synchronization or arithmetic is removed.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_short_list_oct8_sum_v11"


def address(row, col, width):
    phase = f"({row}) % 16" if width == 4 else f"(({row}) // 4) % 4"
    return f"({row}) * BK + ((({col}) // {width}) ^ ({phase})) * {width} + ({col}) % {width}"


def main():
    records = []
    for parent, label in (("baseline.py", "auto"), ("s2_wave_q0_o1.py", "wave_o")):
        source = (HERE / parent).read_text()
        functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
        original = ast.get_source_segment(source, functions[NAME])
        for width in (4, 16):
            store = "KV_shared[j * BK + d] = V_reg[j, d]"
            load = "KV_shared[(ki * 16 + tid // 16 * 4 + e) * BK + (j * 16 + tid % 16)]"
            assert original.count(store) == 1 and original.count(load) == 1
            revised = original.replace(store, f"KV_shared[{address('j', 'd', width)}] = V_reg[j, d]")
            revised = revised.replace(load, f"KV_shared[{address('ki * 16 + tid // 16 * 4 + e', 'j * 16 + tid % 16', width)}]")
            # All instances of this builder selected by the public dispatcher are D64/S2.
            result = source.replace(original, revised, 1)
            updated = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
            assert [n for n in functions if ast.dump(functions[n]) != ast.dump(updated[n])] == [NAME]
            # Independent finite-domain proof of the proposed physical address map.
            mapped = [r * 64 + ((c // width) ^ (r % 16 if width == 4 else (r // 4) % 4)) * width + c % width
                      for r in range(32) for c in range(64)]
            assert sorted(mapped) == list(range(32 * 64))
            for r in range(32):
                assert all(p // 64 == r for p in mapped[r * 64:(r + 1) * 64])
            path = HERE / f"s2_v{width}_{label}.py"
            with path.open("x") as out:
                out.write(result)
            records.append(dict(file=path.name, parent=parent, width=width,
                                parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                                sha256=hashlib.sha256(result.encode()).hexdigest(),
                                row_preserving_bijection_elements=len(mapped)))
    with (HERE / "s2_v_layout_manifest.json").open("x") as out:
        json.dump(dict(status="screening probes", changed_function=NAME, variants=records,
                       race_checks_enabled=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "S2 V-layout probes; physical address bijections PASS")


if __name__ == "__main__":
    main()
