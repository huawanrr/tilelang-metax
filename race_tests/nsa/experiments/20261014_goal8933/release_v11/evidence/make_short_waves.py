import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    source = (HERE / "baseline.py").read_text()
    template = (HERE / "short_waves_template.py").read_text()
    template = template[template.index("@tilelang.jit"):]
    records = []
    for stage_v, balanced in ((False, False), (False, True), (True, False), (True, True)):
        body = source
        marker = "        if preload_direct:\n"
        assert body.count(marker) == 1
        replace = f'''        if mathcast_defaults and groups == 16 and D == 64 and block_size == 16 and S in (2, 4) and seq_len >= 64 and seq_len % 16 == 0:
            kernel = native_sparse_attention_short_waves(selected_blocks=S, stage_v={stage_v}, balanced={balanced}, **common)
        elif preload_direct:
'''
        body = body.replace(marker, replace, 1)
        at = body.index("def _get_kernel(")
        body = body[:at] + template + "\n\n" + body[at:]
        ast.parse(body)
        path = HERE / f"short_waves_r2_v{int(stage_v)}_b{int(balanced)}.py"
        with path.open("x") as out:
            out.write(body)
        records.append(dict(path=path.name, sha256=hashlib.sha256(body.encode()).hexdigest(), stage_v=stage_v, balanced=balanced))
    (HERE / "short_waves_r2_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        scope="Default complete S2/S4 D64 BS16 G16 shapes; two waves, disjoint block subsets, FP32 merge"), indent=2) + "\n")
    print("Generated four short-list wave variants", flush=True)


if __name__ == "__main__":
    main()
