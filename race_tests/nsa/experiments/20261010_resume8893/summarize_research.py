"""Retain positive, negative and unfiltered outcomes from every valid screen."""
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
FILES = ("v7_vs_v6_oj", "load_mask_screen_serial", "reduction_screen", "large_mask_screen",
         "large_mixed_family", "mid_q_family", "mid_reduce_family", "d128_load_family")


def aggregate(values):
    values = [v for v in values if v is not None]
    if not values:
        return dict(count=0)
    return dict(count=len(values), geometric_mean=math.exp(statistics.mean(map(math.log, values))),
                minimum=min(values), maximum=max(values), faster=sum(v > 1 for v in values))


def main():
    reports = []
    for stem in FILES:
        path = HERE / (stem + ".json")
        if not path.exists():
            continue
        data = json.loads(path.read_text())
        names = list(data["sha256"])
        record = dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                      baseline=names[0], baseline_sha256=data["sha256"][names[0]], variants=[])
        for i, name in enumerate(names[1:], 1):
            rows = []
            for row in data["rows"]:
                s = row["summaries"][i-1]
                trials = row["trials"][i]
                rows.append(dict(case=row["case"], seed=row["seed"], config=row["config"],
                    speedup=s["median_speedup"], unfiltered_speedup=statistics.median(t["speedup"] for t in trials),
                    accepted=s["accepted"], total=s["total"],
                    baseline_us=s["median_baseline_us"], candidate_us=s["median_candidate_us"]))
            record["variants"].append(dict(module=name, sha256=data["sha256"][name],
                aggregate=aggregate([r["speedup"] for r in rows]),
                unfiltered=aggregate([r["unfiltered_speedup"] for r in rows]), rows=rows))
        reports.append(record)
    result = dict(official_baseline="candidate_v6_submission.py", user_reported_score=88.93,
        target=89.5, official_new_score=None, reports=reports,
        excluded_runs={"load_mask_screen.log": "Q16 assertion failure",
                       "load_mask_screen_v2.log": "Accidental overlapping preliminary run; terminated, excluded",
                       "load_mask_screen_v3.log": "Accidental overlapping preliminary run; terminated, excluded"},
        notes=["A source-identical control is retained in each screen.",
               "Warm-cache timing varies between runs even when source and compiler flags match.",
               "All raw trials and all regressions remain available; local time is not an official score."])
    (HERE / "research_summary.json").write_text(json.dumps(result, indent=2) + "\n")
    for report in reports:
        print(Path(report["path"]).name, [(Path(v["module"]).name,
            round(v["aggregate"]["geometric_mean"], 6)) for v in report["variants"]])


if __name__ == "__main__":
    main()
