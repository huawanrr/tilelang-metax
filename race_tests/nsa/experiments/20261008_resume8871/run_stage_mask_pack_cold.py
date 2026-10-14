"""Resolve staging, mask scheduling, and pack cache behavior in serial."""
import json
from datetime import datetime, timezone
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
HOT = ROOT / "experiments/20261005_goal8929/bracketed_audited.py"
COLD = ROOT / "experiments/20261008_goal895/profile_cold.py"
S4_CASES = HERE / "staged_group_cases.json"
JOBS = [
    ("staged_group_screen", HOT, ["s4_staged_group2.py", "s4_staged_group4.py"],
     S4_CASES, "s4_small,s4_oj11,s4_multi,s4_large",
     ["--seeds", "0,61", "--attempts", "16", "--repeat", "300", "--shared-pool"]),
    ("mask_schedule_screen", HOT,
     ["boundary_mask_post.py", "mask_distance_mid.py", "mask_boundary_init_mid.py"],
     HERE / "mid_boundary_cases.json",
     "n256_b1_h2,n512_b2_h1,n512_b2_h2,n128_b3_h2,n512_b1_h1,n256_b3_h1,n512_b4_h1",
     ["--seeds", "0,61", "--attempts", "20", "--repeat", "400", "--shared-pool"]),
    ("pack_quads_cold", COLD, ["pack_quads_w64.py"], HERE / "pack_tiling_family_cases.json",
     "pack_b1_t1024_h1,pack_b2_t256_h2,pack_b1_t512_h2,pack_b2_t512_h2,pack_b4_t1024_h1,pack_b1_t1024_h4,pack_b8_t1024_h1,pack_b4_t1024_h2,pack_b8_t1024_h2",
     ["--seed", "61", "--repeat", "48", "--rounds", "6"]),
]


def main():
    cases = {name: dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=64, S=4,
                       block_size=16, is_causal=True)
             for name, b, t, h in [("s4_small", 1, 256, 1), ("s4_oj11", 2, 512, 1),
                                   ("s4_multi", 1, 1024, 2), ("s4_large", 4, 1024, 1)]}
    with S4_CASES.open("x") as handle:
        handle.write(json.dumps(cases, indent=2) + "\n")
    records = []
    for name, harness, modules, case_file, selected, options in JOBS:
        output, log = HERE / (name + ".json"), HERE / (name + ".log")
        assert not output.exists() and not log.exists(), name
        command = [sys.executable, str(harness), str(HERE / "parent.py"),
                   str(HERE / "parent_submission.py")]
        command += [str(HERE / module) for module in modules]
        command += ["--case-file", str(case_file), "--cases", selected] + options
        command += ["--output", str(output)]
        record = dict(name=name, command=command,
                      started_utc=datetime.now(timezone.utc).isoformat())
        records.append(record)
        (HERE / "stage_mask_pack_runs.json").write_text(json.dumps(records, indent=2) + "\n")
        print("START", name, flush=True)
        with log.open("x") as handle:
            result = subprocess.run(command, stdout=handle, stderr=subprocess.STDOUT)
        record.update(returncode=result.returncode,
                      finished_utc=datetime.now(timezone.utc).isoformat())
        (HERE / "stage_mask_pack_runs.json").write_text(json.dumps(records, indent=2) + "\n")
        print("DONE", name, result.returncode, flush=True)


if __name__ == "__main__":
    main()
