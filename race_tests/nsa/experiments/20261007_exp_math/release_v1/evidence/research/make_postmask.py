"""Start QK from zero and apply the key mask to computed probabilities.

Test an uncommon partial-tile branch and an unconditional per-element select.
This also avoids multiplying the mask's negative infinity by zero/negative
scale. It keeps the selected-block bounds checks and all shared synchronization.
"""
import ast
import hashlib
import json
from pathlib import Path
import re

from make_cast_and_flags import HERE, ONLINE, SINGLE, edit_functions
from make_lane_cast import COALESCED

BASE = HERE / "lane_cast_folded.py"


def transform(fn, name, predicated):
    tree = ast.parse(fn)
    lines = fn.splitlines(keepends=True)
    score = "scores" if name == SINGLE else "acc_s"
    if name == SINGLE:
        masks = [n for n in ast.walk(tree) if isinstance(n, ast.For)
                 and isinstance(n.body[0], ast.Assign)
                 and ast.unparse(n.body[0]).startswith("scores[i, j] = T.if_then_else(")]
    else:
        masks = [n for n in ast.walk(tree) if isinstance(n, ast.If)
                 and ast.unparse(n.test).startswith("is_causal and ")
                 and " + BS > " in ast.unparse(n.test)]
    exps = [n for n in ast.walk(tree) if isinstance(n, ast.For)
            and isinstance(n.body[0], ast.Assign)
            and ast.unparse(n.body[0]).startswith(score + "[i, j] = T.exp")]
    masks.sort(key=lambda n: n.lineno)
    exps.sort(key=lambda n: n.lineno)
    assert len(masks) == len(exps) == (5 if name in ONLINE else 1), (name, len(masks), len(exps))
    edits = []
    for mask, exp in zip(masks, exps):
        pad = re.match(" *", lines[mask.lineno - 1])[0]
        edits.append((mask.lineno - 1, mask.end_lineno, pad + f"T.clear({score})\n"))
        if name == SINGLE:
            start, token = "start", "token"
        elif name == COALESCED:
            start, token = "_start_buffer_0[0]", "i_t"
        else:
            match = re.search(r"is_causal and (i_s[0-3]?) \+ BS", ast.unparse(mask.test))
            assert match, ast.unparse(mask.test)
            start, token = match[1], "i_t"
        valid = f"{start} + j < seq_len and (not is_causal or {start} + j <= {token})"
        exp_pad = re.match(" *", lines[exp.lineno - 1])[0]
        value = ast.unparse(exp.body[0].value)
        if predicated:
            new = (exp_pad + "for i, j in T.Parallel(G, BS):\n"
                   + exp_pad + f"    {score}[i, j] = T.if_then_else({valid}, {value}, 0.0)\n")
        else:
            new = "".join(lines[exp.lineno - 1:exp.end_lineno])
            new += (exp_pad + f"if {start} + BS > ({token} + 1 if is_causal else seq_len):\n"
                    + exp_pad + "    for i, j in T.Parallel(G, BS):\n"
                    + exp_pad + f"        {score}[i, j] = T.if_then_else({valid}, {score}[i, j], 0.0)\n")
        edits.append((exp.lineno - 1, exp.end_lineno, new))
    for first, last, new in sorted(edits, reverse=True):
        lines[first:last] = [new]
    return "".join(lines)


def main():
    records = []
    for name, predicated in (("mask_late_branch", False), ("mask_late_predicate", True)):
        source = edit_functions(BASE.read_text(), ONLINE + (SINGLE, COALESCED),
            lambda fn, n: transform(fn, n, predicated))
        ast.parse(source)
        path = HERE / (name + ".py")
        with path.open("x") as f:
            f.write(source)
        records.append(dict(path=str(path), predicated=predicated,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "postmask_assembly.json").write_text(json.dumps(dict(parent=str(BASE),
        variants=records, qk_starts_from_zero=True, bounds_and_sync_retained=True,
        positive_scale_math="Same mask and clamped exponent in a different order"), indent=2) + "\n")
    print("Generated", len(records), "post-exponent mask probes")


if __name__ == "__main__":
    main()
