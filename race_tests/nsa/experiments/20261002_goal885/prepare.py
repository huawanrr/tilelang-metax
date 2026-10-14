"""Freeze the validated D32 release and copy independent research harnesses."""
import ast
import hashlib
import json
from pathlib import Path
import shutil


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_d32_v1"


def main():
    release = json.loads((BASE / "release_manifest.json").read_text())
    hashes = dict(release["preserved_baselines"])
    for name, value in release["source_sha256"].items():
        hashes[str((BASE / name).relative_to(ROOT))] = value
    for name, expected in hashes.items():
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
    manifest = dict(baseline=str((BASE / "submission.py").relative_to(ROOT)),
        baseline_development=str((BASE / "nsa.py").relative_to(ROOT)),
        source_sha256=hashes, last_official_score=87.93, target_official_score=88.5,
        new_official_score=None)
    target = HERE / "baseline_manifest.json"
    if target.exists():
        assert json.loads(target.read_text()) == manifest
    else:
        target.write_text(json.dumps(manifest, indent=2) + "\n")
    previous = ROOT / "experiments/20261002_next"
    for name in ("compare_family.py", "bracketed_multiseed.py", "family_cases.json"):
        target = HERE / name
        if not target.exists():
            shutil.copyfile(previous / name, target)
    for target, source in (("reference_d32.py", BASE / "submission.py"),
                           ("reference_1001.py", ROOT / "experiments/20261001_final/submission.py")):
        path = HERE / target
        if not path.exists():
            shutil.copyfile(source, path)
        assert path.read_bytes() == source.read_bytes()
    original = ROOT / "experiments/20260929_recheck/make_shuffle_candidates.py"
    module = ast.parse(original.read_text())
    nodes = [node for node in module.body if isinstance(node, ast.FunctionDef)
             and node.name in ("bit_expr", "exchange", "indent")]
    assert len(nodes) == 3
    source = ast.unparse(ast.Module(body=nodes, type_ignores=[])) + "\n"
    target = HERE / "register_exchange.py"
    if target.exists():
        assert target.read_text() == source
    else:
        target.write_text(source)
    print("Protected", len(hashes), "sources; copied independent harnesses")


if __name__ == "__main__":
    main()
