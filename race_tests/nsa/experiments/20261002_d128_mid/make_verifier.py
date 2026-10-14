"""Adapt the established release checks to the selected D128 shape domains."""
import ast
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
TEMPLATE = ROOT / "experiments/20261002_mid_output"


def once(source, old, new):
    assert source.count(old) == 1, (source.count(old), old)
    return source.replace(old, new)


def replace_span(source, start, stop, value):
    assert source.count(start) == source.count(stop) == 1
    left, right = source.index(start), source.index(stop)
    assert left < right
    return source[:left] + value + source[right:]


def main():
    source = (TEMPLATE / "verify_output.py").read_text()
    source = once(source, "def cfg(t, d=64,", "def cfg(t, d=128,")
    helpers = '''def selected_kind(case, config):
    if not (case["S"] == 1 and case["D"] == 128 and case["HQ"] == 16 * case["H"]
            and case["block_size"] == 16 and case["SEQ_LEN"] % 16 == 0):
        return "base"
    grid = case["B"] * case["H"] * case["SEQ_LEN"]
    for name in ("linear", "coalesced"):
        domain = config[name]
        if (domain["enabled"] and domain["min_grid"] <= grid < domain["max_grid_exclusive"]
                and case["SEQ_LEN"] >= domain["min_seq"]
                and (domain["heads"] is None or case["H"] in domain["heads"])):
            return name
    return "base"


def selected(case, config):
    return selected_kind(case, config) != "base"


def boundary_cases(config):
    cases = []
    thresholds = {128, 1280}
    for name in ("linear", "coalesced"):
        domain = config[name]
        if domain["enabled"]:
            thresholds.update((domain["min_grid"], domain["max_grid_exclusive"]))
    for threshold in sorted(thresholds):
        cases.extend(cfg(t, causal=t % 2 == 0) for t in
            sorted({max(1, threshold - 1), threshold, threshold + 1,
                    max(16, threshold // 16 * 16), max(16, threshold // 16 * 16 - 16)}))
    cases += [cfg(16, b=16), cfg(32, b=8), cfg(48, b=4), cfg(64, b=4), cfg(64, b=16),
        cfg(128, b=8), cfg(192, b=4), cfg(256, b=2), cfg(512, b=2),
        cfg(256, h=2), cfg(256, b=2, h=2), cfg(256, h=4), cfg(512, h=2),
        cfg(255, b=4, causal=False), cfg(256, b=4, causal=False), cfg(512, causal=False),
        cfg(512, d=64), cfg(1024, d=32), cfg(1024, b=8, bs=32),
        cfg(4096, d=64, s=2), cfg(4096, d=64, s=8), cfg(129, d=64, s=4)]
    grouped = cfg(1024)
    grouped["HQ"] = 32
    cases.append(grouped)
    unique = {json.dumps(case, sort_keys=True): case for case in cases}
    return list(unique.values())


'''
    source = replace_span(source, "def selected(case, config):", "def digest(path):", helpers)
    source = once(source, 'ROOT / "experiments/20261002_mid_v1/submission.py"',
                  'ROOT / "experiments/20261002_output_v1/submission.py"')
    source = once(source, '    probe = load_module(str(ROOT / assembly["config"]["probe"]))',
        '    probes = {"base": base}\n'
        '    for name in ("linear", "coalesced"):\n'
        '        if config[name]["enabled"]:\n'
        '            probes[name] = load_module(str(ROOT / config[name]["probe"]))')
    source = replace_span(source, "    cases = [cfg(t, causal=t % 2 == 0)",
                          "    for i, case in enumerate(cases):",
        '    cases = boundary_cases(config)\n'
        '    report["expected_boundary_count"] = len(cases)\n'
        '    persist()\n')
    source = once(source, '        active = selected(case, config)',
                  '        kind = selected_kind(case, config)\n        active = kind != "base"')
    source = once(source, '(trial, dev, probe if active else base)', '(trial, dev, probes[kind])')
    source = once(source, '                assert "*(uint1*)(K_reg" in source and "*(uint1*)(V_reg" in source',
        '                assert any(marker in source for marker in ("*(uint1*)(K_reg", "*(uint2*)(K_reg"))\n'
        '                assert any(marker in source for marker in ("*(uint1*)(V_reg", "*(uint2*)(V_reg"))')
    source = once(source, '            assert audits[0]["wave_barriers"] == 7 and audits[0]["block_barriers"] == 0',
        '            assert audits[0]["wave_barriers"] == (3 if kind == "linear" else 7)\n'
        '            assert audits[0]["block_barriers"] == 0')
    source = once(source, 'report["boundaries"].append(dict(config=case, active=active,',
                  'report["boundaries"].append(dict(config=case, active=active, kind=kind,')
    source = once(source, 'report["sources"].append(dict(config=case, active=active,',
                  'report["sources"].append(dict(config=case, active=active, kind=kind,')
    source = once(source, '    for case in (cfg(2048), cfg(2176)):',
                  '    for case in (cfg(256), cfg(1024)):')
    source = replace_span(source, '    extreme_cases = [cfg(2048)', '    for i, case in enumerate(extreme_cases):',
        '    active_cases = [case for case in cases if selected(case, config)]\n'
        '    assert len(active_cases) >= 6\n'
        '    extreme_cases = active_cases[:3] + active_cases[-3:]\n')
    source = replace_span(source, '    live_cases = [cfg(2048)', '    for case in live_cases:',
        '    linear_cases = [case for case in cases if selected_kind(case, config) == "linear"]\n'
        '    coalesced_cases = [case for case in cases if selected_kind(case, config) == "coalesced"]\n'
        '    live_cases = (linear_cases[:2] + coalesced_cases[:2])\n'
        '    if len(live_cases) < 4:\n'
        '        live_cases = active_cases[:4]\n'
        '    live_cases += [cfg(1024, d=32), cfg(4096, d=64, s=8)]\n'
        '    assert len(live_cases) == 6\n')
    ast.parse(source)
    with (HERE / "verify_d128.py").open("x") as output:
        output.write(source)
    for name in ("verify_reference.py", "audit_sources.py"):
        assert not (HERE / name).exists()
        shutil.copyfile(TEMPLATE / name, HERE / name)
    runner = (TEMPLATE / "validate_release.py").read_text().replace('"audit_output.py"', '"audit_d128.py"')
    with (HERE / "validate_release.py").open("x") as output:
        output.write(runner)
    print("Created D128 release verifier and sequential validation runner")


if __name__ == "__main__":
    main()
