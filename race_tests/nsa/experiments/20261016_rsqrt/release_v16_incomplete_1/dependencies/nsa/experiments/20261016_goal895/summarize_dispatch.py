"""Validate final evidence and retain every timing row, including regressions."""
import argparse
import hashlib
import json
from pathlib import Path
import statistics

from run_dispatch_final import BASE_SHA, FAMILY, COLD

HERE = Path(__file__).resolve().parent


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def config_key(config):
    return json.dumps(config, sort_keys=True)


def geomean(values):
    return statistics.geometric_mean(values) if values else None


def graph(path, candidate_sha, expected_cases, changed_configs, binaries):
    data = read(path)
    assert list(data["sha256"].values()) == [BASE_SHA, BASE_SHA, candidate_sha]
    assert {(r["case"], r["seed"]) for r in data["rows"]} == {
        (case, seed) for case in expected_cases for seed in (0, 61)}
    assert len(data["rows"]) == 2 * len(expected_cases)
    rows = []
    for record in data["rows"]:
        key = config_key(record["config"])
        changed = key in changed_configs
        hashes = record["device_source_sha256"]
        assert hashes[0] == hashes[1]
        assert (hashes[0] != hashes[2]) == changed, record["case"]
        assert hashes[0] == binaries[key]["before_source"]
        assert hashes[2] == binaries[key]["after_source"]
        row = dict(case=record["case"], seed=record["seed"], config=record["config"],
                   changed=changed, max_abs_error=max(record["max_abs_error"]))
        for index, name in ((1, "control"), (2, "candidate")):
            trials = record["trials"][index]
            accepted = [trial for trial in trials if trial["accepted"]]
            row[name] = dict(total=len(trials), accepted=len(accepted),
                unfiltered=statistics.median(t["speedup"] for t in trials),
                filtered=statistics.median(t["speedup"] for t in accepted) if accepted else None,
                baseline_us=statistics.median((t["before_us"] + t["after_us"]) / 2 for t in trials),
                candidate_us=statistics.median(t["candidate_us"] for t in trials))
        rows.append(row)
    aggregate = {}
    for name in ("control", "candidate"):
        aggregate[name] = dict(
            unfiltered=geomean([r[name]["unfiltered"] for r in rows]),
            filtered=geomean([r[name]["filtered"] for r in rows if r[name]["filtered"] is not None]),
            changed_unfiltered=geomean([r[name]["unfiltered"] for r in rows if r["changed"]]),
            unchanged_unfiltered=geomean([r[name]["unfiltered"] for r in rows if not r["changed"]]))
    return dict(method=data["method"], aggregate=aggregate, rows=rows,
                regressions=[r for r in rows if r["candidate"]["unfiltered"] < 1])


