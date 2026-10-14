"""Change operand lifetime and Q/K shared staging on the current BS16 kernel."""
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
    k_load = "                T.copy(K[i_b, _start_buffer_0[0]:_start_buffer_0[0] + BS, i_h, :], K_reg)\n"
    v_load = "                T.copy(V[i_b, _start_buffer_0[0]:_start_buffer_0[0] + BS, i_h, i_v * BV:(i_v + 1) * BV], V_reg)\n"
    q_stage = """                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()
"""
    k_store = """                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]
"""
    pre_qk_sync = """                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)"""
    variants = (
        ("v_late", False, "late", False),
        ("kv_after_q", True, "after_q", False),
        ("k_after_q_v_late", True, "late", False),
        ("qk_parallel", False, "early", True),
        ("qk_parallel_v_late", False, "late", True),
    )
    records = []
    for label, k_late, v_where, parallel_shared in variants:
        part = once(original, "def _coalesced_qo_prim(", "def _coalesced_schedule_prim(")
        after_q = ""
        if k_late:
            part = once(part, k_load, "")
            after_q += k_load
        if v_where != "early":
            part = once(part, v_load, "")
            if v_where == "after_q":
                after_q += v_load
            else:
                part = once(part, "                for j, d in T.Parallel(BS, BV):",
                            v_load + "                for j, d in T.Parallel(BS, BV):")
        if after_q:
            part = once(part, q_stage, q_stage + after_q)
        if parallel_shared:
            # Q and K are simultaneously live: the storage planner must retain
            # distinct regions. One barrier then protects both store-to-read
            # dependencies. Keep K/V WAR and every subsequent V/O dependency.
            part = once(part, k_store, "")
            part = once(part, q_stage, "                T.copy(Q_stage, Q_shared)\n" + k_store +
                        "                T.sync_warp()\n                T.copy(Q_shared, Q_reg)\n")
            part = once(part, pre_qk_sync,
                        "                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)")
        new_wrapper = once(wrapper, "    return _coalesced_qo_prim(\n",
                           "    return _coalesced_schedule_prim(\n")
        result = once(baseline, wrapper, part + "\n\n" + new_wrapper)
        ast.parse(result)
        path = HERE / f"coalesced_{label}.py"
        assert not path.exists(), path
        path.write_text(result)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            k_after_q=k_late, v_load=v_where, parallel_shared=parallel_shared))
        print(path.name)
    (HERE / "coalesced_schedule_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, scope="Existing coalesced S1/BS16 paths; explicit barriers protect all shared dependencies"),
        indent=2) + "\n")


if __name__ == "__main__":
    main()
