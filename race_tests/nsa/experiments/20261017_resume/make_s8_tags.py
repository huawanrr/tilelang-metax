"""Prevalidate and pack eight indices within the existing BS16 K/V pack CTA.

Each CTA has 128 lanes: one lane per (token in block, selected block).
Three wave-local OR shuffles assemble eight bytes for each token. One lane
writes the int64 record. No additional GPU launch or cross-call state.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ATTENTION = (
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
)
PACK = "native_sparse_attention_pack_kv"


def expr(text):
    return ast.parse(text, mode="eval").body


def statements(text):
    return ast.parse(text).body


def convert_pack(original):
    fn = copy.deepcopy(original)
    fn.name += "_s8_tags"
    fn.args.args.append(ast.arg(arg="is_causal"))
    fn.body[:0] = statements("assert block_size == 16 and dim == 64 and 0 < seq_len <= 1024")
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    kernel.args.args.extend([
        ast.arg(arg="RawIndices", annotation=expr("T.Tensor([batch, seq_len, heads, 8], T.int32)")),
        ast.arg(arg="EncodedIndices", annotation=expr("T.Tensor([batch, seq_len, heads], T.int64)")),
    ])
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body.extend(statements('''
tag_bits = T.alloc_local([1], T.uint64)
lane = T.get_thread_binding()
tag_token = bs * BS + lane // 8
raw_block = T.if_then_else(tag_token < seq_len, RawIndices[b, tag_token, h, lane % 8], -1)
tag_valid = tag_token < seq_len and raw_block >= 0 and raw_block < T.ceildiv(seq_len, BS) and (not is_causal or raw_block <= tag_token // BS)
tag_full = raw_block < seq_len // BS and (not is_causal or raw_block < (tag_token + 1) // BS)
tag_code = T.if_then_else(tag_valid, (raw_block & 63) | T.if_then_else(tag_full, 128, 64), 0)
tag_bits[0] = T.cast(tag_code, "uint64") << (lane % 8 * 8)
tag_bits[0] = tag_bits[0] | T.shfl_xor(tag_bits[0], 1, 64, 18446744073709551615)
tag_bits[0] = tag_bits[0] | T.shfl_xor(tag_bits[0], 2, 64, 18446744073709551615)
tag_bits[0] = tag_bits[0] | T.shfl_xor(tag_bits[0], 4, 64, 18446744073709551615)
if lane % 8 == 0 and tag_token < seq_len:
    EncodedIndices[b, tag_token, h] = T.reinterpret("int64", tag_bits[0])
'''))
    return ast.unparse(ast.fix_missing_locations(fn))


def convert_attention(original, mode):
    fn = copy.deepcopy(original)
    fn.name += "_s8_tags"
    fn.body[:0] = statements("assert selected_blocks == 8 and block_size == 16 and dim == 64 and 0 < seq_len <= 1024")
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    arg = next(a for a in kernel.args.args if a.arg == "BlockIndices")
    arg.arg = "EncodedIndices"
    arg.annotation = expr("T.Tensor([batch, seq_len, head_kv], T.int64)")
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    old_loop = next(n for n in scope.body if isinstance(n, ast.For) and ast.unparse(n.target) == "si")
    pos = scope.body.index(old_loop)
    decode = '''
packed_tags = T.alloc_local([S], T.int32)
tag_record = T.reinterpret("uint64", EncodedIndices[i_b, i_t, i_h])
for si in T.unroll(S):
    packed_tags[si] = T.cast((tag_record >> (si * 8)) & T.uint64(255), "int32")
    indices[si] = T.min(packed_tags[si] & 63, T.ceildiv(seq_len, BS) - 1) * BS
'''
    if mode == "compact":
        decode = decode.replace("indices[si] = T.min(packed_tags[si] & 63, T.ceildiv(seq_len, BS) - 1) * BS",
                                "indices[si] = T.if_then_else(packed_tags[si] != 0, T.min(packed_tags[si] & 63, T.ceildiv(seq_len, BS) - 1) * BS, -BS)")
    scope.body[pos:pos + 1] = statements(decode)
    mapping = {}
    for n in ast.walk(scope):
        if isinstance(n, ast.Assign) and isinstance(n.targets[0], ast.Name) and n.targets[0].id.startswith("i_s"):
            assert isinstance(n.value, ast.Subscript) and ast.unparse(n.value.value) == "indices"
            mapping[n.targets[0].id] = "packed_tags[" + ast.unparse(n.value.slice) + "]"
    assert set(mapping) == {"i_s", "i_s0", "i_s1", "i_s2", "i_s3"}
    replaced = []
    if mode == "validated":
        class Guards(ast.NodeTransformer):
            def visit_If(self, node):
                node = self.generic_visit(node)
                text = ast.unparse(node.test)
                found = [v for v in mapping if v in {n.id for n in ast.walk(node.test) if isinstance(n, ast.Name)}]
                if not found:
                    return node
                assert len(found) == 1, text
                var = found[0]
                tag = mapping[var]
                if f"{var} >= 0" in text:
                    assert isinstance(node.test, ast.BoolOp) and isinstance(node.test.op, ast.And)
                    terms = [v for v in node.test.values if var not in {n.id for n in ast.walk(v) if isinstance(n, ast.Name)}]
                    terms.append(expr(tag + " != 0"))
                    node.test = terms[0] if len(terms) == 1 else ast.BoolOp(op=ast.And(), values=terms)
                elif f"{var} + BS >" in text:
                    assert isinstance(node.test, ast.BoolOp) and isinstance(node.test.op, ast.And)
                    assert len(node.test.values) == 2
                    node.test.values[-1] = expr("(" + tag + " & 64) != 0")
                else:
                    raise AssertionError(text)
                replaced.append(dict(before=text, after=ast.unparse(node.test)))
                return node
        fn = Guards().visit(fn)
        assert len(replaced) == 19, len(replaced)
    return ast.unparse(ast.fix_missing_locations(fn)), replaced


def cpu_proof():
    scenarios = 0
    for seq in (1, 15, 16, 17, 31, 32, 127, 128, 255, 256, 511, 512, 1009, 1023, 1024):
        nb = (seq + 15) // 16
        for causal in (False, True):
            for token in range(seq):
                blocks = [-2147483648, -2, -1, *range(nb + 2), 2147483647]
                for block in blocks:
                    valid = block >= 0 and block < nb and (not causal or block <= token // 16)
                    full = block < seq // 16 and (not causal or block < (token + 1) // 16)
                    code = (block & 63) | (128 if full else 64) if valid else 0
                    expected = 0 <= block < nb and (not causal or block * 16 <= token)
                    expected_full = expected and block * 16 + 16 <= seq and (not causal or block * 16 + 16 <= token + 1)
                    assert (code != 0) == expected
                    if expected:
                        assert code & 63 == block
                        assert (code >= 128) == expected_full
                        assert bool(code & 64) == (not expected_full)
                    scenarios += 1
    # Full 128-lane shuffle simulation, including records with sign bit set.
    for seed in range(128):
        codes = [((seed * 13 + t * 17 + s * 7) % 192) for t in range(16) for s in range(8)]
        lane_bits = [code << ((lane % 8) * 8) for lane, code in enumerate(codes)]
        for delta in (1, 2, 4):
            lane_bits = [bits | lane_bits[lane ^ delta] for lane, bits in enumerate(lane_bits)]
        for token in range(16):
            packed = lane_bits[token * 8]
            assert [(packed >> (si * 8)) & 255 for si in range(8)] == codes[token * 8:token * 8 + 8]
    return dict(index_scenarios=scenarios, shuffle_scenarios=128,
                tails_extremes_causal_and_noncausal=True, eight_byte_order_and_duplicates_preserved=True)


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    proof = cpu_proof()
    pack = convert_pack(functions[PACK])
    wrapper = '''
def _make_s8_tagged_attention(pack, attention, batch, seq_len, heads, dim, block_size):
    blocks = (seq_len + block_size - 1) // block_size
    k_shape = (batch, blocks, heads, dim // 32, block_size // 16, 64, 8)
    v_shape = (batch, blocks, heads, block_size // 16, dim // 32, 64, 8)
    tag_shape = (batch, seq_len, heads)
    def run(q, k, v, indices, output):
        packed_k = torch.empty(k_shape, dtype=k.dtype, device=k.device)
        packed_v = torch.empty(v_shape, dtype=v.dtype, device=v.device)
        tags = torch.empty(tag_shape, dtype=torch.int64, device=k.device)
        pack(k, v, packed_k, packed_v, indices, tags)
        attention(q, packed_k, packed_v, tags, output)
    return run
'''
    records = []
    for mode in ("compact", "validated"):
        additions = [pack]
        replaced = {}
        for name in ATTENTION:
            converted, guards = convert_attention(functions[name], mode)
            additions.append(converted)
            replaced[name] = guards
        additions.append(wrapper)
        dispatch = ast.get_source_segment(source, functions["_get_kernel"])
        revised = dispatch.replace("    key = (B, seq_len,", "    s8_tagged = mathcast_s8 and 0 < seq_len <= 1024\n    key = (B, seq_len,", 1)
        revised = revised.replace("small_coalesced_blocks, s2_wave_output)", "small_coalesced_blocks, s2_wave_output, s8_tagged)", 1)
        for name in ATTENTION:
            revised = revised.replace("online_builder = " + name + "\n", "online_builder = " + name + "_s8_tags if s8_tagged else " + name + "\n")
        revised = revised.replace("pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)",
                                  "pack = native_sparse_attention_pack_kv_s8_tags(B, seq_len, H, D, block_size, bool(is_causal)) if s8_tagged else native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)")
        revised = revised.replace("kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)",
                                  "kernel = (_make_s8_tagged_attention if s8_tagged else _make_packed_attention)(pack, attention, B, seq_len, H, D, block_size)")
        result = source.replace(dispatch, "\n\n".join(additions) + "\n\n" + revised, 1)
        ast.parse(result)
        dest = HERE / f"s8_tags_{mode}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, sha256=hashlib.sha256(result.encode()).hexdigest(), mode=mode,
                            replaced_guards=replaced))
    with (HERE / "s8_tags_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), proof=proof,
                       variants=records, all_launches_in_public_call=True, metadata_rebuilt_on_every_call=True,
                       original_math_and_tuning_fallbacks_preserved=True), out, indent=2)
        out.write("\n")
    print("Generated two S8 metadata probes; CPU proof:", proof)


if __name__ == "__main__":
    main()
