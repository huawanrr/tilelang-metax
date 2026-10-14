"""Audit measured sources and the final coalesced-output dispatch."""
import hashlib
import json
from pathlib import Path
import sys

import audit_sources
from experiment_bench import load_module
from verify_output import selected

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    audit_sources.main()
    directory = Path(sys.argv[sys.argv.index("--directory") + 1]).resolve()
    config = json.loads((directory / "assembly.json").read_text())["config"]
    paths = [HERE / "reference_mid.py", HERE / "coalesced_ge2048.py",
             directory / "nsa.py", directory / "submission.py"]
    modules = [load_module(str(path)) for path in paths]
    timing_path = HERE / "bracketed_multiseed.json"
    timing = json.loads(timing_path.read_text())
    for path, expected in timing["sha256"].items():
        assert digest(ROOT / path) == expected, path
    assert timing["sha256"][str(paths[1].relative_to(ROOT))] == digest(paths[1])
    cases = list(dict.fromkeys(row["case"] for row in timing["rows"]))
    assert len(cases) == 25
    report = dict(status="running", rows=[],
        source_sha256={str(path.relative_to(ROOT)): digest(path) for path in paths},
        benchmark_reports_sha256={str(timing_path.relative_to(ROOT)): digest(timing_path)},
        method="Active shapes must match the measured coalesced probe; fallback shapes must match the measured baseline")
    output = directory / "bracketed_source_audit.json"
    for name in cases:
        case = next(row["config"] for row in timing["rows"] if row["case"] == name)
        assert all(row["config"] == case for row in timing["rows"] if row["case"] == name)
        kernels = [audit_sources.parts(module._get_kernel(case["B"], case["SEQ_LEN"],
            case["H"], case["HQ"], case["D"], case["S"], case["block_size"],
            case["is_causal"], 0.1)) for module in modules]
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
        output.write_text(json.dumps(report, indent=2) + "\n")
        print("BRACKET SOURCE PASS", name, active, flush=True)
    assert sum(row["active"] for row in report["rows"]) == 18
    report["status"] = "PASS"
    output.write_text(json.dumps(report, indent=2) + "\n")
    print("PASS: all 25 bracketed shapes match the final source/flags or the preserved baseline")


if __name__ == "__main__":
    main()
