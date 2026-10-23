"""Check untested argument/load lowering choices against exact v13 device bytes.

This CPU-only experiment does not change synchronization or use asynchronous
transfers. The default must reproduce the exported JIT binary before any flag
comparison is interpreted.
"""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
HELPER = ROOT / "experiments/20261014_goal8933/probe_compiler_offline.py"
spec = importlib.util.spec_from_file_location("offline_helpers", HELPER)
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)

FLAGS = {"default": []}
for name, flag in (
    ("arguments", "metaxgpu-ir-lower-kernel-arguments"),
    ("sink_extract", "metaxgpu-sink-load-extract"),
    ("sink_load", "metaxgpu-sinkload"),
    ("memcpy_lower", "metaxgpu-MemcpyToLoadStore"),
):
    for value in (True, False):
        FLAGS[f"{name}_{str(value).lower()}"] = ["-mllvm", f"--{flag}={str(value).lower()}"]


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    output = HERE / "lowering_offline"
    output.mkdir(exist_ok=False)
    audit = ROOT / "experiments/20261015_goal8933/validation_v13_final/actual_binary"
    evidence = json.loads((audit / "report.json").read_text())
    report = dict(cpu_only=True, flags=FLAGS, rows=[], command_source="v13 final actual JIT source")
    for case, part in (("oj1", 0), ("oj6", 1), ("oj9", 0), ("oj12", 1)):
        source = audit / f"{case}_m1_p{part}.cpp"
        recorded = next(r for r in evidence["rows"] if r["case"] == case)["modules"][1]["parts"][part]
        assert sha(source.read_bytes()) == recorded["device_source_sha256"]
        row = dict(case=case, part=part, source=str(source),
                   source_sha256=sha(source.read_bytes()),
                   actual_text_sha256=recorded["sections"][".text"]["sha256"], variants=[])
        for name, flags in FLAGS.items():
            target = output / f"{case}_{name}.o"
            command = ["/opt/maca/mxgpu_llvm/bin/mxcc", "-x", "maca", "-device-obj",
                       "-O3", "-lineinfo", "--offload-arch=xcore1000", "-std=c++17",
                       "-I/app/tilelang-metax/src", "-I/opt/maca/include", "-use-fast-math",
                       *flags, "-D__FAST_HALF_CVT__", "-o", str(target), str(source)]
            result = subprocess.run(command, capture_output=True, text=True)
            target.with_suffix(".log").write_text(result.stdout + result.stderr)
            item = dict(name=name, command=command, exit_code=result.returncode)
            if result.returncode == 0:
                data = target.read_bytes()
                binary = helpers.text_section(data)
                item.update(text_sha256=sha(binary), text_bytes=len(binary),
                            resources=helpers.metax_notes(data),
                            changed=sha(binary) != row["actual_text_sha256"])
                if name == "default":
                    assert not item["changed"], (case, "default fails to reproduce actual JIT")
            row["variants"].append(item)
            print(case, name, item.get("text_sha256", "ERROR")[:12], flush=True)
        report["rows"].append(row)
        (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
