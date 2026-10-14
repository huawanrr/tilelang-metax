"""Summarize local measurements, retaining controls and negative samples."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import statistics
import sys


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def stats(rows, module, accepted_only):
    medians = []
    accepted = total = 0
    for row in rows:
        trials = row["trials"][module]
        accepted += sum(t["accepted"] for t in trials)
        total += len(trials)
        values = [t["speedup"] for t in trials if t["accepted"] or not accepted_only]
        assert values, (row["case"], row["seed"], module)
        medians.append(statistics.median(values))
    if not medians:
        return dict(count=0)
    return dict(count=len(medians), geomean=math.exp(statistics.mean(map(math.log, medians))),
        minimum=min(medians), maximum=max(medians), improved=sum(x > 1 for x in medians),
        regressed=sum(x < 1 for x in medians), accepted_trials=accepted, total_trials=total)


def changed(row, index):
    return (row["device_source_sha256"][0] != row["device_source_sha256"][index]
        or row["compile_flags"][0] != row["compile_flags"][index])


def hot(path, expected_rows, index=None, selected_keys=None):
    data = json.loads(Path(path).read_text())
    rows = data["rows"]
    assert data["shared_pool"] and len(rows) == expected_rows
    if selected_keys is not None:
        rows = [r for r in rows if (r["case"], r["seed"]) in selected_keys]
    index = len(data["sha256"]) - 1 if index is None else index
    for row in rows:
        assert row["device_source_sha256"][0] == row["device_source_sha256"][1]
        assert row["compile_flags"][0] == row["compile_flags"][1]

    def group(selected):
        return dict(candidate_accepted=stats(selected, index, True),
            candidate_unfiltered=stats(selected, index, False),
            control_accepted=stats(selected, 1, True), control_unfiltered=stats(selected, 1, False))

    altered = [r for r in rows if changed(r, index)]
    same = [r for r in rows if not changed(r, index)]
    return dict(source=str(path), source_sha256=digest(path), method=data["method"],
        modules=data["sha256"], candidate_index=index, command=data["command"], all=group(rows),
        changed=group(altered), unchanged=group(same),
        rows=[dict(case=r["case"], seed=r["seed"], config=r["config"],
            changed=changed(r, index), summary=r["summaries"][index - 1],
            control=r["summaries"][0],
            unfiltered_speedup=statistics.median(t["speedup"] for t in r["trials"][index])) for r in rows],
        negative_cases=[dict(case=r["case"], seed=r["seed"], changed=changed(r, index),
            summary=r["summaries"][index - 1]) for r in rows
            if r["summaries"][index - 1]["median_speedup"] < 1],
        max_abs_error=max(error for r in rows for error in r["max_abs_error"]))


def cold(path):
    data = json.loads(Path(path).read_text())
    rows = []
    for row in data["rows"]:
        assert len(row["records"]) == 3
        for records in row["records"]:
            for record in records:
                assert len(record["kernel_events"]) == record["expected_kernels"]
        rows.append(dict(case=row["case"], config=row["config"],
            median_kernel_us=row["median_kernel_us"], speedup=row["speedup"],
            paired_round_speedups=[a["total_kernel_us_per_call"] / b["total_kernel_us_per_call"]
                for a, b in zip(row["records"][0], row["records"][2])],
            control_round_speedups=[a["total_kernel_us_per_call"] / b["total_kernel_us_per_call"]
                for a, b in zip(row["records"][0], row["records"][1])],
            rounds=len(row["records"][0]), max_abs_error=max(row["max_abs_error"])))
    return dict(source=str(path), source_sha256=digest(path), method=data["method"],
        command=data["command"], flush_bytes=data["flush_bytes"],
        modules=data["sha256"], rows=rows)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--oj", required=True)
    p.add_argument("--full", required=True)
    p.add_argument("--cold", required=True)
    p.add_argument("--confirmation", required=True)
    p.add_argument("--components", required=True)
    p.add_argument("--short-confirmation")
    p.add_argument("--output", required=True)
    a = p.parse_args()
    observed = json.loads((Path(__file__).resolve().parent / "official_baseline.json").read_text())
    components = json.loads(Path(a.components).read_text())
    assert components["status"] == "PASS"
    assert components["timing_source_sha256"] == digest(a.confirmation)
    retained = {(r["case"], r["seed"]) for r in components["rows"] if r["retained_probe_kernel"]
                and Path(r["file"]).resolve() == Path(a.confirmation).resolve()}
    report = dict(command=sys.argv, official_baseline=observed, target_score=89.5,
        official_candidate_score=None, official_target_confirmed=False,
        oj=hot(a.oj, 28), full=hot(a.full, 109), cold=cold(a.cold),
        confirmation_probe=hot(a.confirmation, 342, index=2),
        confirmation_retained=hot(a.confirmation, 342, index=2, selected_keys=retained),
        confirmation_exclusions=[dict(file=r["file"], case=r["case"], seed=r["seed"], config=r["configuration"])
            for r in components["rows"] if not r["retained_probe_kernel"]],
        component_audit=dict(source=a.components, sha256=digest(a.components)),
        limitation="Local measurements; no official candidate score or official timing interface is available. "
                   "V4 scores 88.57 and 88.71 are repeated observations of identical code, not an optimization gain.")
    if a.short_confirmation:
        assert components["short_mode"] == "wave"
        assert any(x["sha256"] == digest(a.short_confirmation) for x in components["datasets"])
        report["short_confirmation"] = hot(a.short_confirmation, 126, index=2)
    Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
    for name in ("oj", "full", "confirmation_probe", "confirmation_retained"):
        print(name, json.dumps({k: report[name][k] for k in ("all", "changed", "unchanged")}))
    if "short_confirmation" in report:
        print("short_confirmation", json.dumps({k: report["short_confirmation"][k]
            for k in ("all", "changed", "unchanged")}))
    for row in report["cold"]["rows"]:
        print("cold", json.dumps(row))


if __name__ == "__main__":
    main()
