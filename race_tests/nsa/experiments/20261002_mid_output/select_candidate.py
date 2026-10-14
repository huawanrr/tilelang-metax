"""Retain medium direct output below the measured coalesced crossover."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    base = HERE / "coalesced_mid.py"
    source = base.read_text()
    old = "and 1024 <= grid < 2304 and seq_len >= 128"
    assert source.count(old) == 1
    source = source.replace(old, "and 2048 <= grid < 2304 and seq_len >= 128")
    path = HERE / "coalesced_ge2048.py"
    assert not path.exists()
    ast.parse(source)
    path.write_text(source)
    cases_path = HERE / "family_cases.json"
    cases = json.loads(cases_path.read_text())
    added = {}
    shapes = [(1,2048,1,True),(1,2064,1,True),(1,2112,1,True),(1,2176,1,True),
        (1,2288,1,True),(2,1056,1,True),(4,544,1,True),(8,272,1,True),
        (12,176,1,True),(17,128,1,True),(2,1120,1,True),(4,560,1,True),
        (4,512,1,False),(1,2112,1,False),(1,2032,1,True),(32,64,1,True),
        (17,127,1,True),(1,2319,1,True),(2,512,2,True),(12,128,1,True)]
    for b,t,h,causal in shapes:
        name = f"cross_b{b}_t{t}_h{h}_c{int(causal)}"
        assert name not in cases
        added[name] = dict(B=b,SEQ_LEN=t,H=h,HQ=16*h,D=64,S=1,block_size=16,is_causal=causal)
    cases.update(added)
    cases_path.write_text(json.dumps(cases,indent=2)+"\n")
    selected = ["28","40","52","d64_bs16_b16_h1_t128",*added,"d64_bs16_t2304"]
    record = dict(source=path.name, source_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        parent=base.name, parent_sha256=hashlib.sha256(base.read_bytes()).hexdigest(),
        config=dict(dim=64,block_size=16,groups=16,threads=64,kv_heads=1,min_grid=2048,
                    max_grid_exclusive=2304,min_seq=128,complete_blocks_only=True),
        bracket_cases=selected)
    (HERE / "selection.json").write_text(json.dumps(record,indent=2)+"\n")
    print("cases", ",".join(selected))
    print("candidate SHA256",record["source_sha256"])


if __name__ == "__main__":
    main()
