"""Freeze this turn's source inputs without changing historical evidence."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
SOURCES = {
    "baseline.py": "experiments/20261008_goal895/release_v4/nsa.py",
    "baseline_submission.py": "experiments/20261008_goal895/release_v4/submission.py",
    "parent.py": "experiments/20261008_resume8871/candidate_v6.py",
    "parent_submission.py": "experiments/20261008_resume8871/candidate_v6_submission.py",
    "oj_cases.json": "experiments/20261008_goal895/oj_cases.json",
}
manifest = {}
for name, source in SOURCES.items():
    data = (ROOT / source).read_bytes()
    destination = HERE / name
    if destination.exists():
        assert destination.read_bytes() == data
    else:
        with destination.open("xb") as output:
            output.write(data)
    manifest[name] = dict(source=source, sha256=hashlib.sha256(data).hexdigest())
with (HERE / "baseline_manifest.json").open("x") as output:
    json.dump(dict(target_score=89.33, official_score=88.71,
                   morning_session="01a11e94-0174-7800-9a45-cd2f3c2d0774",
                   sources=manifest), output, indent=2)
    output.write("\n")
print(json.dumps(manifest, indent=2))
