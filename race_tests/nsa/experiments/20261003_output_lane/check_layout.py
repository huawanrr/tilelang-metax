"""Evaluate the generated output indices and the uint32 lane exchange on CPU."""

import ast
import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent


def evaluate(node, env):
    return eval(compile(ast.Expression(node), "<output-index>", "eval"), {"__builtins__": {}}, env)


def main():
    records = []
    for path in (HERE / "output_lane_shared.py", HERE / "output_lane_d32.py"):
        tree = ast.parse(path.read_text())
        for fn in [node for node in tree.body if isinstance(node, ast.FunctionDef)]:
            assignments = [node for node in ast.walk(fn) if isinstance(node, ast.Assign)]
            named = lambda name: [node for node in assignments if isinstance(node.targets[0], ast.Subscript)
                                 and isinstance(node.targets[0].value, ast.Name) and node.targets[0].value.id == name]
            if not named("output_raw"):
                continue
            load, exchange, write = [named(name)[0] for name in ("output_raw", "output_exchanged", "Output")]
            assert isinstance(exchange.value, ast.Call) and exchange.value.func.attr == "shfl_sync"
            assert [ast.literal_eval(arg) for arg in exchange.value.args[2:]] == [64, 0xffffffffffffffff]
            for dim in ((32,) if "d32" in path.stem else (64, 128)):
                env = dict(BV=dim, D=dim, G=16, i_b=1, b=1, i_t=7, token=7, t_0=7, i_h=2, h=2, i_v=0)
                raw, shuffled, seen = {}, {}, set()
                for tid in range(64):
                    for slot in range(dim // 16):
                        for element in range(4):
                            current = dict(env, output_tid=tid, output_slot=slot, output_element=element)
                            local = evaluate(load.targets[0].slice, current)
                            row, col = evaluate(load.value.slice, current)
                            assert row + col % 16 // 4 * 16 == tid
                            assert col // 16 * 4 + col % 4 == local
                            assert (tid, local) not in raw
                            raw[tid, local] = (row, col)
                for tid in range(64):
                    for word in range(dim // 8):
                        current = dict(env, output_tid=tid, output_word=word)
                        destination = evaluate(exchange.targets[0].slice, current)
                        source = evaluate(exchange.value.args[0].slice, current)
                        lane = evaluate(exchange.value.args[1], current)
                        assert 0 <= lane < 64
                        for half in range(2):
                            shuffled[tid, destination * 2 + half] = raw[lane, source * 2 + half]
                for tid in range(64):
                    for slot in range(dim // 16):
                        for element in range(4):
                            current = dict(env, output_tid=tid, output_slot=slot, output_element=element)
                            b, t, h, col = evaluate(write.targets[0].slice, current)
                            local = evaluate(write.value.slice, current)
                            assert (b, t) == (1, 7) and (h - 32, col) == shuffled[tid, local]
                            assert 32 <= h < 48 and 0 <= col < dim
                            assert (h, col) not in seen
                            seen.add((h, col))
                assert len(raw) == len(shuffled) == len(seen) == 16 * dim
                records.append(dict(module=path.name, function=fn.name, dim=dim, elements=len(seen),
                                    unique_complete_stores=True, source_lane_ownership=True,
                                    paired_half_bit_patterns_preserved=True))
    report = dict(status="PASS", records=records, source_sha256={
        path.name: hashlib.sha256(path.read_bytes()).hexdigest() for path in
        (HERE / "output_lane_shared.py", HERE / "output_lane_d32.py")})
    (HERE / "layout_proof.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PASS", len(records), "function/dimension combinations")


if __name__ == "__main__":
    main()
