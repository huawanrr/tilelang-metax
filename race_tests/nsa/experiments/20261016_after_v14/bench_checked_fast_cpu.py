"""Compare real public host ASTs with dummy checked-adapter stand-ins."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import statistics
import timeit

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
FIXTURE = ROOT / "experiments/20261014_resume8933/verify_host_fast_cpu.py"
spec = importlib.util.spec_from_file_location("checked_input_host_fixture", FIXTURE)
fixture = importlib.util.module_from_spec(spec)
spec.loader.exec_module(fixture)


def main():
    os.sched_setaffinity(0, {min(os.sched_getaffinity(0))})
    paths = [HERE / name for name in ("baseline.py", "control.py", "checked_fast_input.py")]
    contexts = [fixture.context(path) for path in paths]
    cases = json.loads((HERE / "cases.json").read_text())
    rows = []
    for name in ("oj1", "oj3", "oj10", "oj12"):
        shape = fixture.helpers.shape(cases[name], 0.1)
        inputs = (object(), object(), object(), fixture.CurrentIndex(), object())
        functions = [ns["run_kernel"] for ns, *_ in contexts]
        for fn in functions:
            fn(*inputs, *shape)
        assert contexts[0][2] == contexts[1][2] == contexts[2][2]
        samples = [[] for _ in contexts]
        for attempt in range(12):
            for index in range(3) if attempt % 2 == 0 else reversed(range(3)):
                fn = functions[index]
                elapsed = timeit.timeit(lambda: fn(*inputs, *shape), number=50000)
                samples[index].append(elapsed / 50000 * 1e9)
        medians = [statistics.median(values) for values in samples]
        row = dict(case=name, ns=medians, samples=samples,
                   speedup=[medians[0] / value for value in medians])
        rows.append(row)
        print(name, medians, row["speedup"], flush=True)
    report = dict(status="PASS", gpu_execution=False,
                  method="CPU affinity; actual host AST with fake adapter; no GPU or dtype/stride compatibility evidence",
                  sha256={str(path):hashlib.sha256(path.read_bytes()).hexdigest() for path in paths},
                  rows=rows)
    with (HERE / "checked_fast_cpu.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")


if __name__ == "__main__":
    main()
