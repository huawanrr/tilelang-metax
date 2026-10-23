"""Exercise real host dispatch with both JIT and ordinary callable builders."""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
from types import SimpleNamespace

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
spec = importlib.util.spec_from_file_location("dispatch_helpers",
    ROOT / "experiments/20261012_goal89/check_public_cache_cpu.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


class FakeJIT:
    def __init__(self, function, counts):
        self.signature = function.signature
        self.function = function
        self.counts = counts

    def torch_function(self, *values):
        self.counts["adapter"] += 1
        return self.function(*values)

    def __call__(self, *values, **kwargs):
        self.counts["jit_wrapper"] += 1
        return self.torch_function(*values, **kwargs)


class CurrentIndex:
    dtype = "int32"

    def is_contiguous(self):
        return True


def context(path):
    namespace, constructions, launches = helpers.host(path)
    counts = dict(adapter=0, jit_wrapper=0)
    constructors = [n.name for n in ast.parse(path.read_text()).body
        if isinstance(n, ast.FunctionDef)
        and n.name.startswith("native_sparse_attention_")]
    for name in constructors:
        original = namespace[name]
        def build(*args, _original=original, **kwargs):
            return FakeJIT(_original(*args, **kwargs), counts)
        namespace[name] = build
    namespace["torch"] = SimpleNamespace(int32="int32")
    return namespace, constructions, launches, counts


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module")
    p.add_argument("--output", required=True)
    a = p.parse_args()
    paths = [HERE / "baseline.py", Path(a.module).resolve()]
    contexts = [context(path) for path in paths]
    configs = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    configs += list(json.loads((HERE / "cases.json").read_text()).values())
    configs = list({json.dumps(c, sort_keys=True):c for c in configs}.values())
    requests = 0
    for config in configs:
        for ns, builds, launches, counts in contexts:
            ns["_KERNEL_CACHE"].clear()
            builds.clear()
            launches.clear()
        for visit in range(3):
            for scale in (None, 0.0, -0.0, 0.1, -0.1, 0.03125):
                shape = helpers.shape(config, scale)
                for cast in (int, float, str):
                    values = (requests, object(), object(), CurrentIndex(), object())
                    args = tuple(cast(v) for v in shape[:7]) + shape[7:]
                    for ns, _, _, _ in contexts:
                        ns["run_kernel"](*values, *args)
                    assert contexts[0][2] == contexts[1][2], (config, scale, cast)
                    assert contexts[1][2][0][1] == values
                    requests += 1
                for options in ({"q_preload":True}, {"q_preload":False}, {"num_stages":2},
                                {"threads":128}, {"kv_split":True}):
                    kernels = [ns["_get_kernel"](*shape, **options) for ns, *_ in contexts]
                    assert kernels[0].signature == kernels[1].signature
            if visit == 1:
                for ns, *_ in contexts:
                    ns["_KERNEL_CACHE"].clear()
        assert contexts[0][1] == contexts[1][1], config
    assert contexts[0][3]["adapter"] > 0
    assert contexts[0][3]["adapter"] == contexts[1][3]["adapter"]
    assert contexts[0][3]["jit_wrapper"] == contexts[0][3]["adapter"]
    assert contexts[1][3]["jit_wrapper"] == 0
    with Path(a.output).open("x") as out:
        json.dump(dict(status="PASS", configurations=len(configs), public_requests=requests,
            call_counts=[c[3] for c in contexts], current_inputs_preserved=True,
            explicit_paths_unchanged=True, cache_clear_exercised=True,
            sources={str(path):hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}), out, indent=2)
        out.write("\n")
    print("PASS", len(configs), requests, [c[3] for c in contexts], flush=True)


if __name__ == "__main__":
    main()
