"""Screen synchronized short-list variants on the one GPU, sequentially."""
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
modules = ["baseline.py", "baseline_submission.py", "short_wave_only.py", "short_wave_lane.py",
           "short_wave_qpreload.py", "short_complete_pairs.py", "short_wave_pairs.py"]
command = [sys.executable, str(ROOT / "experiments/20261005_goal8929/bracketed_audited.py")]
command += [str(HERE / name) for name in modules]
command += ["--case-file", str(HERE / "confirmation_cases.json"), "--cases",
    "s2_b1_t256_h1_c1,s2_b1_t65_h1_c1,s2_b1_t128_h1_c0,s2_b1_t512_h2_c1",
    "--seeds", "0,61", "--attempts", "16", "--repeat", "500", "--shared-pool",
    "--output", str(HERE / "short_sync_screen.json")]
print("Command:", command, flush=True)
subprocess.run(command, cwd=ROOT, check=True)
