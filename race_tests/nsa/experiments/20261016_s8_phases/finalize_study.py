"""Archive all positive and negative evidence for the rejected S8 phase study."""
import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PARENT = HERE.parent / "20261016_goal895/release_v14/submission.py"
PARENT_SHA = "d3c4e9f7417069efc0a0189d5754d4f8e765034c848c2219d32e869dd3b22080"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    assert sha(PARENT) == PARENT_SHA
    assert sha(HERE / "baseline.py") == sha(HERE / "control.py") == PARENT_SHA
    studies = []
    for stem, count in (("phase", 4), ("phase_shared", 3)):
        data = json.loads((HERE / f"{stem}_screen.json").read_text())
        assert len(data["rows"]) == 8
        assert len(data["sha256"]) == count + 1
        for filename, digest in data["sha256"].items():
            assert sha(ROOT / filename) == digest, filename
        for row in data["rows"]:
            assert len(row["max_abs_error"]) == count + 1
            assert len(row["graph_checks"]) == 2 * (count + 1)
            assert all(len(trials) == 24 for trials in row["trials"][1:])
        summary = json.loads((HERE / f"{stem}_summary.json").read_text())["studies"][0]
        for module in summary["modules"]:
            if Path(module["file"]).name != "control.py":
                assert module["regressions"] == 8
        studies.append(summary)
    binary_path = HERE / "phase_binary/report.json"
    binary = json.loads(binary_path.read_text())
    assert len(binary["rows"]) == 2
    for row in binary["rows"]:
        assert len(row["modules"]) == 6
        for index, module in enumerate(row["modules"]):
            assert sha(ROOT / module["path"]) == module["sha256"]
            assert module["parts"][0]["sections"][".text"] == row["modules"][0]["parts"][0]["sections"][".text"]
            for part_index, part in enumerate(module["parts"]):
                elf = binary_path.parent / f"{row['case']}_m{index}_p{part_index}.elf"
                assert sha(elf) == part["elf_sha256"]
    occupancy_path = HERE / "occupancy/report.json"
    occupancy = json.loads(occupancy_path.read_text())
    assert occupancy["binary_report_sha256"] == sha(binary_path)
    assert len(occupancy["rows"]) == 12
    for row in occupancy["rows"]:
        assert sha(ROOT / row["module"]) == row["sha256"]
        assert sha(ROOT / row["elf"]) == row["elf_sha256"]
        assert row["runtime"]["attributes"]["local_bytes"] == 0
    summary = dict(
        status="complete research, all five candidates rejected; no new submission",
        current_submission=str(PARENT.relative_to(ROOT)), current_submission_sha256=PARENT_SHA,
        official_score_reported_by_user=89, target_score=89.5,
        official_v14_result=None, goal_complete=False,
        graph_studies=studies, binary_configurations=12, audited_device_parts=24,
        occupancy=occupancy["rows"],
        conclusions=[
            "All five S8 phase candidates regress on all eight shape/seed rows.",
            "Register weights reduce vector registers and raise the OJ12 runtime residency limit from 20 to 24-28 blocks, without improving latency.",
            "Shared weights use 4096 dynamic shared bytes, lowering OJ12 residency to 16 blocks despite fewer vector registers.",
            "Scalar registers are 52 throughout; the measured residency results do not justify repeating old raw-block guard combinations.",
            "No private-memory spilling was reported. Pack device text is unchanged.",
            "No full v14 validation was repeated for these rejected, isolated probes.",
        ],
    )
    (HERE / "study_summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    files = []
    for path in sorted(HERE.rglob("*")):
        if not path.is_file() or "__pycache__" in path.parts or path.name == "research_manifest.json":
            continue
        files.append(dict(path=str(path.relative_to(HERE)), bytes=path.stat().st_size,
                          sha256=sha(path)))
    (HERE / "research_manifest.json").write_text(json.dumps(dict(
        status="rejected research archive", files=files), indent=2) + "\n")
    print("S8 phases archived:", len(files), "hashed files; 40/40 candidate rows regress; v14 unchanged")


if __name__ == "__main__":
    main()
