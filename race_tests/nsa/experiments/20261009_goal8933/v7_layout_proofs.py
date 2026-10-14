"""Prove complete-block mask equivalence and FP32 MMA lane ownership."""
import hashlib
import json
from pathlib import Path

import z3

HERE = Path(__file__).resolve().parent


def main():
    length, token, block, col = z3.Ints("length token block col")
    causal = z3.Bool("causal")
    domain = [length > 0, length <= 2147483647, length % 16 == 0,
              token >= 0, token < length, block >= -2147483648,
              block <= 2147483647, col >= 0, col < 16]
    valid = z3.And(block >= 0, block < length / 16,
                   z3.Or(z3.Not(causal), block <= token / 16))
    position = block * 16 + col
    original = z3.And(position >= 0, position < length,
                      z3.Or(z3.Not(causal), position <= token))
    boundary_only = z3.If(z3.And(causal, block == token / 16), col <= token % 16, True)
    statements = {
        "complete_block_address_in_bounds_and_no_int32_overflow":
            z3.And(position >= 0, position < length, position <= 2147483647),
        "causal_boundary_only_mask_equivalent": original == boundary_only,
    }
    proofs = {}
    for name, proposition in statements.items():
        solver = z3.Solver()
        solver.add(*domain, valid, z3.Not(proposition))
        result = solver.check()
        assert result == z3.unsat, (name, result, solver.model())
        proofs[name] = str(result)
    a_positions = {(tid % 16, tid // 16) for tid in range(64)}
    assert a_positions == {(row, k) for row in range(16) for k in range(4)}
    c_positions = []
    for tid in range(64):
        row = tid % 16
        for local in range(4):
            col = (tid // 16) * 4 + local
            assert row + (col // 4) * 16 == tid
            c_positions.append((row, col))
        assert row + ((tid // 16)*4 // 4)*16 == tid
    assert len(c_positions) == len(set(c_positions)) == 256
    assert set(c_positions) == {(row, col) for row in range(16) for col in range(16)}
    files = [HERE / "fp32_core.py", HERE / "fp32_mask_post.py", HERE / "small_vfirst.py"]
    result = dict(status="PASS", source_sha256={str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
        proofs=proofs, a_fragment_elements=len(a_positions), c_fragment_elements=len(c_positions),
        constant_one_mma="C[row,col] = sum(A[row,k], k=0..3); lane-owned column is 4*(tid//16)",
        hypothesis="One 64-lane wave, G=16, complete BS16 block validated before address formation",
        precision_evidence=str(HERE / "fp32_sum_numeric.json"))
    with (HERE / "v7_layout_proofs.json").open("x") as f:
        json.dump(result, f, indent=2)
        f.write("\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
