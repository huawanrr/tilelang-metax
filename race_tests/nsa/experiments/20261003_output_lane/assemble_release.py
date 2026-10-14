"""Append one measured D32 builder and gate it by the recorded shape domain."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261003_d128_v1/nsa.py"
BUILDER = "native_sparse_attention_d32_output_lane"
PROBE_BUILDER = "native_sparse_attention_d32_shuffle"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def functions(source):
    return {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}


def once(source, old, new):
    assert source.count(old) == 1, old
    return source.replace(old, new)


def condition(config):
    terms = ["d32_defaults", f"grid >= {config['min_grid']}"]
    if config.get("min_seq", 1) > 1:
        terms.append(f"seq_len >= {config['min_seq']}")
    if config.get("complete_blocks_only"):
        terms.append("seq_len % block_size == 0")
    if config.get("causal_only"):
        terms.append("is_causal")
    if config.get("heads") is not None:
        terms.append(f"H in {tuple(config['heads'])!r}")
    return "(" + " and ".join(terms) + ")"


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--output-dir", required=True)
    a = p.parse_args()
    target = Path(a.output_dir).resolve()
    target.mkdir(parents=True, exist_ok=True)
    selection = HERE / "selection.json"
    config = json.loads(selection.read_text())["config"]
    probe = ROOT / config["probe"]
    source, probe_source = BASE.read_text(), probe.read_text()
    node = next(n for n in ast.parse(probe_source).body
        if isinstance(n, ast.FunctionDef) and n.name == PROBE_BUILDER)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    builder = "\n".join(probe_source.splitlines()[start:node.end_lineno])
    builder = once(builder, f"def {PROBE_BUILDER}(", f"def {BUILDER}(")
    result = once(source, "def _get_kernel(\n", builder + "\n\n\ndef _get_kernel(\n")
    result = once(result, "    key = (\n",
        "    # Synchronous output exchange pays off in the measured large-grid domain.\n"
        "    # Validate block numbers before forming K/V element addresses.\n"
        f"    d32_output = {condition(config)}\n\n    key = (\n")
    result = once(result,
        "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks, linear_blocks,",
        "        d32_index_guard, d32_compact, coalesced_blocks, shared_q_blocks, linear_blocks, d32_output,")
    result = once(result, "        if linear_blocks:",
        f"        if d32_output:\n"
        f"            kernel = {BUILDER}(\n"
        "                late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False, **common)\n"
        "        elif linear_blocks:")
    old, new = functions(source), functions(result)
    retained = [name for name in old if name != "_get_kernel"]
    assert len(retained) == 45 and all(old[name] == new[name] for name in retained)
    assert set(new) - set(old) == {BUILDER}
    expected = ast.parse(builder).body[0]
    assert new[BUILDER] == ast.dump(expected)
    dev, sub = target / "nsa.py", target / "submission.py"
    with dev.open("x") as output:
        output.write(result)
    assert not sub.exists()
    subprocess.run([sys.executable, str(ROOT.parent / "moe/strip_comments.py"),
        str(dev), str(sub), "--docstrings"], check=True)
    paths = [BASE, probe, selection, Path(__file__).resolve(), dev, sub]
    report = dict(command=sys.argv, config=config, retained_functions=retained,
        new_functions=[BUILDER], probe_builder=PROBE_BUILDER,
        source_sha256={str(path.relative_to(ROOT)): digest(path) for path in paths},
        user_confirmed_best_score=88.29, official_new_score=None,
        status="assembled; final local validation pending")
    with (target / "assembly.json").open("x") as output:
        output.write(json.dumps(report, indent=2) + "\n")
    print("Assembled", target, "submission SHA256", digest(sub))


if __name__ == "__main__":
    main()
