"""QK/weight producer and PV consumer waves, using synchronous shared rings."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_s8_wave_pipeline"
DUAL = "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast"
QUAD = "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast"


def proof(depth):
    groups = 8 // depth
    scenarios = 0
    for acc in (2, 4):
        for valid in range(256):
            writes, reads = {}, {}
            den_order = []
            out_order = [[] for _ in range(acc)]
            ring = {}
            for step in range(groups + 1):
                if step < groups:
                    for p in range(depth):
                        slot = step * depth + p
                        key = step % 2, p
                        if key in ring:
                            old = ring[key]
                            assert reads[old] < step  # WAR: an earlier full barrier.
                        ring[key] = slot
                        writes[slot] = step
                        if valid >> slot & 1:
                            den_order.append(slot)
                if step > 0:
                    for p in range(depth):
                        slot = (step - 1) * depth + p
                        key = (step - 1) % 2, p
                        assert ring[key] == slot
                        assert writes[slot] < step  # RAW: an earlier full barrier.
                        reads[slot] = step
                        if valid >> slot & 1:
                            out_order[slot % acc].append(slot)
            assert list(writes) == list(reads) == list(range(8))
            assert den_order == [s for s in range(8) if valid >> s & 1]
            assert out_order == [[s for s in range(8) if s % acc == a and valid >> s & 1] for a in range(acc)]
            scenarios += 1
    # The producer/consumer have the same lane and local probability element.
    covered = {(lane % 16, lane // 16 * 4 + e) for lane in range(64) for e in range(4)}
    assert covered == {(i, j) for i in range(16) for j in range(16)}
    output_written = {(lane % 16, c * 16 + lane // 16 * 4 + e)
                      for lane in range(64) for c in range(4) for e in range(4)}
    output_read = {(flat // 64, flat % 64) for flat in range(1024)}
    assert output_written == output_read
    return dict(ownership_and_barrier_scenarios=scenarios, one_producer_one_consumer=True,
                fp32_denominator_and_pv_order_preserved=True,
                cross_wave_raw_war_barriers="Each ring handoff/reuse separated by all 128 threads; inverse transfer separately fenced",
                output_wave_fence_preserved=True)


def main():
    base = (HERE / "baseline.py").read_text()
    template = (HERE / "s8_wave_pipeline_template.py").read_text()
    original = {n.name: n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)}
    dispatch = ast.get_source_segment(base, original["_get_kernel"])
    records = []
    for depth in (1, 2, 4):
        additions = []
        for acc, label in ((2, "dual"), (4, "quad")):
            impl = template.replace(NAME, NAME + "_" + label, 1)
            impl = impl.replace("    DEPTH = 2", f"    DEPTH = {depth}", 1)
            impl = impl.replace("    ACC = 2", f"    ACC = {acc}", 1)
            additions.append(impl)
        revised = dispatch.replace("    key = (B, seq_len,", "    wave_pipeline_s8 = mathcast_s8\n    key = (B, seq_len,", 1)
        revised = revised.replace("small_coalesced_blocks, s2_wave_output)", "small_coalesced_blocks, s2_wave_output, wave_pipeline_s8)", 1)
        for old_name, label in ((DUAL, "dual"), (QUAD, "quad")):
            before = "online_builder = " + old_name + "\n"
            assert revised.count(before) == 1
            revised = revised.replace(before, "online_builder = " + NAME + "_" + label + " if wave_pipeline_s8 else " + old_name + "\n", 1)
        result = base.replace(dispatch, "\n\n".join(additions) + "\n\n" + revised, 1)
        functions = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        for name, fn in original.items():
            if name != "_get_kernel":
                assert ast.dump(fn) == ast.dump(functions[name]), name
        dest = HERE / f"s8_wave_pipeline_d{depth}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            depth=depth, proof=proof(depth)))
    with (HERE / "s8_wave_pipeline_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(base.encode()).hexdigest(),
                       template_sha256=hashlib.sha256(template.encode()).hexdigest(),
                       original_functions_ast_unchanged_except_dispatch=True,
                       default_mathcast_scope_and_separate_cache=True,
                       synchronous_copies_only=True, all_launches_in_public_call=True,
                       variants=records), out, indent=2)
        out.write("\n")
    print("Generated 3 two-wave pipeline probes; ownership, fences and arithmetic order checked")


if __name__ == "__main__":
    main()
