"""Compare the existing complete-block Q/O builder near the D128 crossover."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def once(source, old, new):
    assert source.count(old) == 1, old
    return source.replace(old, new)


def main():
    source = (HERE / "reference_output.py").read_text()
    flag = """    d128_mid_coalesced = (qo_defaults and D == 128 and block_size == 16
        and 512 <= grid < 1280 and seq_len % block_size == 0
        and pair_resolved == 1 and num_stages == 1 and online_unroll == 2
        and not late_normalize)
    if d128_mid_coalesced:
        coalesced_qo = True
        coalesced_blocks = True

"""
    records = []
    before = {node.name: ast.dump(node) for node in ast.parse(source).body
              if isinstance(node, ast.FunctionDef) and node.name != "_get_kernel"}
    for vec in (8, 4):
        result = once(source, "    key = (\n", flag + "    key = (\n")
        if vec == 4:
            result = once(result, "builder(q_vec=4 if qo_four else 8,",
                          "builder(q_vec=4 if (qo_four or d128_mid_coalesced) else 8,")
        after = {node.name: ast.dump(node) for node in ast.parse(result).body
                 if isinstance(node, ast.FunctionDef)}
        assert len(before) == 44 and all(after[name] == body for name, body in before.items())
        path = HERE / f"coalesced_q{vec}.py"
        with path.open("x") as output:
            output.write(result)
        records.append(dict(path=str(path.relative_to(ROOT)),
            sha256=hashlib.sha256(path.read_bytes()).hexdigest(), q_vec=vec,
            unchanged_non_dispatch_functions=44))
    path = HERE / "family_cases.json"
    cases = json.loads(path.read_text())
    for b, t, h, causal in ((1,1264,1,True),(2,384,1,True),(4,192,1,True),
                          (8,96,1,True),(16,64,1,True),(1,1056,1,True)):
        name = f"d128mid_b{b}_t{t}_h{h}_c{int(causal)}"
        assert name not in cases
        cases[name] = dict(B=b,SEQ_LEN=t,H=h,HQ=16*h,D=128,S=1,block_size=16,is_causal=causal)
    path.write_text(json.dumps(cases,indent=2)+"\n")
    (HERE / "coalesced_assembly.json").write_text(json.dumps(records,indent=2)+"\n")
    print(json.dumps(records,indent=2))


if __name__ == "__main__":
    main()
