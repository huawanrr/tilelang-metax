"""Summarize exact JIT binaries without recompiling or timing kernels."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    source = HERE / "binary/report.json"
    data = json.loads(source.read_text())
    assert len(data["rows"]) == 9
    rows = []
    for row in data["rows"]:
        parent = row["modules"][0]
        parts = len(parent["parts"])
        for module_index, module in enumerate(row["modules"]):
            assert hashlib.sha256(Path(module["path"]).read_bytes()).hexdigest() == module["sha256"]
            assert len(module["parts"]) == parts
            for part_index, part in enumerate(module["parts"]):
                original = parent["parts"][part_index]
                assert part["compile_flags"] == original["compile_flags"]
                if parts == 2 and part_index == 0:
                    assert part["device_source_sha256"] == original["device_source_sha256"]
                    assert part["sections"][".text"] == original["sections"][".text"]
                    assert part["resources"] == original["resources"]
                else:
                    if module_index:
                        assert part["sections"][".text"]["sha256"] != original["sections"][".text"]["sha256"]
                    resource = part["resources"][0]
                    assert resource[".private_memory_size"] == 0
                    ir = (HERE / f"binary/{row['case']}_m{module_index}_p{part_index}.normalized.ll").read_text()
                    rows.append(dict(case=row["case"], module=Path(module["path"]).name,
                                     text_bytes=part["sections"][".text"]["size"],
                                     text_sha256=part["sections"][".text"]["sha256"],
                                     registers=resource[".mtreg_count"],
                                     private_memory=resource[".private_memory_size"],
                                     rsq_instructions=sum("call " in line and "@llvm.mxc.rsq.f32(" in line
                                                          for line in ir.splitlines())))
    result = dict(report_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                  configs=9, modules=3, rows=rows, packing_unchanged=True,
                  compile_flags_unchanged=True, status="PASS",
                  findings="Both probes change actual attention instructions in every audited configuration. T.rsqrt retains a tiny-input scaling path; T.ieee_frsqrt maps directly to the public backend RSQ intrinsic.")
    with (HERE / "binary_summary.json").open("x") as out:
        json.dump(result, out, indent=2)
        out.write("\n")
    for row in rows:
        print(row["case"], row["module"], row["text_bytes"], row["registers"], row["rsq_instructions"])


if __name__ == "__main__":
    main()
