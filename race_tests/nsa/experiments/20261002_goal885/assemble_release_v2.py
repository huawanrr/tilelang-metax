"""Keep the unstable D64 short-sequence family on the verified D32 release."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

from make_register_qk import once


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def functions(source):
    return {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(source).body
            if isinstance(n, ast.FunctionDef)}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--input-dir", required=True)
    p.add_argument("--output-dir", required=True)
    p.add_argument("--d64-min-seq", type=int, required=True)
    a = p.parse_args()
    assert a.d64_min_seq >= 64 and a.d64_min_seq % 16 == 0
    initial, out = Path(a.input_dir).resolve(), Path(a.output_dir).resolve()
    out.mkdir(parents=True, exist_ok=True)
    dev, sub = out / "nsa.py", out / "submission.py"
    assert not dev.exists() and not sub.exists(), out
    old = json.loads((initial / "assembly.json").read_text())
    for name, expected in old["source_sha256"].items():
        assert digest(ROOT / name) == expected, name
    baseline = (initial / "nsa.py").read_text()
    source = once(baseline,
        "    coalesced_blocks = (coalesced_qo and block_size == 16 and seq_len % block_size == 0\n",
        "    coalesced_blocks = (coalesced_qo and block_size == 16 and seq_len % block_size == 0\n"
        f"        and (D != 64 or seq_len >= {a.d64_min_seq})\n")
    before, after = functions(baseline), functions(source)
    assert set(before) == set(after)
    assert all(before[name] == after[name] for name in before if name != "_get_kernel")
    dev.write_text(source)
    subprocess.run([sys.executable, str(ROOT.parent / "moe/strip_comments.py"),
                    str(dev), str(sub), "--docstrings"], check=True)
    config = dict(old["config"], d64_min_seq=a.d64_min_seq)
    inherited = {name: value for name, value in old["source_sha256"].items()}
    inherited.update({str(path.relative_to(ROOT)): digest(path) for path in
                      (initial / "assembly.json", Path(__file__).resolve(), dev, sub)})
    report = dict(command=sys.argv, config=config,
        retained_functions=old["retained_functions"], new_functions=old["new_functions"],
        source_sha256=inherited, initial_candidate=str(initial.relative_to(ROOT)),
        unchanged_from_initial=[name for name in before if name != "_get_kernel"],
        baseline_official_score=87.93, target_official_score=88.5,
        new_official_score=None, status="assembled; final GPU validation pending")
    (out / "assembly.json").write_text(json.dumps(report, indent=2) + "\n")
    print("Assembled", out, "D64 minimum sequence", a.d64_min_seq)


if __name__ == "__main__":
    main()
