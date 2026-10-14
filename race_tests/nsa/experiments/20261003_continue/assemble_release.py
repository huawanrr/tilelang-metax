"""Assemble the selected D128 domains while preserving all published builders."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def once(source, old, new):
    assert source.count(old) == 1, old
    return source.replace(old, new)


def functions(source):
    return {node.name: ast.dump(node) for node in ast.parse(source).body if isinstance(node, ast.FunctionDef)}


def condition(domain):
    head = "" if domain["heads"] is None else " and H in " + repr(tuple(domain["heads"]))
    return (f"({domain['min_grid']} <= grid < {domain['max_grid_exclusive']}"
            f" and seq_len >= {domain['min_seq']}" + head + ")")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    directory = Path(args.output_dir).resolve()
    directory.mkdir(parents=True, exist_ok=True)
    dev, sub = directory / "nsa.py", directory / "submission.py"
    assert not dev.exists() and not sub.exists()
    selection = json.loads((HERE / "selection.json").read_text())
    config = selection["config"]
    assert config["linear"]["enabled"] and config["coalesced"]["enabled"]
    source = BASE.read_text()
    probe = ROOT / config["linear"]["probe"]
    probe_source = probe.read_text()
    node = next(node for node in ast.parse(probe_source).body
                if isinstance(node, ast.FunctionDef) and node.name == "native_sparse_attention_linear_v_blocks")
    start = min([node.lineno] + [item.lineno for item in node.decorator_list]) - 1
    builder = "\n".join(probe_source.splitlines()[start:node.end_lineno])
    result = once(source, "def _get_kernel(\n", builder + "\n\n\ndef _get_kernel(\n")
    dispatch = f'''    # Complete D128 blocks retain direct Q/O below the measured crossover.
    # Larger launches reuse the existing coalesced complete-block builder.
    d128_block_defaults = (qo_defaults and D == 128 and block_size == 16
        and seq_len % block_size == 0 and pair_resolved == 1 and num_stages == 1
        and online_unroll == 2 and not late_normalize)
    linear_blocks = d128_block_defaults and {condition(config["linear"])}
    d128_mid_coalesced = d128_block_defaults and {condition(config["coalesced"])}
    if d128_mid_coalesced:
        coalesced_qo = True
        coalesced_blocks = True

'''
    result = once(result, "    key = (\n", dispatch + "    key = (\n")
    result = once(result, "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks,",
        "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks, linear_blocks,")
    result = once(result, "        if d32_compact:", """        if linear_blocks:
            kernel = native_sparse_attention_linear_v_blocks(
                late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)
        elif d32_compact:""")
    before, after = functions(source), functions(result)
    retained = [name for name in before if name != "_get_kernel"]
    assert len(retained) == 44 and all(before[name] == after[name] for name in retained)
    assert set(after) - set(before) == {"native_sparse_attention_linear_v_blocks"}
    assert after["native_sparse_attention_linear_v_blocks"] == functions(probe_source)["native_sparse_attention_linear_v_blocks"]
    dev.write_text(result)
    subprocess.run([sys.executable, str(ROOT.parent / "moe/strip_comments.py"),
                    str(dev), str(sub), "--docstrings"],check=True)
    paths = [BASE, probe, ROOT / config["coalesced"]["probe"], HERE / "selection.json",
             Path(__file__).resolve(), dev, sub]
    report = dict(command=sys.argv, config=config, retained_functions=retained,
        new_functions=["native_sparse_attention_linear_v_blocks"],
        source_sha256={str(path.relative_to(ROOT)):digest(path) for path in paths},
        baseline_official_score=88.29, target_official_score=88.5, new_official_score=None,
        status="assembled; final local validation pending")
    (directory / "assembly.json").write_text(json.dumps(report,indent=2)+"\n")
    print("Assembled",directory,"submission SHA256",digest(sub))


if __name__ == "__main__":
    main()
