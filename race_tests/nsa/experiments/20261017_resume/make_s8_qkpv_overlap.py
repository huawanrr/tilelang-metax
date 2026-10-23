"""Overlap the next sparse QK with the current PV within valid four-block groups.

Earlier probes interleaved QK chains or separated all QK/PV phases. Here two
score fragments form a short pipeline: exp/cast for block n, QK for n+1 and
PV for n. Original per-block guards handle every partial/invalid group.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def nodes(text):
    return ast.parse(text).body


def rename(node, mapping):
    class Rewrite(ast.NodeTransformer):
        def visit_Name(self, n):
            if n.id in mapping:
                return ast.copy_location(ast.Name(id=mapping[n.id], ctx=n.ctx), n)
            return n
    return Rewrite().visit(copy.deepcopy(node))


def transform(original, native_interleave):
    fn = copy.deepcopy(original)
    fn.decorator_list = []
    fn.body[:0] = nodes("assert selected_blocks == 8 and groups == 16 and dim == 64 and block_size == 16 and threads == 64 and prefetch_depth == 4")
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body[:0] = nodes("""
overlap_score0 = T.alloc_fragment([G, BS], T.float32)
overlap_score1 = T.alloc_fragment([G, BS], T.float32)
T.annotate_layout({overlap_score0: qk.make_mma_store_layout(overlap_score0),
                   overlap_score1: qk.make_mma_store_layout(overlap_score1)})
""")
    outer = next(n for n in ast.walk(scope) if isinstance(n, ast.For)
                 and ast.unparse(n.target) == "group")
    guards = [n for n in outer.body if isinstance(n, ast.If) and len(n.body) > 1]
    assert len(guards) == 4
    for guard in guards:
        assert len(guard.body) == 7
        assert "qk.mma" in ast.unparse(guard.body[2])
        assert "pv.mma" in ast.unparse(guard.body[-1])

    def score(i):
        return f"overlap_score{i % 2}"

    def full_qk(i):
        return [rename(guards[i].body[2], {"acc_s": score(i)})]

    def pv_tile(i):
        # Keep the existing dual/quad output accumulator selection verbatim.
        selection = copy.deepcopy(guards[i].body[-1].body)
        class EmitTile(ast.NodeTransformer):
            def visit_Call(self, n):
                if ast.unparse(n.func) == "pv.mma":
                    assert len(n.args) == 4
                    prob, val, out, _ = [ast.unparse(a) for a in n.args]
                    return ast.parse(
                        f"T.tvm_mfma(pv.mma_suffix, 'row', 'row', 'float16x4', 'float16x4', 'float32x4', "
                        f"{val}.data, overlap_k, {prob}.data, 0, {out}.data, overlap_k, dtype='float32x4')",
                        mode="eval").body
                return self.generic_visit(n)
        return [EmitTile().visit(n) for n in selection]

    fast = nodes(f"T.clear({score(0)})") + full_qk(0)
    for i in range(4):
        body = guards[i].body
        # Current V can load while current exp and next QK execute.
        fast.append(copy.deepcopy(body[0]))
        exponent = body[3]
        assert ast.unparse(exponent.test) == "scale_log2 > 0"
        fast.extend(rename(n, {"acc_s": score(i)}) for n in exponent.body)
        fast.extend(rename(n, {"acc_s": score(i)}) for n in body[4:6])
        if i == 3:
            fast.append(copy.deepcopy(body[6]))
        else:
            fast += nodes(f"T.clear({score(i + 1)})")
            if native_interleave:
                key = "K_reg" if i + 1 == 0 else f"K_reg{i + 1}"
                loop = nodes("for overlap_k in T.unroll(BK // 16):\n    pass")[0]
                loop.body = nodes(
                    f"T.tvm_mfma(qk.mma_suffix, 'row', 'row', 'float16x4', 'float16x4', 'float32x4', "
                    f"{key}.data, overlap_k, Q_reg.data, overlap_k, {score(i + 1)}.data, 0, dtype='float32x4')")
                loop.body += pv_tile(i)
                fast.append(loop)
            else:
                fast += full_qk(i + 1)
                fast.append(copy.deepcopy(body[6]))
    condition = " and ".join(
        f"i_s{i} >= 0 and i_s{i} + BS <= seq_len and (not is_causal or i_s{i} + BS <= i_t + 1)"
        for i in range(4))
    fast_guard = ast.If(test=ast.parse(condition, mode="eval").body,
                        body=fast, orelse=copy.deepcopy(guards))
    start = outer.body.index(guards[0])
    assert outer.body[start:] == guards
    outer.body[start:] = [fast_guard]
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for interleave in (False, True):
        result = source
        for name in sorted(NAMES):
            fn = functions[name]
            result = result.replace(ast.get_source_segment(source, fn), transform(fn, interleave), 1)
        ast.parse(result)
        path = HERE / f"s8_qkpv_overlap_i{int(interleave)}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, native_interleave=interleave,
                            sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE / "s8_qkpv_overlap_manifest.json").write_text(json.dumps(dict(
        parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        changed_functions=sorted(NAMES),
        fallback="Original per-block algorithm for partial or invalid groups",
        preserved="FP32 MMA, per-dot K order, per-block exp/clip, denominator addition order, FP16 cast, alternating PV accumulators, output fences, packing and dispatch"), indent=2) + "\n")
    print("Generated", len(records), "short QK/PV pipeline probes")


if __name__ == "__main__":
    main()
