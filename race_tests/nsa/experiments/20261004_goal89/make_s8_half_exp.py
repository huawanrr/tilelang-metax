"""Research native half exponentials in the existing unnormalized S8 path."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once
from make_v_only_packed import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/submission.py"


def main():
    original = BASE.read_text()
    source = original
    changes = []
    for name in ("native_sparse_attention_online_packed",
                 "native_sparse_attention_online_packed_batch_minor_o_v2",
                 "native_sparse_attention_online_packed_quad_batch_minor_o_v2"):
        old = extract(original, name)
        expression = "T.exp2(\n                                T.min(acc_s[i, j] * scale_log2, 15.0))"
        count = old.count(expression)
        assert count > 0, name
        fn = old.replace(expression,
            "T.exp2(T.cast(T.min(acc_s[i, j] * scale_log2, 15.0), T.float16))")
        source = replace_once(source, old, fn)
        changes.append(dict(function=name, replacements=count))
    ast.parse(source)
    path = HERE / "s8_half_exp.py"
    with path.open("x") as f:
        f.write(source)
    (HERE / "s8_half_exp_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), variant=path.name,
        sha256=hashlib.sha256(path.read_bytes()).hexdigest(), changes=changes,
        precision="Log2 exponents and exp2 results round to FP16; denominator and numerator accumulation remain FP32.",
        status="Research only. Must pass independent-reference correctness and performance before any adoption.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
