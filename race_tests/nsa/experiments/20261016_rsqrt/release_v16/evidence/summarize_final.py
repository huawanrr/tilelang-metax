"""Bind candidate correctness and performance evidence to actual device bytes."""
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def gm(values):
    return math.exp(statistics.mean(math.log(value) for value in values))


def read(name):
    return json.loads((HERE / name).read_text())


def verify_modules(data):
    for path, digest in data["sha256"].items():
        assert sha(Path(path)) == digest, path


def binaries():
    data = read("candidate_binary/report.json")
    assert len(data["rows"]) == 23
    bindings, changed = {}, []
    for row in data["rows"]:
        parent, probe, candidate = row["modules"]
        for module in row["modules"]:
            assert sha(Path(module["path"])) == module["sha256"]
        assert len(parent["parts"]) == len(candidate["parts"])
        selected = row["case"] == "oj1"
        compared = probe if selected else parent
        for actual, expected in zip(candidate["parts"], compared["parts"]):
            for key in ("device_source_sha256", "resources", "compile_flags"):
                assert actual[key] == expected[key], (row["case"], key)
            assert actual["sections"][".text"] == expected["sections"][".text"]
        if selected:
            assert candidate["parts"][0]["sections"][".text"] != parent["parts"][0]["sections"][".text"]
            changed.append(row["case"])
        bindings[row["case"]] = {"parent": parent, "probe": probe, "candidate": candidate}
    assert changed == ["oj1"]
    return bindings


def graph_rows(filename, bindings, source):
    data = read(filename)
    verify_modules(data)
    rows = []
    for row in data["rows"]:
        if row.get("base_case", row["case"]) != "oj1":
            continue
        assert row["device_source_sha256"][0] == [p["device_source_sha256"] for p in bindings["oj1"]["parent"]["parts"]]
        assert row["device_source_sha256"][2] == [p["device_source_sha256"] for p in bindings["oj1"][source]["parts"]]
        control = statistics.median(t["speedup"] for t in row["trials"][1])
        trials = row["trials"][2]
        kept = [t["speedup"] for t in trials if t["accepted"]]
        rows.append(dict(evidence=filename, case=row["case"], seed=row["seed"],
                         source=source, speedup=statistics.median(t["speedup"] for t in trials),
                         filtered_speedup=statistics.median(kept) if kept else None,
                         control_speedup=control, accepted=len(kept), trials=len(trials),
                         max_abs_error=row["max_abs_error"][2]))
    return rows


def cold_row(filename, seed, source):
    data = read(filename)
    verify_modules(data)
    row = next(row for row in data["rows"] if row["case"] == "oj1")
    for records in row["records"]:
        for record in records:
            assert len(record["kernel_events"]) == record["expected_kernels"]
    return dict(evidence=filename, seed=seed, source=source,
                baseline_us=row["median_kernel_us"][0], candidate_us=row["median_kernel_us"][2],
                speedup=row["speedup"][2], control_speedup=row["speedup"][1],
                max_abs_error=row["max_abs_error"][2])


def max_error(value):
    found = []
    if isinstance(value, dict):
        for key, item in value.items():
            if key.endswith("max_abs_error") and isinstance(item, (int, float)):
                found.append(item)
            elif isinstance(item, (dict, list)):
                found.append(max_error(item))
    elif isinstance(value, list):
        found.extend(max_error(item) for item in value)
    return max(found, default=0.0)


