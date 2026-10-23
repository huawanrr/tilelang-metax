"""Summarize all public-call samples, including conversion regressions."""
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent


def gm(values):
    return math.exp(statistics.mean(math.log(v) for v in values))


def main():
    studies = []
    for filename in ("checked_fast_public.json", "checked_fast_conversion.json"):
        data = json.loads((HERE / filename).read_text())
        for path, expected in data["sha256"].items():
            assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected
        study = dict(file=filename, modules=[])
        paths = list(data["sha256"])
        for index in range(1, len(paths)):
            rows = []
            for row in data["rows"]:
                trials = row["trials"][index]
                assert trials
                kept = [r for r in trials if r["accepted"]]
                rows.append(dict(
                    case=row["case"], seed=row["seed"], index_mode=row.get("index_mode", "int32_contiguous"),
                    unfiltered=statistics.median(r["speedup"] for r in trials),
                    unfiltered_wall=statistics.median(r["wall_speedup"] for r in trials),
                    filtered=statistics.median(r["speedup"] for r in kept) if kept else None,
                    baseline_us=statistics.median((r["before"]["event_us"] + r["after"]["event_us"]) / 2 for r in trials),
                    candidate_us=statistics.median(r["candidate"]["event_us"] for r in trials),
                    accepted=len(kept), trials=len(trials),
                    identical_device_source=len(set(row["device_source_sha256"])) == 1,
                    max_abs_error=row["max_abs_error"][index]))
            result = dict(file=paths[index], rows=rows,
                          unfiltered_geomean=gm([r["unfiltered"] for r in rows]),
                          unfiltered_wall_geomean=gm([r["unfiltered_wall"] for r in rows]),
                          regressions=sum(r["unfiltered"] < 1 for r in rows),
                          samples=sum(r["trials"] for r in rows),
                          accepted_samples=sum(r["accepted"] for r in rows))
            study["modules"].append(result)
            print(filename, Path(paths[index]).stem, result["unfiltered_geomean"],
                  result["regressions"], "/", len(rows))
        studies.append(study)
    compatibility = json.loads((HERE / "checked_fast_compatibility.json").read_text())
    assert compatibility["status"] == "PASS"
    report = dict(decision="rejected", compatibility="PASS",
                  reason="Exception-driven normalization has severe conversion-path regressions; ready-input public-call benefit is not established above control noise.",
                  official_score_known=False, studies=studies)
    with (HERE / "checked_fast_summary.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")


if __name__ == "__main__":
    main()
