"""Audit the full measured sources and transfer only equivalent probe timings."""
import hashlib
import json
from pathlib import Path
import sys

import audit_sources
from experiment_bench import load_module
from verify_mid import selected

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    audit_sources.main()
    directory = Path(sys.argv[sys.argv.index("--directory") + 1]).resolve()
    config = json.loads((directory / "assembly.json").read_text())["config"]
    paths = [HERE / "reference_blocks_v2.py", HERE / "mid_pairs.py",
             directory / "nsa.py", directory / "submission.py"]
    modules = [load_module(str(path)) for path in paths]
    records = [json.loads((HERE / name).read_text()) for name in
               ("bracketed_multiseed.json", "word_views_multiseed.json")]
    for report in records:
        for path, expected in report["sha256"].items():
            assert digest(ROOT / path) == expected, path
        assert report["sha256"][str(paths[1].relative_to(ROOT))] == digest(paths[1])
    cases = list(dict.fromkeys(row["case"] for row in records[0]["rows"]))
    assert cases == list(dict.fromkeys(row["case"] for row in records[1]["rows"]))
    report = dict(status="running", rows=[], source_sha256={str(p.relative_to(ROOT)): digest(p) for p in paths},
        benchmark_reports_sha256={str((HERE / name).relative_to(ROOT)): digest(HERE / name)
            for name in ("bracketed_multiseed.json", "word_views_multiseed.json")},
        method="Active H1 shapes must match the measured pair-load probe; fallback shapes must match the measured baseline")
    for name in cases:
        case = next(row["config"] for row in records[0]["rows"] if row["case"] == name)
        assert all(row["config"] == case for data in records for row in data["rows"] if row["case"] == name)
        kernels = [audit_sources.parts(module._get_kernel(case["B"], case["SEQ_LEN"], case["H"],
            case["HQ"], case["D"], case["S"], case["block_size"], case["is_causal"], 0.1))
            for module in modules]
        sources = [[part.get_kernel_source() for part in kernel] for kernel in kernels]
        flags = [[list(part.compile_flags or []) for part in kernel] for kernel in kernels]
        active = selected(case, config)
        expected = 1 if active else 0
        assert sources[2] == sources[3] == sources[expected], name
        assert flags[2] == flags[3] == flags[expected], name
        report["rows"].append(dict(case=name, config=case, active=active,
            development_submission_equal=True, measured_probe_or_baseline_equal=True,
            source_sha256=[hashlib.sha256(source.encode()).hexdigest() for source in sources[3]],
            compile_flags=flags[3]))
        (directory / "bracketed_source_audit.json").write_text(json.dumps(report, indent=2) + "\n")
        print("BRACKET SOURCE PASS", name, active, flush=True)
    report["status"] = "PASS"
    (directory / "bracketed_source_audit.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PASS: all 26 bracketed shapes match the final source/flags or the preserved baseline")


if __name__ == "__main__":
    main()
