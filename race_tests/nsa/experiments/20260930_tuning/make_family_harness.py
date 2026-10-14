"""Extend the established A/B and bracketed harnesses with nearby shapes."""
import json

from make_pair import HERE, ROOT, replace_once


cases = {}
for s in (2, 4):
    for t in (63, 64, 65, 127, 128, 129, 192, 256, 383, 384, 385, 512, 768, 1024, 1280, 1536, 1792,
              2048, 2560, 3072, 4096, 6144, 8192):
        cases[f's{s}_t{t}'] = dict(B=1, SEQ_LEN=t, H=1, HQ=16, D=64,
                                    S=s, block_size=16, is_causal=True)
    for b, t, h in ((2,128,1),(4,64,1),(1,128,2),(2,256,1),(4,256,1),
                    (1,512,2),(4,512,1),(2,512,2),(8,512,1),(2,1024,2)):
        cases[f's{s}_b{b}_t{t}_h{h}'] = dict(B=b, SEQ_LEN=t, H=h, HQ=h*16,
            D=64, S=s, block_size=16, is_causal=True)
for d, bs in ((64,16),(128,16),(128,32),(64,32),(64,64)):
    for t in (64,127,128,129,256,257,384,512,768,1024,1280,1536,1537,
              1792,2047,2048,2049,2304,2559,2560,2561,3072,4095,4096,4097,8192):
        cases[f'd{d}_bs{bs}_t{t}'] = dict(B=1, SEQ_LEN=t, H=1, HQ=16,
            D=d, S=1, block_size=bs, is_causal=True)
    for b,t,h in ((2,128,1),(2,256,1),(4,128,1),(4,256,1),(2,512,1),(1,512,2),(2,512,2),
                   (4,512,1),(8,256,1),(8,512,1),(2,1024,1),(2,1024,2),(8,1024,1)):
        cases[f'd{d}_bs{bs}_b{b}_t{t}_h{h}'] = dict(B=b, SEQ_LEN=t, H=h, HQ=h*16,
            D=d, S=1, block_size=bs, is_causal=True)
(HERE / 'family_cases.json').write_text(json.dumps(cases, indent=2)+'\n')

for src, dest, anchor in (
    ('experiments/20260927_next/compare_same_output.py', 'compare_family.py',
     '    selected = [str(i) for i in parse_cases'),
    ('experiments/20260928_output_split/compare_bracketed.py', 'bracketed_family.py',
     '    modules = [load_module(path)'),
):
    source = (ROOT / src).read_text()
    source = replace_once(source, anchor,
        '    named.update(json.loads(Path(__file__).with_name("family_cases.json").read_text()))\n' + anchor)
    (HERE / dest).write_text(source)
    print(dest)
