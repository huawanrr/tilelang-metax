"""Summarize all retained D128 bracket samples for explicit shape domains."""
import argparse
import hashlib
import itertools
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def geomean(values):
    return math.exp(statistics.mean(map(math.log, values)))


def selected_kind(case, config):
    if not (case["S"] == 1 and case["D"] == 128 and case["HQ"] == 16 * case["H"]
            and case["block_size"] == 16 and case["SEQ_LEN"] % 16 == 0):
        return "base"
    grid = case["B"] * case["H"] * case["SEQ_LEN"]
    for name in ("linear", "coalesced"):
        domain = config[name]
        if (domain["enabled"] and domain["min_grid"] <= grid < domain["max_grid_exclusive"]
                and case["SEQ_LEN"] >= domain["min_seq"]
                and (domain["heads"] is None or case["H"] in domain["heads"])):
            return name
    return "base"


def summarize(path, config):
    data = json.loads(path.read_text())
    for name, expected in data["sha256"].items():
        assert digest(ROOT / name) == expected, name
    command = data["command"]
    option = lambda name, default=None: command[command.index(name)+1] if name in command else default
    cases = option("--cases").split(",")
    seeds = list(map(int, option("--seeds").split(",")))
    attempts, repeat = int(option("--attempts")), int(option("--repeat"))
    drift = float(option("--max-drift", "0.01"))
    assert attempts == 24 and repeat == 500 and seeds == [0,61,2026]
    assert [(row["case"], row["seed"]) for row in data["rows"]] == list(itertools.product(cases, seeds))
    modules = list(data["sha256"])
    indices = {name: modules.index(config[name]["probe"]) - 1
               for name in ("linear", "coalesced") if config[name]["enabled"]}
    accepted, control, rows, by_kind = [], [], [], {name: [] for name in ("linear", "coalesced")}
    for row in data["rows"]:
        assert len(row["summaries"]) == len(row["trials"]) - 1
        for summary, trials in zip(row["summaries"],row["trials"][1:]):
            assert len(trials) == summary["total"] == attempts
            kept = [trial for trial in trials if trial["accepted"]]
            assert len(kept) == summary["accepted"] >= attempts // 2
            assert all(trial["accepted"] == (trial["drift"] <= drift) for trial in trials)
            assert math.isclose(summary["median_speedup"], statistics.median(
                trial["speedup"] for trial in kept), rel_tol=1e-12)
            accepted.append(len(kept))
        control.append(row["summaries"][0]["median_speedup"])
        kind = selected_kind(row["config"], config)
        if kind != "base":
            speedup = row["summaries"][indices[kind]]["median_speedup"]
            by_kind[kind].append(speedup)
            rows.append(dict(case=row["case"],seed=row["seed"],config=row["config"],kind=kind,speedup=speedup))
    ratios = [row["speedup"] for row in rows]
    return dict(report=str(path.relative_to(ROOT)), report_sha256=digest(path), shapes=len(cases),
        seed_combinations=len(data["rows"]), seeds=seeds, attempts=attempts,calls_per_graph=repeat,
        active_shapes=len({row["case"] for row in rows}), active_combinations=len(ratios),
        active_geomean=geomean(ratios), active_range=[min(ratios),max(ratios)],
        active_below_one=[row for row in rows if row["speedup"]<1],
        by_kind={name:dict(combinations=len(values),geomean=geomean(values),
                          range=[min(values),max(values)]) for name,values in by_kind.items() if values},
        control_range=[min(control),max(control)],minimum_accepted=min(accepted),
        rejected_samples_retained=True,rows=rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config",required=True)
    parser.add_argument("--output",required=True)
    args = parser.parse_args()
    config=json.loads(Path(args.config).read_text())["config"]
    summaries=[summarize(ROOT/name,config) for name in config["bracket_reports"]]
    with Path(args.output).open("x") as output:
        output.write(json.dumps(dict(config=config,reports=summaries),indent=2)+"\n")
    for report in summaries:
        print(json.dumps({key:value for key,value in report.items() if key!="rows"},indent=2))


if __name__ == "__main__":
    main()
