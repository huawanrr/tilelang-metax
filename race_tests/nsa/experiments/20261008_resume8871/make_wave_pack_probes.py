"""Increase pack CTA count using disjoint tiles confined to one wave."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
BS32 = {"native_sparse_attention_pack_kv_bs32_direct",
        "native_sparse_attention_pack_kv_bs32_shared"}


def builder(name, rows, cols):
    return f'''
@tilelang.jit(pass_configs={{tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True}})
def {name}(batch, seq_len, heads, dim, block_size):
    BS, D, NT = block_size, dim, 64
    BJ, DD = min(BS, {rows}), min(D, {cols})
    NR, NC = BS // BJ, D // DD
    assert BS % BJ == 0 and D % DD == 0 and BJ % 16 == 0 and DD % 32 == 0
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D//32, BS//16, 64, 8], T.float16),
        Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS//16, D//32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS) * NR * NC, heads, batch, threads=NT) as (bx, h, b):
            bs, split = bx // (NR * NC), bx % (NR * NC)
            jbase, dbase = split // NC * BJ, split % NC * DD
            ktile = T.alloc_fragment([BJ, DD], T.float16)
            tile = T.alloc_fragment([BJ, DD], T.float16)
            packed_k = T.alloc_fragment([BJ, DD], T.float16)
            packed_v = T.alloc_fragment([BJ, DD], T.float16)
            k_shared = T.alloc_shared([BJ, DD], T.float16)
            v_shared = T.alloc_shared([BJ, DD], T.float16)
            T.annotate_layout({{
                packed_k: T.Fragment([BJ, DD],
                    forward_thread_fn=lambda kj, kd: (((kd // 32 * (BJ // 16) + kj // 16) * 64
                        + (kd % 32 // 8) * 16 + kj % 16) % NT),
                    forward_index_fn=lambda kj, kd: (((kd // 32 * (BJ // 16) + kj // 16) * 64
                        + (kd % 32 // 8) * 16 + kj % 16) // NT * 8 + kd % 8)),
                packed_v: T.Fragment([BJ, DD],
                    forward_thread_fn=lambda pj, pd: (((pj // 16 * (DD // 32) + pd // 32) * 64
                        + (pj % 16 // 4) * 16 + pd % 16) % NT),
                    forward_index_fn=lambda pj, pd: (((pj // 16 * (DD // 32) + pd // 32) * 64
                        + (pj % 16 // 4) * 16 + pd % 16) // NT * 8
                        + (pd % 32 // 16) * 4 + pj % 4)),
                k_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(k_shared, vecSize=8),
                v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=4),
            }})
            T.copy(K[b, bs * BS + jbase : bs * BS + jbase + BJ, h, dbase : dbase + DD], ktile)
            T.copy(V[b, bs * BS + jbase : bs * BS + jbase + BJ, h, dbase : dbase + DD], tile)
            T.copy(ktile, k_shared)
            T.copy(tile, v_shared)
            T.sync_warp()
            T.copy(k_shared, packed_k)
            T.copy(v_shared, packed_v)
            for j, d in T.Parallel(BJ, DD):
                PackedK[b, bs, h, (dbase + d) // 32, (jbase + j) // 16,
                        ((dbase + d) % 32 // 8) * 16 + (jbase + j) % 16, (dbase + d) % 8] = packed_k[j, d]
            for j, d in T.Parallel(BJ, DD):
                Packed[b, bs, h, (jbase + j) // 16, (dbase + d) // 32,
                       ((jbase + j) % 16 // 4) * 16 + (dbase + d) % 16,
                       ((dbase + d) % 32 // 16) * 4 + (jbase + j) % 4] = packed_v[j, d]
    return kernel
'''


def main():
    source = BASE.read_text()
    reports = []
    variants = [
        ("pack_cols32_w64", BS32, 32, 32),
        ("pack_quads_w64", BS32, 16, 64),
        ("pack_s8_whole_w64", {"native_sparse_attention_pack_kv"}, 16, 64),
        ("pack_s8_cols32_w64", {"native_sparse_attention_pack_kv"}, 16, 32),
    ]
    for name, targets, rows, cols in variants:
        lines = source.splitlines(keepends=True)
        edits = []
        for function in ast.parse(source).body:
            if not isinstance(function, ast.FunctionDef) or function.name not in targets:
                continue
            start = min([function.lineno] + [d.lineno for d in function.decorator_list]) - 1
            edits.append((start, function.end_lineno, builder(function.name, rows, cols)))
        for start, end, value in reversed(edits):
            lines[start:end] = [value]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / (name + ".py")
        with path.open("x") as handle:
            handle.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            maximum_tile=[rows, cols], threads=64, targets=sorted(targets)))
        print(name)
    (HERE / "wave_pack_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), variants=reports, attention_unchanged=True,
        partition="Disjoint row/column tiles, with every packed element written once",
        synchronization="One explicit wave barrier after both shared stores; only one wave per CTA",
        copies="Synchronous T.copy retains tail padding and bounds checks"), indent=2) + "\n")


if __name__ == "__main__":
    main()
