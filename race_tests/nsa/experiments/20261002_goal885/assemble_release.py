"""Add the verified aligned-block builder without changing existing GPU builders."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

from make_register_qk import function, once


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_d32_v1/nsa.py"
PROBE = HERE / "coalesced_block_view_pair_loads.py"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def functions(source):
    return {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(source).body
            if isinstance(n, ast.FunctionDef)}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--output-dir", required=True)
    a = p.parse_args()
    out = Path(a.output_dir).resolve()
    out.mkdir(parents=True, exist_ok=True)
    dev, sub = out / "nsa.py", out / "submission.py"
    assert not dev.exists() and not sub.exists(), out
    frozen = json.loads((HERE / "baseline_manifest.json").read_text())
    for name, expected in frozen["source_sha256"].items():
        assert digest(ROOT / name) == expected, name
    baseline = BASE.read_text()
    part = function(PROBE.read_text(), "_coalesced_block_view_prim")
    part = once(part, "def _coalesced_block_view_prim(", "def _coalesced_block_loads_prim(")
    part = once(part, "    assert seq_len % block_size == 0",
                "    assert block_size == 16 and seq_len % block_size == 0")
    doc = ast.get_docstring(ast.parse(part).body[0])
    assert doc
    # Keep the tested TIR statements and variable names unchanged.
    node = ast.parse(part).body[0].body[0]
    lines = part.splitlines(keepends=True)
    part = "".join(lines[:node.lineno-1]) + '''    """Coalesced Q/O with guarded, same-storage views of complete K/V blocks.

    Each lane loads its eight contiguous fp16 values as four uint32 words.
    This avoids unpromoted aggregate copies while retaining the tested shared
    layouts. Seven wave barriers protect Q RAW, Q/K WAR, K RAW, K/V WAR,
    V RAW, V/O WAR and O RAW. No extra kernel or data preparation is needed.
    """\n''' + "".join(lines[node.end_lineno:])
    wrapper = function(baseline, "native_sparse_attention_coalesced_qo")
    wrapper = once(wrapper, "def native_sparse_attention_coalesced_qo(",
                   "def native_sparse_attention_coalesced_blocks(")
    wrapper = once(wrapper, "    return _coalesced_qo_prim(\n",
                   "    return _coalesced_block_loads_prim(\n")
    source = once(baseline, "\ndef _get_kernel(",
                  "\n" + part + "\n\n" + wrapper + "\n\ndef _get_kernel(")
    flag = '''    # Complete BS16 blocks admit a same-storage K/V view. Scalar uint32
    # loads avoid aggregate-copy private arrays without weakening bounds checks.
    coalesced_blocks = (coalesced_qo and block_size == 16 and seq_len % block_size == 0
        and pair_resolved == 1 and num_stages == 1 and online_unroll == 2
        and not late_normalize)

'''
    source = once(source, "    key = (\n        B,\n        seq_len,", flag + "    key = (\n        B,\n        seq_len,")
    source = once(source, "        d32_index_guard, d32_compact,",
                  "        d32_index_guard, d32_compact, coalesced_blocks,")
    source = once(source, "        elif coalesced_qo:\n            builder = native_sparse_attention_coalesced_qo",
                  "        elif coalesced_qo:\n            builder = (native_sparse_attention_coalesced_blocks if coalesced_blocks\n"
                  "                       else native_sparse_attention_coalesced_qo)")
    before, after = functions(baseline), functions(source)
    retained = [name for name in before if name != "_get_kernel"]
    assert all(before[name] == after[name] for name in retained)
    assert set(after) - set(before) == {"_coalesced_block_loads_prim", "native_sparse_attention_coalesced_blocks"}
    dev.write_text(source)
    subprocess.run([sys.executable, str(ROOT.parent / "moe/strip_comments.py"),
                    str(dev), str(sub), "--docstrings"], check=True)
    report = dict(command=sys.argv,
        config=dict(block_size=16, load_elements=2, complete_blocks_only=True,
                    d64_min_grid=2304, d128_min_grid=1280,
                    probe=str(PROBE.relative_to(ROOT))),
        retained_functions=retained, new_functions=sorted(set(after)-set(before)),
        source_sha256={str(path.relative_to(ROOT)): digest(path) for path in
                       (BASE, PROBE, Path(__file__).resolve(), dev, sub)},
        baseline_official_score=87.93, target_official_score=88.5,
        new_official_score=None, status="assembled; final GPU validation pending")
    (out / "assembly.json").write_text(json.dumps(report, indent=2) + "\n")
    print("Assembled", out, "with", len(retained), "unchanged GPU/public builders")


if __name__ == "__main__":
    main()
