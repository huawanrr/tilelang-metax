"""Combine host call savings with the observed nonpositive-scale mask repair."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
parent = HERE / "host_inline.py"
source = parent.read_text()
node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
    and n.name == "native_sparse_attention_online_emitter")
original = ast.get_source_segment(source, node)
old = """                    for i, j in T.Parallel(G, BS):
                        acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
"""
new = """                    if scale_log2 > 0:
                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))
                    else:
                        for i, j in T.Parallel(G, BS):
                            acc_s[i, j] = T.if_then_else(
                                i_s + j < seq_len and (not is_causal or i_s + j <= i_t),
                                T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0)), 0.0)
"""
assert original.count(old) == 1
replacement = original.replace(old, new)
source = source.replace(original, replacement, 1)
compile(source, "candidate_v12_submission.py", "exec")
base = (HERE / "baseline.py").read_text()
def functions(text):
    return {n.name:ast.dump(n, include_attributes=False) for n in ast.parse(text).body
            if isinstance(n, ast.FunctionDef)}
before, after = functions(base), functions(source)
changed = [k for k in before if before[k] != after[k]]
assert set(changed) == {"native_sparse_attention", "run_kernel", "native_sparse_attention_online_emitter"}
assert before.keys() == after.keys()
path = HERE / "candidate_v12_submission.py"
with path.open("x") as out:
    out.write(source)
with (HERE / "candidate_v12_manifest.json").open("x") as out:
    json.dump(dict(file=path.name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        parent=parent.name, parent_sha256=hashlib.sha256(parent.read_bytes()).hexdigest(),
        v11_sha256=hashlib.sha256(base.encode()).hexdigest(), changed_functions=changed,
        dispatch_unchanged=True, original_positive_scale_expression_preserved=True,
        reason="Masked -inf times a zero or negative scale may produce nonzero weights in the legacy online emitter; explicitly zero invalid tail/causal lanes after exponentiation."),
        out, indent=2)
    out.write("\n")
print(path.name, hashlib.sha256(path.read_bytes()).hexdigest())
