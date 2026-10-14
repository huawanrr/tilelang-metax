"""Neighbouring S2 launch shapes for a general dispatch boundary."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    shapes = [(1, t, 1) for t in (128, 256, 384, 512, 768, 1024, 1536, 2048, 2560, 3072, 4096, 8192)]
    shapes += [(2, t, 1) for t in (128, 256, 384, 512, 768, 1024, 1536, 2048)]
    shapes += [(4, t, 1) for t in (64, 128, 256, 384, 512, 768, 1024)]
    shapes += [(8, t, 1) for t in (64, 128, 256, 512, 1024)]
    shapes += [(16, 64, 1), (16, 128, 1), (16, 256, 1), (32, 128, 1)]
    shapes += [(1, 256, 2), (1, 512, 2), (1, 1024, 2), (2, 512, 2), (2, 1024, 2),
               (1, 256, 4), (1, 1024, 4)]
    cases = {}
    for b, t, h in shapes:
        cases[f's2_b{b}_t{t}_h{h}_c1'] = dict(B=b, SEQ_LEN=t, H=h, HQ=16*h,
            D=64, S=2, block_size=16, is_causal=True)
    for b, t, h in ((1, 256, 1), (2, 512, 1), (4, 1024, 1), (1, 1024, 2)):
        cases[f's2_b{b}_t{t}_h{h}_c0'] = dict(B=b, SEQ_LEN=t, H=h, HQ=16*h,
            D=64, S=2, block_size=16, is_causal=False)
    (HERE / 's2_family_cases.json').write_text(json.dumps(cases, indent=2) + '\n')
    print(len(cases), 'shapes')


if __name__ == '__main__':
    main()
