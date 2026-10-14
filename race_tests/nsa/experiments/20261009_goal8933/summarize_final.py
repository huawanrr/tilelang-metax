"""Summarize all final measurements without converting local time into an OJ score."""
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent


def aggregate(values):
    values = [x for x in values if x is not None]
    return (dict(count=len(values), geometric_mean=math.exp(statistics.mean(map(math.log, values))),
        minimum=min(values), maximum=max(values), faster=sum(v > 1 for v in values)) if values else dict(count=0))


def graph_report(path):
    data = json.loads(path.read_text())
    names = list(data["sha256"])
    index = next(i for i, name in enumerate(names) if Path(name).name == "candidate_v7_submission.py")
    rows = []
    for row in data["rows"]:
        summary = row["summaries"][index-1]
        values = row["trials"][index]
        rows.append(dict(case=row["case"], seed=row["seed"], config=row["config"],
            changed_vs_v4=row["device_source_sha256"][index] != row["device_source_sha256"][0],
            speedup=summary["median_speedup"], all_samples_speedup=statistics.median(v["speedup"] for v in values),
            baseline_us=summary["median_baseline_us"], candidate_us=summary["median_candidate_us"],
            accepted=summary["accepted"], total=summary["total"]))
    result = dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        accepted=aggregate([r["speedup"] for r in rows]),
        unfiltered=aggregate([r["all_samples_speedup"] for r in rows]),
        changed=aggregate([r["speedup"] for r in rows if r["changed_vs_v4"]]),
        unchanged=aggregate([r["speedup"] for r in rows if not r["changed_vs_v4"]]),
        control=aggregate([r["summaries"][0]["median_speedup"] for r in data["rows"]]), rows=rows)
    parent_index = next((i for i, n in enumerate(names) if Path(n).name == "parent_submission.py"), None)
    if parent_index is not None:
        result["v6_parent_vs_v4"] = aggregate([r["summaries"][parent_index-1]["median_speedup"] for r in data["rows"]])
    return result


def main():
    runs = json.loads((HERE / "final_runs.json").read_text())
    assert {r["name"] for r in runs if r["status"] == "PASS"} >= {
        "v7_static", "v7_reference", "v7_extra", "v7_oj", "v7_full", "v7_audit"}
    assert all(r["status"] == "PASS" for r in runs)
    extra = json.loads((HERE / "v7_extra.json").read_text())
    audit = json.loads((HERE / "v7_audit.json").read_text())
    assert extra["status"] == audit["status"] == "PASS"
    oj, full = [graph_report(HERE / name) for name in ("v7_oj.json", "v7_full.json")]
    cold = []
    for filename in ("preview_cold_seed0.json", "preview_cold_seed61.json"):
        path = HERE / filename
        data = json.loads(path.read_text())
        candidate_hash = data["sha256"][str(HERE / "candidate_v7_preview_submission.py")]
        assert candidate_hash == hashlib.sha256((HERE / "candidate_v7_submission.py").read_bytes()).hexdigest()
        rows = [dict(case=r["case"], config=r["config"], baseline_us=r["median_kernel_us"][0],
            candidate_us=r["median_kernel_us"][2], speedup=r["speedup"][2], control=r["speedup"][1],
            all_rounds_candidate=[s["total_kernel_us_per_call"] for s in r["records"][2]]) for r in data["rows"]]
        cold.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            byte_identical_final_submission=True, aggregate=aggregate([r["speedup"] for r in rows]),
            control=aggregate([r["control"] for r in rows]), rows=rows))
    public = json.loads((HERE / "host_public_loop.json").read_text())
    host_reports = []
    for i, name in enumerate(list(public["sha256"])[1:], 1):
        host_reports.append(dict(module=name,
            accepted=aggregate([r["summaries"][i-1]["median_speedup"] for r in public["rows"]]),
            unfiltered=aggregate([r["summaries"][i-1]["all_samples_speedup"] for r in public["rows"]]),
            note="Includes Python issue gaps. Kept separate from GPU graphs and official scoring."))
    result = dict(official_baseline_score=88.71, official_baseline="v4", target_score=89.33,
        official_candidate_score=None, target_confirmed=False,
        submission=str(HERE / "candidate_v7_submission.py"),
        submission_sha256=hashlib.sha256((HERE / "candidate_v7_submission.py").read_bytes()).hexdigest(),
        development_sha256=hashlib.sha256((HERE / "candidate_v7.py").read_bytes()).hexdigest(),
        oj=oj, full=full, cold=cold, public_loop=host_reports,
        validation=dict(reference_cases=125, both_public_interfaces=True,
            **{key: len(extra[key]) for key in ("boundaries", "extreme_scales", "tuning", "cache_order", "live_inputs", "restricted_host")},
            tuning_preserved_unsupported=sum("error_type" in r["outcomes"][0] for r in extra["tuning"]),
            audited_configurations=len(audit["configurations"]), audited_timings=len(audit["timings"]),
            kept_original_functions=len(audit["kept_functions"]),
            appended_functions=len(audit["appended_functions"])),
        limits=["Official private-grader timing method and new score are not available.",
                "Warm-cache family regressions remain in the research data; cold checks cover representative adverse cases.",
                "RestrictedPython host checks are local compatibility checks, not the official sandbox."])
    path = HERE / "performance_summary.json"
    with path.open("x") as output:
        json.dump(result, output, indent=2)
        output.write("\n")
    print(json.dumps(dict(oj=oj["accepted"], full=full["accepted"],
        cold=[v["aggregate"] for v in cold], validation=result["validation"]), indent=2))


if __name__ == "__main__":
    main()
