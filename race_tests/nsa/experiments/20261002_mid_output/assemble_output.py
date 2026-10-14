"""Integrate the measured crossover while preserving every kernel builder."""
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
PROBE = HERE / "coalesced_ge2048.py"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def functions(source):
    return {node.name: ast.dump(node) for node in ast.parse(source).body if isinstance(node, ast.FunctionDef)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    directory = Path(args.output_dir).resolve()
    directory.mkdir(parents=True, exist_ok=True)
    dev, sub = directory / "nsa.py", directory / "submission.py"
    assert not dev.exists() and not sub.exists()
    source = PROBE.read_text()
    old = "    medium_coalesced = (qo_defaults"
    assert source.count(old) == 1
    source = source.replace(old,
        "    # The complete-block Q/O builder also pays off on single-KV-head\n"
        "    # launches from 2048 CTAs. Smaller launches keep direct output.\n" + old)
    before, after = functions(BASE.read_text()), functions(source)
    retained = [name for name in before if name != "_get_kernel"]
    assert set(before) == set(after) and len(retained) == 44
    assert all(before[name] == after[name] for name in retained)
    dev.write_text(source)
    subprocess.run([sys.executable, str(ROOT.parent / "moe/strip_comments.py"),
                    str(dev), str(sub), "--docstrings"], check=True)
    config = json.loads((HERE / "selection.json").read_text())["config"]
    config["probe"] = str(PROBE.relative_to(ROOT))
    report = dict(command=sys.argv, config=config, retained_functions=retained, new_functions=[],
        source_sha256={str(path.relative_to(ROOT)): digest(path) for path in
            (BASE, PROBE, Path(__file__).resolve(), dev, sub)},
        baseline_official_score=87.93, target_official_score=88.5, new_official_score=None,
        status="assembled; final local validation pending")
    (directory / "assembly.json").write_text(json.dumps(report, indent=2)+"\n")
    print("Assembled", directory, "44 unchanged non-dispatch functions")
    print("submission SHA256", digest(sub))


if __name__ == "__main__":
    main()