def main():
    manifest = read("candidate_manifest.json")
    assert sha(HERE / "candidate.py") == manifest["candidate_sha256"]
    assert sha(HERE / "baseline.py") == manifest["parent_sha256"]
    checked = read("candidate_validation.json")
    assert checked["status"] == "PASS"
    assert checked["candidate_sha256"] == manifest["candidate_sha256"]
    assert "PASS" in (HERE / "candidate_rules.log").read_text()
    numeric = read("math.json")
    assert numeric["status"] == "PASS"
    bound = binaries()
    hot = graph_rows("storage.json", bound, "probe") + graph_rows("candidate_storage.json", bound, "candidate")
    assert len(hot) == 24 and {row["seed"] for row in hot} == {0, 61, 2026}
    followup = graph_rows("candidate_storage_recheck.json", bound, "candidate")
    assert len(followup) == 24 and {row["seed"] for row in followup} == {2026, 73, 8173}
    cold = [cold_row(f"cold_seed{seed}.json", seed, "probe") for seed in (0, 61)]
    cold.append(cold_row("candidate_cold_seed2026.json", 2026, "candidate"))
    validation_counts = {key: len(checked[key]) for key in
                         ("boundaries", "scales", "zero_inputs", "live", "restricted", "cache_orders")}
    active_binary = bound["oj1"]["candidate"]["parts"][0]
    research = read("summary.json")["studies"][0]
    family = read("family_summary.json")["studies"][0]
    evidence = ["candidate.py", "baseline.py", "control.py", "rsqrt.py", "ieee_rsqrt.py",
                "candidate_manifest.json", "candidate_validation.json", "candidate_rules.log",
                "math.json", "manifest.json", "screen.json", "summary.json", "storage.json",
                "storage_summary.json", "family.json", "family_summary.json", "family_plan.json",
                "cold_plan.json", "cold_status.json", "cold_seed0.json", "cold_seed61.json",
                "candidate_storage.json", "candidate_storage_summary.json", "candidate_cold_seed2026.json",
                "candidate_storage_recheck.json", "candidate_storage_recheck_summary.json",
                "storage_recheck_plan.json", "candidate_binary/report.json", "binary/report.json", "binary_summary.json"]
    report = dict(status="PASS", candidate_sha256=manifest["candidate_sha256"],
                  parent_v15_sha256=manifest["parent_sha256"], user_reported_score=89,
                  official_candidate_score=None, official_target=89.5, official_target_verified=False,
                  changed_functions=manifest["changed_functions"], new_helper=manifest["new_helper"],
                  unchanged_original_functions=manifest["unchanged_original_functions"],
                  dispatch_and_public_functions_equal=True,
                  graph=dict(rows=hot, geomean=gm([r["speedup"] for r in hot]),
                             control_geomean=gm([r["control_speedup"] for r in hot]),
                             regressions=[r for r in hot if r["speedup"] < 1]),
                  graph_confirmation=dict(rows=followup, geomean=gm([r["speedup"] for r in followup]),
                             control_geomean=gm([r["control_speedup"] for r in followup]),
                             regressions=[r for r in followup if r["speedup"] < 1]),
                  cold=dict(rows=cold, geomean=gm([r["speedup"] for r in cold]),
                            control_geomean=gm([r["control_speedup"] for r in cold]),
                            regressions=[r for r in cold if r["speedup"] < 1]),
                  correctness=dict(**validation_counts, strict_fp32_builders=1,
                      strict_fp32_mma_calls=sum(r["shape"] == "16x16x4f32" for r in checked["strict_fp32"]),
                      max_abs_error=max(max_error(checked), max_error(hot), max_error(followup), max_error(cold)),
                      math_inputs=numeric["inputs"], rsqrt_math=next(r for r in numeric["rows"] if r["mode"] == "rsqrt")),
                  binary=dict(configurations=23, modules=3, changed_oj=["oj1"],
                              unchanged_oj=[f"oj{i}" for i in range(2, 15)],
                              resources=active_binary["resources"], text=active_binary["sections"][".text"],
                              selected_matches_screened_probe=True),
                  rejected_research=dict(initial_all_shape_results=[dict(
                      file=m["file"], geomean=m["unfiltered_geomean"], regressions=m["regressions"])
                      for m in research["modules"]], direct_rsqrt_family=[dict(
                      file=m["file"], geomean=m["unfiltered_geomean"], regressions=m["regressions"])
                      for m in family["modules"]],
                      note="Broad direct-rsqrt family and BS32/S8/multihead changes rejected; final change is only the existing tiny D32 path."),
                  performance_scope="OJ1 only; no new fourteen-OJ aggregate or official score. Earlier probe timings are bound to identical candidate device bytes.",
                  performance_review="The initial expectation of positive timing at every placement was not met: 2/24 initial rows and 8/24 fixed follow-up rows regress. Retain all rows. Recommend as a cold-cache improvement (three positive seeds) with positive overall hot measurements, not a universal speedup; keep v15 as fallback.",
                  evidence_sha256={name: sha(HERE / name) for name in evidence})
    assert not report["cold"]["regressions"]
    assert report["graph"]["geomean"] > 1 and report["graph_confirmation"]["geomean"] > 1
    with (HERE / "final_summary.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print("PASS", "hot", report["graph"]["geomean"], "cold", report["cold"]["geomean"],
          "hot confirmation", report["graph_confirmation"]["geomean"],
          "max abs error", report["correctness"]["max_abs_error"])


if __name__ == "__main__":
    main()
