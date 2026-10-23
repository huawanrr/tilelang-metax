"""Audit actual device bytes from cached and freshly compiled JIT adapters."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
OLD = ROOT / "experiments/20261008_resume8871/audit_actual_binary.py"
spec = importlib.util.spec_from_file_location("nsa_actual_binary_helpers", OLD)
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def sha(data):
    return hashlib.sha256(data).hexdigest()


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
    modules = [(path, helpers.load_module(path)) for path in args.modules]
    report = dict(
        command=sys.argv,
        tool_sha256=sha(Path(__file__).read_bytes()),
        helper_sha256=sha(OLD.read_bytes()),
        method=("Exact cached adapter library, or export the freshly compiled "
                "runtime module; extract embedded MetaX ELF. No device recompile "
                "or device execution for extraction."),
        rows=[],
    )
    for case in args.cases.split(","):
        config = cases[case]
        row = dict(case=case, config=config, modules=[])
        for index, (path, module) in enumerate(modules):
            kernel = module._get_kernel(
                config["B"], config["SEQ_LEN"], config["H"], config["HQ"],
                config["D"], config["S"], config["block_size"],
                config["is_causal"], 0.1,
            )
            record = dict(path=path, sha256=sha(Path(path).read_bytes()), parts=[])
            for part_index, part in enumerate(helpers.parts(kernel)):
                stem = output / f"{case}_m{index}_p{part_index}"
                source = part.get_kernel_source().encode()
                stem.with_suffix(".cpp").write_bytes(source)
                cached_path = getattr(part.adapter, "libpath", None)
                if cached_path is not None:
                    library = Path(cached_path)
                    origin = "adapter.libpath"
                else:
                    library = stem.with_suffix(".exported.so")
                    part.export_library(str(library))
                    origin = "exported active artifact.rt_mod"
                library_data = library.read_bytes()
                elf, sections = helpers.device_elf(library_data)
                stem.with_suffix(".elf").write_bytes(elf)
                item = dict(
                    library=str(library), library_origin=origin,
                    library_sha256=sha(library_data),
                    adapter=type(part.adapter).__name__,
                    compile_flags=list(part.compile_flags or []),
                    device_source_sha256=sha(source), elf_sha256=sha(elf),
                    resources=helpers.metax_notes(elf),
                    sections={name: dict(size=len(data), sha256=sha(data))
                              for name, data in sections.items()},
                )
                if ".llvmbc" in sections:
                    stem.with_suffix(".bc").write_bytes(sections[".llvmbc"])
                    subprocess.run([
                        "/opt/maca/mxgpu_llvm/bin/llvm-dis",
                        str(stem.with_suffix(".bc")), "-o",
                        str(stem.with_suffix(".ll")),
                    ], check=True)
                    ir = stem.with_suffix(".ll").read_text()
                    normalized = "\n".join(
                        re.sub(r",? !dbg !\d+", "", line)
                        for line in ir.splitlines()
                        if not line.startswith((";", "source_filename =", "!"))
                    )
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
