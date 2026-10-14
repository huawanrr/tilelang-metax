"""Rebuild the recorded standard kernels and audit the exact submission code."""
import argparse
import hashlib
import inspect
import json
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def parts(kernel):
    if inspect.isfunction(kernel):
        closure = inspect.getclosurevars(kernel).nonlocals
        if "pack" in closure and "attention" in closure:
            return [closure["pack"], closure["attention"]]
    return [kernel]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--directory", required=True)
    args = parser.parse_args()
    directory = Path(args.directory).resolve()
    full = json.loads((directory / "full.json").read_text())
    paths = [directory / name for name in ("nsa.py", "submission.py")]
    recorded_paths = list(full["source_sha256"])
    matches = [i for i, path in enumerate(recorded_paths)
               if full["source_sha256"][path] == digest(paths[1])]
    assert len(matches) == 1, "Performance report must identify this exact submission"
    position = matches[0]
    for path, expected in full["source_sha256"].items():
        assert digest(ROOT / path) == expected, path
    modules = [load_module(str(path)) for path in paths]
    source_dir = directory / "device_sources"
    source_dir.mkdir(exist_ok=True)
    report = dict(command=sys.argv, status="running", rows=[],
        source_sha256={str(path.relative_to(ROOT)): digest(path) for path in paths},
        full_report_sha256=digest(directory / "full.json"),
        measured_module_position=position)
    output = directory / "device_audit.json"
    forbidden = ("memcpy_async", "cp.async", "maca_async", "tma_load", "mbarrier")
    for row in full["rows"]:
        case = row["config"]
        compiled = [parts(module._get_kernel(
            case["B"], case["SEQ_LEN"], case["H"], case["HQ"], case["D"],
            case["S"], case["block_size"], case["is_causal"], 0.1))
            for module in modules]
        sources = [[part.get_kernel_source() for part in kernel] for kernel in compiled]
        flags = [[list(part.compile_flags or []) for part in kernel] for kernel in compiled]
        hashes = [[hashlib.sha256(text.encode()).hexdigest() for text in module]
                  for module in sources]
        assert sources[0] == sources[1], (row["case"], "development/submission source mismatch")
        assert flags[0] == flags[1] == row["compile_flags"][position], row["case"]
        assert hashes[1] == row["device_source_sha256"][position], row["case"]
        audits = []
        for i, (part, source) in enumerate(zip(compiled[1], sources[1])):
            assert not any(marker in source for marker in forbidden), row["case"]
            configurations = {str(key): value for key, value in part.pass_configs.items()}
            assert not any(value for key, value in configurations.items()
                           if "disable_data_race" in key.lower()
                           or "disable_safe_memory" in key.lower()), configurations
            target = source_dir / f"case_{row['case']}_part_{i}.cpp"
            target.write_text(source)
            audits.append(dict(source=str(target.relative_to(ROOT)), sha256=digest(target),
                wave_barriers=source.count("__syncwarp("),
                block_barriers=source.count("__syncthreads("),
                pass_configs=configurations, compile_flags=flags[1][i]))
        report["rows"].append(dict(case=row["case"], config=case,
            development_submission_equal=True, matches_measured_source=True,
            source_hashes=hashes[1], parts=audits,
            unchanged_from_measured_modules=[hashes[1] == old and flags[1] == old_flags
                for old, old_flags in zip(row["device_source_sha256"], row["compile_flags"])]))
        output.write_text(json.dumps(report, indent=2) + "\n")
        print("SOURCE PASS", row["case"], flush=True)
    assert len(report["rows"]) == 109
    report["status"] = "PASS"
    output.write_text(json.dumps(report, indent=2) + "\n")
    print("PASS: all 109 measured sources, development/submission equivalence and enabled checks")


if __name__ == "__main__":
    main()
