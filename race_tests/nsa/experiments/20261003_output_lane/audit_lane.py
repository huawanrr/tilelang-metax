"""Match final device code to standard timings and all bracketed shape probes."""
import hashlib
import json
from pathlib import Path
import sys

import audit_sources
from experiment_bench import load_module
from verify_lane import selected

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    audit_sources.main()
    directory = Path(sys.argv[sys.argv.index("--directory") + 1]).resolve()
    config = json.loads((directory / "assembly.json").read_text())["config"]
    paths = {"base": HERE / "reference_d128.py", "lane": ROOT / config["probe"],
             "development": directory / "nsa.py", "submission": directory / "submission.py"}
    modules = {name: load_module(str(path)) for name, path in paths.items()}
    report = dict(status="running", rows=[], source_sha256={
        str(path.relative_to(ROOT)): digest(path) for path in paths.values()}, benchmark_reports_sha256={},
        method="Final development/submission code and flags equal the measured selected probe or baseline")
    seen = {}
    for name in config["bracket_reports"]:
        timing_path = ROOT / name
        timing = json.loads(timing_path.read_text())
        for path, expected in timing["sha256"].items():
            assert digest(ROOT / path) == expected, path
        report["benchmark_reports_sha256"][name] = digest(timing_path)
        for row in timing["rows"]:
            case_name, case = row["case"], row["config"]
            if case_name in seen:
                assert seen[case_name] == case
                continue
            seen[case_name] = case
            kind = "lane" if selected(case, config) else "base"
            assert str(paths[kind].relative_to(ROOT)) in timing["sha256"]
            call = (case["B"], case["SEQ_LEN"], case["H"], case["HQ"], case["D"], case["S"],
                    case["block_size"], case["is_causal"], 0.1)
            kernels = [audit_sources.parts(modules[key]._get_kernel(*call))
                       for key in ("development", "submission", kind)]
            sources = [[part.get_kernel_source() for part in kernel] for kernel in kernels]
            flags = [[list(part.compile_flags or []) for part in kernel] for kernel in kernels]
            assert sources[0] == sources[1] == sources[2], (case_name, kind)
            assert flags[0] == flags[1] == flags[2], (case_name, kind)
            report["rows"].append(dict(case=case_name, config=case, active=kind == "lane",
                development_submission_equal=True, measured_probe_or_baseline_equal=True,
                source_sha256=[hashlib.sha256(source.encode()).hexdigest() for source in sources[1]],
                compile_flags=flags[1]))
            (directory / "bracketed_source_audit.json").write_text(json.dumps(report, indent=2) + "\n")
            print("BRACKET SOURCE PASS", case_name, kind, flush=True)
    report["status"] = "PASS"
    (directory / "bracketed_source_audit.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PASS:", len(report["rows"]), "bracketed shapes match measured sources and flags")


if __name__ == "__main__":
    main()
