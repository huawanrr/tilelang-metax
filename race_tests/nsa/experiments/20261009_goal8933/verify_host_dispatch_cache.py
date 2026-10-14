"""CPU-only independent dispatch/cache-order equivalence and host timing."""
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
    tree = ast.parse(path.read_text())
    functions = [n for n in tree.body if isinstance(n, ast.FunctionDef)]
    fn = next(n for n in functions if n.name == "_get_kernel")
    calls = []

    def builder(name):
        def build(*args, **kwargs):
            result = (name, tuple(args), tuple(sorted(kwargs.items())))
            calls.append(result)
            return result
        return build

    namespace = {n.name: builder(n.name) for n in functions if n.name != "_get_kernel"}
    namespace.update(_KERNEL_CACHE={}, tilelang=SimpleNamespace(math=SimpleNamespace(
        next_power_of_2=lambda n: 1 << (n-1).bit_length())))
    exec(compile(ast.Module(body=[fn], type_ignores=[]), str(path), "exec"), namespace)
    return namespace, calls


def shape(c, scale):
    return (c["B"], c["SEQ_LEN"], c["H"], c["HQ"], c["D"], c["S"],
            c["block_size"], c["is_causal"], scale)


def main():
    files = [HERE / "parent.py", HERE / "host_dispatch_cache.py"]
    contexts = [host(p) for p in files]
    cases = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    cases += list(json.loads((HERE / "combined_cases.json").read_text()).values())
    unique = {json.dumps(c, sort_keys=True): c for c in cases}
    cases = list(unique.values())
    options = [{}, dict(q_preload=True), dict(q_preload=False), dict(q_frag=True),
        dict(q_frag=False), dict(late_normalize=True), dict(late_normalize=False),
        dict(kv_reuse=False), dict(stage_regs=False), dict(threads=128),
        dict(num_stages=2), dict(pair=2), dict(kv_split=True), dict(kv_frag=True),
        dict(online_unroll=1), dict(min_blocks=1), dict(q_frag_online=True),
        dict(q_frag_online=False), dict(nmax=False), dict(o_stage=True)]
    checked, construction_mismatch = 0, 0
    for c in cases:
        for context, calls in contexts:
            context["_KERNEL_CACHE"].clear()
            calls.clear()
        requests = list(itertools.product((None, 0.0, -0.0, 0.1, -0.1, 0.03125), options))
        requests += list(reversed(requests))
        for scale, kwargs in requests:
            before = [len(v[1]) for v in contexts]
            results = [ctx["_get_kernel"](*shape(c, scale), **kwargs) for ctx, _ in contexts]
            assert results[0] == results[1], (c, scale, kwargs, results)
            increments = [len(v[1])-n for v, n in zip(contexts, before)]
            assert increments[0] == increments[1], (c, scale, kwargs, increments)
            checked += 1
        assert len(contexts[0][1]) == len(contexts[1][1])

    timings = []
    oj = json.loads((HERE / "oj_cases.json").read_text())
    for name in ("oj1", "oj3", "oj6", "oj9", "oj12"):
        args = shape(oj[name], 0.1)
        funcs = [ctx["_get_kernel"] for ctx, _ in contexts]
        for fn in funcs:
            fn(*args)
        samples = [[], []]
        for trial in range(8):
            for i in (range(2) if trial % 2 == 0 else reversed(range(2))):
                total = timeit.timeit(lambda: funcs[i](*args), number=20000)
                samples[i].append(total / 20000 * 1e6)
        medians = [statistics.median(s) for s in samples]
        timings.append(dict(case=name, python_dispatch_us=medians,
                            speedup=medians[0]/medians[1], samples=samples))
        print(name, medians, medians[0]/medians[1], flush=True)
    report = dict(status="PASS", files={str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
        unique_configurations=len(cases), checked_requests=checked, timings=timings,
        method="Execute the real dispatch AST with named builder signatures as independent outputs; compare both visit orders and compiled-call counts",
        limitation="CPU dispatch only; no GPU timing and no official score prediction")
    output = HERE / "host_dispatch_cache_cpu.json"
    with output.open("x") as f:
        json.dump(report, f, indent=2)
        f.write("\n")
    print("PASS", len(cases), checked, flush=True)


if __name__ == "__main__":
    main()
