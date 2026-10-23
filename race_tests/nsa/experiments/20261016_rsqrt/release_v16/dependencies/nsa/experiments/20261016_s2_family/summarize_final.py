"""Verify final S2 evidence and report unfiltered performance, including losses."""
import argparse
import ast
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


def selected(c):
    return (c["S"] == 2 and c["H"] == 1 and c["HQ"] == 16 and c["D"] == 64
            and c["block_size"] == 16 and c["SEQ_LEN"] >= 64
            and c["SEQ_LEN"] % 16 == 0 and 256 <= c["B"] * c["SEQ_LEN"] <= 384)


def verify_modules(data, parent, candidate):
    digests = list(data["sha256"].values())
    assert digests == [parent, parent, candidate], digests
    for filename, digest in data["sha256"].items():
        assert sha(Path(filename)) == digest, filename


def graph_summary(data, parent, candidate):
    verify_modules(data, parent, candidate)
    rows = []
    for row in data["rows"]:
        assert selected(row["config"])
        assert len(row["graph_checks"]) == 6
        assert all(len(trials) == 24 for trials in row["trials"][1:])
        results = []
        for trials in row["trials"][1:]:
            values = [t["speedup"] for t in trials]
            kept = [t["speedup"] for t in trials if t["accepted"]]
            results.append(dict(unfiltered=statistics.median(values),
                                filtered=statistics.median(kept) if kept else None,
                                accepted=len(kept), trials=len(trials),
                                baseline_us=statistics.median((t["before_us"] + t["after_us"]) / 2 for t in trials),
                                candidate_us=statistics.median(t["candidate_us"] for t in trials)))
        rows.append(dict(case=row["case"], config=row["config"], seed=row["seed"],
                         control=results[0], candidate=results[1],
                         max_abs_error=row["max_abs_error"][2]))
    assert len(rows) == 34
    return dict(rows=rows, geomean=gm([r["candidate"]["unfiltered"] for r in rows]),
                control_geomean=gm([r["control"]["unfiltered"] for r in rows]),
                regressions=[r for r in rows if r["candidate"]["unfiltered"] < 1])


def cold_summary(datasets, parent, candidate):
    rows = []
    for seed, data in datasets:
        verify_modules(data, parent, candidate)
        assert len(data["rows"]) == 15
        assert data["flush_bytes"] == 256000000
        for row in data["rows"]:
            assert selected(row["config"])
            assert len(row["records"]) == 3
            medians = []
            for records in row["records"]:
                assert len(records) == 8
                for trial in records:
                    assert len(trial["kernel_events"]) == trial["expected_kernels"] == 48
                    total = sum(event["device_time_us"] for event in trial["kernel_events"]) / 48
                    assert abs(total - trial["total_kernel_us_per_call"]) < 1e-9
                medians.append(statistics.median(t["total_kernel_us_per_call"] for t in records))
            assert medians == row["median_kernel_us"]
            rows.append(dict(case=row["case"], config=row["config"], seed=seed,
                             baseline_us=medians[0], control_us=medians[1], candidate_us=medians[2],
                             speedup=medians[0] / medians[2], control_speedup=medians[0] / medians[1],
                             max_abs_error=row["max_abs_error"][2]))
    return dict(rows=rows, geomean=gm([r["speedup"] for r in rows]),
                control_geomean=gm([r["control_speedup"] for r in rows]),
                regressions=[r for r in rows if r["speedup"] < 1])


