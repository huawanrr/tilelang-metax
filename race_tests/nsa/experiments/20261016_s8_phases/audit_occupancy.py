"""Read runtime occupancy for the exact audited ELF and actual launch sizes.

This is local diagnostic code, never imported by a submission. No device
kernel is executed. Static shared memory in ELF metadata is not the total
shared memory used by a TileLang launch.
"""
import argparse
import ctypes
import hashlib
import importlib.util
import json
from pathlib import Path
import re


HERE = Path(__file__).resolve().parent
AUDIT = HERE.parent / "20261015_goal8933/audit_binary.py"


def sha(data):
    return hashlib.sha256(data).hexdigest()


def attention_launch(host):
    calls = list(re.finditer(
        r"TVMFFIFunctionCall\(kernel_kernel_packed, \(TVMFFIAny\*\) "
        r"stack_ffi_any, (\d+),", host))
    assert len(calls) == 1
    call = calls[0]
    argument_count = int(call.group(1))
    # All studied attention kernels have five pointers and seven launch ints.
    assert argument_count == 12, argument_count
    assignments = re.findall(
        r"\[(\d+)\]\.v_int64\) = \(\(int64_t\)(\d+)\);", host[:call.start()])
    values = {int(index): int(value) for index, value in assignments}
    launch = [values[index] for index in range(5, 12)]
    assert launch[3:6] == [64, 1, 1], launch
    return dict(grid=launch[:3], block=launch[3:6], dynamic_shared_bytes=launch[6])


def runtime():
    lib = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p
    integer_pointer = ctypes.POINTER(ctypes.c_int)
    signatures = {
        "mcSetDevice": [ctypes.c_int],
        "mcModuleLoadData": [ctypes.POINTER(pointer), pointer],
        "mcModuleGetFunction": [ctypes.POINTER(pointer), pointer, ctypes.c_char_p],
        "mcFuncGetAttribute": [integer_pointer, ctypes.c_int, pointer],
        "mcModuleOccupancyMaxActiveBlocksPerMultiprocessor": [
            integer_pointer, pointer, ctypes.c_int, ctypes.c_size_t],
        "mcModuleUnload": [pointer],
    }
    for name, args in signatures.items():
        fn = getattr(lib, name)
        fn.argtypes = args
        fn.restype = ctypes.c_int
    lib.mcGetErrorString.argtypes = [ctypes.c_int]
    lib.mcGetErrorString.restype = ctypes.c_char_p
    return lib


def checked(lib, name, *args):
    status = getattr(lib, name)(*args)
    if status:
        reason = lib.mcGetErrorString(status)
        raise RuntimeError(f"{name}: {status}: {reason!r}")


def query(lib, elf, shared_bytes):
    # Keep the binary buffer alive until the module is unloaded.
    data = ctypes.create_string_buffer(elf)
    module = ctypes.c_void_p()
    checked(lib, "mcModuleLoadData", ctypes.byref(module), data)
    try:
        fn = ctypes.c_void_p()
        checked(lib, "mcModuleGetFunction", ctypes.byref(fn), module, b"kernel_kernel")
        attributes = {}
        for name, code in (
            ("max_threads_per_block", 0), ("static_shared_bytes", 1),
            ("local_bytes", 3), ("num_regs", 4),
        ):
            value = ctypes.c_int()
            checked(lib, "mcFuncGetAttribute", ctypes.byref(value), code, fn)
            attributes[name] = value.value
        results = {}
        for dynamic in sorted({0, shared_bytes}):
            blocks = ctypes.c_int()
            checked(lib, "mcModuleOccupancyMaxActiveBlocksPerMultiprocessor",
                    ctypes.byref(blocks), fn, 64, dynamic)
            results[str(dynamic)] = blocks.value
        return dict(attributes=attributes, resident_blocks_by_dynamic_shared_bytes=results,
                    actual_max_resident_blocks=results[str(shared_bytes)])
    finally:
        checked(lib, "mcModuleUnload", module)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--binary-report", default=str(HERE / "phase_binary/report.json"))
    parser.add_argument("--output-dir", default=str(HERE / "occupancy"))
    args = parser.parse_args()
    report_path = Path(args.binary_report)
    binary = json.loads(report_path.read_text())
    output = Path(args.output_dir)
    output.mkdir(exist_ok=False)
    spec = importlib.util.spec_from_file_location("nsa_binary_audit", AUDIT)
    audit = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(audit)
    lib = runtime()
    checked(lib, "mcSetDevice", 0)
    modules = {}
    report = dict(method="Runtime query, exact audited ELF, dynamic shared bytes parsed from actual host launch",
                  binary_report=str(report_path), binary_report_sha256=sha(report_path.read_bytes()),
                  script_sha256=sha(Path(__file__).read_bytes()), rows=[])
    for row in binary["rows"]:
        c = row["config"]
        for index, entry in enumerate(row["modules"]):
            path = entry["path"]
            assert sha(Path(path).read_bytes()) == entry["sha256"], path
            if path not in modules:
                modules[path] = audit.helpers.load_module(path)
            module = modules[path]
            kernel = module._get_kernel(c["B"], c["SEQ_LEN"], c["H"], c["HQ"],
                                        c["D"], c["S"], c["block_size"], c["is_causal"], 0.1)
            parts = list(audit.helpers.parts(kernel))
            assert len(parts) == 2
            part = parts[1]
            device = part.get_kernel_source().encode()
            assert sha(device) == entry["parts"][1]["device_source_sha256"]
            host = part.get_host_source()
            stem = f"{row['case']}_m{index}_p1"
            (output / (stem + ".host.cpp")).write_text(host)
            launch = attention_launch(host)
            elf_path = report_path.parent / (stem + ".elf")
            elf = elf_path.read_bytes()
            assert sha(elf) == entry["parts"][1]["elf_sha256"]
            result = dict(case=row["case"], module=path, sha256=entry["sha256"],
                          elf=str(elf_path), elf_sha256=sha(elf),
                          host_source_sha256=sha(host.encode()), launch=launch,
                          elf_resources=entry["parts"][1]["resources"],
                          runtime=query(lib, elf, launch["dynamic_shared_bytes"]))
            report["rows"].append(result)
            (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")
            print(row["case"], Path(path).stem, launch, result["runtime"], flush=True)


if __name__ == "__main__":
    main()
