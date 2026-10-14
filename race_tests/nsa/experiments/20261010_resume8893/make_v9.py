"""Narrow the medium multihead path after warm and cold regressions in v8."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def main():
    parent = HERE / "candidate_v8_submission.py"
    source = parent.read_text()
    old = "fp32_multih = oct8_coalesced and H >= 2"
    new = "fp32_multih = oct8_coalesced and H >= 2 and is_causal and grid < 2048"
    assert source.count(old) == 1
    result = source.replace(old, new, 1)
    old_functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    new_functions = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
    for name, fn in old_functions.items():
        if name != "_get_kernel":
            assert ast.dump(fn) == ast.dump(new_functions[name]), name
    dev, sub = HERE / "candidate_v9.py", HERE / "candidate_v9_submission.py"
    with dev.open("x") as file:
        file.write(result)
    subprocess.run([sys.executable, str(ROOT / "experiments/20261007_exp_math/make_submission.py"),
                    str(dev), str(sub)], check=True)
    manifest = json.loads((HERE / "candidate_v8_manifest.json").read_text())
    manifest.update(status="assembled; final validation required", command=sys.argv,
        development=str(dev), development_sha256=digest(dev), submission=str(sub), submission_sha256=digest(sub),
        immediate_parent=str(parent), immediate_parent_sha256=digest(parent),
        additional_preserved_functions=[n for n in old_functions if n != "_get_kernel"],
        dispatch_change=dict(before=old, after=new,
            reason="Restore v6 in noncausal medium multihead and grids >=2048 after adverse warm/cold outcomes",
            evidence=["v8_oj.json", "v8_cold_seed61.json", "v8_cold_seed0.json", "mid_q_family.json"]))
    manifest["options"]["multihead_causal_below2048"] = True
    manifest["scope"]["medium_multihead"] = "Default, complete BS16, D64, H>=2, causal, 512<=B*H*T<2048; other medium cases use v6"
    manifest["inherited"] = "v8 with only the medium multihead dispatch scope narrowed; all device builders and callable-cache key expressions unchanged"
    with (HERE / "candidate_v9_manifest.json").open("x") as file:
        json.dump(manifest, file, indent=2)
        file.write("\n")
    print(json.dumps(dict(submission=str(sub), sha256=digest(sub), dispatch_change=manifest["dispatch_change"]), indent=2))


if __name__ == "__main__":
    main()
