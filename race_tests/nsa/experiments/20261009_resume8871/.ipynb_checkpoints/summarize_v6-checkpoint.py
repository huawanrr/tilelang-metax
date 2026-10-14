"""Keep final v6 performance separate from rejected research and formal scores."""
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT / "experiments/20261008_resume8857"))
from summarize_candidate import hot, cold, digest


def main():
    audit_path = HERE / "v6_final_audit.json"
    audit = json.loads(audit_path.read_text())
    assert audit["status"] == "PASS"
    family_path = ROOT / "experiments/20261008_resume8871/pack_tiling_family.json"
    data = json.loads(family_path.read_text())
    names = list(data["sha256"])
    index = next(i for i, p in enumerate(names) if Path(p).name == "pack_quads_w64.py")
    retained = {(r["case"], r["seed"]) for r in audit["pack_family"] if r["retained_probe"]}
    official = json.loads((ROOT / "experiments/20261008_resume8857/official_baseline.json").read_text())
    result = dict(
        official_baseline=official, target_score=89.5, official_candidate_score=None,
        official_target_confirmed=False,
        source_sha256=audit["source_sha256"],
        oj=hot(str(HERE / "v6_oj.json"), 28),
        full=hot(str(HERE / "v6_final_full.json"), 109),
        cold=cold(str(HERE / "v6_final_cold.json")),
        packing_probe_family=hot(str(family_path), 68, index=index),
        packing_retained_family=hot(str(family_path), 68, index=index, selected_keys=retained),
        audit=dict(path=str(audit_path), sha256=digest(audit_path),
                   configurations=len(audit["configurations"]), timings=len(audit["timings"]),
                   packing_family_records=len(audit["pack_family"])),
        rejected_d32_cold=[cold(str(HERE / f"d32_denom_cold_seed{seed}.json")) for seed in (0, 61)],
        rejected_research=dict(path=str(HERE / "research_progress.json"),
                               sha256=digest(HERE / "research_progress.json")),
        limitation=("Local A/B/A graphs and device-profiled cold calls are not an official score. "
                    "The unchanged v4 was observed at 88.57 and 88.71. "
                    "The D32 denominator and query-pair probes were rejected; their timings "
                    "must not be attributed to v6."))
    target = HERE / "v6_performance_summary.json"
    with target.open("x") as file:
        file.write(json.dumps(result, indent=2) + "\n")
    for name in ("oj", "full", "packing_probe_family", "packing_retained_family"):
        print(name, json.dumps({key: result[name][key] for key in ("all", "changed", "unchanged")}))
    for row in result["cold"]["rows"]:
        print("cold", row["case"], row["median_kernel_us"], row["speedup"], row["paired_round_speedups"])


if __name__ == "__main__":
    main()
