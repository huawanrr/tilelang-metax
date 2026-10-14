"""Representative pack grids and CPU proofs of every disjoint output tile."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    shapes = [
        (4, 256, 1), (2, 512, 1), (1, 1024, 1), (2, 256, 2), (1, 512, 2), (1, 256, 4),
        (3, 512, 1), (1, 1536, 1), (1, 768, 2),
        (8, 256, 1), (4, 512, 1), (2, 1024, 1), (1, 2048, 1),
        (4, 256, 2), (2, 512, 2), (1, 1024, 2), (1, 512, 4),
        (3, 1024, 1), (1, 1536, 2),
        (8, 512, 1), (4, 1024, 1), (2, 2048, 1), (1, 4096, 1),
        (2, 1024, 2), (4, 512, 2), (1, 2048, 2), (1, 1024, 4),
        (8, 1024, 1), (4, 1024, 2), (2, 2048, 2), (8, 1024, 2),
    ]
    cases = {f"pack_b{b}_t{t}_h{h}": dict(B=b, SEQ_LEN=t, H=h, HQ=16*h,
              D=128, S=1, block_size=32, is_causal=True) for b, t, h in shapes}
    for b, t, h in [(4, 1024, 1), (1, 1024, 4), (2, 512, 2)]:
        cases[f"pack_b{b}_t{t}_h{h}_noncausal"] = dict(B=b, SEQ_LEN=t, H=h, HQ=16*h,
            D=128, S=1, block_size=32, is_causal=False)
    with (HERE / "pack_tiling_family_cases.json").open("x") as handle:
        handle.write(json.dumps(cases, indent=2) + "\n")

    proofs = []
    for bs, dim, bj, dd, nt in [(32, 128, 32, 64, 128), (32, 128, 32, 32, 64),
                              (32, 128, 16, 64, 64), (16, 64, 16, 64, 64),
                              (16, 64, 16, 32, 64)]:
        k_offsets, v_offsets = [], []
        nr, nc = bs // bj, dim // dd
        for split in range(nr * nc):
            jb, db = split // nc * bj, split % nc * dd
            k_local, v_local = [], []
            for j in range(bj):
                for d in range(dd):
                    row, col = jb + j, db + d
                    k_lane = col % 32 // 8 * 16 + row % 16
                    v_lane = row % 16 // 4 * 16 + col % 16
                    k_offsets.append(((col // 32 * (bs // 16) + row // 16) * 64 + k_lane) * 8 + col % 8)
                    v_offsets.append(((row // 16 * (dim // 32) + col // 32) * 64 + v_lane) * 8
                                     + col % 32 // 16 * 4 + row % 4)
                    k_packet = (d // 32 * (bj // 16) + j // 16) * 64 + d % 32 // 8 * 16 + j % 16
                    v_packet = (j // 16 * (dd // 32) + d // 32) * 64 + j % 16 // 4 * 16 + d % 16
                    k_local.append((k_packet % nt, k_packet // nt * 8 + d % 8))
                    v_local.append((v_packet % nt, v_packet // nt * 8 + d % 32 // 16 * 4 + j % 4))
            assert len(set(k_local)) == len(set(v_local)) == bj * dd
            assert {tid for tid, _ in k_local} == {tid for tid, _ in v_local} == set(range(nt))
        assert sorted(k_offsets) == sorted(v_offsets) == list(range(bs * dim))
        proofs.append(dict(block_size=bs, dim=dim, tile=[bj, dd], threads=nt,
                           tiles=nr*nc, elements=bs*dim, unique_full_coverage=True,
                           local_thread_index_bijection=True))
    with (HERE / "pack_tiling_cpu_proof.json").open("x") as handle:
        handle.write(json.dumps(dict(proofs=proofs,
            limitation="CPU address proof; generated-device packing and tail behavior still require GPU checks"),
            indent=2) + "\n")
    print(len(cases), "family shapes;", len(proofs), "partition proofs")


if __name__ == "__main__":
    main()
