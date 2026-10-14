"""Generate register transposes from explicit bijections of tile address bits.

All exchange operations are ordinary synchronous 64-lane TileLang shuffles.
The generator is a local experiment tool and is not part of a submission.
"""
import argparse
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = (ROOT / "experiments/20260927_next/selected.py").read_text()
assert hashlib.sha256(BASE.encode()).hexdigest() == "311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26"
NODE = next(n for n in ast.parse(BASE).body if isinstance(n, ast.FunctionDef)
            and n.name == "native_sparse_attention_single_block_emitter")
LINES = BASE.splitlines(keepends=True)
ORIGINAL = "".join(LINES[NODE.decorator_list[0].lineno - 1:NODE.end_lineno])


def bit_expr(var, axes):
    return " + ".join(f"(({var} // {1 << bit}) % 2) * {1 << axis}"
                      for bit, axis in enumerate(axes)) or "0"


def exchange(prefix, d, bs, vec, value):
    db, rb = d.bit_length() - 1, bs.bit_length() - 1
    total_bits, local_bits = db + rb, db + rb - 6
    word_bits = local_bits - 1
    count = 1 << word_bits
    if value in {"K", "Q"}:
        local_axes = [0, 1, 2] + list(range(9, total_bits))
        lane_axes = list(range(3, 9))
        target_local = [0, 1, 2] + list(range(db + 4, total_bits)) + list(range(5, db))
        target_lanes = list(range(db, db + 4)) + [3, 4]
    else:
        vector_bits = vec.bit_length() - 1
        lane_axes = list(range(vector_bits, vector_bits + 4)) + [db + 2, db + 3]
        local_axes = [x for x in range(total_bits) if x not in lane_axes]
        target_local = [db, db + 1] + list(range(4, db)) + list(range(db + 4, total_bits))
        target_lanes = list(range(4)) + [db + 2, db + 3]
    assert len(local_axes) == len(target_local) == local_bits
    assert sorted(local_axes + lane_axes) == sorted(target_local + target_lanes) == list(range(total_bits))
    axes = local_axes + lane_axes
    allocations = [f"{prefix}_raw = T.alloc_local([{count * 2}], T.float16)",
                   f"{prefix}_w0 = T.Tensor([{count}], T.uint32, data={prefix}_raw.data, scope=\"local\")"]
    loads = [f"for slot in T.unroll({count * 2 // vec}):",
             f"    for e in T.vectorized({vec}):",
             f"        linear = {bit_expr(f'(slot * {vec} + e)', local_axes)} + {bit_expr('tid', lane_axes)}",
             f"        {prefix}_raw[slot * {vec} + e] = T.if_then_else(i_s + linear // {d} < seq_len,",
             f"            {value}[i_b, i_s + linear // {d}, i_h, linear % {d}], T.float16(0))"]
    if value == "Q":
        loads = loads[:3] + [f"        {prefix}_raw[slot * {vec} + e] = Q[i_b, i_t, i_h * G + linear // {d}, linear % {d}]"]
    statements = []
    current, stage = f"{prefix}_w0", 0

    def next_buffer():
        nonlocal stage
        stage += 1
        name = f"{prefix}_w{stage}"
        allocations.append(f"{name} = T.alloc_local([{count}], T.uint32)")
        return name

    # Swap the within-word half bit with a local register bit. The V load
    # arrangement deliberately keeps its target half bit in local storage.
    if axes[0] != target_local[0]:
        pos = axes.index(target_local[0])
        assert 1 <= pos < local_bits
        delta = 1 << (pos - 1)
        output = next_buffer()
        for a in range(count):
            if a & delta:
                continue
            b = a | delta
            statements.extend([
                f"{output}[{a}] = ({current}[{a}] & T.uint32(65535)) | ({current}[{b}] << T.uint32(16))",
                f"{output}[{b}] = ({current}[{a}] >> T.uint32(16)) | ({current}[{b}] & T.uint32(4294901760))",
            ])
        current = output
        axes[0], axes[pos] = axes[pos], axes[0]

    desired_registers = set(target_local[1:])
    for pos in range(1, local_bits):
        if axes[pos] in desired_registers:
            continue
        missing = next(axis for axis in target_local[1:] if axis not in axes[1:local_bits])
        lane_pos = axes.index(missing)
        assert lane_pos >= local_bits
        register_delta = 1 << (pos - 1)
        lane_delta = 1 << (lane_pos - local_bits)
        output = next_buffer()
        for a in range(count):
            if a & register_delta:
                continue
            b = a | register_delta
            name = f"{prefix}_cross_{stage}_{a}"
            statements.extend([
                f"{name} = T.shfl_xor(T.if_then_else(tid & {lane_delta} == 0, {current}[{b}], {current}[{a}]), {lane_delta}, 64, 0xffffffffffffffff)",
                f"{output}[{a}] = T.if_then_else(tid & {lane_delta} == 0, {current}[{a}], {name})",
                f"{output}[{b}] = T.if_then_else(tid & {lane_delta} == 0, {name}, {current}[{b}])",
            ])
        current = output
        axes[pos], axes[lane_pos] = axes[lane_pos], axes[pos]

    assert set(axes[1:local_bits]) == desired_registers
    output = next_buffer()
    src_lane = " + ".join(f"((tid // {1 << target_lanes.index(axis)}) % 2) * {1 << bit}"
                          for bit, axis in enumerate(axes[local_bits:]))
    for dest in range(count):
        src = sum(((dest >> (target_local.index(axis) - 1)) & 1) << bit
                  for bit, axis in enumerate(axes[1:local_bits]))
        statements.append(f"{output}[{dest}] = T.shfl_sync({current}[{src}], {src_lane}, 64, 0xffffffffffffffff)")
    allocations.append(f"{prefix}_mma = T.Tensor([{count * 2}], T.float16, data={output}.data, scope=\"local\")")
    return allocations, loads, statements


