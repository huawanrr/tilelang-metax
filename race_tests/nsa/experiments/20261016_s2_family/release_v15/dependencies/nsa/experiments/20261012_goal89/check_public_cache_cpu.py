"""Exercise the real public entry and dispatch AST with independent kernel labels."""
import argparse
import ast
import hashlib
import itertools
import json
from pathlib import Path
import statistics
import timeit
from types import SimpleNamespace

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def host(path):
    functions = [n for n in ast.parse(path.read_text()).body if isinstance(n, ast.FunctionDef)]
    selected = [n for n in functions if n.name in ("run_kernel", "_get_kernel")]
    constructions, launches = [], []

    def canonical(value):
        if callable(value):
            return value.signature
        if isinstance(value, (list, tuple)):
            return tuple(canonical(v) for v in value)
        if isinstance(value, dict):
            return tuple((k, canonical(v)) for k, v in sorted(value.items()))
        return value

    def builder(name):
        def build(*args, **kwargs):
            signature = name, canonical(args), canonical(kwargs)
            constructions.append(signature)

            def kernel(*values):
                launches[:] = [(signature, values)]

            kernel.signature = signature
            return kernel
        return build

    namespace = {n.name: builder(n.name) for n in functions if n.name not in ("run_kernel", "_get_kernel")}
    namespace.update(_KERNEL_CACHE={}, _as_int32=lambda value: value,
        tilelang=SimpleNamespace(math=SimpleNamespace(next_power_of_2=lambda n: 1 << (n-1).bit_length())))
    exec(compile(ast.Module(body=selected, type_ignores=[]), str(path), "exec"), namespace)
    return namespace, constructions, launches


def shape(c, scale):
    return (c["B"], c["SEQ_LEN"], c["H"], c["HQ"], c["D"], c["S"],
            c["block_size"], c["is_causal"], scale)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parent", default=str(HERE / "parent_v9.py"))
    parser.add_argument("--candidate", default=str(HERE / "public_cache.py"))
    parser.add_argument("--output", default=str(HERE / "public_cache_cpu.json"))
    args = parser.parse_args()
    files = [Path(args.parent), Path(args.candidate)]
    contexts = [host(p) for p in files]
    cases = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    cases += list(json.loads((HERE / "cases.json").read_text()).values())
    cases = list({json.dumps(c, sort_keys=True): c for c in cases}.values())
    checked = 0
    for c in cases:
        for namespace, constructions, launches in contexts:
            namespace["_KERNEL_CACHE"].clear()
            constructions.clear()
            launches.clear()
        for visit in range(3):
            scales = (None, 0.0, -0.0, 0.1, -0.1, 0.03125)
            for scale in scales if visit % 2 == 0 else reversed(scales):
                base = shape(c, scale)
                for cast in (int, float, str):
                    normalized = tuple(cast(v) for v in base[:7]) + base[7:]
                    current_inputs = tuple((checked, tensor) for tensor in range(5))
                    before = [len(ctx[1]) for ctx in contexts]
                    for namespace, _, _ in contexts:
                        namespace["run_kernel"](*current_inputs, *normalized)
                    assert contexts[0][2] == contexts[1][2], (c, scale, cast)
                    assert [len(ctx[1]) - n for ctx, n in zip(contexts, before)][0] == [len(ctx[1]) - n for ctx, n in zip(contexts, before)][1]
                    assert contexts[1][2][0][1] == current_inputs
                    checked += 1
                for options in ({"q_preload": True}, {"q_preload": False}, {"num_stages": 2}, {"kv_split": True}):
                    kernels = [ns["_get_kernel"](*base, **options) for ns, _, _ in contexts]
                    assert kernels[0].signature == kernels[1].signature, (c, scale, options)
            if visit == 1:
                for namespace, _, _ in contexts:
                    namespace["_KERNEL_CACHE"].clear()
        assert contexts[0][1] == contexts[1][1]
    timings = []
    oj = json.loads((HERE / "cases.json").read_text())
    for name in ("oj1", "oj6", "oj13"):
        call_args = (None,) * 5 + shape(oj[name], 0.1)
        functions = [namespace["run_kernel"] for namespace, _, _ in contexts]
        for fn in functions:
            fn(*call_args)
        samples = [[], []]
        for attempt in range(8):
            for i in range(2) if attempt % 2 == 0 else reversed(range(2)):
                elapsed = timeit.timeit(lambda: functions[i](*call_args), number=20000)
                samples[i].append(elapsed / 20000 * 1e6)
        medians = [statistics.median(v) for v in samples]
        timings.append(dict(case=name, public_dispatch_us=medians, speedup=medians[0]/medians[1], samples=samples))
    output = Path(args.output)
    with output.open("x") as file:
        json.dump(dict(status="PASS", command=__import__("sys").argv,
            sources={str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
            configurations=len(cases), public_requests=checked,
            method="Actual run_kernel and _get_kernel AST; independent builder signatures and current call values; mixed explicit/default requests and cache clearing",
            gpu_execution=False, timings=timings), file, indent=2)
        file.write("\n")
    print("PASS", len(cases), checked, timings, flush=True)


if __name__ == "__main__":
    main()
