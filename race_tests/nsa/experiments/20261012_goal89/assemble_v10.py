"""Freeze v9's GPU improvements plus the canonical public-callable cache."""
import ast
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def functions(path):
    return {n.name: ast.dump(n) for n in ast.parse(Path(path).read_text()).body if isinstance(n, ast.FunctionDef)}


def main():
    parent, baseline, probe = [HERE / n for n in ("parent_v9.py", "baseline_v6.py", "public_cache_fast.py")]
    old, original, chosen = [functions(p) for p in (parent, baseline, probe)]
    assert old.keys() == chosen.keys()
    assert [n for n in old if old[n] != chosen[n]] == ["run_kernel"]
    assert [n for n in original if original[n] != chosen[n]] == ["_get_kernel", "run_kernel"]
    dev, sub = HERE / "candidate_v10.py", HERE / "candidate_v10_submission.py"
    assert not dev.exists() and not sub.exists()
    shutil.copy2(probe, dev)
    subprocess.run([sys.executable, str(ROOT / "experiments/20261007_exp_math/make_submission.py"),
                    str(dev), str(sub)], check=True)
    manifest = dict(status="assembled; final validation required", command=sys.argv,
        development=str(dev), development_sha256=digest(dev), submission=str(sub), submission_sha256=digest(sub),
        parent=str(parent), parent_sha256=digest(parent), baseline=str(baseline), baseline_sha256=digest(baseline),
        probe=str(probe), probe_sha256=digest(probe), target_score=89, official_candidate_score=None,
        official_baseline_score=None,
        score_note="The resumed raw user message reports a best score of 88.79; the previous README says v6=88.93. Confirmation is pending.",
        changed_vs_parent=["run_kernel"], unchanged_parent_functions=[n for n in old if n != "run_kernel"],
        unchanged_v6_functions=[n for n in original if n not in ("_get_kernel", "run_kernel")],
        inherited_gpu_functions=sorted(set(chosen)-set(original)),
        adopted="v9 GPU dispatch and mathematical improvements; canonical compiled-callable cache in run_kernel",
        rejected=["Alternate existing builders", "Broader Q4 loads", "Pairwise partial sums", "Narrow PV tiles", "First public-cache prototype"],
        cache="No tensors, addresses, inputs, outputs or preprocessing are cached. The only additional stored values are compiled callables keyed by canonical public shape and scale.")
    with (HERE / "candidate_v10_manifest.json").open("x") as file:
        json.dump(manifest, file, indent=2)
        file.write("\n")
    print(json.dumps(dict(submission=str(sub), sha256=digest(sub), parent_gpu_unchanged=True), indent=2))


if __name__ == "__main__":
    main()
