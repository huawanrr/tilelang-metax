"""Keep only the confirmed ordinary-rsqrt change in the existing tiny D32 builder."""
import ast
import hashlib
import json
from pathlib import Path

from prepare import EXPECTED, HELPERS

HERE = Path(__file__).resolve().parent
TARGET = "native_sparse_attention_q_preload_vfirst"
HELPER = "_d32_rsqrt_reciprocal"


def functions(source):
    return {fn.name: fn for fn in ast.parse(source).body if isinstance(fn, ast.FunctionDef)}


def main():
    parent = (HERE / "baseline.py").read_text()
    probe = (HERE / "rsqrt.py").read_text()
    assert hashlib.sha256(parent.encode()).hexdigest() == EXPECTED
    before, trial = functions(parent), functions(probe)
    target = ast.get_source_segment(probe, trial[TARGET]).replace("_rsqrt_denominator_probe", HELPER)
    result = parent.replace(ast.get_source_segment(parent, before[TARGET]), target, 1)
    helper = HELPERS["rsqrt"].replace("_rsqrt_denominator_probe", HELPER)
    at = result.index("def _small_newton2(")
    result = result[:at] + helper + result[at:]
    after = functions(result)
    assert set(after) - set(before) == {HELPER}
    changed = [name for name in before if ast.dump(before[name]) != ast.dump(after[name])]
    assert changed == [TARGET]
    assert [ast.dump(node) for node in ast.parse(parent).body if not isinstance(node, ast.FunctionDef)] == [
        ast.dump(node) for node in ast.parse(result).body if not isinstance(node, ast.FunctionDef)]
    assert ast.dump(before[TARGET].args) == ast.dump(after[TARGET].args)
    assert [ast.dump(node) for node in before[TARGET].decorator_list] == [ast.dump(node) for node in after[TARGET].decorator_list]
    compile(result, "candidate", "exec")
    output = HERE / "candidate.py"
    with output.open("x") as out:
        out.write(result)
    report = dict(parent_sha256=EXPECTED, candidate_sha256=hashlib.sha256(result.encode()).hexdigest(),
                  probe_sha256=hashlib.sha256(probe.encode()).hexdigest(),
                  changed_functions=changed, new_helper=HELPER, unchanged_original_functions=len(before)-1,
                  module_statements_equal=True, dispatch_and_public_functions_equal=True,
                  selection="Existing tiny_vfirst branch only: default S1/G16/D32/BS16, causal, complete blocks, seq_len>=64 and B*H*seq_len<=64.",
                  rationale="Ordinary rsqrt is positive in all 16 D32 address/window rows and both cold seeds. BS32/S8/multihead changes and the direct RSQ variant are rejected.",
                  status="candidate awaiting final validation")
    with (HERE / "candidate_manifest.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print(output, report["candidate_sha256"], changed)


if __name__ == "__main__":
    main()
