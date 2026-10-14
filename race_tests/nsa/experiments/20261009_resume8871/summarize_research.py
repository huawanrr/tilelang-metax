"""Summarize all completed and partial screens without dropping regressions."""
import hashlib
import json
import math
from pathlib import Path
import statistics
from datetime import datetime, timezone

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
NAMES = ("v6_oj", "tensor_denom_screen", "wave_group_pack_screen", "packed_tensor_denom_screen",
         "small_denom_floor_screen", "unsigned_guard_screen", "pair_ilp_screen", "d32_denom_family")


def stats(values):
    if not values:
        return dict(count=0)
    return dict(count=len(values), geomean=math.exp(statistics.mean(math.log(v) for v in values)),
                minimum=min(values), maximum=max(values), improved=sum(v > 1 for v in values))


def main():
    report = dict(updated_utc=datetime.now(timezone.utc).isoformat(), official_baseline_score=88.71,
                  official_candidate_score=None, target=89.5, screens=[])
    for name in NAMES:
        path = HERE / (name + ".json")
        if not path.exists():
            continue
        data = json.loads(path.read_text())
        modules = list(data["sha256"])
        assert all(hashlib.sha256((ROOT / p).read_bytes()).hexdigest() == value
                   for p, value in data["sha256"].items())
        entry = dict(name=name, path=str(path.relative_to(ROOT)), completed_records=len(data["rows"]),
                     source_sha256=data["sha256"], shared_pool=data["shared_pool"], variants=[])
        for index, module in enumerate(modules[1:], 1):
            records = []
            for row in data["rows"]:
                summary = row["summaries"][index - 1]
                changed = row["device_source_sha256"][0] != row["device_source_sha256"][index]
                all_ratio = statistics.median(v["speedup"] for v in row["trials"][index])
                records.append(dict(case=row["case"], seed=row["seed"], config=row["config"],
                    changed_device_source=changed, accepted=summary["accepted"], total=summary["total"],
                    speedup=summary["median_speedup"], unfiltered_speedup=all_ratio,
                    baseline_us=summary["median_baseline_us"], candidate_us=summary["median_candidate_us"]))
            filtered = [r["speedup"] for r in records if r["speedup"] is not None]
            changed = [r["speedup"] for r in records if r["changed_device_source"] and r["speedup"] is not None]
            entry["variants"].append(dict(module=module, accepted_stats=stats(filtered),
                changed_stats=stats(changed), unfiltered_stats=stats([r["unfiltered_speedup"] for r in records]),
                negative_records=[r for r in records if r["speedup"] is not None and r["speedup"] < 1],
                records=records))
        report["screens"].append(entry)
    target = HERE / "research_progress.json"
    target.write_text(json.dumps(report, indent=2) + "\n")
    print(target)
    for screen in report["screens"]:
        print(screen["name"], screen["completed_records"],
              [(Path(v["module"]).name, v["changed_stats"]) for v in screen["variants"]])


if __name__ == "__main__":
    main()
