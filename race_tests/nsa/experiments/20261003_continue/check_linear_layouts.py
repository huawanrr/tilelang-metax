"""Check actual D128 loader/store AST indices and unchanged shared dependencies."""
import argparse
import ast
import hashlib
import itertools
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


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


def get_function(path, name):
    return next(node for node in ast.parse(path.read_text()).body
                if isinstance(node, ast.FunctionDef) and node.name == name)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("modules", nargs="+")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    parent_path = ROOT / "experiments/20261002_mid_v1/nsa.py"
    parent = get_function(parent_path, "native_sparse_attention_single_linear_v_wave")
    parent_layout = next(node.value for node, _ in assignments(parent)
        if any(isinstance(target, ast.Name) and target.id == "_layout" for target in node.targets))
    report = dict(status="running", parent=str(parent_path.relative_to(ROOT)),
        parent_sha256=hashlib.sha256(parent_path.read_bytes()).hexdigest(), modules=[], views=[])
    for name in args.modules:
        path = Path(name)
        fn = get_function(path, "native_sparse_attention_linear_v_blocks")
        all_assignments = list(assignments(fn))
        layout = next(node.value for node, _ in all_assignments
            if any(isinstance(target, ast.Name) and target.id == "_layout" for target in node.targets))
        assert ast.dump(layout) == ast.dump(parent_layout)
        env = dict(BS=16, BK=128, BV=128, dim=128, KPHASE=1, KMAX=16,
                   i_b=0, i_h=0, _selected_block=1)
        operands = []
        for operand in ("K", "V"):
            load, load_loops = next((node, loops) for node, loops in all_assignments
                if isinstance(node.value, ast.Subscript) and isinstance(node.value.value, ast.Name)
                and node.value.value.id == f"{operand}_blocks")
            width = evaluate(load_loops[-1].iter.args[0], env)
            assert width in (2, 4) and load_loops[-1].iter.func.attr == "vectorized"
            loads = {}
            for tid in range(64):
                for current in iterations(load_loops, dict(env, tid=tid)):
                    b, block, row, h, col = evaluate(load.value.slice, current)
                    assert (b, block, h) == (0, 1, 0)
                    assert evaluate(load.targets[0].slice, current) == (row, col)
                    local = (row * 128 + col) // 512 * 8 + col % 8
                    assert 0 <= row < 16 and 0 <= col < 128
                    assert (row * 128 + col) // 8 % 64 == tid
                    assert (tid, local) not in loads
                    loads[tid, local] = (row, col)
            assert len(loads) == len(set(loads.values())) == 2048
            write, write_loops = next((node, loops) for node, loops in all_assignments
                if isinstance(node.value, ast.Subscript) and isinstance(node.value.value, ast.Name)
                and node.value.value.id == f"{operand}_reg"
                and isinstance(node.targets[0], ast.Subscript)
                and isinstance(node.targets[0].value, ast.Name)
                and node.targets[0].value.id == "KV_shared")
            shared = {}
            for current in iterations(write_loops, env):
                address = evaluate(write.targets[0].slice, current)
                row, col = evaluate(write.value.slice, current)
                owner = (row * 128 + col) // 8 % 64
                local = (row * 128 + col) // 512 * 8 + col % 8
                assert loads[owner, local] == (row, col)
                expected = (row * 128 + ((col // 8) ^ row) * 8 + col % 8
                            if operand == "K" else row * 128 + col)
                assert address == expected and address not in shared
                shared[address] = (row, col)
            assert set(shared) == set(range(2048))
            operands.append(dict(operand=operand, elements_per_load=width, loads=len(loads),
                stores=len(shared), same_lane_values=True, shared_bijection=True))
        syncs = [node.func.attr for node in ast.walk(fn) if isinstance(node, ast.Call)
                 and isinstance(node.func, ast.Attribute) and node.func.attr.startswith("sync_")]
        assert syncs == ["sync_warp"] * 3
        guard = next(node.test for node in ast.walk(fn) if isinstance(node, ast.If)
                     and "_selected_block" in ast.unparse(node.test))
        bound_count = 0
        for length, causal in itertools.product((16, 32, 64, 128, 256, 512, 1024, 1264, 1280), (False, True)):
            for token in sorted({0, 15, length // 2, length - 1}):
                for block in (-2147483648, -268435456, -1, 0, length // 32,
                              length // 16 - 1, length // 16, 268435456, 2147483647):
                    valid = evaluate(guard, dict(env, seq_len=length, is_causal=causal,
                                                 i_t=token, _selected_block=block))
                    assert valid == (0 <= block < length // 16 and (not causal or block * 16 <= token))
                    if valid:
                        assert 0 <= block * 16 <= length - 16
                    bound_count += 1
        report["modules"].append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            operands=operands, preserved_fragment_layouts=True, protected_shared_dependencies=3,
            checked_guard_combinations=bound_count))
    for batch, heads, length in ((1, 1, 16), (2, 2, 32), (2, 4, 256), (8, 1, 128)):
        count = 0
        for b, block, row, h, col in itertools.product(range(batch), range(length // 16),
                range(16), range(heads), range(128)):
            view = ((((b * (length // 16) + block) * 16 + row) * heads + h) * 128 + col) * 2
            original = (((b * length + block * 16 + row) * heads + h) * 128 + col) * 2
            assert view == original and 0 <= view <= batch * length * heads * 128 * 2 - 2
            count += 1
        report["views"].append(dict(batch=batch, heads=heads, seq_len=length,
            checked_half_addresses=count, identical_storage_bytes=True))
    report["status"] = "PASS"
    Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    print("PASS", len(report["modules"]), "modules; actual load/store indices, guard bounds and shared layouts")


if __name__ == "__main__":
    main()
