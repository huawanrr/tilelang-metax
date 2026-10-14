"""Freeze the verified v5 source and all local evidence without overwriting releases."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
EXPECTED = {
    "experiments/20261008_goal895/release_v4/nsa.py": "06d69bab6089e3ac11f9cca58804b9ccdc505e2913f019a5ee31b85f811b67fc",
    "experiments/20261008_goal895/release_v4/submission.py": "6f1922f56d5bc372262eca5e3b54630b9ef6a2de23c082606aacec94b2010e02",
    "experiments/20261008_resume8857/candidate_v5b.py": "4887b6a68ea8f0a7647441625079f87f74c13906bcfb7bcd17e9fa170769121d",
    "experiments/20261008_resume8857/candidate_v5b_submission.py": "9a718acd3c0fee4be2195039a06e11456f2b453e3f3a265ef4c55302d7ca2541",
}


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read(name):
    return json.loads((HERE / name).read_text())


def main():
    for name, value in EXPECTED.items():
        assert digest(ROOT / name) == value, name
    reference = read("candidate_v5b_reference.json")
    assert len(reference) == 125 and all(r["status"] == "PASS" for r in reference)
    extra = read("candidate_v5b_extra.json")
    counts = dict(boundaries=76, extreme_scales=70, tuning=136,
                  cache_order=8, live_inputs=48, restricted_host=10)
    assert extra["status"] == "PASS" and all(len(extra[k]) == n for k, n in counts.items())
    assert extra["source_sha256"] == EXPECTED["experiments/20261008_resume8857/candidate_v5b_submission.py"]
    layouts = read("candidate_v5b_layout_proofs.json")
    assert layouts["status"] == "PASS" and len(layouts["scalar_maps"]) == 18
    assert layouts["source_sha256"] == EXPECTED["experiments/20261008_resume8857/candidate_v5b.py"]
    audit = read("candidate_v5b_audit.json")
    assert audit["status"] == "PASS" and len(audit["configurations"]) == 110 and len(audit["timings"]) == 137
    assert len(audit["static"]["unchanged_original_functions"]) == 55
    assert audit["static"]["added_functions"] == ["native_sparse_attention_q_preload"]
    components = read("candidate_v5b_components.json")
    assert components["status"] == "PASS" and len(components["rows"]) == 342
    assert components["unique_configurations"] == 114 and components["short_mode"] == "none"
    assert sum(r["retained_probe_kernel"] for r in components["rows"]) == 111
    performance = read("candidate_v5b_performance_summary.json")
    assert performance["full"]["all"]["candidate_accepted"]["count"] == 109
    assert performance["oj"]["all"]["candidate_accepted"]["count"] == 28
    assert len(performance["cold"]["rows"]) == 21
    assert performance["official_baseline"]["observed_official_scores"] == [88.57, 88.71]
    assert performance["official_candidate_score"] is None and not performance["official_target_confirmed"]
    for name in ("full", "oj", "cold", "confirmation_probe", "confirmation_retained"):
        result = performance[name]
        assert digest(ROOT / result["source"]) == result["source_sha256"]
    assert (HERE / "candidate_v5b_static.log").read_text().count(" PASS") == 2
    runs = read("candidate_v5b_validation_runs.json")
    assert all(r["status"] == "PASS" for r in runs)
    completed = {stage["stage"] for run in runs for stage in run["stages"] if stage["status"] == "PASS"}
    assert completed == {"reference", "extra", "oj", "full", "cold", "audit", "components", "performance_summary"}
    environment = read("candidate_v5b_environment.json")
    assert environment["device"]["multi_processor_count"] == 104

    previous = ROOT / "experiments/20261008_goal895/release_v4/REPRO_DEPENDENCIES.sha256"
    dependencies = {line.split("  ", 1)[1] for line in previous.read_text().splitlines()}
    dependencies.update(EXPECTED)
    dependencies.update(str((HERE / name).relative_to(ROOT)) for name in (
        "baseline.py", "baseline_submission.py", "verify_candidate.py", "layout_proofs.py",
        "audit_candidate.py", "audit_components.py", "summarize_candidate.py", "official_baseline.json",
        "final_cold_cases.json", "oj_cases.json", "confirmation_cases.json", "confirmation_screen.json",
        "candidate_probe_v2.py", "qsync_wide_late.py", "capture_environment.py"))
    dependencies.update(str((HERE / name).relative_to(ROOT)) for name in (
        "make_short_pairs.py", "make_short_sync.py", "run_short_sync_screen.py",
        "run_short_wave_confirmation.py", "run_v5_validation.py", "finalize_candidate.py"))
    dependencies.update(("experiments/20261007_resume/make_short_block_loads.py",
        "experiments/20261007_resume/make_s8_schedule.py",
        "experiments/20261003_packed_compute/inspect_resources.py"))
    for filename in ("confirmation_screen.json", "short_sync_screen.json", "short_wave_confirmation.json"):
        dependencies.add(str((HERE / filename).relative_to(ROOT)))
        dependencies.update(str(Path(name).relative_to(ROOT)) if Path(name).is_absolute() else name
                            for name in read(filename)["sha256"])
    dependencies.update(str((HERE / name).relative_to(ROOT)) for name in (
        "audit_candidate_v5b.py", "audit_components_v5b.py", "run_v5b_validation.py", "refine_v5.py"))
    dependency_hashes = {name: digest(ROOT / name) for name in sorted(dependencies)}

    destination = HERE / "release_v5"
    assert not destination.exists(), "A frozen release must not be overwritten"
    for filename in ("README_v5.md", "release_commands.sh", "candidate_v5b_environment.json"):
        assert (HERE / filename).is_file(), filename
    release = Path(tempfile.mkdtemp(prefix=".release_v5_stage.", dir=HERE))
    for source, target in {
        "candidate_v5b.py": "nsa.py", "candidate_v5b_submission.py": "submission.py",
        "README_v5.md": "README.md", "release_commands.sh": "commands.sh",
        "candidate_v5b_performance_summary.json": "performance_summary.json",
        "candidate_v5b_environment.json": "environment.json", "official_baseline.json": "official_baseline.json",
    }.items():
        shutil.copy2(HERE / source, release / target)
    evidence = release / "evidence/research"
    evidence.mkdir(parents=True)
    for source in sorted(HERE.iterdir()):
        if source.is_file() and source.suffix in (".py", ".json", ".log", ".md", ".sh", ".cpp", ".ll"):
            shutil.copy2(source, evidence / source.name)
    for name in dependencies:
        target = release / "evidence/dependencies" / name.replace("../", "parent/")
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(ROOT / name, target)
    (release / "REPRO_DEPENDENCIES.sha256").write_text(
        "".join(f"{value}  {name}\n" for name, value in dependency_hashes.items()))
    files = {str(p.relative_to(release)): digest(p) for p in sorted(release.rglob("*")) if p.is_file()}
    manifest = dict(created_at_utc=datetime.now(timezone.utc).isoformat(), candidate_version="v5",
        official_baseline=read("official_baseline.json"), target_score=89.5,
        official_candidate_score=None, official_target_confirmed=False,
        preserved_and_verified_sources=EXPECTED,
        source=dict(development=files["nsa.py"], submission=files["submission.py"]),
        verification=dict(reference_cases=125, extra=counts, scalar_maps=18,
            audited_timing_records=137, audited_configurations=110,
            component_timing_records=342, component_configurations=114,
            retained_component_timing_records=111, original_functions_unchanged=55),
        rejected_s2_research=True, repository_dependencies=dependency_hashes, files=files)
    (release / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    all_files = {str(p.relative_to(release)): digest(p) for p in sorted(release.rglob("*")) if p.is_file()}
    (release / "SHA256SUMS").write_text("".join(f"{value}  {name}\n" for name, value in all_files.items()))
    for name, value in EXPECTED.items():
        assert digest(ROOT / name) == value
    assert not destination.exists()
    release.rename(destination)
    print(destination)
    print("archived files", len(all_files), "submission SHA256", files["submission.py"])


if __name__ == "__main__":
    main()
