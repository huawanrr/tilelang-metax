"""Compare real dispatch AST and call data with independently named builders."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
spec = importlib.util.spec_from_file_location("dispatch_helpers", ROOT / "experiments/20261012_goal89/check_public_cache_cpu.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def canonical(value):
    if isinstance(value, str):
        return value.replace("_block_joint", "").replace("_sum_v11", "").replace("_make_attention", "_make_packed_attention")
    if isinstance(value, (tuple, list)):
        return tuple(canonical(x) for x in value)
    if isinstance(value, dict):
        return {k:canonical(v) for k,v in value.items()}
    return value


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module")
    p.add_argument("--output", required=True)
    args = p.parse_args()
    paths = [HERE / "baseline.py", Path(args.module).resolve()]
    contexts = [helpers.host(path) for path in paths]
    configs = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    for name in ("followup_cases.json", "bs32_cold_family_cases.json", "short_cold_family_cases.json"):
        configs += list(json.loads((HERE / name).read_text()).values())
    configs = list({json.dumps(c, sort_keys=True):c for c in configs}.values())
    options = [{}, {"q_preload": True}, {"q_preload": False}, {"q_frag": True},
        {"q_frag": False}, {"late_normalize": False}, {"late_normalize": True},
        {"num_stages": 2}, {"threads": 128}, {"kv_split": True}, {"kv_frag": True},
        {"stage_regs": False}, {"kv_reuse": False}, {"nmax": False}, {"o_stage": True},
        {"pair": 2}, {"online_unroll": 4}]
    requests = 0
    for config in configs:
        for namespace, constructions, launches in contexts:
            namespace["_KERNEL_CACHE"].clear()
            constructions.clear()
            launches.clear()
        for visit in range(2):
            for scale in (None, 0.0, 0.1, -0.1):
                shape = helpers.shape(config, scale)
                for override in options if visit == 0 else reversed(options):
                    signatures = [ns["_get_kernel"](*shape, **override).signature for ns, _, _ in contexts]
                    assert canonical(signatures[0]) == canonical(signatures[1]), (config, override, signatures)
                    if override:
                        assert signatures[0] == signatures[1], ("Explicit tuning path changed", config, override)
                    requests += 1
                values = tuple((requests, i) for i in range(5))
                for namespace, _, launches in contexts:
                    namespace["run_kernel"](*values, *shape)
                    assert launches[0][1] == values
                assert canonical(contexts[0][2]) == canonical(contexts[1][2])
            for namespace, _, _ in contexts:
                namespace["_KERNEL_CACHE"].clear()
        assert canonical(contexts[0][1]) == canonical(contexts[1][1]), config
    output = Path(args.output)
    with output.open("x") as out:
        json.dump(dict(status="PASS", configurations=len(configs), requests=requests,
            explicit_paths_unchanged=True, current_inputs_preserved=True,
            sources={str(path):hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}), out, indent=2)
        out.write("\n")
    print("PASS", len(configs), requests, flush=True)


if __name__ == "__main__":
    main()
