"""Specialize the established boundary and live-input checks for the new gate."""
from pathlib import Path
import shutil

from prepare import function, once, write_new

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    for name in ("verify_reference.py", "audit_sources.py"):
        target = HERE / name
        assert not target.exists()
        shutil.copyfile(ROOT / "experiments/20261002_goal885" / name, target)
    source = (ROOT / "experiments/20261002_goal885/verify_blocks.py").read_text()
    original = function(source, "selected")
    selected = '''def selected(case, config):
    grid = case["B"] * case["H"] * case["SEQ_LEN"]
    return (case["S"] == 1 and case["D"] == 64 and case["block_size"] == 16
        and case["H"] == 1 and case["HQ"] == 16 and case["SEQ_LEN"] % 16 == 0
        and config["grid_min_exclusive"] < grid <= config["grid_max_inclusive"])
'''
    source = once(source, original, selected)
    source = once(source, 'experiments/20261002_d32_v1/submission.py',
                  'experiments/20261002_blocks_v2/submission.py')
    start = source.index("    cases = []\n")
    end = source.index("    persist()\n    for i, case in enumerate(cases):", start)
    cases = '''    cases = [cfg(t, causal=t % 2 == 0) for t in
        (255, 256, 257, 271, 272, 273, 2032, 2047, 2048, 2049, 2064, 2065)]
    cases += [cfg(16, b=32), cfg(32, b=32), cfg(48, b=32), cfg(64, b=8),
        cfg(80, b=16), cfg(112, b=16), cfg(128, b=16), cfg(256, b=2),
        cfg(512, b=2), cfg(1280, causal=False), cfg(272, causal=False),
        cfg(256, h=2), cfg(512, b=2, h=2), cfg(256, b=2, h=4),
        cfg(2304), cfg(1280, d=128), cfg(768, d=32),
        cfg(1024, d=128, b=8, bs=32), cfg(4096, s=2), cfg(4096, s=8), cfg(129, s=4)]
    grouped = cfg(1280, d=128)
    grouped["HQ"] = 32
    cases.append(grouped)
'''
    source = source[:start] + cases + source[end:]
    source = once(source, 'audits[0]["wave_barriers"] == 7', 'audits[0]["wave_barriers"] == 5')
    source = once(source, 'for case in (cfg(4096), cfg(2048, d=128)):',
                  'for case in (cfg(512), cfg(2048)):')
    start = source.index('    small_t = max(16, config.get("d64_min_seq", 0))')
    end = source.index('    for i, case in enumerate(extreme_cases):', start)
    source = source[:start] + '''    extreme_cases = [cfg(272), cfg(512, causal=False), cfg(2032),
                     cfg(16, b=32), cfg(64, b=16), cfg(128, b=8, causal=False)]
''' + source[end:]
    start = source.index('    live_cases = [')
    end = source.index('    for case in live_cases:', start)
    source = source[:start] + '''    live_cases = [cfg(512), cfg(1280, causal=False), cfg(16, b=32),
                  cfg(2032), cfg(2304), cfg(4096, s=8)]
''' + source[end:]
    write_new(HERE / "verify_mid.py", source)
    print("Prepared verify_mid.py, verify_reference.py and audit_sources.py")


if __name__ == "__main__":
    main()
