"""Freeze v16 with its documented hot-cache limitations and cold-cache evidence."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

HERE = Path(__file__).resolve().parent
PRIOR = HERE.parent / "20261016_s2_family/release_v15"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    report = json.loads((HERE / "final_summary.json").read_text())
    assert report["status"] == "PASS"
    assert report["candidate_sha256"] == sha(HERE / "candidate.py")
    assert report["parent_v15_sha256"] == sha(HERE / "baseline.py") == sha(PRIOR / "submission.py")
    assert report["official_candidate_score"] is None and not report["official_target_verified"]
    for name, digest in report["evidence_sha256"].items():
        assert sha(HERE / name) == digest, name
    assert len(report["graph"]["regressions"]) == 2
    assert len(report["graph_confirmation"]["regressions"]) == 8
    snapshot = [path for path in HERE.rglob("*") if path.is_file()
                and "__pycache__" not in path.parts
                and not any(part.startswith("release_") and part != "release_readme.md.in"
                            for part in path.relative_to(HERE).parts)]
    output = HERE / "release_v16"
    output.mkdir(exist_ok=False)
    shutil.copy2(HERE / "candidate.py", output / "submission.py")
    shutil.copy2(HERE / "baseline.py", output / "parent_v15.py")
    shutil.copy2(HERE / "final_summary.json", output / "final_summary.json")
    cold = {row["seed"]: row["speedup"] for row in report["cold"]["rows"]}
    readme = (HERE / "release_readme.md.in").read_text().format(
        candidate_sha256=report["candidate_sha256"], hot_geomean=report["graph"]["geomean"],
        confirmation_geomean=report["graph_confirmation"]["geomean"],
        cold0=cold[0], cold61=cold[61], cold2026=cold[2026],
        hot_control=report["graph"]["control_geomean"],
        confirmation_control=report["graph_confirmation"]["control_geomean"],
        max_abs_error=report["correctness"]["max_abs_error"])
    (output / "README.md").write_text(readme)
    for path in snapshot:
        destination = output / "evidence" / path.relative_to(HERE)
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, destination)
    shutil.copytree(PRIOR / "dependencies", output / "dependencies",
                    ignore=shutil.ignore_patterns("__pycache__", "*.pyc"))
    root = output / "dependencies/nsa"
    study = root / "experiments/20261016_rsqrt"
    study.mkdir(parents=True)
    for name in ("baseline.py", "control.py", "rsqrt.py", "ieee_rsqrt.py", "candidate_cases.json",
                 "family_cases.json", "verify_candidate.py", "verify_math.py", "prepare.py"):
        shutil.copy2(HERE / name, study / name)
    for name in ("bench_storage_windows.py",):
        shutil.copy2(HERE.parent / "20261016_s2_family" / name,
                     root / "experiments/20261016_s2_family" / name)
    required = ["check_submission_nsa.py", "env.sh", "benchmark_nsa.py", "verify_nsa.py",
                "experiment_bench.py", "test_cases_nsa_fwd.json",
                "experiments/20261005_goal8929/verify_candidate.py",
                "experiments/20260928_guard_fix/check_restricted_host.py",
                "experiments/20261008_goal895/profile_cold.py",
                "experiments/20261008_resume8871/audit_actual_binary.py",
                "experiments/20261015_goal8933/audit_binary.py",
                "experiments/20261016_goal895/summarize_screen.py",
                "experiments/20261016_s2_family/bench_storage_windows.py"]
    assert all((root / name).is_file() for name in required)
    assert (output / "dependencies/moe/check_submission.py").is_file()
    commands = output / "commands.sh"
    shutil.copy2(HERE / "commands.sh.in", commands)
    commands.chmod(0o755)
    subprocess.run(["bash", "-n", str(commands)], check=True)
    manifest = dict(candidate_sha256=report["candidate_sha256"],
                    parent_v15_sha256=report["parent_v15_sha256"],
                    user_reported_score=89, official_target=89.5,
                    official_candidate_score=None, official_target_verified=False,
                    hot_regressions_retained=True,
                    files={str(path.relative_to(output)): sha(path)
                           for path in sorted(output.rglob("*")) if path.is_file()})
    (output / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    assert all(sha(output / name) == digest for name, digest in manifest["files"].items())
    print("Frozen", output, len(manifest["files"]), "files", report["candidate_sha256"])


if __name__ == "__main__":
    main()
