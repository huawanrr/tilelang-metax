"""Compare fresh versus reused host caches, and preserve explicit fallbacks.

Expected callables come from fresh executions of the real dispatch AST. This
checks cache order independently of how the dispatcher builds its cache key.
"""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
FIXTURE = ROOT / "experiments/20261014_resume8933/verify_host_fast_cpu.py"
spec = importlib.util.spec_from_file_location("dispatch_cache_fixtures", FIXTURE)
fixture = importlib.util.module_from_spec(spec)
spec.loader.exec_module(fixture)

OPTIONS = [
    {}, {"q_frag": False}, {"q_frag": True}, {"q_preload": True},
    {"q_preload": False}, {"late_normalize": False}, {"late_normalize": True},
    {"pair": 1}, {"pair": 2}, {"q_frag_online": False}, {"online_unroll": 1},
    {"num_stages": 2}, {"threads": 128}, {"kv_split": True}, {"nmax": False},
    {"kv_reuse": False}, {"stage_regs": False}, {"o_stage": True},
    {"min_blocks": 2},
]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("parent")
    parser.add_argument("candidate")
    parser.add_argument("--case-file", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    output = Path(args.output)
    assert not output.exists()
    paths = [Path(args.parent).resolve(), Path(args.candidate).resolve()]
    configs = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    configs.extend(json.loads(Path(args.case_file).read_text()).values())
    configs = list({json.dumps(c, sort_keys=True): c for c in configs}.values())
    contexts = [fixture.context(path) for path in paths]
    requests, explicit, public = 0, 0, 0
    changed = []
    for c in configs:
        for scale in (None, 0.0, -0.0, -0.1, 0.03125, 0.1):
            shape = fixture.helpers.shape(c, scale)
            expected = []
            for ns, constructions, launches, counts in contexts:
                signatures = []
                for options in OPTIONS:
                    ns["_KERNEL_CACHE"].clear()
                    signatures.append(ns["_get_kernel"](*shape, **options).signature)
                expected.append(signatures)
            assert expected[0][1:] == expected[1][1:], (c, scale, "explicit fallback changed")
            explicit += len(OPTIONS) - 1
            if scale == 0.1 and expected[0][0] != expected[1][0]:
                changed.append(dict(config=c, before=expected[0][0], after=expected[1][0]))
            for ci, (ns, constructions, launches, counts) in enumerate(contexts):
                # Both default-first and explicit-first cache orders matter.
                orders = [list(range(len(OPTIONS))), list(reversed(range(len(OPTIONS)))),
                          [j for i in range(1, len(OPTIONS)) for j in (i, 0, i, 0)]]
                for order in orders:
                    ns["_KERNEL_CACHE"].clear()
                    for index in order:
                        actual = ns["_get_kernel"](*shape, **OPTIONS[index])
                        assert actual.signature == expected[ci][index], (c, scale, ci, index)
                        requests += 1
                    for cast in (int, float, str):
                        args_shape = tuple(cast(v) for v in shape[:7]) + shape[7:]
                        inputs = (object(), object(), object(), fixture.CurrentIndex(), object())
                        ns["run_kernel"](*inputs, *args_shape)
                        assert launches[0][0] == expected[ci][0], (c, scale, ci, "public cache")
                        assert launches[0][1] == inputs, (c, scale, ci, "stale input")
                        public += 1
    trees = [ast.parse(path.read_text()) for path in paths]
    functions = [{fn.name: ast.dump(fn, include_attributes=False)
                  for fn in tree.body if isinstance(fn, ast.FunctionDef)} for tree in trees]
    report = dict(status="PASS", gpu_execution=False,
                  sources={str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
                  fixture_sha256=hashlib.sha256(FIXTURE.read_bytes()).hexdigest(),
                  configurations=len(configs), cache_requests=requests,
                  explicit_fallback_comparisons=explicit, public_requests=public,
                  changed_functions=[name for name in functions[0]
                                     if functions[0][name] != functions[1].get(name)],
                  changed_default_dispatch=changed, tuning_options=OPTIONS,
                  input_identity_preserved=True, cache_orders=["default-first", "explicit-first", "interleaved"])
    with output.open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print("PASS", len(configs), requests, public, "changed defaults", len(changed))


if __name__ == "__main__":
    main()
