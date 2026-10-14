"""Execute host dispatch with recording builders to check the complete gate."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
from types import SimpleNamespace

from verify_lane import boundary_cases, selected

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def inspect_dispatch(path):
    functions = {n.name: n for n in ast.parse(path.read_text()).body if isinstance(n, ast.FunctionDef)}
    def record(name):
        def call(*args, **kwargs):
            return dict(builder=name, args=args, kwargs=kwargs)
        return call
    env = {name: record(name) for name in functions}
    env["tilelang"] = SimpleNamespace(math=SimpleNamespace(next_power_of_2=lambda n: 1 << (n-1).bit_length()))
    env["_KERNEL_CACHE"] = {}
    exec(compile(ast.Module(body=[functions["_get_kernel"]], type_ignores=[]), str(path), "exec"), env)
    return functions, env["_get_kernel"]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--directory", required=True)
    a = p.parse_args()
    directory = Path(a.directory).resolve()
    config = json.loads((directory / "assembly.json").read_text())["config"]
    paths = [ROOT / "experiments/20261003_d128_v1/nsa.py", directory / "nsa.py"]
    (old_functions, old), (new_functions, new) = [inspect_dispatch(path) for path in paths]
    retained = [name for name in old_functions if name != "_get_kernel"]
    assert len(retained) == 45
    assert all(ast.dump(old_functions[name]) == ast.dump(new_functions[name]) for name in retained)
    cases = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text()) + boundary_cases(config)
    for name in config["bracket_reports"]:
        cases += [row["config"] for row in json.loads((ROOT / name).read_text())["rows"]]
    cases = list({json.dumps(case, sort_keys=True): case for case in cases}.values())
    rows = []
    for case in cases:
        call = (case["B"], case["SEQ_LEN"], case["H"], case["HQ"], case["D"], case["S"],
                case["block_size"], case["is_causal"], 0.1)
        before, after = old(*call), new(*call)
        active = selected(case, config)
        if active:
            assert before["builder"] == "native_sparse_attention_d32_shuffle"
            expected = dict(before, builder="native_sparse_attention_d32_output_lane")
            assert after == expected, (case, before, after)
        else:
            assert before == after, (case, before, after)
        rows.append(dict(config=case, active=active, expected_dispatch=True, selection=after))
    knobs_list = [dict(q_preload=False), dict(kv_reuse=False), dict(nmax=False),
        dict(stage_regs=False), dict(kv_split=True), dict(q_frag=True), dict(o_stage=True),
        dict(kv_frag=True), dict(min_blocks=1), dict(pair=2), dict(num_stages=2),
        dict(online_unroll=1), dict(late_normalize=True), dict(threads=128)]
    fallbacks = []
    for case in [row["config"] for row in rows if row["active"]][:4]:
        call = (case["B"], case["SEQ_LEN"], case["H"], case["HQ"], case["D"], case["S"],
                case["block_size"], case["is_causal"], 0.1)
        for knobs in knobs_list:
            before, after = old(*call, **knobs), new(*call, **knobs)
            assert before == after, (case, knobs, before, after)
            fallbacks.append(dict(config=case, knobs=knobs, identical_dispatch=True))
    report = dict(status="PASS", rows=rows, fallbacks=fallbacks, preserved_functions=retained,
        method="Run exact host dispatch with recording builders; check builder names and every argument",
        source_sha256={str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
    (directory / "host_dispatch_audit.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PASS:", len(rows), "default dispatches,", len(fallbacks), "tuning fallbacks and 45 preserved functions")


if __name__ == "__main__":
    main()
