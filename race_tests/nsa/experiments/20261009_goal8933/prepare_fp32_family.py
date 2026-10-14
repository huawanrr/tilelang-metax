"""Cover the existing D128 linear and D64/D128 coalesced dispatch families."""
import json
from pathlib import Path
from make_fp32_wave_sum import main

HERE = Path(__file__).resolve().parent

if __name__ == "__main__":
    main("fp32_core", {"native_sparse_attention_linear_v_blocks_oct8",
                       "_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8"})
    cases = {}

    def add(d, b, n, h, causal):
        name = f"d{d}_b{b}_t{n}_h{h}_c{int(causal)}"
        cases[name] = dict(B=b, SEQ_LEN=n, H=h, HQ=16*h, D=d, S=1,
                           block_size=16, is_causal=causal)

    for b, n, h in ((1, 128, 1), (1, 144, 1), (1, 160, 1), (1, 192, 1),
                    (1, 256, 1), (1, 384, 1), (1, 512, 1), (1, 640, 1),
                    (1, 752, 1), (1, 768, 1), (2, 80, 1), (2, 128, 1),
                    (2, 192, 1), (2, 256, 1), (2, 384, 1), (4, 48, 1),
                    (4, 64, 1), (4, 96, 1), (4, 128, 1), (8, 32, 1),
                    (16, 16, 1), (1, 128, 2), (1, 256, 2), (2, 256, 2)):
        for causal in (True, False):
            add(128, b, n, h, causal)
    for b, n, h in ((1, 128, 1), (1, 256, 1), (1, 512, 1), (1, 768, 1),
                    (1, 1024, 1), (1, 2048, 1), (1, 2304, 1), (1, 4096, 1),
                    (1, 8192, 1), (2, 256, 1), (2, 512, 1), (2, 1024, 1),
                    (4, 128, 1), (4, 256, 1), (4, 512, 1), (4, 1024, 1),
                    (8, 128, 1), (8, 256, 1), (16, 128, 1),
                    (1, 128, 2), (1, 256, 2), (1, 512, 2), (2, 512, 2),
                    (1, 128, 4), (1, 256, 4), (1, 384, 4), (1, 512, 4),
                    (1, 128, 8), (1, 256, 8), (1, 512, 8), (1, 1024, 4)):
        for causal in (True, False):
            add(64, b, n, h, causal)
    for b, n, h in ((1, 1024, 1), (1, 1280, 1), (1, 2048, 1), (2, 1024, 1),
                    (1, 512, 4), (4, 1024, 1)):
        for causal in (True, False):
            add(128, b, n, h, causal)
    with (HERE / "fp32_family_cases.json").open("x") as output:
        json.dump(cases, output, indent=2)
        output.write("\n")
    print("Family configurations:", len(cases))
