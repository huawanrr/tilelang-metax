"""Check all recorded device events and retain every cold-cache result."""
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    rows = []
    for seed in (0, 61):
        path = HERE / f"cold_seed{seed}.json"
        data = json.loads(path.read_text())
        assert len(data["rows"]) == 8
        for filename, expected in data["sha256"].items():
            assert hashlib.sha256((ROOT / filename).read_bytes()).hexdigest() == expected
        for row in data["rows"]:
            assert len(row["records"]) == 3
            medians = []
            for records in row["records"]:
                assert len(records) == 8
                for trial in records:
                    assert len(trial["kernel_events"]) == trial["expected_kernels"] == 48
                    total = sum(e["device_time_us"] for e in trial["kernel_events"]) / 48
                    assert abs(total - trial["total_kernel_us_per_call"]) < 1e-9
                medians.append(statistics.median(t["total_kernel_us_per_call"] for t in records))
            assert medians == row["median_kernel_us"]
            rows.append(dict(case=row["case"], seed=seed, config=row["config"],
                             baseline_us=medians[0], control_us=medians[1], candidate_us=medians[2],
                             control_speedup=medians[0] / medians[1],
                             speedup=medians[0] / medians[2],
                             max_abs_error=row["max_abs_error"][2]))
    report = dict(status="completed screening, no dispatch selection yet",
                  method="256 MB flush per public call, actual device kernel durations, 8 rounds x 48 calls x 2 seeds",
                  rows=rows, geomean=math.exp(statistics.mean(math.log(r["speedup"]) for r in rows)),
                  regressions=sum(r["speedup"] < 1 for r in rows),
                  control_geomean=math.exp(statistics.mean(math.log(r["control_speedup"]) for r in rows)))
    with (HERE / "cold_summary.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print("cold", len(rows), report["geomean"], report["regressions"], "control", report["control_geomean"])


if __name__ == "__main__":
    main()
