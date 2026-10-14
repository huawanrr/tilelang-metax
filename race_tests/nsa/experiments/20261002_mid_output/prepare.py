"""Probe the Q/O-coalesced crossover without modifying any released sources."""
import ast
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    for old, name in ((BASE, "reference_mid.py"), (BASE, "reference_control.py"),
        *[(ROOT / "experiments/20261002_mid_blocks" / name, name)
          for name in ("compare_family.py", "bracketed_multiseed.py", "family_cases.json", "inspect_resources.py")]):
        target = HERE / name
        assert not target.exists(), target
        shutil.copyfile(old, target)
    source = BASE.read_text()
    old = "    key = (\n"
    assert source.count(old) == 1
    flag = '''    medium_coalesced = (qo_defaults and D == 64 and block_size == 16 and H == 1
        and 1024 <= grid < 2304 and seq_len >= 128 and seq_len % block_size == 0
        and pair_resolved == 1 and num_stages == 1 and online_unroll == 2
        and not late_normalize)
    if medium_coalesced:
        coalesced_qo = True
        coalesced_blocks = True

'''
    result = source.replace(old, flag + old)
    before = {n.name: ast.dump(n) for n in ast.parse(source).body
              if isinstance(n, ast.FunctionDef) and n.name != "_get_kernel"}
    after = {n.name: ast.dump(n) for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
    assert all(after[name] == node for name, node in before.items())
    path = HERE / "coalesced_mid.py"
    assert not path.exists()
    path.write_text(result)
    cases_path = HERE / "family_cases.json"
    cases = json.loads(cases_path.read_text())
    for b, t, h, causal in [(1,2112,1,True),(1,2176,1,True),(1,2288,1,True),
                            (12,128,1,True),(1,1536,1,False),(4,512,1,False)]:
        name = f"output_b{b}_t{t}_h{h}_c{int(causal)}"
        assert name not in cases
        cases[name] = dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=64, S=1, block_size=16, is_causal=causal)
    cases_path.write_text(json.dumps(cases, indent=2) + "\n")
    report = dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=digest(BASE),
        source=path.name, source_sha256=digest(path), unchanged_non_dispatch_functions=len(before),
        hypothesis="The validated coalesced block builder may move the Q/O crossover into the upper medium grid range; all seven barriers remain intact",
        scope="Default S1/D64/BS16/G16/H1, complete blocks, seq_len >= 128, 1024 <= grid < 2304",
        official_score=None)
    (HERE / "assembly.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
