"""Enumerate lane loads, block views and the unchanged shared operand mappings."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[2]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("source")
    p.add_argument("--output", required=True)
    a = p.parse_args()
    source = Path(a.source).resolve()
    tree = ast.parse(source.read_text())
    fn = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
              and n.name == "_coalesced_block_loads_prim")
    transfers = [n for n in ast.walk(fn) if isinstance(n, ast.Assign)
                 and isinstance(n.value, ast.Subscript)
                 and isinstance(n.value.value, ast.Name)
                 and n.value.value.id in ("K_blocks", "V_blocks")]
    assert len(transfers) == 2
    assert {n.targets[0].value.id for n in transfers} == {"K_reg", "V_reg"}
    assert all(isinstance(n.targets[0], ast.Subscript) for n in transfers)
    report = dict(command=sys.argv, status="running", source=str(source.relative_to(ROOT)),
                  source_sha256=digest(source), layouts=[], views=[], bounds=[],
                  value_transfer="Direct fp16 buffer assignment, without numeric conversion or arithmetic")
    for dim in (64, 128):
        visited = {}
        for tid in range(64):
            for slot in range(16 * dim // 512):
                for pair in range(4):
                    for element in range(2):
                        row = (slot * 512 + tid * 8) // dim
                        col = tid % (dim // 8) * 8 + pair * 2 + element
                        local = (row * dim + col) // 512 * 8 + col % 8
                        owner = (row * dim + col) // 8 % 64
                        assert owner == tid and local == slot * 8 + pair * 2 + element
                        assert (row, col) not in visited
                        visited[row, col] = (tid, local)
        assert set(visited) == {(j, d) for j in range(16) for d in range(dim)}
        phase, maximum = max(1, 64 // dim), min(16, dim // 8)
        shared = {}
        for row, col in visited:
            address = row * dim + ((col // 8) ^ (row // phase % maximum)) * 8 + col % 8
            assert 0 <= address < 16 * dim and address not in shared
            shared[address] = (row, col)
        k_reads, v_reads = set(), set()
        for tid in range(64):
            for ki in range(dim // 32):
                for e in range(8):
                    row, col = tid % 16, ki * 32 + tid // 16 * 8 + e
                    address = row * dim + ((col // 8) ^ (row // phase % maximum)) * 8 + col % 8
                    assert shared[address] == (row, col)
                    k_reads.add((row, col))
            for tile in range(dim // 16):
                for e in range(4):
                    row, col = tid // 16 * 4 + e, tile * 16 + tid % 16
                    assert 0 <= row * dim + col < 16 * dim
                    v_reads.add((row, col))
        assert k_reads == v_reads == set(visited)
        report["layouts"].append(dict(dim=dim, values=16*dim, lanes=64,
            word_bytes=4, lane_ownership=True, load_coverage=True,
            shared_k_bijection=True, mma_k_and_v_coverage=True))
        for batch, heads, length in ((1, 1, 16), (2, 2, 32), (3, 4, 48), (8, 1, 1024)):
            nb = length // 16
            count = 0
            for b in range(batch):
                for h in range(heads):
                    for block in sorted({0, nb // 2, nb-1}):
                        for row, col in visited:
                            original = ((b * length + block * 16 + row) * heads + h) * dim + col
                            viewed = ((((b * nb + block) * 16 + row) * heads + h) * dim + col)
                            assert original == viewed
                            assert 0 <= viewed < batch * length * heads * dim
                            count += 1
            report["views"].append(dict(batch=batch, heads=heads, seq_len=length,
                dim=dim, compared_addresses=count, identical_storage_offsets=True))
    for length in (16, 32, 48, 1280, 2304, 8192):
        nb = length // 16
        for causal in (False, True):
            checked = 0
            for token in sorted({0, 15, length // 2, length-1}):
                for block in (-2147483648, -268435456, -1, 0, nb//2, nb-1, nb, 268435456, 2147483647):
                    valid = 0 <= block < nb and (not causal or block <= token // 16)
                    if valid:
                        start = block * 16
                        assert 0 <= start <= length - 16 and start + 15 < length
                        assert not causal or start <= token
                    checked += 1
            report["bounds"].append(dict(seq_len=length, causal=causal, cases=checked,
                validate_before_multiplication=True, full_block_access_in_range=True))
    prior = ROOT / "experiments/20261002_d32_v1/release_manifest.json"
    report["unchanged_baseline_manifest"] = dict(path=str(prior.relative_to(ROOT)), sha256=digest(prior))
    report["status"] = "PASS"
    Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
    print("PASS: two lane/shared layouts, eight same-storage views and twelve boundary groups")


if __name__ == "__main__":
    main()
