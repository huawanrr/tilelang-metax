"""Stage both K and V once, then write their MMA layouts contiguously."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {"native_sparse_attention_pack_kv", "native_sparse_attention_pack_kv_bs32_direct",
           "native_sparse_attention_pack_kv_bs32_shared"}


def builder(name, nt, k_shared=True):
    extra_layout = """
                packed_k: T.Fragment([BS, D],
                    forward_thread_fn=lambda kj, kd: (((kd // 32 * (BS // 16) + kj // 16) * 64
                        + (kd % 32 // 8) * 16 + kj % 16) % NT),
                    forward_index_fn=lambda kj, kd: (((kd // 32 * (BS // 16) + kj // 16) * 64
                        + (kd % 32 // 8) * 16 + kj % 16) // NT * 8 + kd % 8)),
                k_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(k_shared, vecSize=8),
""" if k_shared else ""
    k_alloc = """
            packed_k = T.alloc_fragment([BS, D], T.float16)
            k_shared = T.alloc_shared([BS, D], T.float16)
""" if k_shared else ""
    k_store = "            T.copy(ktile, k_shared)\n" if k_shared else ""
    k_load = "            T.copy(k_shared, packed_k)\n" if k_shared else ""
    k_reg = "packed_k" if k_shared else "ktile"
    return f'''
@tilelang.jit(pass_configs={{tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True}})
def {name}(batch, seq_len, heads, dim, block_size):
    """Fresh K/V packing with one CTA barrier protecting both transposes."""
    BS, D, NT = block_size, dim, {nt}
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D//32, BS//16, 64, 8], T.float16),
        Packed: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, BS//16, D//32, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads=NT) as (bs, h, b):
            ktile = T.alloc_fragment([BS, D], T.float16)
            tile = T.alloc_fragment([BS, D], T.float16)
            packed_v = T.alloc_fragment([BS, D], T.float16)
            v_shared = T.alloc_shared([BS, D], T.float16)
{k_alloc}
            T.annotate_layout({{
                packed_v: T.Fragment([BS, D],
                    forward_thread_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                        + (pj % 16 // 4) * 16 + pd % 16) % NT),
                    forward_index_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                        + (pj % 16 // 4) * 16 + pd % 16) // NT * 8
                        + (pd % 32 // 16) * 4 + pj % 4)),
                v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=4),
{extra_layout}
            }})
            T.copy(K[b, bs * BS : (bs + 1) * BS, h, :], ktile)
            T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], tile)
{k_store}
            T.copy(tile, v_shared)
            T.sync_threads()
{k_load}
            T.copy(v_shared, packed_v)
            for j, d in T.Parallel(BS, D):
                PackedK[b, bs, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8] = {k_reg}[j, d]
            for j, d in T.Parallel(BS, D):
                Packed[b, bs, h, j // 16, d // 32,
                       (j % 16 // 4) * 16 + d % 16,
                       (d % 32 // 16) * 4 + j % 4] = packed_v[j, d]
    return kernel
'''


def main():
    source = BASE.read_text()
    reports = []
    for name, nt, shared in (("joint_pack128", 128, True), ("joint_pack256", 256, True),
                             ("pack_joint_load256", 256, False)):
        lines = source.splitlines(keepends=True)
        edits = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            edits.append((start, fn.end_lineno, builder(fn.name, nt, shared)))
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"{name}.py"
        with path.open("x") as f:
            f.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            threads=nt, shared_k=shared))
        print(path.name)
    (HERE / "joint_pack_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=reports,
        synchronous_copies=True, explicit_sync="One block barrier after both shared writes",
        attention_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
