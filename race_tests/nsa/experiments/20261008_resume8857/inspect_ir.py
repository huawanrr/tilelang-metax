"""Copy generated C++ and emit CPU-only diagnostic LLVM IR; never execute it."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
p = argparse.ArgumentParser(description=__doc__)
p.add_argument("screen")
p.add_argument("--case", required=True)
p.add_argument("--modules", default="0,3")
a = p.parse_args()
screen = json.loads(Path(a.screen).read_text())
row = next(r for r in screen["rows"] if r["case"] == a.case)
selected = [int(i) for i in a.modules.split(",")]
hashes = {h for i in selected for h in row["device_source_sha256"][i]}
matches = {}
for path in Path("/tmp/tilelang-cache-nsa").glob("*/kernels/*/device_kernel.cu"):
    digest = hashlib.sha256(path.read_bytes()).hexdigest()
    if digest in hashes:
        matches[digest] = path
assert hashes <= matches.keys(), hashes - matches.keys()
for index in selected:
    for component, digest in enumerate(row["device_source_sha256"][index]):
        target = HERE / f"ir_{Path(a.screen).stem}_{a.case}_m{index}_p{component}"
        source = target.with_suffix(".cpp")
        source.write_bytes(matches[digest].read_bytes())
        command = ["/opt/maca/mxgpu_llvm/bin/mxcc", "-x", "maca", "-w", "-std=c++17",
            "-O3", "-use-fast-math", "-D__FAST_HALF_CVT__", "-I/app/tilelang-metax/src",
            "-I/opt/maca/include", "-S", "-emit-llvm", "-maca-device-only",
            "--offload-arch=xcore1000", str(source), "-o", str(target.with_suffix(".ll"))]
        with target.with_suffix(".log").open("w") as log:
            subprocess.run(command, stdout=log, stderr=subprocess.STDOUT, check=True)
        print(source.name, digest, flush=True)
