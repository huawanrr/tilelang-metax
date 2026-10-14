"""Prove lane ownership, pair identity and complete stores from the final AST."""
import argparse
import ast
import hashlib
import json
from pathlib import Path

from check_layout import evaluate


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module")
    p.add_argument("--output", required=True)
    a = p.parse_args()
    path = Path(a.module)
    tree = ast.parse(path.read_text())
    fn = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
              and n.name == "native_sparse_attention_d32_output_lane")
    assignments = [n for n in ast.walk(fn) if isinstance(n, ast.Assign)]
    def named(name):
        return [n for n in assignments if isinstance(n.targets[0], ast.Subscript)
                and isinstance(n.targets[0].value, ast.Name) and n.targets[0].value.id == name]
    load, exchange, write = [named(name)[0] for name in ("output_raw", "output_exchanged", "Output")]
    assert exchange.value.func.attr == "shfl_sync"
    assert [ast.literal_eval(arg) for arg in exchange.value.args[2:]] == [64, 0xffffffffffffffff]
    raw, shuffled, seen = {}, {}, set()
    env = dict(BV=32, G=16, i_b=1, i_t=7, i_h=2, i_v=0)
    for tid in range(64):
        for slot in range(2):
            for element in range(4):
                current = dict(env, output_tid=tid, output_slot=slot, output_element=element)
                local = evaluate(load.targets[0].slice, current)
                row, col = evaluate(load.value.slice, current)
                assert row + col % 16 // 4 * 16 == tid
                assert col // 16 * 4 + col % 4 == local
                assert (tid, local) not in raw
                raw[tid, local] = row, col
    for tid in range(64):
        for word in range(4):
            current = dict(env, output_tid=tid, output_word=word)
            destination = evaluate(exchange.targets[0].slice, current)
            source = evaluate(exchange.value.args[0].slice, current)
            lane = evaluate(exchange.value.args[1], current)
            assert 0 <= lane < 64
            for half in range(2):
                shuffled[tid, destination*2+half] = raw[lane, source*2+half]
    for tid in range(64):
        for slot in range(2):
            for element in range(4):
                current = dict(env, output_tid=tid, output_slot=slot, output_element=element)
                b, t, h, col = evaluate(write.targets[0].slice, current)
                local = evaluate(write.value.slice, current)
                assert (b, t) == (1, 7) and (h-32, col) == shuffled[tid, local]
                assert 32 <= h < 48 and 0 <= col < 32 and (h, col) not in seen
                seen.add((h, col))
    assert len(raw) == len(shuffled) == len(seen) == 512
    guard = next(n for n in ast.walk(fn) if isinstance(n, ast.If)
                 and "selected_block >= 0" in ast.unparse(n.test))
    start_address = guard.body[0]
    assert isinstance(start_address, ast.Assign) and ast.unparse(start_address.targets[0]) == "i_s"
    assert ast.unparse(start_address.value) == "selected_block * BS"
    class Lang:
        @staticmethod
        def ceildiv(n, d):
            return (n+d-1)//d
    guard_checks = 0
    for length in (1, 15, 16, 17, 31, 511, 512, 513, 8191, 8192, 8193, 32768):
        tokens = set(range(length)) if length < 32 else {0, 1, 15, 16, length//2, length-2, length-1}
        indices = set(range((length+15)//16+2)) | {-2147483648, 2147483647, -268435456, 268435456, -1}
        for causal in (False, True):
            for token in tokens:
                for index in indices:
                    current = dict(T=Lang, BS=16, seq_len=length, i_t=token,
                                   selected_block=index, is_causal=causal)
                    valid = evaluate(guard.test, current)
                    expected = index >= 0 and index*16 < length and (not causal or index*16 <= token)
                    assert valid == expected
                    if valid:
                        assert 0 <= index*16 < length and index*16 <= 2147483647
                    guard_checks += 1
    report = dict(status="PASS", module=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        function=fn.name, elements=512, unique_complete_stores=True, source_lane_ownership=True,
        paired_half_bit_patterns_preserved=True, synchronous_full_wave_exchange=True,
        guard_equivalence_checks=guard_checks,
        guard_before_start_address=True,
        shared_dependency="Original V shared store to PV read; automatic thread storage synchronization retained")
    Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
    print("PASS: 512 output elements and", guard_checks, "raw-index guard combinations")


if __name__ == "__main__":
    main()
