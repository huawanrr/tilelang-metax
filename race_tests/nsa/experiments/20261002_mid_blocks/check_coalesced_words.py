"""Prove the experimental coalesced native-word lane and shared addresses."""
import ast
import hashlib
import json
from pathlib import Path

from check_mid_layouts import assignments, evaluate, iterations

HERE = Path(__file__).resolve().parent


def builder(path):
    return next(n for n in ast.parse(path.read_text()).body if isinstance(n, ast.FunctionDef)
                and n.name == "_coalesced_block_loads_prim")


def syncs(fn):
    return [ast.dump(n) for n in ast.walk(fn) if isinstance(n, ast.Call)
            and isinstance(n.func, ast.Attribute) and n.func.attr.startswith("sync_")]


def main():
    source = HERE / "coalesced_words2.py"
    fn = builder(source)
    assert syncs(fn) == syncs(builder(HERE / "reference_blocks_v2.py"))
    records = []
    statements = list(assignments(fn))
    for dim in (64, 128):
        env = dict(BS=16, BK=dim, BV=dim, dim=dim, KPHASE=1, KMAX=min(16, dim // 8),
                   i_b=0, i_h=0, _selected_block=1)
        for name in ("K", "V"):
            load, loops = next((n, loop) for n, loop in statements
                if isinstance(n.value, ast.Subscript) and isinstance(n.value.value, ast.Name)
                and n.value.value.id == f"{name}_blocks")
            values = {}
            for tid in range(64):
                for current in iterations(loops, dict(env, tid=tid)):
                    b, block, row, h, word = evaluate(load.value.slice, current)
                    local_word = evaluate(load.targets[0].slice, current)
                    assert (b, block, h) == (0, 1, 0)
                    for e in range(2):
                        col, local = word * 2 + e, local_word * 2 + e
                        assert 0 <= row < 16 and 0 <= col < dim
                        assert (row * dim + col) // 8 % 64 == tid
                        assert local == (row * dim + col) // 512 * 8 + col % 8
                        assert (tid, local) not in values
                        values[tid, local] = (row, col)
            store, loops = next((n, loop) for n, loop in statements
                if isinstance(n.value, ast.Subscript) and isinstance(n.value.value, ast.Name)
                and n.value.value.id == f"{name}_reg"
                and isinstance(n.targets[0], ast.Subscript)
                and isinstance(n.targets[0].value, ast.Name) and n.targets[0].value.id == "KV_shared")
            shared = {}
            for tid in range(64):
                for current in iterations(loops, dict(env, tid=tid)):
                    address = evaluate(store.targets[0].slice, current)
                    local = evaluate(store.value.slice, current)
                    row, col = values[tid, local]
                    expected = (row * dim + ((col // 8) ^ (row % min(16, dim // 8))) * 8 + col % 8
                                if name == "K" else row * dim + col)
                    assert address == expected and address not in shared
                    shared[address] = (row, col)
            assert len(values) == len(set(values.values())) == 16 * dim
            assert set(shared) == set(range(16 * dim))
            records.append(dict(dim=dim, operand=name, checked_values=len(values),
                identical_lane_values=True, shared_bijection=True))
        for batch, heads, length in ((1, 1, 1280), (2, 2, 32), (3, 4, 48)):
            for b in range(batch):
                for block in range(length // 16):
                    for row in range(16):
                        for h in range(heads):
                            for word in range(dim // 2):
                                original = (((b * length + block * 16 + row) * heads + h) * dim + word * 2) * 2
                                viewed = ((((b * (length // 16) + block) * 16 + row) * heads + h) * (dim // 2) + word) * 4
                                assert original == viewed
                                assert 0 <= viewed <= batch * length * heads * dim * 2 - 4
    report = dict(status="PASS", source=source.name,
                  source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(), layouts=records,
                  same_storage_offsets=True, synchronization_calls_unchanged=True)
    output = HERE / "coalesced_words_layouts.json"
    assert not output.exists()
    output.write_text(json.dumps(report, indent=2) + "\n")
    print("PASS: D64/D128 native-word loads, shared stores, byte views and unchanged synchronization")


if __name__ == "__main__":
    main()
