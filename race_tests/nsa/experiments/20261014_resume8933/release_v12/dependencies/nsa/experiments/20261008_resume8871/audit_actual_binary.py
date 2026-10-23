"""Inspect the exact cached libraries returned by the active JIT adapters."""
import argparse
import hashlib
import inspect
import json
from pathlib import Path
import re
import struct
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / "experiments/20261003_packed_compute"))
from experiment_bench import load_module
from inspect_resources import metax_notes


def sha(data):
    return hashlib.sha256(data).hexdigest()


def parts(kernel):
    if inspect.isfunction(kernel):
        values = inspect.getclosurevars(kernel).nonlocals
        if "pack" in values and "attention" in values:
            return [values["pack"], values["attention"]]
    return [kernel]


def device_elf(data):
    cursor = 0
    while True:
        start = data.find(b"\x7fELF", cursor)
        if start < 0:
            raise ValueError("No MetaX ELF")
        cursor = start + 4
        if data[start + 4:start + 6] != b"\x02\x01":
            continue
        if struct.unpack_from("<H", data, start + 18)[0] != 253:
            continue
        table = struct.unpack_from("<Q", data, start + 40)[0]
        size, count, string_index = struct.unpack_from("<HHH", data, start + 58)
        assert size == 64
        entries = [struct.unpack_from("<IIQQQQIIQQ", data, start + table + i * size)
                   for i in range(count)]
        length = max([table + count * size] + [s[4] + s[5] for s in entries if s[1] != 8])
        elf = data[start:start + length]
        strings = entries[string_index]
        string_data = elf[strings[4]:strings[4] + strings[5]]
        sections = {}
        for section in entries:
            name = string_data[section[0]:].split(b"\0", 1)[0].decode()
            if section[1] != 8:
                sections[name] = elf[section[4]:section[4] + section[5]]
        return elf, sections


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("modules", nargs="+")
    parser.add_argument("--case-file", required=True)
    parser.add_argument("--cases", required=True)
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    output = Path(args.output_dir)
    output.mkdir(exist_ok=False)
    cases = json.loads(Path(args.case_file).read_text())
    modules = [(path, load_module(path)) for path in args.modules]
    report = dict(command=sys.argv, rows=[],
                  method="Exact JIT adapter libpath; embedded MetaX ELF; no device execution")
    for case in args.cases.split(","):
        config = cases[case]
        row = dict(case=case, config=config, modules=[])
        for index, (path, module) in enumerate(modules):
            kernel = module._get_kernel(config["B"], config["SEQ_LEN"], config["H"],
                                       config["HQ"], config["D"], config["S"],
                                       config["block_size"], config["is_causal"], 0.1)
            record = dict(path=path, sha256=sha(Path(path).read_bytes()), parts=[])
            for part_index, part in enumerate(parts(kernel)):
                stem = output / f"{case}_m{index}_p{part_index}"
                source = part.get_kernel_source().encode()
                stem.with_suffix(".cpp").write_bytes(source)
                library = Path(part.adapter.libpath)
                library_data = library.read_bytes()
                elf, sections = device_elf(library_data)
                stem.with_suffix(".elf").write_bytes(elf)
                item = dict(library=str(library), library_sha256=sha(library_data),
                            compile_flags=list(part.compile_flags or []),
                            device_source_sha256=sha(source), elf_sha256=sha(elf),
                            resources=metax_notes(elf),
                            sections={name: dict(size=len(data), sha256=sha(data))
                                      for name, data in sections.items()})
                if ".llvmbc" in sections:
                    stem.with_suffix(".bc").write_bytes(sections[".llvmbc"])
                    subprocess.run(["/opt/maca/mxgpu_llvm/bin/llvm-dis",
                                    str(stem.with_suffix(".bc")), "-o",
                                    str(stem.with_suffix(".ll"))], check=True)
                    ir = stem.with_suffix(".ll").read_text()
                    normalized = "\n".join(
                        re.sub(r",? !dbg !\d+", "", line)
                        for line in ir.splitlines()
                        if not line.startswith((";", "source_filename =", "!")))
                    stem.with_suffix(".normalized.ll").write_text(normalized + "\n")
                    item["normalized_llvm_sha256"] = sha(normalized.encode())
                record["parts"].append(item)
            row["modules"].append(record)
        report["rows"].append(row)
        (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")
        print(case, [(Path(m["path"]).name,
                      [p["sections"][".text"]["sha256"][:12] for p in m["parts"]])
                     for m in row["modules"]], flush=True)


if __name__ == "__main__":
    main()
