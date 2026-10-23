"""Recompare existing complete-block S1 builders on the current v13 baseline."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    source = (HERE / "baseline.py").read_text()
    marker = "        if preload_direct:\n"
    assert source.count(marker) == 1
    builders = {
        "direct": "native_sparse_attention_direct_kv(natural=True, late=False, **common)",
        "preload": "native_sparse_attention_q_preload(natural=True, late=False, **common)",
        "coalesced": "native_sparse_attention_coalesced_blocks_oct8(q_vec=8, pv_width=128, **common)",
        "boundary_q8": "native_sparse_attention_coalesced_blocks_boundary_v8(q_vec=8, pv_width=128, **common)",
        "boundary_q4": "native_sparse_attention_coalesced_blocks_boundary_v8(q_vec=4, pv_width=128, **common)",
        "fp32_sum": "native_sparse_attention_coalesced_blocks_fp32_sum(q_vec=8, pv_width=128, **common)",
    }
    rows = []
    before = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    for name, call in builders.items():
        insertion = f"""        if mathcast_defaults and S == 1 and block_size == 16 and groups == 16 and seq_len % 16 == 0 and D in (64, 128) and grid <= 2560:
            kernel = {call}
        elif preload_direct:
"""
        result = source.replace(marker, insertion, 1)
        after = {n.name: ast.dump(n) for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert before.keys() == after.keys()
        assert [k for k in before if before[k] != after[k]] == ["_get_kernel"]
        path = HERE / f"dispatch_{name}.py"
        with path.open("x") as out:
            out.write(result)
        rows.append(dict(path=path.name, builder=call, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "dispatch_manifest.json").open("x") as out:
        json.dump(dict(baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=rows,
                       all_builders_unchanged=True,
                       scope="default complete S1 BS16 D64/D128 G16 grid<=2560"), out, indent=2)
        out.write("\n")
    cases = json.loads((HERE / "cases.json").read_text())
    for d, t in ((64, 256), (128, 128), (128, 192), (128, 384), (128, 512), (128, 768)):
        cases[f"s1_d{d}_t{t}"] = dict(B=1, SEQ_LEN=t, H=1, HQ=16, D=d, S=1,
                                       block_size=16, is_causal=True)
    (HERE / "dispatch_cases.json").write_text(json.dumps(cases, indent=2) + "\n")
    print("Generated", len(rows), "existing-builder dispatch probes")


if __name__ == "__main__":
    main()
