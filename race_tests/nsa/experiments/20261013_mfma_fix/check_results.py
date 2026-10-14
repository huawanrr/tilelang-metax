"""Check the recorded results and summarize the compatibility-only release."""
import argparse
import hashlib
import json
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("results", type=Path)
    args = parser.parse_args()
    results = args.results
    here = Path(__file__).resolve().parent
    manifest = json.loads((here / "source_manifest.json").read_text())
    source_hash = hashlib.sha256((here / "submission.py").read_bytes()).hexdigest()
    assert source_hash == manifest["submission_sha256"]
    assert (here / "nsa.py").read_bytes() == (here / "submission.py").read_bytes()
    static = (results / "static.log").read_text().strip().splitlines()
    assert len(static) == 2 and all(line.endswith(" PASS") for line in static)
    reference = json.loads((results / "reference.json").read_text())
    assert len(reference) == 125 and all(row["status"] == "PASS" for row in reference)
    compatibility = json.loads((results / "compatibility.json").read_text())
    assert compatibility["status"] == "PASS"
    assert compatibility["submission_sha256"] == source_hash
    assert compatibility["parent_sha256"] == manifest["parent_sha256"]
    assert len(compatibility["normal_primfunc_equal"]) == 3
    for key, count in (("strict_primexpr", 3), ("oj", 19), ("adversarial", 25), ("restricted_host", 5)):
        assert len(compatibility[key]) == count, key
    assert all(row["expected_rejection"] and row["fixed_pass"] for row in compatibility["strict_primexpr"])
    binary = json.loads((results / "binary_audit/report.json").read_text())
    assert len(binary["rows"]) == 16
    hashes = []
    for row in binary["rows"]:
        old, new = row["modules"]
        assert old["sha256"] == manifest["parent_sha256"]
        assert new["sha256"] == source_hash
        assert len(old["parts"]) == len(new["parts"])
        for before, after in zip(old["parts"], new["parts"]):
            for key in ("device_source_sha256", "compile_flags", "resources"):
                assert before[key] == after[key], (row["case"], key)
            assert before["sections"][".text"] == after["sections"][".text"], row["case"]
        hashes.append(dict(case=row["case"], device_text_sha256=[part["sections"][".text"]["sha256"] for part in new["parts"]]))
    report = dict(status="PASS", submission_sha256=source_hash,
                  parent_sha256=manifest["parent_sha256"], official_oj_retested=False,
                  changed_emitter_constructors=3, reference_cases=125,
                  max_reference_abs_error=max(row["max_abs_error"] for row in reference),
                  strict_primexpr_regressions=3, oj_shape_seed_checks=19,
                  adversarial_checks=25, restricted_host_checks=5,
                  identical_device_binary_cases=16, binaries=hashes,
                  note="Strict PrimExpr FFI probe and local RestrictedPython host checks; official sandbox is unavailable.")
    (results / "validation_summary.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PASS: 125 reference cases; 19 OJ shape/seed checks; 25 adversarial checks; 5 guarded host checks; 3 strict dtype regressions; 16 identical device binaries")


if __name__ == "__main__":
    main()
