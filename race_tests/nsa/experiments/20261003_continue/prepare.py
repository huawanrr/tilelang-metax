"""Resume the unfinished D128 experiment on the user-confirmed 88.29 baseline."""

import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PRIOR = ROOT / "experiments/20261002_d128_mid"
BASE = ROOT / "experiments/20261002_mid_v1"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_once(path, source):
    if path.exists():
        assert path.read_text() == source, path
    else:
        path.write_text(source)


def main():
    assert digest(BASE / "submission.py") == "ee780d62a64e427d742db494596feffd0f3f9834e4587cad61a66713f2936c31"
    sources = [BASE / "nsa.py", BASE / "submission.py"]
    sources += [PRIOR / name for name in (
        "linear_pairs.py", "coalesced_q8.py", "selection.json",
        "family_multiseed.json", "boundary_multiseed.json",
    )]
    manifest = dict(
        baseline="experiments/20261002_mid_v1/submission.py",
        official_score=88.29,
        score_source="User confirmation on 2026-10-03",
        prior_session="01a0fc6c-a137-7183-8163-fac99959d30e",
        source_sha256={str(path.relative_to(ROOT)): digest(path) for path in sources},
    )
    write_once(HERE / "baseline_manifest.json", json.dumps(manifest, indent=2) + "\n")
    for name in (
        "compare_family.py", "bracketed_multiseed.py", "family_cases.json",
        "inspect_resources.py", "selection.json", "study_summary.py",
        "verify_reference.py", "audit_sources.py", "validate_release.py",
    ):
        write_once(HERE / name, (PRIOR / name).read_text())
    for name in ("reference_mid.py", "reference_control.py"):
        write_once(HERE / name, (BASE / "nsa.py").read_text())
    replacements = {
        "assemble_release.py": [
            ('experiments/20261002_output_v1/nsa.py', 'experiments/20261002_mid_v1/nsa.py'),
            ('baseline_official_score=87.93', 'baseline_official_score=88.29'),
        ],
        "verify_d128.py": [
            ('experiments/20261002_output_v1/submission.py', 'experiments/20261002_mid_v1/submission.py'),
        ],
        "check_linear_layouts.py": [
            ('experiments/20261002_output_v1/nsa.py', 'experiments/20261002_mid_v1/nsa.py'),
        ],
        "audit_d128.py": [
            ('HERE / "reference_output.py"', 'ROOT / "experiments/20261002_d128_mid/reference_output.py"'),
        ],
    }
    for name, edits in replacements.items():
        source = (PRIOR / name).read_text()
        for old, new in edits:
            assert old in source, (name, old)
            source = source.replace(old, new)
        write_once(HERE / name, source)
    print("Prepared independent D128 continuation on official 88.29 baseline")


if __name__ == "__main__":
    main()
