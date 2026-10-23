"""Make packed vector loads explicit and test wave-local workspace removal.

The first screen exposed scalar V loads for NW=1 with a 3D Parallel loop.
The explicit inverse mapping is identical for all wave counts. Wave-local
reduction retains the baseline FP32 addition order (32 then 16) and guard.
"""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_multiwave import NAME, proof

HERE = Path(__file__).resolve().parent


def main():
    base = (HERE / "baseline.py").read_text()
    template = (HERE / "packed_multiwave_template.py").read_text()
    k_old = '''                for w, j, d in T.Parallel(NW, BS, D):
                    k[w, j, d] = PackedKV[b, block, h, 0, d // 32 * (BS // 16) + j // 16,
                                                 d % 32 // 8 * 16 + j % 16, d % 8]'''
    k_new = '''                for ct in T.unroll(D // 32 * (BS // 16)):
                    for ce in T.vectorized(8):
                        k[T.get_thread_binding() // 64,
                          ct % (BS // 16) * 16 + T.get_thread_binding() % 16,
                          ct // (BS // 16) * 32 + T.get_thread_binding() % 64 // 16 * 8 + ce] = PackedKV[
                          b, block, h, 0, ct, T.get_thread_binding() % 64, ce]'''
    v_old = '''                for w, j, d in T.Parallel(NW, BS, W):
                    v[w, j, d] = PackedKV[b, block, h, 1, j // 16 * (D // 32) + d // 32,
                                                 j % 16 // 4 * 16 + d % 16, d % 32 // 16 * 4 + j % 4]'''
    v_new = '''                for ct in T.unroll(BS // 16 * (W // 32)):
                    for ce in T.vectorized(8):
                        v[T.get_thread_binding() // 64,
                          ct // (W // 32) * 16 + T.get_thread_binding() % 64 // 16 * 4 + ce % 4,
                          ct % (W // 32) * 32 + ce // 4 * 16 + T.get_thread_binding() % 16] = PackedKV[
                          b, block, h, 1, ct, T.get_thread_binding() % 64, ce]'''
    assert template.count(k_old) == template.count(v_old) == 1
    template = template.replace(k_old, k_new).replace(v_old, v_new)
    reduce_old = '''                T.reduce_sum(scores, denom, dim=1, clear=True)
                for i in T.Parallel(MG):
                    inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)'''
    reduce_new = '''                wave_sum[0] = T.float32(0.0)
                for re in T.unroll(4):
                    for rc in T.unroll(BS // 16):
                        wave_sum[0] += scores[T.get_thread_binding() // 64 * G + T.get_thread_binding() % 16,
                                              rc * 16 + T.get_thread_binding() % 64 // 16 * 4 + re]
                wave_sum[0] = wave_sum[0] + T.shfl_xor(wave_sum[0], 32, 64, 18446744073709551615)
                wave_sum[0] = wave_sum[0] + T.shfl_xor(wave_sum[0], 16, 64, 18446744073709551615)
                wave_sum[0] = T.if_then_else(wave_sum[0] > 0, 1.0 / wave_sum[0], 0.0)'''
    records = []
    for waves, qvec, reduced in ((1, 4, False), (1, 8, False), (2, 8, True), (4, 8, True)):
        impl = template.replace("waves=2, q_vec=4,", f"waves={waves}, q_vec={qvec},")
        if reduced:
            assert impl.count(reduce_old) == 1
            impl = impl.replace("            denom = T.alloc_fragment([MG], T.float32)", "            wave_sum = T.alloc_local([1], T.float32)")
            impl = impl.replace("            inv = T.alloc_fragment([MG], T.float32)\n", "")
            impl = impl.replace(reduce_old, reduce_new).replace("scores[i, j] *= inv[i]", "scores[i, j] *= wave_sum[0]")
        parent = (HERE / f"packed_multiwave_w{waves}_q{qvec if waves != 1 else 4}.py").read_text()
        node = next(n for n in ast.parse(parent).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
        begin = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
        lines = parent.splitlines(keepends=True)
        lines[begin:node.end_lineno] = [impl + "\n"]
        result = "".join(lines)
        ast.parse(result)
        suffix = "_sum" if reduced else ""
        dest = HERE / f"packed_multiwave_v2_w{waves}_q{qvec}{suffix}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            parent_sha256=hashlib.sha256(parent.encode()).hexdigest(),
                            waves=waves, qvec=qvec, explicit_wave_sum=reduced, mapping_proof=proof(waves, qvec)))
    with (HERE / "packed_multiwave_v2_manifest.json").open("x") as out:
        json.dump(dict(baseline_sha256=hashlib.sha256(base.encode()).hexdigest(), variants=records,
                       explicit_loads="ct selects MMA fragment tile; ce is the contiguous packed element",
                       fp32_order_and_guards_preserved=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "vectorized multiwave probes")


if __name__ == "__main__":
    main()
