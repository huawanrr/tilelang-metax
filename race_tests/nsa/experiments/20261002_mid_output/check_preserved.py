"""Verify immutable source/evidence hashes without changing prior releases."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PRIOR = ("experiments/20261002_d32_v1", "experiments/20261002_blocks_v2",
         "experiments/20261002_mid_v1")


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def check_release(directory):
    manifest_path = directory / "release_manifest.json"
    manifest = json.loads(manifest_path.read_text())
    count = 0
    for key, root in (("source_sha256", directory), ("preserved_baselines", ROOT),
                      ("evidence_sha256", ROOT)):
        for name, expected in manifest[key].items():
            assert digest(root / name) == expected, str(root / name)
            count += 1
    return dict(directory=str(directory.relative_to(ROOT)), verified_hashes=count)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--include", action="append", default=[])
    parser.add_argument("--output")
    args = parser.parse_args()
    directories = [ROOT / name for name in (*PRIOR, *args.include)]
    checks = [check_release(directory) for directory in directories]
    report = dict(status="PASS", prior_manifests={
        str((directory / "release_manifest.json").relative_to(ROOT)):
            digest(directory / "release_manifest.json") for directory in directories},
        checks=checks)
    if args.output:
        with Path(args.output).open("x") as output:
            output.write(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
