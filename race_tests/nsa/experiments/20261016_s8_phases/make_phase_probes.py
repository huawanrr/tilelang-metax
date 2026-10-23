"""Separate streamed S8 QK and PV phases with per-thread FP16 weight storage.

Each phase still streams a bounded number of packed tiles. The weight cache
contains the exact FP16 casts already used by the parent, and both the FP32
denominator association and alternating output accumulators are retained.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / "20261016_goal895/release_v14/submission.py"
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def nodes(source):
    return ast.parse(source).body


def rename(node, mapping, step=None):
    class Replace(ast.NodeTransformer):
        def visit_Name(self, current):
            if current.id == "s" and step is not None:
                return ast.copy_location(ast.Constant(step), current)
            if current.id in mapping:
                return ast.copy_location(ast.Name(id=mapping[current.id], ctx=current.ctx), current)
            return current
    return Replace().visit(copy.deepcopy(node))


def transform(original, kdepth, vdepth):
    fn = copy.deepcopy(original)
    fn.decorator_list = []
    fn.body[:0] = nodes("assert selected_blocks == 8 and groups == 16 and dim == 64 and block_size == 16 and threads == 64")
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    algorithm = next(n for n in scope.body if isinstance(n, ast.If)
                     and ast.unparse(n.test) == "prefetch_depth == 1")
    single_loop = algorithm.body[0]
    guard = single_loop.body[1]
    kload, vload, mask, qk, exponent, denominator, cast, pv_loop = guard.body
    assert "K_reg[j, d] = K[" in ast.unparse(kload)
    assert "V_reg[j, d] = V[" in ast.unparse(vload)
    assert "qk.mma" in ast.unparse(qk) and "pv.mma" in ast.unparse(pv_loop)
    assert "sum_acc[i, j] += acc_s[i, j]" in ast.unparse(denominator)

    declarations = nodes("""
