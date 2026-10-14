"""Probe bounded packed addresses and boundary-only masking in S1/BS32."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_single_packed_qo_v2_mathcast"


def bounded(body):
    body = body.replace("            start = block * BS", "            load_block = T.min(T.max(block, 0), NB - 1)\n            start = block * BS")
    assert body.count("K[b, block, h,") == 1 and body.count("V[b, block, h,") == 2
    return body.replace("K[b, block, h,", "K[b, load_block, h,").replace("V[b, block, h,", "V[b, load_block, h,")


def assumed(body):
    return body.replace("            if valid:\n", "            if valid:\n                T.assume(block >= 0 and block < NB)\n", 1)


def postmask(body, natural=False):
    begin = body.index("                for i, j in T.Parallel(G, BS):\n                    scores[i, j] = T.if_then_else(")
    end = body.index("                for ki in T.serial(D // 32):", begin)
    body = body[:begin] + "                T.clear(scores)\n" + body[end:]
    begin = body.index("                if scale_log2 > 0:")
    end = body.index("                if not late:", begin)
    exp = "T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))" if natural else "T.exp2(T.min(scores[i, j] * scale_log2, 15.0))"
    new = f"""                for i, j in T.Parallel(G, BS):
                    scores[i, j] = {exp}
                if is_causal and block == token // BS:
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] = T.if_then_else(j <= token % BS, scores[i, j], T.float32(0))
                elif not is_causal and start + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] = T.if_then_else(start + j < seq_len, scores[i, j], T.float32(0))
"""
    return body[:begin] + new + body[end:]


def main():
    source = (HERE / "baseline.py").read_text()
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
    body = ast.get_source_segment(source, node)
    variants = {"packed_bound": bounded(body), "packed_assume": assumed(body),
                "packed_postmask": postmask(body), "packed_postmask_exp": postmask(body, True)}
    records = []
    for name, new in variants.items():
        result = source.replace(body, new, 1)
        ast.parse(result)
        path = HERE / f"{name}.py"
        with path.open("x") as file:
            file.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE / "packed_probes_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records), indent=2) + "\n")
    print("Generated",len(records),"packed probes")


if __name__ == "__main__":
    main()
