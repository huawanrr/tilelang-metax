"""Run independent release checks sequentially in one initialized GPU process."""
import argparse
import contextlib
import json
from pathlib import Path
import runpy
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--directory", required=True)
    args = parser.parse_args()
    directory = Path(args.directory).resolve()
    relative = str(directory.relative_to(ROOT))
    stages = [
        (HERE / "verify_reference.py", [f"{relative}/submission.py", "--extras", "--output",
            f"{relative}/verification_fp32.json"], "verification_fp32.log"),
        (ROOT / "check_equiv.py", [f"{relative}/nsa.py", f"{relative}/submission.py"], "equivalence.log"),
        (HERE / "audit_mid.py", ["--directory", relative], "device_audit.log"),
    ]
    report = dict(status="running", stages=[])
    for script, arguments, log_name in stages:
        command = [str(script.relative_to(ROOT)), *arguments]
        print("RUN", " ".join(command), flush=True)
        sys.argv = command
        with (directory / log_name).open("x") as output:
            with contextlib.redirect_stdout(output), contextlib.redirect_stderr(output):
                try:
                    runpy.run_path(str(script), run_name="__main__")
                except SystemExit as error:
                    if error.code not in (None, 0):
                        raise
        report["stages"].append(dict(command=command, status="PASS", log=log_name))
        (directory / "validation_pipeline.json").write_text(json.dumps(report, indent=2) + "\n")
        print("PASS", log_name, flush=True)
    report["status"] = "PASS"
    (directory / "validation_pipeline.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()
