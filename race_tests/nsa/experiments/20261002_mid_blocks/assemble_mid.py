"""Integrate the stable H1 D64 medium-grid loader without changing old builders."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

from prepare import function, once, write_new

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_blocks_v2/nsa.py"
PROBE = HERE / "mid_pairs.py"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def functions(source):
    return {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(source).body
            if isinstance(n, ast.FunctionDef)}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--output-dir", required=True)
    args = p.parse_args()
    out = Path(args.output_dir).resolve()
    out.mkdir(parents=True, exist_ok=True)
    source = PROBE.read_text()
    source = once(source,
        "    shared_q_blocks = (wave_q_reuse and seq_len % block_size == 0",
        "    # H1 makes each selected K/V block physically contiguous. Keep the\n"
        "    # separately strided multi-head family on its existing builder.\n"
        "    shared_q_blocks = (wave_q_reuse and H == 1 and seq_len % block_size == 0")
    part = function(source, "native_sparse_attention_shared_q_blocks")
    node = ast.parse(part).body[0].body[0]
    assert isinstance(node, ast.Expr) and isinstance(node.value, ast.Constant)
    lines = part.splitlines(keepends=True)
    doc = '''    """D64 complete blocks for medium grids with one KV head.

    Validate the block number before forming an address, then load each
    lane's eight fp16 values as four uint32 words. The five original wave
    barriers protect Q RAW, Q/K WAR, K RAW, K/V WAR and V RAW. The shared
    layouts, output stores and arithmetic stay unchanged.
    """\n'''
    new_part = "".join(lines[:node.lineno-1]) + doc + "".join(lines[node.end_lineno:])
    source = once(source, part, new_part)
    before, after = functions(BASE.read_text()), functions(source)
    retained = [name for name in before if name != "_get_kernel"]
    assert len(retained) == 43
    assert all(before[name] == after[name] for name in retained)
    assert set(after) - set(before) == {"native_sparse_attention_shared_q_blocks"}
    dev, sub = out / "nsa.py", out / "submission.py"
    write_new(dev, source)
    assert not sub.exists()
    subprocess.run([sys.executable, str(ROOT.parent / "moe/strip_comments.py"),
                    str(dev), str(sub), "--docstrings"], check=True)
    record = dict(command=sys.argv,
        config=dict(dim=64, block_size=16, groups=16, threads=64, kv_heads=1,
            grid_min_exclusive=256, grid_max_inclusive=2048, complete_blocks_only=True,
            load_elements=2, wave_barriers=5, probe=str(PROBE.relative_to(ROOT))),
        retained_functions=retained, new_functions=["native_sparse_attention_shared_q_blocks"],
        source_sha256={str(path.relative_to(ROOT)): digest(path) for path in
                       (BASE, PROBE, Path(__file__).resolve(), dev, sub)},
        baseline_official_score=87.93, target_official_score=88.5,
        new_official_score=None, status="assembled; final local validation pending")
    write_new(out / "assembly.json", json.dumps(record, indent=2) + "\n")
    print("Assembled", out, "with", len(retained), "unchanged non-dispatch functions")
    print("submission SHA256", digest(sub))


if __name__ == "__main__":
    main()
