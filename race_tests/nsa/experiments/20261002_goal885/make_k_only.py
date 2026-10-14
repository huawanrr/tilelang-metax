"""Test live K-only packing while preserving coalesced Q/O and linear shared V."""
import ast
import hashlib
import json
from pathlib import Path

from make_register_qk import function, once


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_d32_v1/nsa.py"
GUARD = ROOT / "experiments/20261002_next/guard_start_local.py"


def main():
    baseline = BASE.read_text()
    original = function(GUARD.read_text(), "_coalesced_qo_prim")
    records = []
    for pack_threads, late_v in ((128, False), (128, True), (256, False)):
        prim = once(original, "def _coalesced_qo_prim(", "def _kpacked_coalesced_prim(")
        prim = once(prim, "    late_normalize = False", "    late_normalize = False\n    direct_k = True")
        prim = once(prim, "K: T.Tensor(kv_shape, T.float16)",
                    "K: T.Tensor([batch, T.ceildiv(seq_len, BS), head_kv, BK // 32, BS // 16, 64, 8], T.float16)")
        prim = once(prim, "                T.copy(K[i_b, _start_buffer_0[0]:_start_buffer_0[0] + BS, i_h, :], K_reg)",
                    """                for j, d in T.Parallel(BS, BK):
                    K_reg[j, d] = K[i_b, _selected_block, i_h, d // 32, j // 16,
                        d % 32 // 8 * 16 + j % 16, d % 8]""")
        prim = once(prim, """                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
""", "")
        prim = once(prim, """                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)""",
                    "                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)")
        start = prim.index("                for ki in T.serial(qk_steps):")
        end = prim.index("                for j, d in T.Parallel(BS, BV):", start)
        prim = prim[:start] + """                for ki in T.serial(qk_steps):
                    qk.mma(Q_reg, K_reg, acc_s, ki)
""" + prim[end:]
        if late_v:
            load = "                T.copy(V[i_b, _start_buffer_0[0]:_start_buffer_0[0] + BS, i_h, i_v * BV:(i_v + 1) * BV], V_reg)\n"
            prim = once(prim, load, "")
            prim = once(prim, "                for j, d in T.Parallel(BS, BV):", load + "                for j, d in T.Parallel(BS, BV):")
        pack = f'''
@tilelang.jit
def native_sparse_attention_pack_k_only(batch, seq_len, heads, dim, block_size):
    BS, D = block_size, dim
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        PackedK: T.Tensor([batch, T.ceildiv(seq_len, BS), heads, D // 32, BS // 16, 64, 8], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, BS), heads, batch, threads={pack_threads}) as (bs, h, b):
            tile = T.alloc_fragment([BS, D], T.float16)
            T.copy(K[b, bs * BS:(bs + 1) * BS, h, :], tile)
            for j, d in T.Parallel(BS, D):
                PackedK[b, bs, h, d // 32, j // 16,
                        d % 32 // 8 * 16 + j % 16, d % 8] = tile[j, d]
    return kernel


def _make_kpacked_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    blocks = (seq_len + block_size - 1) // block_size
    shape = (batch, blocks, heads, dim // 32, block_size // 16, 64, 8)
    def run(q, k, v, indices, output):
        packed_k = torch.empty(shape, device=k.device, dtype=k.dtype)
        pack(k, packed_k)
        attention(q, packed_k, v, indices, output)
    return run


@tilelang.jit(pass_configs={{
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
}})
def native_sparse_attention_kpacked_coalesced(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, q_vec=8, pv_width=128,
):
    return _kpacked_coalesced_prim(
        batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
        threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)
'''
        result = once(baseline, "\ndef _get_kernel(", "\n" + prim + "\n" + pack + "\ndef _get_kernel(")
        old = """        elif coalesced_qo:
            builder = native_sparse_attention_coalesced_qo
            kernel = builder(q_vec=4 if qo_four else 8,
                             pv_width=64 if qo_narrow else 128, **common)"""
        new = """        elif coalesced_qo:
            attention = native_sparse_attention_kpacked_coalesced(
                q_vec=4 if qo_four else 8, pv_width=64 if qo_narrow else 128, **common)
            pack = native_sparse_attention_pack_k_only(B, seq_len, H, D, block_size)
            kernel = _make_kpacked_attention(pack, attention, B, seq_len, H, D, block_size)"""
        result = once(result, old, new)
        ast.parse(result)
        path = HERE / f"k_only_t{pack_threads}_late{int(late_v)}.py"
        assert not path.exists(), path
        path.write_text(result)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            pack_threads=pack_threads, late_v=late_v))
        print(path.name)
    (HERE / "k_only_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, scope="Existing coalesced S1/BS16 paths only; every call repacks live K; V remains unmodified"),
        indent=2) + "\n")


if __name__ == "__main__":
    main()
