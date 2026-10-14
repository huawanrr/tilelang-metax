"""Revisit independent QK work under the measured lower-register exp path."""
import ast
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "exp_folded.py"
old_generator = HERE.parent / "20261007_resume/make_s8_schedule.py"
spec = importlib.util.spec_from_file_location("prior_schedule_generator", old_generator)
prior = importlib.util.module_from_spec(spec)
spec.loader.exec_module(prior)
BUILDERS = prior.BUILDERS


def main():
    source = BASE.read_text()
    records = []
    variants = (("guard", 0, "none", 4), ("clamp", 0, "none", 4),
                ("g2_qk", 2, "qk", 4), ("g2_prob", 2, "prob", 4),
                ("g4_qk", 4, "qk", 4), ("g2_qk_p2", 2, "qk", 2))
    for name, size, phase, depth in variants:
        result = source
        for builder in BUILDERS:
            node = next(n for n in ast.parse(result).body
                        if isinstance(n, ast.FunctionDef) and n.name == builder)
            old = prior.region(result, node, decorated=True)
            if size:
                fn = prior.schedule(old, size, phase, False)
            else:
                if name == "guard":
                    replacement = ("                raw_index = BlockIndices[i_b, i_t, i_h, si]\n"
                        "                indices[si] = T.if_then_else(raw_index >= 0 and raw_index < T.ceildiv(seq_len, BS),\n"
                        "                                            raw_index * BS, seq_len)")
                else:
                    replacement = ("                raw_index = BlockIndices[i_b, i_t, i_h, si]\n"
                        "                indices[si] = T.min(T.max(raw_index, -1), T.ceildiv(seq_len, BS)) * BS")
                fn = prior.replace_once(old,
                    "                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS", replacement)
            if depth != 4:
                fn = prior.replace_once(fn, "    head_kv = heads // groups\n",
                    f"    prefetch_depth = {depth}\n    head_kv = heads // groups\n")
            result = prior.replace_once(result, old, fn)
        ast.parse(result)
        path = HERE / f"s8_pipeline_{name}.py"
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path), group=size, phase=phase, depth=depth,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "pipeline_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), previous_generator=str(old_generator), variants=records,
        reason="Plain exp reduced oj12 mtregs from 103 to 94. Check if shorter QK dependencies now repay extra live scores.",
        scope="Research only, large-S8 builders, unchanged dispatch and public-call packing."), indent=2) + "\n")
    print("Generated", len(records), "pipeline/guard probes")


if __name__ == "__main__":
    main()