def binary_summary(data, parent, candidate):
    rows = []
    for row in data["rows"]:
        modules = row["modules"]
        assert len(modules) == 3
        assert [m["sha256"] for m in modules[:2]] == [parent, candidate]
        for module in modules:
            assert sha(Path(module["path"])) == module["sha256"]
        old, new, probe = [m["parts"] for m in modules]
        assert len(old) == len(new) == len(probe)
        is_selected = selected(row["config"])
        expected = probe if is_selected else old
        for actual, target in zip(new, expected):
            for field in ("device_source_sha256", "resources", "compile_flags"):
                assert actual[field] == target[field]
            assert actual["sections"][".text"] == target["sections"][".text"]
        changed = any(a["sections"][".text"] != b["sections"][".text"] for a, b in zip(old, new))
        assert changed == is_selected
        rows.append(dict(case=row["case"], config=row["config"], changed=changed,
                         equals_probe=is_selected, equals_parent=not is_selected))
    assert len(rows) == 22
    assert [row["case"] for row in rows if row["case"].startswith("oj") and row["changed"]] == ["oj10"]
    return dict(configurations=len(rows), rows=rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--study-dir", default=str(HERE))
    parser.add_argument("--module", default=str(HERE / "candidate_s2.py"))
    parser.add_argument("--parent", default=str(HERE / "baseline.py"))
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    directory, module, parent = Path(args.study_dir), Path(args.module), Path(args.parent)
    candidate_sha, parent_sha = sha(module), sha(parent)
    assert parent_sha == "d3c4e9f7417069efc0a0189d5754d4f8e765034c848c2219d32e869dd3b22080"
    evidence = {}

    def read(name):
        path = directory / name
        evidence[name] = sha(path)
        return json.loads(path.read_text())

    cpu = read("candidate_dispatch_cpu.json")
    assert cpu["status"] == "PASS" and candidate_sha in cpu["sources"].values()
    assert parent_sha in cpu["sources"].values()
    assert all(selected(row["config"]) for row in cpu["changed_default_dispatch"])
    validation = read("candidate_validation.json")
    assert validation["status"] == "PASS" and validation["source_sha256"] == candidate_sha
    assert validation["parent_sha256"] == parent_sha
    counts = {name: len(validation[name]) for name in
              ("strict_fp32", "boundaries", "scales", "live", "restricted", "compiled_cache_orders")}
    assert counts == dict(strict_fp32=7, boundaries=38, scales=30, live=36,
                          restricted=6, compiled_cache_orders=64), counts
    graph = graph_summary(read("candidate_family_screen.json"), parent_sha, candidate_sha)
    cold = cold_summary([(seed, read(f"candidate_cold_seed{seed}.json")) for seed in (0, 61)],
                        parent_sha, candidate_sha)
    binary = binary_summary(read("candidate_binary/report.json"), parent_sha, candidate_sha)
    functions = [{n.name: ast.dump(n) for n in ast.parse(p.read_text()).body if isinstance(n, ast.FunctionDef)}
                 for p in (parent, module)]
    changed = [name for name in functions[0] if functions[0][name] != functions[1].get(name)]
    assert changed == ["_get_kernel"], changed
    added = sorted(set(functions[1]) - set(functions[0]))
    assert added == ["native_sparse_attention_short_list_oct8_wave_output_v15"]
    errors = [r["max_abs_error"] for field in ("boundaries", "scales", "restricted", "compiled_cache_orders")
              for r in validation[field]]
    errors += [r["graph_max_abs_error"] for r in validation["live"]]
    errors += [r["direct_max_abs_error"] for r in validation["live"]]
    errors += [r["max_abs_error"] for r in graph["rows"] + cold["rows"]]
    report = dict(status="PASS", candidate_sha256=candidate_sha, parent_v14_sha256=parent_sha,
                  user_reported_current_score=89, official_target=89.5,
                  official_candidate_score=None, official_target_verified=False,
                  scope="Default S2, H1, G16, D64, complete BS16, T >= 64, 256 <= B*H*T <= 384",
                  changed_original_functions=changed, new_functions=added,
                  all_original_builders_and_public_interfaces_unchanged=True,
                  correctness=dict(**counts, max_abs_error=max(errors),
                                   cpu_configurations=cpu["configurations"],
                                   cpu_cache_requests=cpu["cache_requests"],
                                   cpu_public_requests=cpu["public_requests"],
                                   both_public_interfaces=True, tf32_disabled=True,
                                   official_sandbox=False),
                  graph=graph, cold=cold, binary=binary, evidence_sha256=evidence)
    output = Path(args.output)
    with output.open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print("PASS", counts, "graph", graph["geomean"], "cold", cold["geomean"],
          "cold losses", len(cold["regressions"]), "max error", max(errors))


if __name__ == "__main__":
    main()
