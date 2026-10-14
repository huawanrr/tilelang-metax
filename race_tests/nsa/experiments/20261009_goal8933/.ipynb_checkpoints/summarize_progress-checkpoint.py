"""Summarize all positive and negative measurements without inventing scores."""
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent


def aggregate(values):
    if not values:
        return dict(count=0)
    return dict(count=len(values), geometric_mean=math.exp(statistics.mean(map(math.log, values))),
                minimum=min(values), maximum=max(values), faster=sum(v > 1 for v in values))


def main():
    files = sorted(HERE.glob("*_screen.json"))
    files += sorted(HERE.glob("*_family.json"))
    reports = []
    for path in files:
        data = json.loads(path.read_text())
        names = list(data["sha256"])
        item = dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                    completed_rows=len(data["rows"]), modules=[])
        for index, name in enumerate(names[1:], 1):
            accepted, all_samples, rows = [], [], []
            for row in data["rows"]:
                summary = row["summaries"][index - 1]
                speed = summary["median_speedup"]
                raw = statistics.median(t["speedup"] for t in row["trials"][index])
                if speed is not None:
                    accepted.append(speed)
                all_samples.append(raw)
                rows.append(dict(case=row["case"], seed=row["seed"], config=row["config"],
                                 speedup=speed, all_samples_speedup=raw,
                                 baseline_us=summary["median_baseline_us"],
                                 candidate_us=summary["median_candidate_us"],
                                 accepted=summary["accepted"], total=summary["total"],
                                 device_cpp_equal=row["device_source_sha256"][index] == row["device_source_sha256"][0],
                                 compile_flags=row["compile_flags"][index]))
            item["modules"].append(dict(path=name, sha256=data["sha256"][name],
                                         accepted=aggregate(accepted), unfiltered=aggregate(all_samples), rows=rows))
            print(path.stem, Path(name).name, json.dumps(aggregate(accepted)), flush=True)
        reports.append(item)
    result = dict(official_baseline_score=88.71, target_score=89.33,
                  official_candidate_score=None, official_target_confirmed=False,
                  reports=reports,
                  note="Local measurements only. Unchanged device binaries are not code improvements. Partial reports list completed rows explicitly.")
    (HERE / "research_progress.json").write_text(json.dumps(result, indent=2) + "\n")


if __name__ == "__main__":
    main()