phase_weights = T.alloc_fragment([S, G, BS], T.float16)
T.annotate_layout({phase_weights: T.Fragment([S, G, BS],
    forward_thread_fn=lambda ps, pi, pj: pi + pj % 16 // 4 * 16,
    forward_index_fn=lambda ps, pi, pj: ps * (BS // 16) * 4 + pj // 16 * 4 + pj % 4)})
""")
    for slot in range(1, vdepth):
        declarations += nodes(f"""
phase_v{slot} = T.alloc_fragment([BS, BV], T.float16)
T.annotate_layout({{phase_v{slot}: pv.make_mma_load_layout(phase_v{slot}, 'B')}})
""")
    scope.body[:0] = declarations

    def guarded(body, position, step):
        condition = rename(guard.test, {"i_s": position}, step)
        return ast.If(test=condition, body=body, orelse=[])

    replacement = []
    schedule = []
    for group_start in range(0, 8, kdepth):
        for slot in range(kdepth):
            step = group_start + slot
            position = f"phase_k_position{step}"
            key = "K_reg" if slot == 0 else f"K_reg{slot}"
            mapping = {"i_s": position, "K_reg": key}
            replacement += nodes(f"{position} = indices[{step}]")
            replacement.append(guarded([rename(kload, mapping, step)], position, step))
        for slot in range(kdepth):
            step = group_start + slot
            position = f"phase_k_position{step}"
            key = "K_reg" if slot == 0 else f"K_reg{slot}"
            mapping = {"i_s": position, "K_reg": key}
            body = [rename(n, mapping, step) for n in (mask, qk, exponent, denominator)]
            body += nodes(f"""
for phase_chunk in T.unroll(BS // 16):
    for phase_lane in T.unroll(4):
        phase_weights[{step}, T.get_thread_binding() % 16,
                      phase_chunk * 16 + T.get_thread_binding() // 16 * 4 + phase_lane] = acc_s[
            T.get_thread_binding() % 16,
            phase_chunk * 16 + T.get_thread_binding() // 16 * 4 + phase_lane]
""")
            replacement.append(guarded(body, position, step))
            schedule.append(dict(phase="qk", step=step, tile_slot=slot))

    # Delay output initialization until Q and the packed K fragments are dead.
    initializers = [n for n in scope.body if n is not algorithm and "T.fill(acc_o" in ast.unparse(n)]
    assert len(initializers) in (2, 4)
    scope.body = [n for n in scope.body if n not in initializers]
    replacement += initializers

    for group_start in range(0, 8, vdepth):
        for slot in range(vdepth):
            step = group_start + slot
            position = f"phase_v_position{step}"
            value = "V_reg" if slot == 0 else f"phase_v{slot}"
            mapping = {"i_s": position, "V_reg": value}
            replacement += nodes(f"{position} = indices[{step}]")
            replacement.append(guarded([rename(vload, mapping, step)], position, step))
        for slot in range(vdepth):
            step = group_start + slot
            position = f"phase_v_position{step}"
            value = "V_reg" if slot == 0 else f"phase_v{slot}"
            mapping = {"i_s": position, "V_reg": value}
            body = nodes(f"""
for phase_chunk in T.unroll(BS // 16):
    for phase_lane in T.unroll(4):
        acc_s_cast[T.get_thread_binding() % 16,
                   phase_chunk * 16 + T.get_thread_binding() // 16 * 4 + phase_lane] = phase_weights[
            {step}, T.get_thread_binding() % 16,
            phase_chunk * 16 + T.get_thread_binding() // 16 * 4 + phase_lane]
""")
            body.append(rename(pv_loop, mapping, step))
            replacement.append(guarded(body, position, step))
            schedule.append(dict(phase="pv", step=step, tile_slot=slot))
    at = scope.body.index(algorithm)
    scope.body[at:at + 1] = replacement
    assert [x["step"] for x in schedule if x["phase"] == "qk"] == list(range(8))
    assert [x["step"] for x in schedule if x["phase"] == "pv"] == list(range(8))
    return ast.unparse(ast.fix_missing_locations(fn)), schedule


def main():
    source = PARENT.read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == "d3c4e9f7417069efc0a0189d5754d4f8e765034c848c2219d32e869dd3b22080"
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    for label in ("baseline.py", "control.py"):
        with (HERE / label).open("x") as out:
            out.write(source)
    records = []
    for kdepth, vdepth in ((4, 1), (4, 2), (2, 2)):
        result = source
        schedules = {}
        for name in sorted(NAMES):
            revised, schedules[name] = transform(functions[name], kdepth, vdepth)
            original = ast.get_source_segment(source, functions[name])
            assert result.count(original) == 1
            result = result.replace(original, revised, 1)
        new = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert {name for name in functions if ast.dump(functions[name]) != ast.dump(new[name])} == NAMES
        path = HERE / f"phase_k{kdepth}_v{vdepth}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(file=path.name, key_depth=kdepth, value_depth=vdepth,
                            sha256=hashlib.sha256(result.encode()).hexdigest(), schedules=schedules))
    cases = json.loads((HERE.parent / "20261016_after_v14/cases.json").read_text())
    base = cases["oj12"]
    cases.update({
        "s8_b1_t4096": dict(base, B=1, SEQ_LEN=4096),
        "s8_b8_t1024": dict(base, B=8),
        "s8_b1_t8192": dict(base, B=1, SEQ_LEN=8192),
        "s8_b2_h2_t1024": dict(base, B=2, H=2, HQ=32),
        "s8_b4_t1025": dict(base, SEQ_LEN=1025),
        "s8_b4_t1024_c0": dict(base, is_causal=False),
    })
    with (HERE / "cases.json").open("x") as out:
        json.dump(cases, out, indent=2)
        out.write("\n")
    with (HERE / "phase_manifest.json").open("x") as out:
        json.dump(dict(status="unvalidated probes", parent=str(PARENT),
                       parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       changed_functions=sorted(NAMES), variants=records,
                       unchanged="Host, dispatch, per-call packing, masks, FP32 sum association, FP16 weight cast, output accumulator association, output fences."), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "S8 phase probes")


if __name__ == "__main__":
    main()
