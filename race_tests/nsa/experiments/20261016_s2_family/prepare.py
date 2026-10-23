"""Confirm the previously observed S2 signal over a dense neighboring family."""
import ast
import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PARENT = HERE.parent / "20261016_goal895/release_v14/submission.py"
OLD = HERE.parent / "20261016_after_v14"
NAME = "native_sparse_attention_short_list_oct8_sum_v11"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    expected = "d3c4e9f7417069efc0a0189d5754d4f8e765034c848c2219d32e869dd3b22080"
    assert sha(PARENT) == expected
    manifest = json.loads((OLD / "research_manifest.json").read_text())
    files = manifest["files"]
    if isinstance(files, list):
        digests = {entry["path"]: entry["sha256"] for entry in files}
    else:
        digests = {name: value["sha256"] if isinstance(value, dict) else value
                   for name, value in files.items()}
    originals = {n.name: ast.dump(n) for n in ast.parse(PARENT.read_text()).body
                 if isinstance(n, ast.FunctionDef)}
    records = []
    for name, origin in (("baseline.py", PARENT), ("control.py", PARENT),
                         ("wave_output.py", OLD / "s2_wave_q0_o1.py"),
                         ("wave_q4.py", OLD / "s2_wave_q4_o0.py")):
        if origin.parent == OLD:
            assert sha(origin) == digests[origin.name]
        source = origin.read_text()
        updated = {n.name: ast.dump(n) for n in ast.parse(source).body
                   if isinstance(n, ast.FunctionDef)}
        assert set(updated) == set(originals)
        changed = [key for key in originals if originals[key] != updated[key]]
        assert changed == ([] if origin == PARENT else [NAME]), changed
        with (HERE / name).open("x") as out:
            out.write(source)
        records.append(dict(file=name, origin=str(origin.relative_to(ROOT)),
                            sha256=sha(origin), changed_functions=changed))
    base = dict(B=1, SEQ_LEN=256, H=1, HQ=16, D=64, S=2,
                block_size=16, is_causal=True)
    cases = {"oj10": base}
    for length in (64, 96, 128, 160, 192, 224, 288, 320, 384, 512):
        cases[f"s2_b1_t{length}"] = dict(base, SEQ_LEN=length)
    for batch, length in ((2, 128), (2, 192), (4, 64)):
        cases[f"s2_b{batch}_t{length}"] = dict(base, B=batch, SEQ_LEN=length)
    cases["s2_b1_t256_c0"] = dict(base, is_causal=False)
    cases["s2_b1_h2_t128"] = dict(base, H=2, HQ=32, SEQ_LEN=128)
    with (HERE / "cases.json").open("x") as out:
        json.dump(cases, out, indent=2)
        out.write("\n")
    with (HERE / "assembly.json").open("x") as out:
        json.dump(dict(status="confirmation study; no dispatch decision",
                       parent=str(PARENT.relative_to(ROOT)), parent_sha256=expected,
                       reason="Prior OJ10 hot signal, inconsistent neighboring shapes; determine a reproducible family before selecting any dispatch.",
                       unchanged="Probe bytes are exact archived copies; no new arithmetic or synchronization change.",
                       variants=records, cases=len(cases)), out, indent=2)
        out.write("\n")
    print("Prepared", len(records), "modules and", len(cases), "S2 cases")


if __name__ == "__main__":
    main()
