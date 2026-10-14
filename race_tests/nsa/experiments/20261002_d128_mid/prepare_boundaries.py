"""Check unsampled crossover intervals, short sequences and strided KV heads."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    path = HERE / "family_cases.json"
    family = json.loads(path.read_text())
    shapes = [(1,528,1,True),(1,640,1,True),(2,320,1,True),(4,160,1,True),
              (8,80,1,True),(1,896,1,True),(2,448,1,True),(8,112,1,True),
              (4,240,1,True),(20,48,1,True),(1,1040,1,True),(2,528,1,True),
              (4,304,1,True),(8,144,1,True),(32,32,1,True),(64,16,1,True),
              (4,128,2,True),(16,32,2,True),(4,64,4,True),(1,128,8,True)]
    chosen = []
    for b, t, h, causal in shapes:
        name = f"d128edge_b{b}_t{t}_h{h}_c{int(causal)}"
        assert name not in family
        family[name] = dict(B=b,SEQ_LEN=t,H=h,HQ=16*h,D=128,S=1,block_size=16,is_causal=causal)
        chosen.append(name)
    path.write_text(json.dumps(family,indent=2)+"\n")
    with (HERE / "boundary_selection.json").open("x") as output:
        output.write(json.dumps(dict(cases=chosen,seeds=[0,61,2026],attempts=24,repeat=500),indent=2)+"\n")
    print(len(chosen),"boundary shapes")


if __name__ == "__main__":
    main()
