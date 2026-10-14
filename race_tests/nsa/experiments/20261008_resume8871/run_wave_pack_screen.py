"""Serial pack tiling screens followed by the unresolved boundary-mask cases."""
import json
from datetime import datetime, timezone
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
HOT = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
COLD = ROOT / "experiments/20261008_goal895/profile_cold.py"
JOBS = [
    ("wave_pack_bs32_screen", HOT,
     ["pack_tiles_cols.py", "pack_cols32_w64.py", "pack_quads_w64.py"],
     ROOT / "experiments/20261008_goal895/oj_cases.json", "oj6,69,83,70",
     ["--seeds", "0,61", "--repeat", "300", "--attempts", "16", "--shared-pool"]),
    ("wave_pack_s8_screen", HOT,
     ["joint_pack256.py", "pack_s8_whole_w64.py", "pack_s8_cols32_w64.py"],
     ROOT / "experiments/20261008_goal895/oj_cases.json", "oj12,80,81,86",
     ["--seeds", "0,61", "--repeat", "300", "--attempts", "16", "--shared-pool"]),
    ("mid_boundary_cold_seed0", COLD, ["boundary_mask_post.py"],
     HERE / "mid_boundary_cases.json",
     "n128_b3_h2,n256_b3_h1,n128_b8_h1,n128_b4_h2,n256_b2_h2,n256_b1_h4,n512_b4_h1,n256_b1_h2,n512_b2_h2,n256_b1_h2_noncausal,n512_b1_h1_noncausal,n512_b2_h2_noncausal",
     ["--seed", "0", "--repeat", "48", "--rounds", "6"]),
]


def main():
    records = []
    for name, harness, modules, case_file, cases, options in JOBS:
        output, log = HERE / (name + ".json"), HERE / (name + ".log")
        assert not output.exists() and not log.exists(), name
        command = [sys.executable, str(harness), str(HERE / "parent.py"),
                   str(HERE / "parent_submission.py")]
        command += [str(HERE / module) for module in modules]
        command += ["--case-file", str(case_file), "--cases", cases] + options
        command += ["--output", str(output)]
        record = dict(name=name, command=command,
                      started_utc=datetime.now(timezone.utc).isoformat())
        records.append(record)
        (HERE / "wave_pack_runs.json").write_text(json.dumps(records, indent=2) + "\n")
        print("START", name, flush=True)
        with log.open("x") as handle:
            result = subprocess.run(command, stdout=handle, stderr=subprocess.STDOUT)
        record.update(returncode=result.returncode,
                      finished_utc=datetime.now(timezone.utc).isoformat())
        (HERE / "wave_pack_runs.json").write_text(json.dumps(records, indent=2) + "\n")
        print("DONE", name, result.returncode, flush=True)


if __name__ == "__main__":
    main()
