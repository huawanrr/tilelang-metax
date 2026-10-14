"""Summarize every screen and both accepted and unfiltered bracket samples."""
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def geomean(values):
    values = list(values)
    return math.exp(statistics.mean(math.log(v) for v in values)) if values else None


def bracket_summary(path, threshold=8192):
    data = json.loads(path.read_text())
    for name, expected in data["sha256"].items():
        assert digest(ROOT / name) == expected, name
    rows = []
    for row in data["rows"]:
        assert all(s["accepted"] > 0 and s["total"] == 24 for s in row["summaries"])
        cfg = row["config"]
        active = cfg["B"]*cfg["H"]*cfg["SEQ_LEN"] >= threshold
        rows.append(dict(case=row["case"], seed=row["seed"], config=cfg, active=active,
            control_speedup=row["summaries"][0]["median_speedup"],
            candidate_speedup=row["summaries"][1]["median_speedup"],
            candidate_unfiltered_speedup=statistics.median(v["speedup"] for v in row["trials"][2]),
            accepted=[s["accepted"] for s in row["summaries"]]))
    active = [r for r in rows if r["active"]]
    controls = [r["control_speedup"] for r in rows]
    return dict(report=str(path.relative_to(ROOT)), sha256=digest(path),
        shape_count=len({r["case"] for r in rows}), shape_seed_count=len(rows),
        active_shape_count=len({r["case"] for r in active}), active_shape_seed_count=len(active),
        active_geomean_speedup=geomean(r["candidate_speedup"] for r in active),
        active_unfiltered_geomean_speedup=geomean(r["candidate_unfiltered_speedup"] for r in active),
        active_range=[min(r["candidate_speedup"] for r in active), max(r["candidate_speedup"] for r in active)],
        control_range=[min(controls), max(controls)], control_geomean_speedup=geomean(controls),
        minimum_accepted=min(n for r in rows for n in r["accepted"]),
        active_below_one=[r for r in active if r["candidate_speedup"] < 1],
        active_unfiltered_below_one=[r for r in active if r["candidate_unfiltered_speedup"] < 1],
        inactive_below_one=[r for r in rows if not r["active"] and r["candidate_speedup"] < 1], rows=rows)


def summarize():
    screens = []
    for name in ("screen.json", "d32_screen.json", "mid_screen.json", "guard_screen.json"):
        path = HERE / name
        data = json.loads(path.read_text())
        for module, expected in data["source_sha256"].items():
            assert digest(ROOT / module) == expected, module
        modules = list(data["source_sha256"])
        screens.append(dict(report=name, sha256=digest(path), rows=len(data["rows"]),
            modules=modules, geomean_speedups=data["geomean_speedups"],
            below_one=[dict(case=r["case"], module=modules[i], speedup=r["speedups"][i])
                for r in data["rows"] for i in range(1, len(modules)) if r["speedups"][i] < 1]))
    brackets = bracket_summary(HERE / "lane_multiseed.json")
    assert brackets["shape_seed_count"] == 108 and brackets["active_shape_seed_count"] == 90
    assert not brackets["active_below_one"] and not brackets["active_unfiltered_below_one"]
    extremes = json.loads((HERE / "extreme_probe.json").read_text())
    assert len(extremes["rows"]) == 18 and all(r["status"] == "PASS" for r in extremes["rows"])
    report = dict(status="PASS", screens=screens, bracketed=brackets,
        extreme_checks=18, baseline_extreme_failure_reproduced=False,
        selection=json.loads((HERE / "selection.json").read_text()),
        rejected=["Shared output staging replaced by lane shuffles on coalesced S1 and S8 paths",
                  "D32 output lane exchange on small and medium grids",
                  "Extra lane/register-bit exchange for fully contiguous D32 stores",
                  "D64 medium direct-output lane exchange: mixed results, aggregate 1.001393x"],
        caveats=["Initial screen noncausal B1/T8192 combination was 0.995911x; all later bracketed seeds were faster",
                 "Guard-only speedups were mixed; the final builder uses the independently measured combination",
                 "Subset speedups are not the 109-case aggregate or an official score"])
    (HERE / "experiment_summary.json").write_text(json.dumps(report, indent=2) + "\n")
    return report


if __name__ == "__main__":
    report = summarize()
    print(json.dumps({k: v for k, v in report["bracketed"].items() if k != "rows"}, indent=2))
