"""Add shape-family and dispatch-boundary cases before final selection."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    path = HERE / "family_cases.json"
    family = json.loads(path.read_text())
    chosen = ["9", "12", "15", "20", "23", "26", "32", "35", "38", "47", "50"]
    extra = [(1,144,1,True),(1,384,1,True),(1,768,1,True),(1,1008,1,True),
             (1,1056,1,True),(1,1264,1,True),(2,80,1,True),(4,48,1,True),
             (8,32,1,True),(16,16,1,True),(2,384,1,True),(4,192,1,True),
             (8,96,1,True),(16,64,1,True),(1,512,1,False),(4,256,1,False),
             (1,256,2,True),(2,256,2,True),(1,256,4,True)]
    for b, t, h, causal in extra:
        name = f"d128mid_b{b}_t{t}_h{h}_c{int(causal)}"
        config = dict(B=b, SEQ_LEN=t,H=h,HQ=16*h,D=128,S=1,block_size=16,is_causal=causal)
        if name in family:
            assert family[name] == config
        else:
            family[name] = config
        chosen.append(name)
    chosen += ["73", "6", "d128_bs16_t257", "d128_bs16_t1280", "29"]
    assert len(chosen) == len(set(chosen)) == 35
    path.write_text(json.dumps(family,indent=2)+"\n")
    with (HERE / "family_selection.json").open("x") as output:
        output.write(json.dumps(dict(cases=chosen,seeds=[0,61,2026],attempts=24,repeat=500),indent=2)+"\n")
    print(",".join(chosen))


if __name__ == "__main__":
    main()