def cold(path, candidate_sha, changed_configs):
    data = read(path)
    assert list(data["sha256"].values()) == [BASE_SHA, BASE_SHA, candidate_sha]
    assert {r["case"] for r in data["rows"]} == set(COLD)
    assert len(data["rows"]) == len(COLD) and data["flush_bytes"] == 256000000
    rows = []
    for record in data["rows"]:
        medians = []
        for records in record["records"]:
            assert len(records) == 6
            for trial in records:
                assert len(trial["kernel_events"]) == trial["expected_kernels"] == 64
                actual = sum(e["device_time_us"] for e in trial["kernel_events"]) / 64
                assert abs(actual - trial["total_kernel_us_per_call"]) < 1e-10
            medians.append(statistics.median(t["total_kernel_us_per_call"] for t in records))
        assert medians == record["median_kernel_us"]
        rows.append(dict(case=record["case"], config=record["config"],
                         changed=config_key(record["config"]) in changed_configs,
                         max_abs_error=max(record["max_abs_error"]), median_us=medians,
                         control_speedup=medians[0]/medians[1],
                         candidate_speedup=medians[0]/medians[2]))
    return dict(method=data["method"], flush_bytes=data["flush_bytes"], rows=rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("validation")
    parser.add_argument("--module", required=True)
    parser.add_argument("--probe-audit", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    root, module = Path(args.validation), Path(args.module)
    candidate_sha = sha(module)
    state = read(root / "status.json")
    assert state["status"] == "PASS" and state["candidate_sha256"] == candidate_sha
    assert state["parent_sha256"] == BASE_SHA and sha(HERE / "baseline.py") == BASE_SHA
    assert len(state["steps"]) == 9 and all(s["returncode"] == 0 for s in state["steps"])
    reference = read(root / "reference.json")
    assert len(reference) == 125 and all(r["status"] == "PASS" for r in reference)
    host, cpu, families = (read(root / name) for name in
                           ("host_call.json", "dispatch_cpu.json", "changed_families.json"))
    for data in (host, cpu):
        assert data["status"] == "PASS" and candidate_sha in data["sources"].values()
    assert families["status"] == "PASS" and families["source_sha256"] == candidate_sha
    family_counts = {k:len(families[k]) for k in
                     ("strict_fp32", "boundaries", "scales", "live", "restricted", "compiled_cache_orders")}
    assert family_counts == dict(strict_fp32=6, boundaries=42, scales=25,
                                 live=30, restricted=5, compiled_cache_orders=64)
    host_counts = {k:len(host[k]) for k in ("cache", "normalization", "errors", "live", "restricted")}
    assert host_counts == dict(cache=32, normalization=24, errors=10, live=32, restricted=8)
    changed_configs = {config_key(r["config"]) for r in cpu["changed_default_dispatch"]}
    binary = read(root / "actual_binary/report.json")
    assert {r["case"] for r in binary["rows"]} == {f"oj{i}" for i in range(1,15)} | set(FAMILY)
    binaries, binary_rows = {}, []
    for row in binary["rows"]:
        before, after = row["modules"]
        assert before["sha256"] == BASE_SHA and after["sha256"] == candidate_sha
        assert len(before["parts"]) == len(after["parts"])
        key = config_key(row["config"])
        changed = key in changed_configs
        parts = []
        for index, (a, b) in enumerate(zip(before["parts"], after["parts"])):
            actual = a["sections"][".text"] != b["sections"][".text"]
            assert actual == changed, row["case"]
            assert a["compile_flags"] == b["compile_flags"]
            if not changed:
                assert a["device_source_sha256"] == b["device_source_sha256"]
                assert a["resources"] == b["resources"]
            parts.append(dict(part=index, changed=changed,
                before_text=a["sections"][".text"], after_text=b["sections"][".text"],
                before_resources=a["resources"], after_resources=b["resources"]))
        binaries[key] = dict(before_source=[p["device_source_sha256"] for p in before["parts"]],
                             after_source=[p["device_source_sha256"] for p in after["parts"]],
                             after_text=[p["sections"][".text"] for p in after["parts"]])
        binary_rows.append(dict(case=row["case"], config=row["config"], changed=changed,
                                launches=len(after["parts"]), parts=parts))
    probe_path = Path(args.probe_audit)
    probe = read(probe_path)
    assert len(probe["rows"]) == 8
    for row in probe["rows"]:
        candidate, screened = row["modules"]
        assert candidate["sha256"] == candidate_sha
        assert screened["sha256"] == sha(HERE / "dispatch_boundary_q8.py")
        assert len(candidate["parts"]) == len(screened["parts"]) == 1
        assert config_key(row["config"]) in changed_configs
        for a, b in zip(candidate["parts"], screened["parts"]):
            for field in ("compile_flags", "device_source_sha256", "resources"):
                assert a[field] == b[field], (row["case"], field)
            assert a["sections"][".text"] == b["sections"][".text"], row["case"]
    summary = dict(status="PASS", candidate_sha256=candidate_sha, parent_v13_sha256=BASE_SHA,
        user_reported_current_score=89, parent_release_assumed="v13",
        official_candidate_score=None, official_target=89.5, official_target_verified=False,
        static=state["static"],
        correctness=dict(reference_cases=125,
            reference_max_abs_error=max(r["max_abs_error"] for r in reference),
            cpu_configurations=cpu["configurations"], cpu_cache_requests=cpu["cache_requests"],
            cpu_public_requests=cpu["public_requests"], families=family_counts,
            host=host_counts, official_sandbox=False),
        graph=graph(root / "oj_graph.json", candidate_sha,
                    [f"oj{i}" for i in range(1,15)], changed_configs, binaries),
        family_graph=graph(root / "family_graph.json", candidate_sha, FAMILY, changed_configs, binaries),
        cold={str(seed):cold(root / f"cold_seed{seed}.json", candidate_sha, changed_configs)
              for seed in (0,61)},
        binary=binary_rows,
        probe_binary_equivalence=dict(path=str(probe_path), sha256=sha(probe_path),
                                      configurations=len(probe["rows"])),
        evidence_sha256={str(p.relative_to(root)):sha(p) for p in sorted(root.rglob("*"))
                         if p.is_file() and "__pycache__" not in p.relative_to(root).parts})
    with Path(args.output).open("x") as out:
        json.dump(summary, out, indent=2)
        out.write("\n")
    print(json.dumps({k:summary[k] for k in ("status", "candidate_sha256", "correctness")}, indent=2))
    print("OJ graph", summary["graph"]["aggregate"])
    print("Family graph", summary["family_graph"]["aggregate"])


if __name__ == "__main__":
    main()
