"""Compile audited C++ on CPU; compare instructions before timing any flags."""
import hashlib
import json
from pathlib import Path
import struct
import subprocess
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / "20261003_packed_compute"))
from inspect_resources import metax_notes

FLAGS = {"default": []}
FLAGS.update({f"latency{v}": ["-mllvm", f"--metaxgpu-memory-latency={v}"]
              for v in (100, 400, 800, 1600)})
FLAGS.update({
    "load_use_on": ["-mllvm", "--metaxgpu-load-use-order=true"],
    "load_use_off": ["-mllvm", "--metaxgpu-load-use-order=false"],
    "no_vectorizer": ["-mllvm", "--metaxgpu-load-store-vectorizer=false"],
    "generic_address": ["-mllvm", "--metaxgpu-direct-address=generic"],
    "no_warp_split": ["-mllvm", "--metaxgpu-warp-split=false"],
})


def text_section(data):
    table = struct.unpack_from("<Q", data, 40)[0]
    size, count, strings = struct.unpack_from("<HHH", data, 58)
    assert size == 64
    entries = [struct.unpack_from("<IIQQQQIIQQ", data, table + i * size) for i in range(count)]
    names = data[entries[strings][4]:entries[strings][4] + entries[strings][5]]
    section = next(s for s in entries if names[s[0]:].split(b"\0", 1)[0] == b".text")
    return data[section[4]:section[4] + section[5]]


def main():
    output = HERE / "compiler_offline_fast"
    output.mkdir(exist_ok=False)
    audit = HERE.parent / "20261013_mfma_fix/binary_audit"
    report = dict(cpu_only=True, flags=FLAGS, rows=[])
    for case, part in (("oj1", 0), ("oj5", 0), ("oj6", 1), ("oj9", 0),
                       ("oj10", 0), ("oj11", 0), ("oj12", 1), ("oj13", 0)):
        source = audit / f"{case}_m1_p{part}.cpp"
        row = dict(case=case, part=part, source=str(source),
            source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(), variants=[])
        for name, flags in FLAGS.items():
            target = output / f"{case}_{name}.o"
            cmd = ["/opt/maca/mxgpu_llvm/bin/mxcc", "-x", "maca", "-device-obj", "-O3", "-lineinfo",
                   "--offload-arch=xcore1000", "-std=c++17", "-I/app/tilelang-metax/src",
                   "-I/opt/maca/include", "-use-fast-math", *flags, "-D__FAST_HALF_CVT__", "-o", str(target), str(source)]
            result = subprocess.run(cmd, capture_output=True, text=True)
            target.with_suffix(".log").write_text(result.stdout + result.stderr)
            item = dict(name=name, command=cmd, exit_code=result.returncode)
            if result.returncode == 0:
                data = target.read_bytes()
                text = text_section(data)
                item.update(text_sha256=hashlib.sha256(text).hexdigest(), text_bytes=len(text),
                            resources=metax_notes(data))
            row["variants"].append(item)
            print(case, name, item.get("text_sha256", "ERROR")[:16], flush=True)
        report["rows"].append(row)
        (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
