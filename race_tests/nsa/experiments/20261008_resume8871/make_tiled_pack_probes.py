"""Split each BS32 pack block into two independent shared-memory tiles."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {"native_sparse_attention_pack_kv_bs32_direct", "native_sparse_attention_pack_kv_bs32_shared"}


def builder(name, axis):
    bj, dd = (16,128) if axis == "rows" else (32,64)
    offsets = "jbase, dbase = (split * BJ, 0)" if axis == "rows" else "jbase, dbase = (0, split * DD)"
    return f'''
@tilelang.jit(pass_configs={{tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True}})
def {name}(batch, seq_len, heads, dim, block_size):
    assert dim == 128 and block_size == 32
    BS, D, NT, BJ, DD = block_size, dim, 128, {bj}, {dd}
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D//32, BS//16, 64, 8], T.float16),
        Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS//16, D//32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS) * 2, heads, batch, threads=NT) as (bx, h, b):
            bs, split = (bx // 2, bx % 2)
            {offsets}
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
            T.sync_threads()
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
    for axis in ("rows", "cols"):
        lines = source.splitlines(keepends=True)
        edits = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            edits.append((start, fn.end_lineno, builder(fn.name, axis)))
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"pack_tiles_{axis}.py"
        with path.open("x") as f:
            f.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            split_axis=axis, threads_per_cta=128, tiles_per_input_block=2))
        print(path.name)
    (HERE / "tiled_pack_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=reports,
        partition="Disjoint halves of BS32 x D128, full destination coverage",
        copies="Synchronous copies retain partial-row zero filling",
        shared_sync="One CTA RAW barrier after both shared writes", attention_unchanged=True,
        safety_passes_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
