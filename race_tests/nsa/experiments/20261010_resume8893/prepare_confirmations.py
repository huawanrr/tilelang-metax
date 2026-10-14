"""Prepare neighboring shapes and serial, independently logged confirmation jobs."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    cases, groups = {}, {name: [] for name in ("mid_q", "mid_reduce", "d128_load")}

    def add(group, n, b=1, h=1, d=64, causal=True):
        name = f"d{d}_b{b}_t{n}_h{h}_c{int(causal)}"
        cases[name] = dict(B=b, SEQ_LEN=n, H=h, HQ=16*h, D=d, S=1,
                           block_size=16, is_causal=causal)
        groups[group].append(name)

    for n, b, h in ((128,1,4),(192,1,3),(256,1,2),(256,1,3),(256,1,4),
                    (384,1,2),(512,1,2),(768,1,2),(512,1,3),(256,2,4),
                    (512,2,2),(128,1,8),(128,2,8)):
        add("mid_q", n, b, h, causal=False)
    for n, b in ((128,4),(256,2),(512,1),(256,4),(512,2),(1024,1),
                 (768,2),(512,3),(1024,2),(2048,1),(128,16),(256,8)):
        add("mid_reduce", n, b)
    for n, b, h in ((1280,1,1),(1536,1,1),(2048,1,1),(4096,1,1),
                    (1024,2,1),(512,1,4),(512,2,2),(8192,1,1)):
        for causal in (False, True):
            add("d128_load", n, b, h, 128, causal)
    for filename, value in (("confirmation_cases.json", cases), ("confirmation_groups.json", groups)):
        with (HERE / filename).open("x") as file:
            json.dump(value, file, indent=2)
            file.write("\n")
    print({k: len(v) for k, v in groups.items()})


if __name__ == "__main__":
    main()
