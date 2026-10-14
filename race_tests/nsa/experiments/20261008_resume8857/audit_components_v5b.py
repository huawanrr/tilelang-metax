"""Match retained probe kernels and restored baseline paths to timed code."""
import argparse
import json
from pathlib import Path
import sys

from audit_candidate_v5b import HERE, ROOT, changed_scope, compiled, digest
from experiment_bench import load_module


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--timings", default=str(HERE / "confirmation_screen.json"))
    parser.add_argument("--short-mode", choices=("none", "wave"), required=True)
    parser.add_argument("--short-timings")
    parser.add_argument("--output", required=True)
    a = parser.parse_args()
    datasets = [(a.timings, "candidate_probe_v2.py", False)]
    if a.short_mode == "wave":
        assert a.short_timings
        datasets.append((a.short_timings, "short_wave_lane.py", True))
    module = load_module(a.module)
    report = dict(status="running", command=sys.argv,
        source_sha256=digest(a.module), timing_source=a.timings,
        timing_source_sha256=digest(a.timings), short_mode=a.short_mode,
        datasets=[], rows=[])
    cache = {}

    def save():
        Path(a.output).write_text(json.dumps(report, indent=2) + "\n")

    save()
    for filename, component, short in datasets:
        data = json.loads(Path(filename).read_text())
        assert data["shared_pool"]
        names = list(data["sha256"])
        index = next(i for i, name in enumerate(names) if Path(name).name == component)
        for name, expected in data["sha256"].items():
            assert digest(ROOT / name) == expected, name
        report["datasets"].append(dict(file=filename, sha256=digest(filename),
            component=names[index], component_sha256=data["sha256"][names[index]]))
        for row in data["rows"]:
            c = row["config"]
            if a.short_mode == "wave" and not short and c["S"] == 2:
                # The later S2 family replaces these timing records.
                continue
            key = json.dumps(c, sort_keys=True)
            if key not in cache:
                cache[key] = compiled(module, c)
            parts = cache[key]
            retained = changed_scope(c, include_short=a.short_mode == "wave")
            expected_index = index if retained else 0
            assert [p["sha256"] for p in parts] == row["device_source_sha256"][expected_index], (
                filename, row["case"], "source")
            assert [p["flags"] for p in parts] == row["compile_flags"][expected_index], (
                filename, row["case"], "flags")
            baseline_equal = (row["device_source_sha256"][0] == row["device_source_sha256"][expected_index]
                and row["compile_flags"][0] == row["compile_flags"][expected_index])
            assert baseline_equal != retained, (row["case"], "scope")
            report["rows"].append(dict(file=filename, case=row["case"], seed=row["seed"], configuration=c,
                actual_timed_source_equal=True, baseline_equal=baseline_equal, kernels=parts,
                retained_probe_kernel=retained, timed_module_index=expected_index))
            save()
            print(row["case"], row["seed"], "PASS", flush=True)
    report["status"] = "PASS"
    report["unique_configurations"] = len(cache)
    save()
    print("PASS", len(report["rows"]), "records;", len(cache), "configurations", flush=True)


if __name__ == "__main__":
    main()
