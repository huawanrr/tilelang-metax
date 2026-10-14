"""Local-only shared imports for tuning existing builders with less startup work."""
import importlib.util
from pathlib import Path

_spec = importlib.util.spec_from_file_location('nsa_probe_baseline', Path(__file__).with_name('baseline.py'))
BASE = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(BASE)
CACHE = {}


def kernel(kind, first, second, B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None, **options):
    shape = (B, seq_len, H, HQ, D, S, block_size, is_causal, scale)
    if options or HQ != H * 16:
        return BASE._get_kernel(*shape, **options)
    selected = ((kind == 'single' and S == 1 and D == 128 and block_size == 32 and B * H * seq_len >= 1024)
                or (kind == 'online' and S == 8 and D == 64 and block_size == 16 and B * H * seq_len >= 4096))
    if not selected:
        return BASE._get_kernel(*shape)
    key = (kind, first, second, shape)
    if key not in CACHE:
        common = dict(batch=B, heads=HQ, seq_len=seq_len, dim=D, is_causal=is_causal,
                      block_size=block_size, groups=16,
                      scale_log2=(D ** -0.5 if scale is None else float(scale)) * 1.44269504,
                      threads=64)
        if kind == 'single':
            attention = BASE.native_sparse_attention_single_packed_qo_v2_mathcast(
                width=first, late=bool(second), **common)
            pack_builder = (BASE.native_sparse_attention_pack_kv_bs32_direct
                            if H == 1 and seq_len >= 64 and B * H * seq_len < 4096
                            else BASE.native_sparse_attention_pack_kv_bs32_shared)
            pack = pack_builder(B, seq_len, H, D, block_size)
        else:
            builder = (BASE.native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast
                       if first == 4 else BASE.native_sparse_attention_online_packed_batch_minor_o_v2_mathcast)
            attention = builder(selected_blocks=S, online_unroll=2, dual_acc=first > 1,
                                prefetch_depth=second, **common)
            pack = BASE.native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
        CACHE[key] = BASE._make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
    return CACHE[key]
