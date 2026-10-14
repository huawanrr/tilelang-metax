"""Probe S2 neighbours around the proposed throughput boundary."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    shapes = [(1, n, 1, True) for n in (1280, 1504, 1520, 1536, 1552, 1792)]
    shapes += [(2, n, 1, True) for n in (640, 752, 768, 784, 896)]
    shapes += [(4, n, 1, True) for n in (320, 368, 384, 400)]
    shapes += [(8, n, 1, True) for n in (176, 192, 208)]
    shapes += [(16, n, 1, True) for n in (80, 96, 112)]
    shapes += [(24, 64, 1, True), (32, 64, 1, True)]
    shapes += [(1, 752, 2, True), (1, 768, 2, True), (1, 784, 2, True),
               (2, 384, 2, True), (1, 384, 4, True), (1, 192, 8, True)]
    shapes += [(1, 1536, 1, False), (2, 768, 1, False),
               (4, 384, 1, False), (16, 96, 1, False),
               (1, 768, 2, False), (1, 384, 4, False)]
    cases = {f's2_b{b}_t{n}_h{h}_c{int(causal)}':
             dict(B=b, SEQ_LEN=n, H=h, HQ=16*h, D=64, S=2,
                  block_size=16, is_causal=causal)
             for b, n, h, causal in shapes}
    destination = HERE / 's2_boundary_cases.json'
    destination.write_text(json.dumps(cases, indent=2) + '\n')
    print(len(cases), 'boundary shapes')


if __name__ == '__main__':
    main()
