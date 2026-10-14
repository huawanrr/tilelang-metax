"""Freeze the verified candidate and evidence without changing older releases."""
import ast
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
EXPECTED = {
    "experiments/20261002_mid_v1/submission.py": "ee780d62a64e427d742db494596feffd0f3f9834e4587cad61a66713f2936c31",
    "experiments/20261007_resume/release_v1/submission.py": "16c5010e65fe0f1fff48768cd3fa72d2b3c6634a5df3ac1dc7dc479baa14dd71",
    "experiments/20261007_exp_math/candidate_v1.py": "d6ef68ec0422c388148bc226a0f7c216f3cb8fb25a74a544a3a6847f3220e246",
    "experiments/20261007_exp_math/candidate_v1_submission.py": "c498c5202367c17ebf1b9d82aff60e000277b2e534f3014dee631be37cdc70ff",
}


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read(name):
    return json.loads((HERE / name).read_text())


def main():
    for name, expected in EXPECTED.items():
        assert digest(ROOT / name) == expected, name
    reference = read("candidate_v1_reference.json")
    assert len(reference) == 125 and all(row["status"] == "PASS" for row in reference)
    extra = read("candidate_v1_extra.json")
    assert extra["status"] == "PASS"
    counts = dict(boundaries=31, extreme_scales=35, tuning=51, cache_order=3,
                  live_inputs=18, restricted_host=5)
    assert all(len(extra[key]) == count for key, count in counts.items())
    assert extra["source_sha256"] == EXPECTED["experiments/20261007_exp_math/candidate_v1_submission.py"]
    rounding = read("cast_rounding.json")
    assert rounding["passed"] and rounding["values"] == 518144
    audit = read("candidate_v1_audit.json")
    assert audit["status"] == "PASS" and len(audit["full"]) == 109 and len(audit["family"]) == 38
    assert len(audit["lane_maps"]) == 16
    performance = read("candidate_v1_performance_summary.json")
    assert performance["full"]["all"]["candidate_accepted"]["count"] == 109
    assert performance["family"]["all"]["candidate_accepted"]["count"] == 114
    assert len(performance["cold"]["rows"]) == 4
    assert performance["official_candidate_score"] is None
    for kind in ("family", "full", "cold"):
        result = performance[kind]
        assert digest(ROOT / result["source"]) == result["source_sha256"]
    static_log = (HERE / "candidate_v1_static.log").read_text()
    assert static_log.count(" PASS") == 2

    # Independently preserve the original function definitions except dispatch.
    base_ast = ast.parse((ROOT / "experiments/20261002_mid_v1/nsa.py").read_text())
    new_ast = ast.parse((HERE / "candidate_v1.py").read_text())
    before = {node.name: ast.dump(node) for node in base_ast.body if isinstance(node, ast.FunctionDef)}
    after = {node.name: ast.dump(node) for node in new_ast.body if isinstance(node, ast.FunctionDef)}
    unchanged = [name for name in before if name != "_get_kernel"]
    assert len(unchanged) == 44
    assert all(before[name] == after[name] for name in unchanged)

    dependencies = [
        "env.sh", "test_cases_nsa_fwd.json", "benchmark_nsa.py", "bench_oj.py",
        "nsa.py", "test_tilelang_nsa_fwd.py", "reference.py",
        "experiment_bench.py", "verify_nsa.py", "kernel_source.py", "check_submission_nsa.py",
        "../moe/check_submission.py",
        "experiments/20261002_mid_v1/nsa.py", "experiments/20261002_mid_v1/submission.py",
        "experiments/20261003_packed_compute/reference_control.py",
        "experiments/20261003_packed_compute/family_cases.json",
        "experiments/20261003_packed_compute/inspect_resources.py",
        "experiments/20261002_mid_blocks/verify_reference.py",
        "experiments/20261005_goal8929/bracketed_audited.py",
        "experiments/20261005_goal8929/verify_candidate.py",
        "experiments/20261002_tuning/verify_candidate.py",
        "experiments/20261001_tuning/verify_release.py",
        "experiments/20260928_guard_fix/check_restricted_host.py",
    ]
    dependencies += [str((HERE / name).relative_to(ROOT)) for name in (
        "verify_candidate.py", "check_cast_rounding.py", "profile_cold.py",
        "audit_candidate.py", "make_submission.py", "summarize_candidate.py")]
    dependency_hashes = {name: digest(ROOT / name) for name in dependencies}

    release = HERE / "release_v1"
    assert not release.exists(), "A frozen release must not be overwritten"
    release.mkdir()
    copies = {"candidate_v1.py": "nsa.py", "candidate_v1_submission.py": "submission.py",
              "README.md": "README.md", "release_commands.sh": "commands.sh",
              "candidate_v1_performance_summary.json": "performance_summary.json"}
    for source, dest in copies.items():
        shutil.copy2(HERE / source, release / dest)
    evidence = release / "evidence/research"
    evidence.mkdir(parents=True)
    for source in sorted(HERE.iterdir()):
        if source.is_file() and source.suffix in (".py", ".json", ".log", ".md", ".elf", ".sh"):
            shutil.copy2(source, evidence / source.name)
    for name in dependencies:
        # Include the sibling static checker without allowing '..' in archive paths.
        dest = release / "evidence/dependencies" / name.replace("../", "parent/")
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(ROOT / name, dest)
    (release / "REPRO_DEPENDENCIES.sha256").write_text(
        "".join(f"{value}  {name}\n" for name, value in dependency_hashes.items()))
    files = {str(path.relative_to(release)): digest(path) for path in sorted(release.rglob("*"))
             if path.is_file()}
    manifest = dict(created_at_utc=datetime.now(timezone.utc).isoformat(),
                    official_baseline_score=88.29, target_score=89,
                    official_candidate_score=None, official_target_confirmed=False,
                    user_tested_previous_release="20261007_resume/release_v1: no official improvement",
                    preserved_and_verified_sources=EXPECTED,
                    source=dict(development=files["nsa.py"], submission=files["submission.py"]),
                    verification=dict(reference_cases=125, extra=counts, rounding_values=518144,
                                      lane_map_expressions=16, family_shapes=38,
                                      full_device_audits=109, original_functions_unchanged=44),
                    repository_dependencies=dependency_hashes, files=files)
    (release / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    all_files = {str(path.relative_to(release)): digest(path) for path in sorted(release.rglob("*"))
                 if path.is_file()}
    (release / "SHA256SUMS").write_text("".join(f"{value}  {name}\n" for name, value in all_files.items()))
    for name, expected in EXPECTED.items():
        assert digest(ROOT / name) == expected
    print(release)
    print("archived files", len(all_files), "submission SHA256", files["submission.py"])


if __name__ == "__main__":
    main()
