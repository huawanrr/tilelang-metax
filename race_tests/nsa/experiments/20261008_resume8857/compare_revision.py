"""Confirm the final range correction leaves every timed OJ/full kernel unchanged."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    rows = []
    for dataset, expected_count in (("oj", 28), ("full", 109)):
        old_path = HERE / f"candidate_v5_{dataset}.json"
        new_path = HERE / f"candidate_v5b_{dataset}.json"
        old = json.loads(old_path.read_text())
        new = json.loads(new_path.read_text())
        assert len(old["rows"]) == len(new["rows"]) == expected_count
        for data in (old, new):
            for name, value in data["sha256"].items():
                assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == value
        old_index, new_index = len(old["sha256"]) - 1, len(new["sha256"]) - 1
        before = {(r["case"], r["seed"]): r for r in old["rows"]}
        for after in new["rows"]:
            key = (after["case"], after["seed"])
            prior = before[key]
            assert prior["config"] == after["config"]
            assert prior["device_source_sha256"][old_index] == after["device_source_sha256"][new_index], key
            assert prior["compile_flags"][old_index] == after["compile_flags"][new_index], key
            rows.append(dict(dataset=dataset, case=key[0], seed=key[1], identical_device_source_and_flags=True))
    report = dict(status="PASS", rows=rows,
        note="Both files were actually timed. The final change restores D32/T48 to v4; that boundary is checked by the separate component audit and cold measurement.")
    with (HERE / "candidate_v5b_revision_equivalence.json").open("x") as file:
        file.write(json.dumps(report, indent=2) + "\n")
    print("PASS", len(rows), "timed records")


if __name__ == "__main__":
    main()
