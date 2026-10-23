"""Qualify event deltas against known launches and emitted load/MMA counts.

Other catalogued event names are deliberately not treated as reliable
bandwidth, cache-hit, occupancy, or utilization measurements.
"""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    oj6_grid, oj6_pack_grid = 8 * 1024, 8 * 32 * 4
    oj12_grid, oj12_pack_grid = 4 * 1024, 4 * 64
    selected = 4 * sum(min(8, max(1, token // 16)) for token in range(1024))
    expected = {
        ("oj6", "attention"): dict(sm_cta_launched=oj6_grid, active_warps=oj6_grid,
            global_load=24*oj6_grid, global_store=4*oj6_grid,
            shared_load=8*oj6_grid, shared_store=16*oj6_grid,
            inst_executed_fp16_pipe_s0=32*oj6_grid),
        ("oj6", "pack"): dict(sm_cta_launched=oj6_pack_grid, active_warps=oj6_pack_grid,
            global_load=4*oj6_pack_grid, global_store=4*oj6_pack_grid,
            shared_load=18*oj6_pack_grid, shared_store=6*oj6_pack_grid,
            inst_executed_fp16_pipe_s0=0),
        ("oj12", "attention"): dict(sm_cta_launched=oj12_grid, active_warps=oj12_grid,
            global_load=2*oj12_grid+4*selected, global_store=2*oj12_grid,
            shared_load=2*oj12_grid, shared_store=4*oj12_grid,
            inst_executed_fp16_pipe_s0=8*selected),
        ("oj12", "pack"): dict(sm_cta_launched=oj12_pack_grid, active_warps=2*oj12_pack_grid,
            global_load=4*oj12_pack_grid, global_store=18*oj12_pack_grid,
            shared_load=0, shared_store=0, inst_executed_fp16_pipe_s0=0),
    }
    report = dict(method="Cross-check before/after counter differences against emitted instructions and known work",
        selected_s8_blocks=selected, rows=[],
        limitations=[
            "Raw counters can be cumulative across groups/processes; use before/after deltas.",
            "ReadAllEvents misinterpreted the zero-filled event-id output buffer; use ReadEvent with explicit ID.",
            "Some cycle and L2 events exhibit negative deltas or nonzero values in no-MMA pack kernels; they are unqualified.",
            "active_warps matched waves launched, not average active warps; do not infer occupancy.",
            "Counts do not identify cycle bottlenecks by themselves; timing remains uninstrumented A/B/A.",
        ])
    for (case, phase), checks in expected.items():
        path = HERE / f"mcpti_{case}_{phase}.json"
        data = json.loads(path.read_text())
        metrics = {r["event"]["name"]: r for r in data["rows"]}
        row = dict(case=case, phase=phase, file=path.name,
                   file_sha256=hashlib.sha256(path.read_bytes()).hexdigest(), counts={})
        for event, value in checks.items():
            item = metrics[event]
            actual = item["difference_sum"] / data["repeats"]
            empty = item["empty_differences"]
            assert not any(empty), (case, phase, event, "nonzero empty reads", empty)
            assert actual == value, (case, phase, event, actual, value)
            row["counts"][event] = dict(expected_per_call=value, measured_per_call=actual, status="PASS")
        row["total_instructions_per_call"] = metrics["inst_executed"]["difference_sum"] / data["repeats"]
        report["rows"].append(row)
    report["status"] = "PASS: 28 exact instruction/launch count comparisons"
    with (HERE / "mcpti_qualification.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print(report["status"])


if __name__ == "__main__":
    main()
