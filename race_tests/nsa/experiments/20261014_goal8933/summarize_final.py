"""Summarize final results without dropping regressions or predicting OJ scores."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import statistics


def read(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def geomean(values):
    return math.exp(statistics.mean(math.log(v) for v in values)) if values else None


def key(config):
    return json.dumps(config, sort_keys=True)


def hot_summary(data):
    rows = []
    for original in data["rows"]:
        summaries = []
        for index, trials in enumerate(original["trials"][1:]):
            kept = [trial for trial in trials if trial["accepted"]]
            assert kept, (original["case"], original["seed"], index)
            filtered = statistics.median(t["speedup"] for t in kept)
            assert filtered == original["summaries"][index]["median_speedup"]
            summaries.append(dict(filtered_speedup=filtered,
                unfiltered_speedup=statistics.median(t["speedup"] for t in trials),
                accepted=len(kept), total=len(trials),
                filtered_baseline_us=original["summaries"][index]["median_baseline_us"],
                filtered_candidate_us=original["summaries"][index]["median_candidate_us"]))
        assert original["device_source_sha256"][0] == original["device_source_sha256"][1]
        rows.append(dict(case=original["case"], seed=original["seed"],
            config=original["config"], source_changed=(original["device_source_sha256"][0]
                != original["device_source_sha256"][2]),
            control=summaries[0], candidate=summaries[1]))
    report = dict(rows=rows, count=len(rows))
    for group_name, group in (
        ("all", rows), ("changed", [r for r in rows if r["source_changed"]]),
        ("unchanged", [r for r in rows if not r["source_changed"]]),
    ):
        report[group_name] = dict(count=len(group), **{
            variant: {kind: geomean([r[variant][kind + "_speedup"] for r in group])
                      for kind in ("filtered", "unfiltered")}
            for variant in ("control", "candidate")})
    report["candidate_regressions"] = [dict(case=r["case"], seed=r["seed"],
        source_changed=r["source_changed"], speedup=r["candidate"]["filtered_speedup"])
        for r in rows if r["candidate"]["filtered_speedup"] < 1]
    report["changed_improved_count"] = sum(r["source_changed"] and
        r["candidate"]["filtered_speedup"] > 1 for r in rows)
    return report


def cold_summary(data, affected):
    rows = []
    for row in data["rows"]:
        assert "failure" not in row
        for records in row["records"]:
            assert len(records) == 6
            for record in records:
                assert len(record["kernel_events"]) == record["expected_kernels"]
        rows.append(dict(case=row["case"], config=row["config"],
            median_kernel_us=row["median_kernel_us"],
            control_speedup=row["speedup"][1], candidate_speedup=row["speedup"][2],
            rounds_us=[[r["total_kernel_us_per_call"] for r in group] for group in row["records"]]))
    result = dict(rows=rows, flush_bytes=data["flush_bytes"], method=data["method"])
    for name, group in (("all", rows),
                        ("official_tested", [r for r in rows if r["case"].startswith("oj")]),
                        ("official_changed", [r for r in rows if r["case"] in affected]),
                        ("holdouts", [r for r in rows if not r["case"].startswith("oj")])):
        result[name] = dict(count=len(group),
            control=geomean([r["control_speedup"] for r in group]),
            candidate=geomean([r["candidate_speedup"] for r in group]))
    result["candidate_regressions"] = [r["case"] for r in rows if r["candidate_speedup"] < 1]
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("validation")
    parser.add_argument("--module", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--expected-oj", required=True,
                        help="Comma-separated OJ cases expected to change device instructions")
    args = parser.parse_args()
    directory, module = Path(args.validation), Path(args.module)
    status = read(directory / "status.json")
    assert status["status"] == "PASS" and all(job["exit_code"] == 0 for job in status["jobs"])
    candidate_hash, baseline_hash = status["module_sha256"], status["baseline_sha256"]
    assert digest(module) == candidate_hash
    reference = read(directory / "reference.json")
    changed = read(directory / "changed_families.json")
    dispatch = read(directory / "dispatch.json")
    legacy = read(directory / "legacy_guards.json")
    assert len(reference) == 125 and all(r["status"] == "PASS" for r in reference)
    assert changed["status"] == dispatch["status"] == legacy["status"] == "PASS"
    assert changed["source_sha256"] == legacy["source_sha256"] == candidate_hash
    assert set(dispatch["sources"].values()) == {candidate_hash, baseline_hash}
    hot = {name: read(directory / (name + ".json")) for name in ("oj", "full")}
    assert len(hot["oj"]["rows"]) == 28 and len(hot["full"]["rows"]) == 109
    cold = {name: read(directory / (name + ".json")) for name in ("cold_seed0", "cold_seed61")}
    for data in [*hot.values(), *cold.values()]:
        assert list(data["sha256"].values()) == [baseline_hash, baseline_hash, candidate_hash]
    binary = read(directory / "binary/report.json")
    actual = {}
    binary_rows = []
    for row in binary["rows"]:
        assert [record["sha256"] for record in row["modules"]] == [baseline_hash, candidate_hash]
        parts = [record["parts"] for record in row["modules"]]
        hashes = [[p["sections"][".text"]["sha256"] for p in group] for group in parts]
        source_hashes = [[p["device_source_sha256"] for p in group] for group in parts]
        flags = [[p["compile_flags"] for p in group] for group in parts]
        assert len(parts[0]) == len(parts[1]), (row["case"], "launch count changed")
        assert flags[0] == flags[1], (row["case"], "compiler flags changed")
        for index, group in enumerate(parts):
            for part_index, part in enumerate(group):
                source = directory / "binary" / f"{row['case']}_m{index}_p{part_index}.cpp"
                assert digest(source) == part["device_source_sha256"]
                assert not any(token in source.read_text() for token in
                    ("memcpy_async", "cp.async", "maca_async", "tma_load", "mbarrier"))
        actual[key(row["config"])] = dict(source_hashes=source_hashes, flags=flags)
        binary_rows.append(dict(case=row["case"], config=row["config"],
            text_changed=hashes[0] != hashes[1], text_sha256=hashes,
            source_sha256=source_hashes, resources=[[p["resources"] for p in group] for group in parts]))
    affected = [row["case"] for row in binary_rows if row["case"].startswith("oj") and row["text_changed"]]
    assert set(affected) == set(args.expected_oj.split(",")), affected
    correspondence = []
    for name, data in hot.items():
        for row in data["rows"]:
            if key(row["config"]) not in actual:
                continue
            record = actual[key(row["config"])]
            assert row["device_source_sha256"] == [record["source_hashes"][0],
                record["source_hashes"][0], record["source_hashes"][1]], (name, row["case"], "source")
            assert row["compile_flags"] == [record["flags"][0], record["flags"][0], record["flags"][1]]
            correspondence.append(dict(dataset=name, case=row["case"], seed=row["seed"]))
    assert sum(r["dataset"] == "oj" for r in correspondence) == 28
    report = dict(status="PASS", official_baseline_score=88.93, official_target=89.33,
        official_candidate_score=None, official_target_verified=False,
        candidate_sha256=candidate_hash, baseline_sha256=baseline_hash,
        correctness=dict(reference_cases=len(reference), both_public_interfaces=True,
            max_abs_error=max(r["max_abs_error"] for r in reference),
            strict_fp32_builders=len(changed["strict_fp32"]), boundaries=len(changed["boundaries"]),
            scales=len(changed["scales"]), live_graph_and_direct=len(changed["live"]),
            restricted_host=len(changed["restricted"]), official_sandbox=False,
            dispatch_configurations=dispatch["configurations"], dispatch_requests=dispatch["requests"],
            legacy_guard_cases=len(legacy["rows"])),
        hot={name: hot_summary(data) for name, data in hot.items()},
        cold={name: cold_summary(data, affected) for name, data in cold.items()},
        binary=dict(configurations=len(binary_rows), affected_official_cases=affected,
            timed_source_matches=correspondence, rows=binary_rows),
        evidence_sha256={str(p.relative_to(directory)): digest(p)
            for p in sorted(directory.rglob("*.json"))})
    with Path(args.output).open("x") as file:
        json.dump(report, file, indent=2)
        file.write("\n")
    print(json.dumps({"correctness": report["correctness"],
        "hot": {n: d["all"] for n, d in report["hot"].items()},
        "cold": {n: {k: d[k] for k in ("official_changed", "holdouts")} for n, d in report["cold"].items()},
        "binary_affected": affected}, indent=2))


if __name__ == "__main__":
    main()
