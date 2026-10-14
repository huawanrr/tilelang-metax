"""Expose aligned K/V block bounds using same-storage TileLang buffer views."""
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
    wrapper = function(baseline, "native_sparse_attention_coalesced_qo")
    k_load = "                T.copy(K[i_b, _start_buffer_0[0]:_start_buffer_0[0] + BS, i_h, :], K_reg)"
    v_load = "                T.copy(V[i_b, _start_buffer_0[0]:_start_buffer_0[0] + BS, i_h, i_v * BV:(i_v + 1) * BV], V_reg)"
    records = []
    for label, scalar, fused in (("local", False, False), ("scalar", True, False),
                                  ("fused", False, True)):
        part = once(original, "def _coalesced_qo_prim(", "def _coalesced_block_view_prim(")
        part = once(part, "    assert threads == 64 and groups == 16",
                    "    assert seq_len % block_size == 0\n"
                    "    assert threads == 64 and groups == 16")
        part = once(part, "            _start_buffer_0 = T.alloc_local([1], T.int32)",
                    "            K_blocks = T.reshape(K, [batch, seq_len // BS, BS, head_kv, dim])\n"
                    "            V_blocks = T.reshape(V, [batch, seq_len // BS, BS, head_kv, dim])\n"
                    "            _start_buffer_0 = T.alloc_local([1], T.int32)")
        if fused:
            part = once(part, k_load + "\n" + v_load,
                        "                for j, d in T.Parallel(BS, BK):\n"
                        "                    K_reg[j, d] = K_blocks[i_b, _selected_block, j, i_h, d]\n"
                        "                    V_reg[j, d] = V_blocks[i_b, _selected_block, j, i_h, d]")
        else:
            part = once(part, k_load,
                        "                T.copy(K_blocks[i_b, _selected_block, :, i_h, :], K_reg)")
            part = once(part, v_load,
                        "                T.copy(V_blocks[i_b, _selected_block, :, i_h, i_v * BV:(i_v + 1) * BV], V_reg)")
        if scalar:
            part = once(part, "            _start_buffer_0 = T.alloc_local([1], T.int32)\n", "")
            assert part.count("_start_buffer_0[0]") > 1
            part = part.replace("_start_buffer_0[0]", "_selected_start")
        new_wrapper = once(wrapper, "    return _coalesced_qo_prim(\n",
                           "    builder = _coalesced_block_view_prim if seq_len % block_size == 0 else _coalesced_qo_prim\n"
                           "    return builder(\n")
        result = once(baseline, wrapper, part + "\n\n" + new_wrapper)
        ast.parse(result)
        path = HERE / f"coalesced_block_view_{label}.py"
        assert not path.exists(), path
        path.write_text(result)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            scalar_start=scalar, fused_kv_load=fused))
        print(path.name)
    (HERE / "block_view_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records,
        scope="Existing coalesced paths with complete blocks only; T.reshape shares original storage; bounds checks remain enabled"),
        indent=2) + "\n")


if __name__ == "__main__":
    main()
