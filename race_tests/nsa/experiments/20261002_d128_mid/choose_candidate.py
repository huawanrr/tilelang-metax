"""Retain broad stable domains and keep the ambiguous transition unchanged."""
import json
from pathlib import Path

from study_summary import summarize

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    config = dict(
        linear=dict(enabled=True,min_grid=129,max_grid_exclusive=768,min_seq=16,heads=[1],
                    probe="experiments/20261002_d128_mid/linear_pairs.py"),
        coalesced=dict(enabled=True,min_grid=1024,max_grid_exclusive=1280,min_seq=32,heads=[1,2],
                       probe="experiments/20261002_d128_mid/coalesced_q8.py"),
        bracket_reports=["experiments/20261002_d128_mid/family_multiseed.json",
                         "experiments/20261002_d128_mid/boundary_multiseed.json"])
    reports = [summarize(ROOT/name,config) for name in config["bracket_reports"]]
    assert all(not report["active_below_one"] for report in reports)
    assert sum(report["active_combinations"] for report in reports) == 108
    record = dict(config=config,
        rationale=[
            "For H1 below grid768, half pairs and quads both improved every measured seed; pairs have the stronger minimum and slightly higher family geomean.",
            "Grid768..1023 remains on the baseline: the denser boundary study found isolated negative seeds for both new methods.",
            "For grid1024..1279, coalesced Q/O is consistently stronger than only changing K/V loads.",
            "Coalesced requires seq_len>=32 and H<=2: T16 and H4 had negative seeds; these entire shape families retain the parent.",
            "All raw results, including faster rejected shapes and every negative/rejected sample, remain available."],
        evidence=[{key:value for key,value in report.items() if key!="rows"} for report in reports],
        official_new_score=None)
    with (HERE/"selection.json").open("x") as output:
        output.write(json.dumps(record,indent=2)+"\n")
    print("Selected",sum(report["active_shapes"] for report in reports),"shapes / 108 seed combinations; all measured active combinations faster")


if __name__ == "__main__":
    main()
