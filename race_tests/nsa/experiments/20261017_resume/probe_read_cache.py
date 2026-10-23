"""Inspect MXCC's read-cache policy without changing code or invalidation.

The documented --metaxgpu-set-cc-read switch selects hitl1/missl1/misslmc.
Unlike prior __ldg rewrites, this leaves the vector load expressions intact.
Only policies that change actual instructions warrant a runtime screen.
"""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
OLD = HERE.parent / "20261008_resume8871/audit_actual_binary.py"
spec = importlib.util.spec_from_file_location("cache_binary_helpers", OLD)
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    output = HERE / "read_cache_offline"
    output.mkdir(exist_ok=False)
    sources = {
        "oj6": HERE / "packed_binary/oj6_m0_p1.cpp",
        "oj12": HERE.parent / "20261016_s8_phases/phase_binary/oj12_m0_p1.cpp",
    }
    report = dict(method="Offline MXCC compilation from previously audited unchanged device sources",
                  gpu_execution=False, cache_invalidation_unchanged=True, rows=[])
    for case, source in sources.items():
        original, sections = helpers.device_elf(source.with_suffix(".elf").read_bytes())
        row = dict(case=case, source=str(source), source_sha256=digest(source.read_bytes()),
                   actual_jit_text_sha256=digest(sections[".text"]), variants=[])
        for mode in ("default", "hitl1", "missl1", "misslmc"):
            path = output / f"{case}_{mode}.o"
            command = ["/opt/maca/mxgpu_llvm/bin/mxcc", "-x", "maca", "-device-obj", "-O3", "-lineinfo",
                       "--offload-arch=xcore1000", "-std=c++17", "-I/app/tilelang-metax/src",
                       "-I/opt/maca/include", "-use-fast-math", "-D__FAST_HALF_CVT__"]
            if mode != "default":
                command += ["-mllvm", f"--metaxgpu-set-cc-read={mode}"]
            command += ["-o", str(path), str(source)]
            run = subprocess.run(command, capture_output=True, text=True)
            path.with_suffix(".log").write_text(run.stdout + run.stderr)
            item = dict(mode=mode, command=command, exit_code=run.returncode)
            if run.returncode == 0:
                elf, parts = helpers.device_elf(path.read_bytes())
                item.update(text_sha256=digest(parts[".text"]),
                            text_bytes=len(parts[".text"]), resources=helpers.metax_notes(elf))
                item["same_as_actual_jit"] = item["text_sha256"] == row["actual_jit_text_sha256"]
                if mode == "default":
                    assert item["same_as_actual_jit"], (case, "offline flags do not reproduce the JIT")
            row["variants"].append(item)
            print(case, mode, run.returncode, item.get("same_as_actual_jit"), flush=True)
        report["rows"].append(row)
        (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
