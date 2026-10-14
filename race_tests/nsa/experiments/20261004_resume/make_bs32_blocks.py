"""Extend the guarded pair-load mechanism to complete BS32 blocks."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"
NAME = "_coalesced_block_loads_prim"


def once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def main():
    source = BASE.read_text()
    lines = source.splitlines(keepends=True)
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
    template = "".join(lines[node.lineno - 1:node.end_lineno])
    template = once(template, f"def {NAME}(", "def _bs32_pair_loads_prim(")
    template = once(template, "assert block_size == 16 and seq_len % block_size == 0",
                    "assert block_size == 32 and seq_len % block_size == 0")
    builder = '''

@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
})
def native_sparse_attention_bs32_pair_loads(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, q_vec=8, pv_width=128,
):
    return _bs32_pair_loads_prim(
        batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
        threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)

'''
    prefix = source[:source.index("def _get_kernel(")]
    tail = source[source.index("def _get_kernel("):]
    records = []
    for q_width, pv_width in ((8, 128), (4, 128), (8, 64), (4, 64)):
        dispatch = once(tail, "        elif packed_qo:\n", f"""        elif packed_qo and seq_len % block_size == 0:
            kernel = native_sparse_attention_bs32_pair_loads(q_vec={q_width}, pv_width={pv_width}, **common)
        elif packed_qo:
""")
        result = prefix + template + "\n" + builder + dispatch
        ast.parse(result)
        path = HERE / f"bs32_blocks_q{q_width}_pv{pv_width}.py"
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            q_width=q_width, pv_width=pv_width))
    original = {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    for record in records:
        current = {n.name: ast.dump(n) for n in ast.parse((ROOT / record["path"]).read_text()).body if isinstance(n, ast.FunctionDef)}
        assert all(original[n] == current[n] for n in original if n != "_get_kernel")
    with (HERE / "bs32_blocks_assembly.json").open("x") as f:
        f.write(json.dumps(dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
                               variants=records, unchanged_old_builders=True,
                               mechanism="Same-storage complete-block view and explicit uint32 K/V loads, extended from BS16 to BS32",
                               selected_scope="Original packed S1/D128/BS32 route, seq_len divisible by BS32",
                               synchronization="Seven explicit wave RAW/WAR barriers retained", no_pack_launch=True), indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
