"""Run staging and pack-family probes serially through the audited public API."""
import json
from datetime import datetime, timezone
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
HARNESS = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
PACK_CASES = HERE / "pack_tiling_family_cases.json"
JOBS = [
    ("joint_shared_screen",
     ["boundary_mask_post.py", "coalesced_qk_joint.py", "coalesced_qkv_joint.py", "coalesced_qkv_mask.py"],
     HERE / "mid_boundary_cases.json",
     "n256_b1_h2,n512_b2_h1,n512_b2_h2,n128_b3_h2,n512_b1_h1,n256_b3_h1,n512_b4_h1", 16, 300),
    ("pack_tiling_family", ["pack_tiles_cols.py", "pack_quads_w64.py"],
     PACK_CASES, ",".join(json.loads(PACK_CASES.read_text())), 16, 300),
]


def main():
    records = []
    for name, modules, case_file, cases, attempts, repeat in JOBS:
        output, log = HERE / (name + ".json"), HERE / (name + ".log")
        assert not output.exists() and not log.exists(), name
        command = [sys.executable, str(HARNESS), str(HERE / "parent.py"),
                   str(HERE / "parent_submission.py")]
        command += [str(HERE / module) for module in modules]
        command += ["--case-file", str(case_file), "--cases", cases,
                    "--seeds", "0,61", "--attempts", str(attempts), "--repeat", str(repeat),
                    "--shared-pool", "--output", str(output)]
        record = dict(name=name, command=command,
                      started_utc=datetime.now(timezone.utc).isoformat())
        records.append(record)
        (HERE / "shared_pack_family_runs.json").write_text(json.dumps(records, indent=2) + "\n")
        print("START", name, flush=True)
        with log.open("x") as handle:
            result = subprocess.run(command, stdout=handle, stderr=subprocess.STDOUT)
        record.update(returncode=result.returncode,
                      finished_utc=datetime.now(timezone.utc).isoformat())
        (HERE / "shared_pack_family_runs.json").write_text(json.dumps(records, indent=2) + "\n")
        print("DONE", name, result.returncode, flush=True)


if __name__ == "__main__":
    main()
