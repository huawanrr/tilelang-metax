"""Combine register Q/K exchange with the current coalesced Q/O schedule."""
import ast
import hashlib
import json
from pathlib import Path

from register_exchange import exchange, indent


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_d32_v1/nsa.py"
GUARD = ROOT / "experiments/20261002_next/guard_start_local.py"


def once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def function(source, name):
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return "".join(lines[start:node.end_lineno])


def main():
    baseline = BASE.read_text()
    original = function(GUARD.read_text(), "_coalesced_qo_prim")
    wrapper = function(baseline, "native_sparse_attention_coalesced_qo")
    records = []
    for q_shuffle, k_shuffle in ((False, False), (False, True), (True, False), (True, True)):
        additions = []
        for dim in (64, 128):
            name = f"_coalesced_qo_register_d{dim}"
            text = once(original, "def _coalesced_qo_prim(", f"def {name}(")
            text = once(text, "    assert threads == 64 and groups == 16",
                        f"    assert dim == {dim} and block_size == 16\n"
                        "    assert threads == 64 and groups == 16")
            allocations = []
            if q_shuffle:
                alloc, loads, body = exchange("qr", dim, 16, 8, "Q")
                allocations += alloc
                text = once(text, "            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, :], Q_stage)",
                            indent(loads, 12))
                text = once(text, """                T.copy(Q_stage, Q_shared)
                T.sync_warp()
                T.copy(Q_shared, Q_reg)
                T.sync_warp()""", indent(body, 16) + """
                for i, d in T.Parallel(G, BK):
                    Q_reg[i, d] = qr_mma[d // 32 * 8 + d % 8]""")
            if k_shuffle:
                alloc, loads, body = exchange("kr", dim, 16, 8, "K")
                allocations += alloc
                loads = [line.replace("i_s", "_start_buffer_0[0]") for line in loads]
                text = once(text, "                T.copy(K[i_b, _start_buffer_0[0]:_start_buffer_0[0] + BS, i_h, :], K_reg)",
                            indent(loads, 16))
                text = once(text, """                if not direct_k:
                    for j, d in T.Parallel(BS, BK):
                        KV_shared[j * BK + (d // 8 ^ j // KPHASE % KMAX) * 8 + d % 8] = K_reg[j, d]""",
                            indent(body, 16))
                text = once(text, """                if wave_sync:
                    T.sync_warp()
                else:
                    T.sync_threads()
                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)""",
                            "                kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)")
                start = text.index("                for ki in T.serial(qk_steps):")
                end = text.index("                for j, d in T.Parallel(BS, BV):", start)
                text = text[:start] + """                for ki in T.unroll(qk_steps):
                    for e in T.vectorized(8):
                        kb[e] = kr_mma[ki * 8 + e]
                    qk.mma(Q_reg, kb, acc_s, ki)
""" + text[end:]
            if allocations:
                text = once(text, "            _start_buffer_0 = T.alloc_local([1], T.int32)",
                            indent(allocations, 12) + "\n            _start_buffer_0 = T.alloc_local([1], T.int32)")
            additions.append(text)
        replacement = once(wrapper,
            "    return _coalesced_qo_prim(\n",
            "    builder = (_coalesced_qo_register_d64 if dim == 64 else _coalesced_qo_register_d128) if block_size == 16 else _coalesced_qo_prim\n"
            "    return builder(\n")
        result = once(baseline, wrapper, "\n\n".join(additions) + "\n\n" + replacement)
        ast.parse(result)
        path = HERE / f"coalesced_register_q{int(q_shuffle)}k{int(k_shuffle)}.py"
        assert not path.exists(), path
        path.write_text(result)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            q_shuffle=q_shuffle, k_shuffle=k_shuffle,
            barrier_count=sum(text.count("T.sync_warp()") for text in additions)//2))
        print(path.name)
    (HERE / "register_qk_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        guard_primitive_source=str(GUARD.relative_to(ROOT)), guard_primitive_sha256=hashlib.sha256(GUARD.read_bytes()).hexdigest(),
        scope="Only existing coalesced S1/BS16 D64/D128 paths; original defaults and all other paths retained",
        variants=records), indent=2) + "\n")


if __name__ == "__main__":
    main()
