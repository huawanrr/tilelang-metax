"""Neighboring shapes for the existing large packed/coalesced public paths."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    cases = {}

    def add(kind, b, n, h=1, causal=True, alias=None):
        d, selected, bs = {"s8": (64, 8, 16), "s1p": (128, 1, 32),
                           "d64": (64, 1, 16), "d128": (128, 1, 16)}[kind]
        name = alias or f"{kind}_b{b}_t{n}_h{h}_c{int(causal)}"
        assert name not in cases
        cases[name] = dict(B=b, SEQ_LEN=n, H=h, HQ=h*16, D=d, S=selected,
                           block_size=bs, is_causal=causal)

    for b, n, h in ((64, 64, 1), (32, 128, 1), (16, 256, 1), (8, 512, 1),
                    (2, 2048, 1), (1, 4096, 1), (1, 1024, 4), (2, 1024, 2),
                    (8, 1024, 1), (1, 1024, 8), (2, 4096, 1),
                    (4, 1025, 1), (8, 1023, 1)):
        add("s8", b, n, h)
    add("s8", 4, 1024, alias="oj12")
    add("s8", 4, 1024, causal=False)
    add("s8", 1, 1024, 4, causal=False)
    for b, n, h in ((1, 1024, 1), (2, 512, 1), (4, 256, 1), (1, 1025, 1),
                    (4, 512, 1), (1, 4096, 1), (4, 1024, 1),
                    (1, 1024, 2), (1, 1024, 4)):
        add("s1p", b, n, h)
    add("s1p", 8, 1024, alias="oj6")
    add("s1p", 4, 1024, causal=False)
    for b, n, h in ((1, 2304, 1), (2, 1536, 1), (1, 4096, 1), (1, 1024, 4)):
        add("d64", b, n, h)
    add("d64", 1, 8192, alias="oj9")
    add("d64", 1, 8192, causal=False)
    for b, n, h in ((1, 1280, 1), (1, 2048, 1), (4, 1024, 1), (1, 1024, 2)):
        add("d128", b, n, h)
    add("d128", 1, 2048, causal=False)
    destination = HERE / "family_cases.json"
    with destination.open("x") as f:
        f.write(json.dumps(cases, indent=2) + "\n")
    print("Saved", len(cases), "family cases")


if __name__ == "__main__":
    main()
