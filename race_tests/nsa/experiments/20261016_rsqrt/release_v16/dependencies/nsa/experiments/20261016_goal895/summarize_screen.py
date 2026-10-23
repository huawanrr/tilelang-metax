"""Summarize completed graph screens without dropping adverse rows."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import statistics


def gm(values):
    return math.exp(statistics.mean(math.log(x) for x in values)) if values else None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("files", nargs="+")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    studies = []
    for filename in args.files:
        path = Path(filename)
        data = json.loads(path.read_text())
        modules = list(data["sha256"])
        for module, expected in data["sha256"].items():
            assert hashlib.sha256(Path(module).read_bytes()).hexdigest() == expected, module
        study = dict(file=filename, rows=len(data["rows"]), modules=[])
        for index, module in enumerate(modules[1:], 1):
            rows = []
            for row in data["rows"]:
                trials = row["trials"][index]
                assert trials
                raw = statistics.median(x["speedup"] for x in trials)
                kept = [x["speedup"] for x in trials if x["accepted"]]
                rows.append(dict(case=row["case"], seed=row["seed"],
                                 unfiltered=raw, filtered=statistics.median(kept) if kept else None,
                                 baseline_us=statistics.median((x["before_us"] + x["after_us"]) / 2 for x in trials),
                                 candidate_us=statistics.median(x["candidate_us"] for x in trials),
                                 accepted=len(kept), trials=len(trials),
                                 max_abs_error=row["max_abs_error"][index]))
            study["modules"].append(dict(
                file=module, sha256=data["sha256"][module], rows=rows,
                unfiltered_geomean=gm([r["unfiltered"] for r in rows]),
                filtered_geomean=gm([r["filtered"] for r in rows if r["filtered"] is not None]),
                regressions=sum(r["unfiltered"] < 1 for r in rows)))
        studies.append(study)
    Path(args.output).write_text(json.dumps(dict(studies=studies), indent=2) + "\n")
    for study in studies:
        print(study["file"], study["rows"])
        for module in study["modules"]:
            print(Path(module["file"]).stem, module["unfiltered_geomean"], module["regressions"])


if __name__ == "__main__":
    main()
