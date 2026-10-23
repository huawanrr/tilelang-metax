"""Freeze an evidence index without manufacturing a release from failed probes."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(name):
    return json.loads((HERE / name).read_text())


def main():
    summary_path = HERE / "study_summary.json"
    manifest_path = HERE / "research_manifest.json"
    assert not summary_path.exists() and not manifest_path.exists()
    frozen = []
    for name, expected in read("source_manifest.json").items():
        path, origin = HERE / name, ROOT / expected["source"]
        assert sha(path) == sha(origin) == expected["sha256"], name
        frozen.append(dict(file=name, source=str(origin.relative_to(ROOT)), sha256=sha(path)))
    screens = []
    for path in sorted(HERE.glob("*_summary.json")):
        data = json.loads(path.read_text())
        if "studies" not in data:
            continue
        for study in data["studies"]:
            raw_path = ROOT / study["file"]
            assert raw_path.exists(), raw_path
            raw = json.loads(raw_path.read_text())
            modules = []
            for module in study["modules"]:
                source = ROOT / module["file"]
                assert sha(source) == module["sha256"], source
                modules.append(dict(file=module["file"], sha256=module["sha256"],
                                    rows=len(module["rows"]),
                                    unfiltered_geomean=module["unfiltered_geomean"],
                                    regressions=module["regressions"]))
            for name, digest in raw.get("sha256", {}).items():
                assert sha(ROOT / name) == digest, name
            screens.append(dict(summary=path.name, summary_sha256=sha(path),
                                raw_file=str(raw_path.relative_to(HERE)), raw_sha256=sha(raw_path),
                                rows=study["rows"], modules=modules))
    resources = []
    for name in ("packed_multiwave_v2_binary/report.json", "s8_tags_binary/report.json",
                 "s8_wide_v2_binary/report.json", "s8_wave_pipeline_binary/report.json",
                 "s8_wave_overlay_binary/report.json"):
        report = read(name)
        records = []
        for row in report["rows"]:
            for module in row["modules"]:
                assert sha(ROOT / module["path"]) == module["sha256"]
                records.append(dict(case=row["case"], module=module["path"], parts=[
                    dict(elf_sha256=part["elf_sha256"], resources=part["resources"],
                         text_bytes=part["sections"][".text"]["size"],
                         text_sha256=part["sections"][".text"]["sha256"])
                    for part in module["parts"]]))
        resources.append(dict(file=name, sha256=sha(HERE / name), records=records))
    counter_files = ("mcpti_oj12_attention.json", "mcpti_s8_wide_v2_p2_attention.json")
    counters = []
    for name in counter_files:
        report = read(name)
        assert sha(ROOT / report["module"]) == report["source_sha256"]
        counts = {}
        for row in report["rows"]:
            event = row["event"]["name"]
            if event not in {"sm_cta_launched", "global_load", "global_store", "inst_executed_fp16_pipe_s0", "inst_executed"}:
                continue
            assert all(item["code"] == 0 for item in row["api"])
            assert all(value == 0 for value in row["empty_differences"])
            counts[event] = row["difference_sum"] / report["repeats"]
        counters.append(dict(file=name, sha256=sha(HERE / name), counts_per_call=counts))
    for event in ("sm_cta_launched", "global_load", "global_store", "inst_executed_fp16_pipe_s0"):
        assert counters[0]["counts_per_call"][event] == counters[1]["counts_per_call"][event]
    summary = dict(
        created_utc=datetime.now(timezone.utc).isoformat(),
        status="No new release candidate; optimization goal not achieved",
        confirmed_official_score=89, requested_official_score=89.5,
        official_result_for_new_probes=None, release_created=False,
        frozen_sources_verified=frozen, screens=screens,
        actual_cached_device_resources=resources, wide_tile_instruction_comparison=counters,
        diagnostic_files=["qo_copy_diagnostic.json", "s8_tags_phase_times.json", "mcpti_window_state_pack.json"],
        limitations=[
            "Graph timings include every public-call GPU launch; all raw trials are retained.",
            "Negative pilot results justify rejection, not a claim of complete release validation.",
            "The wide-tile, two-wave pipeline and overlay pilots each have two shapes and seed 0 only.",
            "No new candidate received the full boundary, scale, host and both-interface release suite.",
            "The Q/O copy diagnostic omits attention; it is not an NSA implementation or proven attainable lower bound.",
            "Only independently qualified instruction events are used for workload comparisons; cycle/L2 events are not utilization or bandwidth measurements.",
            "The exact current official submission and per-case OJ timings remain unavailable; no local ratio is converted to an OJ score.",
        ],
        decisions="All probes in this study remain research-only. Preserve the user's confirmed 89-point result; no v18 is created.",
    )
    with summary_path.open("x") as out:
        json.dump(summary, out, indent=2, ensure_ascii=False)
        out.write("\n")
    files = {}
    for path in sorted(HERE.rglob("*")):
        if not path.is_file() or "__pycache__" in path.parts or path == manifest_path:
            continue
        files[str(path.relative_to(HERE))] = dict(sha256=sha(path), bytes=path.stat().st_size)
    manifest = dict(created_utc=datetime.now(timezone.utc).isoformat(),
                    purpose="Evidence snapshot, not a submission release", files=files)
    with manifest_path.open("x") as out:
        json.dump(manifest, out, indent=2, ensure_ascii=False)
        out.write("\n")
    for name, record in files.items():
        assert sha(HERE / name) == record["sha256"], name
    print("Verified frozen sources:", len(frozen))
    print("Indexed screens:", len(screens), "; evidence files:", len(files))
    print("No release candidate. Confirmed score 89; 89.5 unachieved.")


if __name__ == "__main__":
    main()
