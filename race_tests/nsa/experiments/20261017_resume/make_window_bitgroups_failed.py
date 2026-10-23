"""Replace shared atomic bucketing with fixed register collectives."""
import ast
import hashlib
import json
import random
from pathlib import Path

from make_window_pairs import PACK

HERE = Path(__file__).resolve().parent
MASK = (1 << 64) - 1


def cpu_records(indices, nb, begin, causal):
    n = len(indices)
    buckets, active, votes = [], [], []
    for half in range(2):
        bs, mask = [], 0
        for lane in range(64):
            token = begin + half*64 + lane
            raw = indices[token] if token < n else -1
            bs.append(raw if 0 <= raw < nb and (not causal or raw <= token//32) else nb)
            if token < n:
                mask |= 1 << lane
        buckets.append(bs)
        active.append(mask)
        # Reproduce every stage of the implemented shuffle-OR.
        fields = [[(1 << lane) if bs[lane] & (1 << bit) else 0 for lane in range(64)] for bit in range(6)]
        for stage in range(6):
            fields = [[values[lane] | values[lane ^ (1 << stage)] for lane in range(64)] for values in fields]
        assert all(len(set(field)) == 1 for field in fields)
        votes.append([field[0] for field in fields])
    matches, counts, leaders, ranks, owners = {}, {}, {}, {}, {}
    for half in range(2):
        for lane in range(64):
            key = (half, lane)
            group = []
            for other in range(2):
                value = active[other]
                for bit in range(6):
                    value &= votes[other][bit] if buckets[half][lane] & (1 << bit) else (MASK ^ votes[other][bit])
                group.append(value)
            matches[key] = group
            counts[key] = sum(x.bit_count() for x in group)
            leaders[key] = group[0].bit_length()-1 if group[0] else 64 + (group[1] | 1).bit_length()-1
            upper = MASK ^ ((1 << (lane+1))-1)
            ranks[key] = (group[half] & upper).bit_count() + (group[0].bit_count() if half else 0)
            owners[key] = (counts[key]+1)//2 if begin+half*64+lane < n and leaders[key] == half*64+lane else 0
    totals = [owners[0,lane] + owners[1,lane] for lane in range(64)]
    prefix, running = [], 0
    for lane in range(64):
        prefix.append(running + owners[0,lane]*65536)
        running += totals[lane]
    records = {}
    for half in range(2):
        for lane in range(64):
            key, token = (half,lane), begin + half*64+lane
            if token >= n or ranks[key] % 2:
                continue
            leader = leaders[key]
            received = prefix[leader % 64]
            task = received % 65536 + (received//65536 if leader>=64 else 0) + ranks[key]//2
            assert task not in records
            lower = matches[key][half] & ((1 << lane)-1)
            partner_lane = (64 + (matches[key][1] | 1).bit_length()-1) if half == 0 and lower == 0 else half*64+(lower | 1).bit_length()-1
            partner = begin+partner_lane if ranks[key]+1<counts[key] else -1
            records[task] = (buckets[half][lane], token, partner)
    assert sorted(records) == list(range(running))
    return records


def proof():
    rng = random.Random(1561)
    cases = 0
    for n in (1, 31, 32, 33, 63, 64, 65, 127, 128, 129, 255, 256, 257, 511, 512, 513, 1023, 1024, 1985, 2016):
        nb = (n+31)//32
        cap = min(128, (128+nb+1)//2)
        for causal in (False, True):
            patterns = [[0]*n, [nb]*n, [rng.randrange(nb) for _ in range(n)],
                        [rng.choice([-2**31, -1, 0, nb-1, nb, 2**31-1]) for _ in range(n)]]
            for indices in patterns:
                seen = []
                for begin in range(0, n, 128):
                    records = cpu_records(indices, nb, begin, causal)
                    assert len(records) <= cap
                    for bucket, first, second in records.values():
                        for token in (first, second):
                            if token >= 0:
                                seen.append(token)
                                raw = indices[token]
                                valid = 0 <= raw < nb and (not causal or raw <= token//32)
                                assert bucket == (raw if valid else nb)
                assert sorted(seen) == list(range(n))
                cases += 1
    return dict(pattern_cases=cases, full_shuffle_simulation=True, complete_unique_tokens=True,
                compact_unique_slots=True, current_bucket_membership=True)


def main():
    parent = HERE / "window_final_row_w64_q8.py"
    source = parent.read_text()
    template = (HERE / "window_bitgroups_prepare.py").read_text()
    fn = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == PACK + "_window_pairs")
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    assert isinstance(scope.body[0], ast.If)
    scope.body[0].orelse = ast.parse(template).body
    fn.body.insert(0, ast.Assert(test=ast.parse("window == 128", mode="eval").body))
    begin = min([fn.lineno] + [d.lineno for d in fn.decorator_list])-1
    lines = source.splitlines(keepends=True)
    lines[begin:fn.end_lineno] = [ast.unparse(ast.fix_missing_locations(fn))+"\n"]
    result = "".join(lines)
    ast.parse(result)
    dest = HERE / "window_bitgroups.py"
    with dest.open("x") as out:
        out.write(result)
    with (HERE / "window_bitgroups_manifest.json").open("x") as out:
        json.dump(dict(parent=parent.name, parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       file=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                       proof=proof(), prep_atomics=False, prep_shared_buffers=False,
                       attention_unchanged=True, bounds_and_race_checks_enabled=True), out, indent=2)
        out.write("\n")
    print("Generated register bit-group preparation probe")


if __name__ == "__main__":
    main()
