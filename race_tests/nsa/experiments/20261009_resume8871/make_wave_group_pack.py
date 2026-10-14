"""Group two/four independent pack waves; prove ownership before GPU tests."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261008_resume8871/candidate_v6.py"


def prove(wr, wc):
    bj, dd, nt = 16 * wr, 64 * wc, 64 * wr * wc
    maps = {key: set() for key in ("input", "k", "v", "shared_k", "shared_v", "output_k", "output_v")}
    for tile in range(4 // (wr * wc)):
        jbase, dbase = tile // (128 // dd) * bj, tile % (128 // dd) * dd
        for j in range(bj):
            for d in range(dd):
                wave = j // 16 * wc + d // 64
                inp = (wave * 64 + (j % 16 * 64 + d % 64) // 8 % 64, (j % 16 * 64 + d % 64) // 512 * 8 + d % 8)
                pk = (wave * 64 + d % 32 // 8 * 16 + j % 16, d % 64 // 32 * 8 + d % 8)
                pv = (wave * 64 + j % 16 // 4 * 16 + d % 16, d % 64 // 32 * 8 + d % 32 // 16 * 4 + j % 4)
                ks = wave * 1024 + j % 16 * 64 + (d % 64 // 8 ^ j % 8) * 8 + d % 8
                vs = wave * 1024 + j % 16 * 64 + (d % 64 // 4 ^ j % 16) * 4 + d % 4
                assert all(x[0] // 64 == wave and 0 <= x[0] < nt and 0 <= x[1] < 16 for x in (inp, pk, pv))
                assert ks // 1024 == vs // 1024 == wave
                jj, dx = jbase + j, dbase + d
                ko = (dx // 32, jj // 16, dx % 32 // 8 * 16 + jj % 16, dx % 8)
                vo = (jj // 16, dx // 32, jj % 16 // 4 * 16 + dx % 16, dx % 32 // 16 * 4 + jj % 4)
                for key, val in zip(maps, (inp, pk, pv, ks, vs, ko, vo)):
                    address = val if key.startswith("output") else (tile, val)
                    assert address not in maps[key], (key, address)
                    maps[key].add(address)
    assert all(len(values) == 4096 for values in maps.values())
    return dict(row_waves=wr, column_waves=wc, threads=nt, elements=4096,
                bijections=True, same_wave_shared_dependencies=True, unique_output_writes=True)


def main():
    source = BASE.read_text()
    template = (HERE / "wave_pair_pack_template.py").read_text()
    records = []
    for mode, (wr, wc) in enumerate(((1, 2), (2, 1), (2, 2))):
        proof = prove(wr, wc)
        builder = template.replace("mode=0):", f"mode={mode}):", 1)
        result = source.replace("def _get_kernel(\n", builder + "\n\ndef _get_kernel(\n", 1)
        old = "pack_builder = (native_sparse_attention_pack_kv_bs32_tiles if tiled_pack else"
        new = "pack_builder = (native_sparse_attention_pack_kv_bs32_wave_groups if tiled_pack else"
        assert result.count(old) == 1
        result = result.replace(old, new)
        ast.parse(result)
        path = HERE / f"pack_wave_groups{wr}x{wc}.py"
        with path.open("x") as handle:
            handle.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(), proof=proof))
    (HERE / "wave_group_pack_manifest.json").write_text(json.dumps(dict(
        base=str(BASE), base_sha256=hashlib.sha256(source.encode()).hexdigest(), candidates=records,
        status="CPU ownership proved; GPU checks and timing pending"), indent=2) + "\n")


if __name__ == "__main__":
    main()