def indent(lines, n=16):
    return "\n".join(" " * n + line for line in lines)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--dim", type=int, default=128)
    parser.add_argument("--block-size", type=int, default=32)
    parser.add_argument("--prefix", default="")
    args = parser.parse_args()
    for name, k_shuffle, v_vec in (
        ("shuffle_k", True, 0), ("shuffle_v2", False, 2),
        ("shuffle_v4", False, 4), ("shuffle_v8", False, 8),
        ("shuffle_kv2", True, 2),
    ):
        if v_vec and v_vec * 16 > args.dim:
            continue
        part = ORIGINAL.replace("def native_sparse_attention_single_block_emitter(",
                                "def single_block_shuffle(", 1)
        allocations = ["tid = T.get_thread_binding()"]
        if k_shuffle:
            alloc, loads, body = exchange("ks", args.dim, args.block_size, 8, "K")
            allocations += alloc
            part = part.replace("                T.copy(K[i_b, i_s : i_s + BS, i_h, :], K_reg)", indent(loads))
            part = part.replace("                if not direct_k:\n                    T.copy(K_reg, KV_shared)", indent(body))
            part = part.replace("""                for ki in T.serial(qk_steps):
                        if direct_k:
                            qk.mma(Q_reg, K_reg, acc_s, ki)
                        else:
                            qk.ldmatrix_b(kb, KV_shared, ki)
                            qk.mma(Q_reg, kb, acc_s, ki)""", """                for ki in T.unroll(qk_steps):
                        for e in T.vectorized(BS // 16 * 8):
                            kb[e] = ks_mma[ki * (BS // 16 * 8) + e]
                        qk.mma(Q_reg, kb, acc_s, ki)""")
        if v_vec:
            alloc, loads, body = exchange("vs", args.dim, args.block_size, v_vec, "V")
            allocations += alloc
            part = part.replace("""                T.copy(V[i_b, i_s : i_s + BS, i_h,
                             i_v * BV : (i_v + 1) * BV], V_reg)""", indent(loads))
            part = part.replace("""                if not kv_split:
                        T.copy(V_reg, KV_shared)""", indent(body))
            part = part.replace("""                for ki in T.serial(pv_steps):
                        pv.ldmatrix_b(vb, V_shared, ki)
                        pv.mma(acc_s_cast, vb, acc_o, ki)""", """                for ki in T.unroll(pv_steps):
                        for e in T.vectorized(BV // 16 * 4):
                            vb[e] = vs_mma[ki * (BV // 16 * 4) + e]
                        pv.mma(acc_s_cast, vb, acc_o, ki)""")
        part = part.replace("            Q_reg = T.alloc_fragment([G, BK], T.float16)",
                            indent(allocations, 12) + "\n            Q_reg = T.alloc_fragment([G, BK], T.float16)", 1)
        result = BASE.replace("\n\n_KERNEL_CACHE = {}", "\n\n" + part + "\n\n_KERNEL_CACHE = {}", 1)
        start = result.index("def _get_kernel(")
        host = result[start:].replace("        if S == 1 and use_emitter:\n", f"""        if S == 1 and groups == 16 and threads == 64 and not kv_frag and D == {args.dim} and block_size == {args.block_size} and not kv_split:
                kernel = single_block_shuffle(
                    late_normalize=late_normalize, kv_split=False,
                    direct_k=False, lane_reduce=True, **common)
            elif S == 1 and use_emitter:
    """, 1)
        result = result[:start] + host
        ast.parse(result)
        (HERE / f"{args.prefix}{name}.py").write_text(result)
        print(args.prefix + name)


if __name__ == "__main__":
    main()
