"""Stream packed reduction tiles through small local MMA operand buffers."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE / "pack_v_shared4_latev.py").read_text()
NAME = "native_sparse_attention_single_packed_qo"
node = next(n for n in ast.parse(BASE).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
lines = BASE.splitlines(keepends=True)
start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
original = "".join(lines[start:node.end_lineno])


def once(s, a, b):
    assert s.count(a) == 1, (a[:100], s.count(a))
    return s.replace(a, b)


for stream_k, stream_v in ((True, False), (False, True), (True, True)):
    fn = once(original, "            b, h = bh // H, bh % H", "            tid = T.get_thread_binding()\n            b, h = bh // H, bh % H")
    if stream_k:
        fn = once(fn, "            k = T.alloc_fragment([BS, D], T.float16)",
                  "            k = T.alloc_local([BS // 16 * 8], T.float16)")
        fn = once(fn, "                k: qk.make_mma_load_layout(k, 'B'),\n", "")
        old = """                for j, d in T.Parallel(BS, D):
                    k[j, d] = K[b, block, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8]"""
        load = """                for kj in T.unroll(BS // 16):
                    for e in T.vectorized(8):
                        k[kj * 8 + e] = K[b, block, h, 0, kj, tid, e]"""
        fn = once(fn, old, load)
        old = """                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)"""
        new = """                for ki in T.unroll(D // 32):
                    if ki > 0:
                        for kj in T.unroll(BS // 16):
                            for e in T.vectorized(8):
                                k[kj * 8 + e] = K[b, block, h, ki, kj, tid, e]
                    qk.mma(q, k, scores, ki)"""
        fn = once(fn, old, new)
    if stream_v:
        fn = once(fn, "            v = T.alloc_fragment([BS, W], T.float16)",
                  "            v = T.alloc_local([W // 4], T.float16)")
        fn = once(fn, "                v: pv.make_mma_load_layout(v, 'B'),\n", "")
        old = """                for j, d in T.Parallel(BS, W):
                    v[j, d] = V[b, block, h, j // 16, d // 32,
                        (j % 16 // 4) * 16 + d % 16,
                        (d % 32 // 16) * 4 + j % 4]"""
        new = """                for vd in T.unroll(W // 32):
                    for e in T.vectorized(8):
                        v[vd * 8 + e] = V[b, block, h, 0, vd, tid, e]"""
        fn = once(fn, old, new)
        old = """                        for j, d in T.Parallel(BS, W):
                            v[j, d] = V[b, block, h, j // 16, vo * (W // 32) + d // 32,
                                (j % 16 // 4) * 16 + d % 16,
                                (d % 32 // 16) * 4 + j % 4]"""
        new = """                        for vd in T.unroll(W // 32):
                            for e in T.vectorized(8):
                                v[vd * 8 + e] = V[b, block, h, 0, vo * (W // 32) + vd, tid, e]"""
        fn = once(fn, old, new)
        old = """                    for ki in T.serial(BS // 16):
                        pv.mma(prob, v, out, ki)"""
        new = """                    for ki in T.unroll(BS // 16):
                        if ki > 0:
                            for vd in T.unroll(W // 32):
                                for e in T.vectorized(8):
                                    v[vd * 8 + e] = V[b, block, h, ki, vo * (W // 32) + vd, tid, e]
                        pv.mma(prob, v, out, ki)"""
        fn = once(fn, old, new)
    for bounds in (False, True):
        part = fn.replace("if valid:", "if block >= 0 and block < NB and (not is_causal or block * BS <= token):") if bounds else fn
        source = "".join(lines[:start]) + part + "".join(lines[node.end_lineno:])
        source = once(source, "packed_qo = qo_defaults and D == 128 and block_size == 32 and grid >= 1024 and True",
                      "packed_qo = qo_defaults and ((D == 128 and block_size == 32) or (D in (64, 128) and block_size == 16)) and grid >= 1024")
        ast.parse(source)
        path = HERE / f"stream_k{int(stream_k)}v{int(stream_v)}_b{int(bounds)}.py"
        if path.exists():
            raise FileExistsError(path)
        path.write_text(source)
        print(path.name)
