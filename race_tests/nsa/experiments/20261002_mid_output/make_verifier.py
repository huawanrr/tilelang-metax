"""Prepare the same release checks around the new crossover interval."""
import ast
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def once(source, old, new):
    assert source.count(old) == 1, old
    return source.replace(old, new)


def main():
    for name in ("verify_reference.py", "audit_sources.py"):
        target = HERE / name
        assert not target.exists()
        shutil.copyfile(ROOT / "experiments/20261002_mid_blocks" / name, target)
    source = (ROOT / "experiments/20261002_mid_blocks/verify_mid.py").read_text()
    node = next(node for node in ast.parse(source).body if isinstance(node, ast.FunctionDef) and node.name == "selected")
    old = "\n".join(source.splitlines()[node.lineno-1:node.end_lineno])
    source = once(source, old, '''def selected(case, config):
    grid = case["B"] * case["H"] * case["SEQ_LEN"]
    return (case["S"] == 1 and case["D"] == 64 and case["H"] == 1 and case["HQ"] == 16
        and case["block_size"] == 16 and case["SEQ_LEN"] % 16 == 0
        and case["SEQ_LEN"] >= config["min_seq"]
        and config["min_grid"] <= grid < config["max_grid_exclusive"])
''')
    source = once(source, 'experiments/20261002_blocks_v2/submission.py', 'experiments/20261002_mid_v1/submission.py')
    start = source.index('    cases = [')
    end = source.index('    persist()\n    for i, case in enumerate(cases):', start)
    source = source[:start] + '''    cases = [cfg(t, causal=t % 2 == 0) for t in
        (2031, 2032, 2047, 2048, 2049, 2064, 2065, 2288, 2303, 2304, 2305, 2320)]
    cases += [cfg(128, b=16), cfg(127, b=17), cfg(128, b=17), cfg(112, b=19),
        cfg(64, b=32), cfg(16, b=128), cfg(176, b=12), cfg(544, b=4),
        cfg(272, b=8), cfg(1056, b=2), cfg(512, b=4, causal=False), cfg(2112, causal=False),
        cfg(512, b=2, h=2), cfg(544, b=2, h=2), cfg(1280), cfg(1536),
        cfg(2048, d=128), cfg(2048, d=32), cfg(1024, d=128, b=8, bs=32),
        cfg(4096, s=2), cfg(4096, s=8), cfg(129, s=4)]
    grouped = cfg(2048)
    grouped["HQ"] = 32
    cases.append(grouped)
''' + source[end:]
    source = once(source, 'audits[0]["wave_barriers"] == 5', 'audits[0]["wave_barriers"] == 7')
    source = once(source, 'for case in (cfg(512), cfg(2048)):', 'for case in (cfg(2048), cfg(2176)):')
    start = source.index('    extreme_cases = [')
    end = source.index('    for i, case in enumerate(extreme_cases):', start)
    source = source[:start] + '''    extreme_cases = [cfg(2048), cfg(2064), cfg(2112, causal=False),
                     cfg(2288), cfg(128, b=16), cfg(176, b=12)]
''' + source[end:]
    start = source.index('    live_cases = [')
    end = source.index('    for case in live_cases:', start)
    source = source[:start] + '''    live_cases = [cfg(2048), cfg(2112, causal=False), cfg(128, b=16),
                  cfg(176, b=12), cfg(1024), cfg(4096, s=8)]
''' + source[end:]
    ast.parse(source)
    target = HERE / "verify_output.py"
    assert not target.exists()
    target.write_text(source)
    print("Prepared verify_output.py and copied validation helpers")


if __name__ == "__main__":
    main()
