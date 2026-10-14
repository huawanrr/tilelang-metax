"""Join pasted OJ per-case results with the local benchmark table.

Usage:
    python score_diff.py oj_scores.txt          # file with pasted OJ lines
    python score_diff.py                        # paste lines, Ctrl-D to end

Accepts any line that contains a case index, a time and optionally a score:
    case 12: 16.44 ms 85     |  12 45.3     |  idx 12, 0.045ms, 88
Time unit defaults to us; "ms" multiplies by 1000.

Prints per case: OJ time, local baseline/optimized time, OJ-side speedup
(OJ time / local optimized time), the local speedup, and flags for cases
where the OJ ordering disagrees with the local one.  With >=3 (speedup,
score) pairs it fits score = a + b*log2(speedup) and reports what speedup
score 85 would need.
"""

import argparse
import csv
import math
import re
import sys
from pathlib import Path

HERE = Path(__file__).parent
DEFAULT_LOCAL = HERE / "benchmark_nsa_final.csv"


def parse_oj(lines):
    """Accepts both the raw SPJ report format and the terse legacy format.

    SPJ:  'Testcase  #6' / 'User kernel: 0.112000 ms' / 'Score ratio: ... (80.50%)'
    Old:  'case 12: 16.44 ms 85'  |  '12 45.3'  |  'idx 12, 0.045ms, 88'
    """
    rows = []
    current = None
    pending = None

    def flush():
        if pending is not None and pending[0] is not None:
            rows.append((pending[0], pending[1], pending[2], pending[3]))

    for line in lines:
        s = line.strip()
        if not s:
            continue
        m = re.match(r"(?:Testcase|测试点)\s*#?(\d+)", s, re.I)
        if m:
            flush()
            pending = None
            current = int(m.group(1))
            continue
        m = re.match(r"([\d.]+)\s*(us|μs|ms)\s*$", s)
        if m and current is not None:
            t = float(m.group(1))
            if m.group(2) == "ms":
                t *= 1000.0
            flush()
            pending = [current, t, None, None]
            continue
        m = re.search(r"User [Kk]ernel:\s*([\d.]+)\s*(ms|[uμ]s)?", s)
        if m and current is not None:
            t = float(m.group(1))
            if (m.group(2) or "").lower() == "ms":
                t *= 1000.0
            flush()
            pending = [current, t, None, None]
            continue
        m = re.search(r"Speedup vs base:\s*([\d.]+)", s)
        if m and pending is not None:
            pending[3] = float(m.group(1))
            continue
        m = re.search(r"Score ratio:.*?\(([\d.]+)%\)", s)
        if m and pending is not None:
            pending[2] = float(m.group(1))
            continue
        m = re.match(r"([\d.]+)\s*pts\s*$", s)
        if m and pending is not None:
            pending[2] = float(m.group(1))
            continue
        if current is None:
            # legacy format: a line that starts with a case number
            m = re.match(r"(?:case|idx)?\s*#?(\d+)\s*[:|,]?\s*(.*)", s, re.I)
            if m:
                rest = m.group(2)
                nums = re.findall(r"(\d+(?:\.\d+)?)", rest)
                if nums:
                    t = float(nums[0])
                    if re.search(r"\bms\b|毫秒", rest, re.I):
                        t *= 1000.0
                    score = float(nums[1]) if len(nums) > 1 else None
                    rows.append((int(m.group(1)), t, score))
            continue
    flush()
    return rows


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("oj_file", nargs="?", help="pasted OJ report (default: stdin)")
    parser.add_argument("--csv", type=Path, default=DEFAULT_LOCAL,
                        help="local benchmark table to join against")
    args = parser.parse_args()
    if args.oj_file:
        lines = Path(args.oj_file).read_text().splitlines()
    else:
        print("paste OJ lines (case <idx> <time> [score]), Ctrl-D to end:")
        lines = sys.stdin.read().splitlines()
    oj = parse_oj(lines)
    if not oj:
        sys.exit("no (idx, time) pairs recognised — check the pasted format")

    local = {}
    with args.csv.open() as handle:
        for r in csv.DictReader(handle):
            local[int(r["idx"])] = dict(
                base=float(r["baseline_ms"]) * 1000,
                opt=float(r["optimized_ms"]) * 1000,
                shape=f"B{r['B']} T{r['SEQ_LEN']} D{r['D']} S{r['S']} bs{r['block_size']}",
                speedup=float(r["speedup"]),
            )

    print(f"{'idx':>4} {'shape':<34} {'oj_us':>9} {'loc_base':>9} {'loc_opt':>8} "
          f"{'oj/loc_opt':>10} {'loc_spd':>8} {'score':>6}")
    flags = []
    triples = []   # (OJ-side speedup, score) — the grader's own numbers
    for idx, oj_us, score, oj_spd in sorted(oj):
        if score is not None and oj_spd:
            triples.append((oj_spd, score))
        if idx not in local:
            print(f"{idx:>4} {'(not in local table)':<34} {oj_us:>9.1f}"
                  + (f"  {oj_spd:.2f}x  {score:.1f}" if oj_spd and score is not None else ""))
            continue
        d = local[idx]
        ratio = oj_us / d["opt"]
        print(f"{idx:>4} {d['shape']:<34} {oj_us:>9.1f} {d['base']:>9.1f} {d['opt']:>8.1f} "
              f"{ratio:>9.2f}x {oj_spd if oj_spd else d['speedup']:>7.2f}x "
              f"{'':>6}" if score is None else
              f"{idx:>4} {d['shape']:<34} {oj_us:>9.1f} {d['base']:>9.1f} {d['opt']:>8.1f} "
              f"{ratio:>9.2f}x {oj_spd if oj_spd else d['speedup']:>7.2f}x {score:>6.1f}")
        # The local table is keyed by the LOCAL case index; OJ numbering is
        # its own, so only compare when the shapes actually match.
        if d["shape"] and oj_spd and abs(ratio - 1.0) > 0.5:
            flags.append((idx, f"same-index local case is {d['shape']} ({d['opt']:.0f}us) "
                          f"— OJ numbering is its own; check the shape before comparing"))

    if len(triples) >= 3:
        xs = [math.log2(s) for s, _ in triples]
        ys = [c for _, c in triples]
        # scores may arrive as percent (80.5) or fraction (0.805) — normalise
        scale = 100.0 if max(ys) > 5 else 1.0
        ys = [y / scale for y in ys]
        n = len(triples)
        mx, my = sum(xs) / n, sum(ys) / n
        denom = sum((x - mx) ** 2 for x in xs)
        if denom > 1e-9:
            b = sum((x - mx) * (y - my) for x, y in zip(xs, ys)) / denom
            a = my - b * mx
            print(f"\nfit over {n} cases: score% ≈ {a*100:.2f} + {b*100:.2f} * log2(speedup)"
                  f"   [{n} (OJ speedup, score) pairs]")
            if b > 0:
                need_log2 = (0.85 - a) / b
                print(f"  85 分需要每例加速比 ≈ {2 ** need_log2:.2f}x；"
                      f"当前均分 ≈ {a*100 + b*100*(math.log2(sum(xs)/n)) if xs else 0:.1f}"
                      f"（按所报用例的 log2 平均加速比折算）")

    if flags:
        print("\nflags:")
        seen = set()
        for idx, msg in flags:
            if idx not in seen:
                seen.add(idx)
                print(f"  case {idx}: {msg}")


if __name__ == "__main__":
    main()
