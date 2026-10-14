"""Use mxcc's documented forwarding option for supported Clang math flags."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
records = []
for name, flags in (
    ("reciprocal", ["-freciprocal-math"]),
    ("fast_preserve_inf", ["-ffast-math", "-fno-finite-math-only"]),
):
    source_path = HERE / f"compiler_{name}.py"
    source = source_path.read_text()
    old = f"compile_flags={flags!r}"
    forwarded = ["-forward-unknown-to-compiler"] + flags
    assert source.count(old) == 10
    result = source.replace(old, f"compile_flags={forwarded!r}")
    ast.parse(result)
    path = HERE / f"compiler_forward_{name}.py"
    with path.open("x") as f:
        f.write(result)
    records.append(dict(path=str(path), flags=forwarded, sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    print(path.name)
(HERE / "compiler_forward_manifest.json").write_text(json.dumps(dict(
    variants=records, note="mxcc --help documents -forward-unknown-to-compiler; initial unsupported-option failures retained."), indent=2) + "\n")

driver = (HERE / "run_compiler_screen.py").read_text()
driver = driver.replace('"compiler_manifest.json"', '"compiler_forward_manifest.json"')
driver = driver.replace('"compiler_runs.json"', '"compiler_forward_runs.json"')
with (HERE / "run_compiler_forward_screen.py").open("x") as f:
    f.write(driver)
