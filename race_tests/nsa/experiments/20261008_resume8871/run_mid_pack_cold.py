"""Cold-cache confirmation of measured positive and negative representatives."""
import json
from datetime import datetime, timezone
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
HARNESS = ROOT / "experiments/20261008_goal895/profile_cold.py"
JOBS = [
    ("tiled_pack_cold", ["joint_pack256.py", "pack_tiles_cols.py"],
     ROOT / "experiments/20261008_goal895/oj_cases.json", "oj6,69,83"),
    ("mid_boundary_cold", ["boundary_mask_post.py"], HERE / "mid_boundary_cases.json",
     "n256_b2_h1,n256_b1_h2,n512_b1_h1,n512_b2_h1,n512_b1_h2,n384_b1_h2,n128_b4_h1,n512_b2_h2"),
]


def main():
    records = []
    for name, modules, case_file, cases in JOBS:
        output, log = HERE / (name + ".json"), HERE / (name + ".log")
        assert not output.exists() and not log.exists(), name
        command = [sys.executable, str(HARNESS), str(HERE / "parent.py"),
                   str(HERE / "parent_submission.py")]
        command += [str(HERE / module) for module in modules]
        command += ["--case-file", str(case_file), "--cases", cases, "--seed", "61",
                    "--repeat", "48", "--rounds", "6", "--output", str(output)]
        record = dict(name=name, command=command,
                      started_utc=datetime.now(timezone.utc).isoformat())
        records.append(record)
        (HERE / "mid_pack_cold_runs.json").write_text(json.dumps(records, indent=2) + "\n")
        print("START", name, flush=True)
        with log.open("x") as handle:
            result = subprocess.run(command, stdout=handle, stderr=subprocess.STDOUT)
        record.update(returncode=result.returncode,
                      finished_utc=datetime.now(timezone.utc).isoformat())
        (HERE / "mid_pack_cold_runs.json").write_text(json.dumps(records, indent=2) + "\n")
        print("DONE", name, result.returncode, flush=True)


if __name__ == "__main__":
    main()
