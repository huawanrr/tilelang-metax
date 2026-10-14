"""Record the runtime after GPU validation has finished."""
import argparse
from datetime import datetime, timezone
import hashlib
import importlib.metadata
import json
import os
from pathlib import Path
import platform
import subprocess
import sys

import torch
import tilelang


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    device = torch.cuda.get_device_properties(0)
    names = ("name", "total_memory", "multi_processor_count", "major", "minor", "warp_size")
    commands = {}
    for name, command in {
        "compiler": ["/opt/maca/mxgpu_llvm/bin/mxcc", "--version"],
        "runtime_git": ["git", "-C", "/app/tilelang-metax", "rev-parse", "HEAD"],
        "workspace_git": ["git", "-C", "/data/tilelang-metax", "rev-parse", "HEAD"],
    }.items():
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        commands[name] = dict(command=command, returncode=result.returncode, output=result.stdout)
    versions = {}
    for package in ("torch", "tilelang", "numpy"):
        try:
            versions[package] = importlib.metadata.version(package)
        except importlib.metadata.PackageNotFoundError:
            versions[package] = None
    files = [Path(__file__).resolve().parents[2] / "env.sh", Path(torch.__file__), Path(tilelang.__file__)]
    report = dict(created_utc=datetime.now(timezone.utc).isoformat(), python=sys.version,
        executable=sys.executable, platform=platform.platform(), package_metadata=versions,
        torch_version=torch.__version__, tilelang_version=getattr(tilelang, "__version__", None),
        torch_module=torch.__file__, tilelang_module=tilelang.__file__,
        device={name: getattr(device, name, None) for name in names}, device_description=str(device),
        commands=commands, environment={key: os.environ.get(key) for key in
            ("TILELANG_CACHE_DIR", "MACA_PATH", "CUDA_VISIBLE_DEVICES", "PYTHONPATH", "LD_LIBRARY_PATH")},
        source_sha256={str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
        verification_tf32=False, official_sandbox=False,
        note="Environment capture only. All validation/measurement commands ran sequentially before this query.")
    with Path(args.output).open("x") as file:
        file.write(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
