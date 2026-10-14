"""Probe native uint32 storage, retaining the exact fp16 value bits and layout."""
import ast
import hashlib
import json
from pathlib import Path

from prepare import function, once, write_new

HERE = Path(__file__).resolve().parent
BASE = HERE / "mid_pairs.py"


def main():
    source = BASE.read_text()
    original = function(source, "native_sparse_attention_shared_q_blocks")
    records = []
    for width in (1, 2, 4):
        part = original
        for name, cols in (("K", "BK"), ("V", "BV")):
            prefix = name.lower()
            part = once(part,
                f"{name}_blocks = T.reshape({name}, [batch, seq_len // BS, BS, head_kv, dim])",
                f"{name}_blocks = T.view({name}, [batch, seq_len // BS, BS, head_kv, dim // 2], dtype=T.uint32)")
            part = once(part, f"            {name}_reg = T.alloc_fragment([BS, {cols}], T.float16)",
                f"            {name}_words = T.alloc_local([BS * {cols} // 128], T.uint32)\n"
                f"            {name}_reg = T.Tensor([BS * {cols} // 64], T.float16, data={name}_words.data, scope=\"local\")")
            part = once(part, f"""                {name}_reg: T.Fragment([BS, {cols}],
                    forward_thread_fn=lambda j, d: (j * {cols} + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * {cols} + d) // 512 * 8 + d % 8),
""", "")
            row = f"({prefix}_slot * 512 + tid * 8) // {cols}"
            old_col = f"tid % ({cols} // 8) * 8 + {prefix}_word * 2 + {prefix}_element"
            old = f"""                for {prefix}_slot in T.unroll(BS * {cols} // 512):
                    for {prefix}_word in T.unroll(4):
                        for {prefix}_element in T.vectorized(2):
                            {name}_reg[{row}, {old_col}] = {name}_blocks[i_b, _selected_block, {row}, i_h, {old_col}]
"""
            word = f"{prefix}_group * {width} + {prefix}_word"
            col = f"tid % ({cols} // 8) * 4 + {word}"
            new = f"""                for {prefix}_slot in T.unroll(BS * {cols} // 512):
                    for {prefix}_group in T.unroll({4 // width}):
                        for {prefix}_word in T.vectorized({width}):
                            {name}_words[{prefix}_slot * 4 + {word}] = {name}_blocks[i_b, _selected_block, {row}, i_h, {col}]
"""
            part = once(part, old, new)
        part = once(part, """            if direct_k:
                _layout[K_reg] = qk.make_mma_load_layout(K_reg, "B")
""", "")
        k_row = "(k_slot * 512 + tid * 8) // BK"
        k_col = "tid % (BK // 8) * 8 + k_element"
        part = once(part, """                    for j, d in T.Parallel(BS, BK):
                        KV_shared[(j) * BK + (((d) // 8) ^ ((j // KPHASE) % KMAX)) * 8 + (d) % 8] = K_reg[j, d]
""", f"""                    for k_slot in T.unroll(BS * BK // 512):
                        for k_element in T.vectorized(8):
                            KV_shared[({k_row}) * BK + ((({k_col}) // 8) ^ ((({k_row}) // KPHASE) % KMAX)) * 8 + ({k_col}) % 8] = K_reg[k_slot * 8 + k_element]
""")
        part = once(part, """                for j, d in T.Parallel(BS, BV):
                    KV_shared[(j) * BK + (d)] = V_reg[j, d]
""", """                for v_slot in T.unroll(BS * BV // 512):
                    for v_element in T.vectorized(8):
                        KV_shared[(v_slot * 512 + tid * 8) + v_element] = V_reg[v_slot * 8 + v_element]
""")
        result = once(source, original, part)
        ast.parse(result)
        path = HERE / f"mid_words{width}.py"
        write_new(path, result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            words_per_load=width))
    write_new(HERE / "word_views_assembly.json", json.dumps(dict(
        baseline=BASE.name, baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=records,
        hypothesis="Native uint32 local storage might permit wider promoted loads without fp16 aggregate temporaries; shared writes retain original lane mapping and five barriers",
        value_semantics="Same-byte global view and local reinterpretation, no numeric conversion or input preparation"), indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
