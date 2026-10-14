"""Summarize raw final measurements without hiding rejected drift samples."""
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
        accepted += sum(trial["accepted"] for trial in trials)
        total += len(trials)
        values = [trial["speedup"] for trial in trials
                  if trial["accepted"] or not accepted_only]
        assert values, (row["case"], row["seed"], module)
        medians.append(statistics.median(values))
    if not medians:
        return dict(count=0)
    return dict(count=len(medians),
                geomean=math.exp(statistics.mean(map(math.log, medians))),
                minimum=min(medians), maximum=max(medians),
                improved=sum(value > 1 for value in medians),
                regressed=sum(value < 1 for value in medians),
                accepted_trials=accepted, total_trials=total)


def measured_change(row):
    return (row["device_source_sha256"][0] != row["device_source_sha256"][2]
            or row["compile_flags"][0] != row["compile_flags"][2])


def group(rows):
    return dict(candidate_accepted=stats(rows, 2, True),
                candidate_unfiltered=stats(rows, 2, False),
                control_accepted=stats(rows, 1, True),
                control_unfiltered=stats(rows, 1, False))


def hot(path, expected_rows):
    data = json.loads(Path(path).read_text())
    assert data["shared_pool"] and len(data["rows"]) == expected_rows
    assert len(data["sha256"]) == 3
    for row in data["rows"]:
        assert row["device_source_sha256"][0] == row["device_source_sha256"][1]
        assert row["compile_flags"][0] == row["compile_flags"][1]
    rows = data["rows"]
    changed = [row for row in rows if measured_change(row)]
    same = [row for row in rows if not measured_change(row)]
    return dict(source=str(path), source_sha256=digest(path),
                method=data["method"], modules=data["sha256"], command=data["command"],
                all=group(rows), changed=group(changed), unchanged=group(same),
                s8_changed=group([row for row in changed if row["config"]["S"] == 8]),
                s1_changed=group([row for row in changed if row["config"]["S"] == 1]),
                changed_cases=[dict(case=row["case"], seed=row["seed"], config=row["config"],
                                    summary=row["summaries"][1]) for row in changed],
                negative_cases=[dict(case=row["case"], seed=row["seed"],
                                     changed=measured_change(row), summaries=row["summaries"])
                                for row in rows if row["summaries"][1]["median_speedup"] < 1],
                max_abs_error=max(error for row in rows for error in row["max_abs_error"]))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--family", required=True)
    parser.add_argument("--full", required=True)
    parser.add_argument("--cold", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    family = hot(args.family, 114)
    full = hot(args.full, 109)
    cold = json.loads(Path(args.cold).read_text())
    assert len(cold["rows"]) == 4
    cold_rows = []
    for row in cold["rows"]:
        assert len(row["records"]) == 3
        for records in row["records"]:
            for record in records:
                assert len(record["kernel_events"]) == record["expected_kernels"]
        per_round = [base["total_kernel_us_per_call"] / new["total_kernel_us_per_call"]
                     for base, new in zip(row["records"][0], row["records"][2])]
        cold_rows.append(dict(case=row["case"], config=row["config"],
                              median_kernel_us=row["median_kernel_us"], speedup=row["speedup"],
                              paired_round_speedups=per_round,
                              rounds=len(row["records"][0]),
                              max_abs_error=max(row["max_abs_error"])))
    report = dict(command=sys.argv, official_baseline_score=88.29,
                  official_candidate_score=None, target_score=89, official_target_confirmed=False,
                  family=family, full=full,
                  cold=dict(source=args.cold, source_sha256=digest(args.cold),
                            method=cold["method"], flush_bytes=cold["flush_bytes"],
                            modules=cold["sha256"], rows=cold_rows),
                  limitation="Local timings, not a prediction or confirmation of the official score.")
    Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    for label, data in (("family", family), ("full", full)):
        print(label, json.dumps({key: data[key] for key in ("all", "changed", "unchanged")}))
    for row in cold_rows:
        print("cold", json.dumps(row))


if __name__ == "__main__":
    main()
