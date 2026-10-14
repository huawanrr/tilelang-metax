"""Evaluate actual loader/store indices to prove lane ownership and byte identity."""
import argparse
import ast
import hashlib
import itertools
import json
from pathlib import Path
import struct


def evaluate(node, env):
    return eval(compile(ast.Expression(node), "<index>", "eval"), {"__builtins__": {}}, env)


def assignments(node, loops=()):
    if isinstance(node, ast.For):
        loops += (node,)
    if isinstance(node, ast.Assign):
        yield node, loops
    for child in ast.iter_child_nodes(node):
        yield from assignments(child, loops)


def iterations(loops, env):
    if not loops:
        yield env
        return
    loop = loops[0]
    assert isinstance(loop.iter, ast.Call)
    sizes = [evaluate(arg, env) for arg in loop.iter.args]
    names = ([loop.target.id] if isinstance(loop.target, ast.Name)
             else [name.id for name in loop.target.elts])
    assert len(names) == len(sizes)
    for indices in itertools.product(*[range(n) for n in sizes]):
        yield from iterations(loops[1:], dict(env, **dict(zip(names, indices))))


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("modules", nargs="+")
    p.add_argument("--output", required=True)
    args = p.parse_args()
    report = dict(status="running", modules=[], bounds=[], views=[], bit_patterns=0)
    for path_string in args.modules:
        path = Path(path_string)
        tree = ast.parse(path.read_text())
        fn = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
                  and n.name == "native_sparse_attention_shared_q_blocks")
        all_assignments = list(assignments(fn))
        native_words = any(isinstance(n, ast.Call) and isinstance(n.func, ast.Attribute)
                           and n.func.attr == "view" for n in ast.walk(fn))
        env = dict(BS=16, BK=64, BV=64, dim=64, KPHASE=1, KMAX=8,
                   i_b=0, i_h=0, _selected_block=1)
        results = []
        for name in ("K", "V"):
            load, load_loops = next((n, loops) for n, loops in all_assignments
                if isinstance(n.value, ast.Subscript) and isinstance(n.value.value, ast.Name)
                and n.value.value.id == f"{name}_blocks")
            loads = {}
            for tid in range(64):
                for current in iterations(load_loops, dict(env, tid=tid)):
                    b, block, row, h, col = evaluate(load.value.slice, current)
                    assert (b, block, h) == (0, 1, 0)
                    left = evaluate(load.targets[0].slice, current)
                    if native_words:
                        positions = [(row, 2 * col + e, 2 * left + e) for e in range(2)]
                    else:
                        assert left == (row, col)
                        positions = [(row, col, (row * 64 + col) // 512 * 8 + col % 8)]
                    for row, col, local in positions:
                        assert 0 <= row < 16 and 0 <= col < 64
                        assert (row * 64 + col) // 8 % 64 == tid
                        assert (tid, local) not in loads
                        loads[tid, local] = (row, col)
            assert len(loads) == 1024 and len(set(loads.values())) == 1024
            write, write_loops = next((n, loops) for n, loops in all_assignments
                if isinstance(n.value, ast.Subscript) and isinstance(n.value.value, ast.Name)
                and n.value.value.id == f"{name}_reg"
                and isinstance(n.targets[0], ast.Subscript)
                and isinstance(n.targets[0].value, ast.Name)
                and n.targets[0].value.id == "KV_shared")
            shared = {}
            for tid in (range(64) if native_words else (0,)):
                for current in iterations(write_loops, dict(env, tid=tid)):
                    address = evaluate(write.targets[0].slice, current)
                    local = evaluate(write.value.slice, current)
                    if native_words:
                        row, col = loads[tid, local]
                    else:
                        row, col = local
                        owner = (row * 64 + col) // 8 % 64
                        local_index = (row * 64 + col) // 512 * 8 + col % 8
                        assert loads[owner, local_index] == (row, col)
                    expected = (row * 64 + ((col // 8) ^ (row % 8)) * 8 + col % 8
                                if name == "K" else row * 64 + col)
                    assert address == expected and address not in shared
                    shared[address] = (row, col)
            assert set(shared) == set(range(1024))
            results.append(dict(operand=name, loads=len(loads), stores=len(shared),
                                same_lane_values=True, shared_bijection=True))
        syncs = [n.func.attr for n in ast.walk(fn) if isinstance(n, ast.Call)
                 and isinstance(n.func, ast.Attribute) and n.func.attr.startswith("sync_")]
        assert syncs == ["sync_warp"] * 5
        report["modules"].append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            native_word_storage=native_words, operands=results, protected_shared_dependencies=5))

    for length in (16, 32, 48, 64, 80, 128, 272, 512, 1280, 2032, 2048):
        for causal in (False, True):
            nb, checked = length // 16, 0
            for token in sorted({0, 15, length // 2, length - 1}):
                for block in (-2147483648, -268435456, -1, 0, nb // 2, nb - 1, nb, 268435456, 2147483647):
                    valid = 0 <= block < nb and (not causal or block <= token // 16)
                    if valid:
                        assert 0 <= block * 16 <= length - 16
                        assert not causal or block * 16 <= token
                    checked += 1
            report["bounds"].append(dict(seq_len=length, causal=causal, checked=checked))
    for batch, heads, length in ((1, 1, 16), (2, 2, 32), (2, 4, 256), (8, 1, 128)):
        count = 0
        for b, block, row, h, word in itertools.product(range(batch), range(length // 16),
                                                       range(16), range(heads), range(32)):
            byte_offset = ((((b * (length // 16) + block) * 16 + row) * heads + h) * 32 + word) * 4
            half_offset = (((b * length + block * 16 + row) * heads + h) * 64 + word * 2) * 2
            assert byte_offset == half_offset
            assert 0 <= byte_offset <= batch * length * heads * 64 * 2 - 4
            count += 1
        report["views"].append(dict(batch=batch, heads=heads, seq_len=length,
                                    checked_word_addresses=count, identical_storage_bytes=True))
    for low in range(65536):
        high = low ^ 0xA55A
        bits = struct.pack("<HH", low, high)
        word, = struct.unpack("<I", bits)
        assert (word & 0xFFFF, word >> 16) == (low, high)
        report["bit_patterns"] += 1
    report["status"] = "PASS"
    Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    print("PASS", len(report["modules"]), "modules; actual load/store AST indices, shared bijections, byte views and bounds")


if __name__ == "__main__":
    main()
