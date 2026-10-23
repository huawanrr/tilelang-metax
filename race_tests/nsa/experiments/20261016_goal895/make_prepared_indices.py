"""Fuse index validation into the existing S8 K/V packing launch.

The attention kernel consumes only metadata produced earlier in the same call.
Start mode stores a valid block start or -1. End mode stores the last valid key
position or -1, encoding both the block number and its boundary mask in int32.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
NAMES = (
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
)


def parse(text):
    return ast.parse(text).body


class PrepareAttention(ast.NodeTransformer):
    def __init__(self, end):
        self.end = end
        self.guards = 0
        self.masks = 0
        self.scales = 0

    def visit_If(self, node):
        test = ast.unparse(node.test)
        match = re.fullmatch(r"is_causal and (i_s[0-3]?) \+ BS > i_t \+ 1", test)
        if match and self.end:
            var = match[1]
            assert "T.clear(acc_s)" in ast.unparse(node)
            self.masks += 1
            return parse(f"""
if {var} % BS != BS - 1:
    for i, j in T.Parallel(G, BS):
        acc_s[i, j] = T.if_then_else(j <= {var} % BS, 0.0, neg_inf)
else:
    T.clear(acc_s)
""")[0]
        if isinstance(node.test, ast.BoolOp) and isinstance(node.test.op, ast.And):
            terms = [ast.unparse(v) for v in node.test.values]
            vars_ = [v for v in ("i_s", "i_s0", "i_s1", "i_s2", "i_s3")
                     if f"{v} >= 0" in terms]
            if vars_:
                assert len(vars_) == 1
                var = vars_[0]
                upper = f"{var} < seq_len"
                causal = f"not is_causal or {var} <= i_t"
                assert upper in terms and causal in terms, terms
                terms = [s for s in terms if s not in (upper, causal)]
                node.test = ast.parse(" and ".join(f"({s})" for s in terms), mode="eval").body
                self.guards += 1
        return self.generic_visit(node)

    def visit_Call(self, node):
        if (self.end and isinstance(node.func, ast.Attribute)
                and node.func.attr == "if_then_else" and node.args):
            test = ast.unparse(node.args[0])
            match = re.fullmatch(
                r"(i_s[0-3]?) \+ j < seq_len and \(not is_causal or \1 \+ j <= i_t\)", test)
            if match:
                node.args[0] = ast.parse(f"j <= {match[1]} % BS", mode="eval").body
                self.scales += 1
        return self.generic_visit(node)


def attention(fn, end):
    fn = copy.deepcopy(fn)
    fn.name += "_prepared"
    transform = PrepareAttention(end)
    fn = transform.visit(fn)
    scope = next(n for n in next(n for n in fn.body if isinstance(n, ast.FunctionDef)).body
                 if isinstance(n, ast.With))
    loop = next(n for n in scope.body if isinstance(n, ast.For)
                and ast.unparse(n.target) == "si")
    assert "raw_index" in ast.unparse(loop)
    loop.body = parse("indices[si] = BlockIndices[i_b, i_t, i_h, si]")
    assert transform.guards == 9, transform.guards
    if end:
        assert transform.masks == 5 and transform.scales == 5, vars(transform)
    return fn, dict(guards=transform.guards, masks=transform.masks, scale_masks=transform.scales)


def packing(fn):
    fn = copy.deepcopy(fn)
    fn.name += "_prepared"
    fn.args.args += [ast.arg(arg="selected_blocks"), ast.arg(arg="is_causal"), ast.arg(arg="end_metadata")]
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    inputs = parse("""
def signature(BlockIndices: T.Tensor([batch, seq_len, heads, selected_blocks], T.int32),
              Prepared: T.Tensor([batch, seq_len, heads, selected_blocks], T.int32)):
    pass
""")[0].args.args
    kernel.args.args.insert(2, inputs[0])
    kernel.args.args.append(inputs[1])
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.body += parse("""
for meta_slot in T.unroll(T.ceildiv(BS * selected_blocks, 128)):
    meta_index = meta_slot * 128 + T.get_thread_binding()
    meta_token = bs * BS + meta_index // selected_blocks
    meta_selected = meta_index % selected_blocks
    if meta_index < BS * selected_blocks and meta_token < seq_len:
        raw_block = BlockIndices[b, meta_token, h, meta_selected]
        if raw_block >= 0 and raw_block < T.ceildiv(seq_len, BS):
            block_start = raw_block * BS
            if not is_causal or block_start <= meta_token:
                if end_metadata:
                    block_end = T.min(block_start + BS - 1, seq_len - 1)
                    if is_causal:
                        block_end = T.min(block_end, meta_token)
                    Prepared[b, meta_token, h, meta_selected] = block_end
                else:
                    Prepared[b, meta_token, h, meta_selected] = block_start
            else:
                Prepared[b, meta_token, h, meta_selected] = -1
        else:
            Prepared[b, meta_token, h, meta_selected] = -1
""")
    return fn


RUNNER = """
def _make_prepared_attention(pack, attention, batch, seq_len, heads, dim, block_size, selected_blocks):
    blocks = (seq_len + block_size - 1) // block_size
    k_shape = (batch, blocks, heads, dim // 32, block_size // 16, 64, 8)
    v_shape = (batch, blocks, heads, block_size // 16, dim // 32, 64, 8)
    index_shape = (batch, seq_len, heads, selected_blocks)
    def run(q, k, v, indices, output):
        packed_k = torch.empty(k_shape, device=k.device, dtype=k.dtype)
        packed_v = torch.empty(v_shape, device=v.device, dtype=v.dtype)
        prepared = torch.empty(index_shape, device=indices.device, dtype=torch.int32)
        pack(k, v, indices, packed_k, packed_v, prepared)
        attention(q, packed_k, packed_v, prepared, output)
    return run
"""


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for end in (False, True):
        result = source
        additions = []
        edits = {}
        for name in NAMES:
            fn, info = attention(functions[name], end)
            additions.append(ast.unparse(ast.fix_missing_locations(fn)))
            edits[name] = info
            old = f"                    online_builder = {name}\n"
            assert result.count(old) == 1
            result = result.replace(old, f"                    online_builder = {name}_prepared\n", 1)
        additions.append(ast.unparse(ast.fix_missing_locations(packing(functions["native_sparse_attention_pack_kv"]))))
        additions.append(RUNNER)
        old = """            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif S > 1 and use_emitter_online:"""
        assert result.count(old) == 1
        result = result.replace(old, f"""            if mathcast_s8:
                pack = native_sparse_attention_pack_kv_prepared(B, seq_len, H, D, block_size, S, bool(is_causal), {end})
                kernel = _make_prepared_attention(pack, attention, B, seq_len, H, D, block_size, S)
            else:
                pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
                kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif S > 1 and use_emitter_online:""", 1)
        at = result.index("def _get_kernel(")
        result = result[:at] + "\n\n".join(additions) + "\n\n" + result[at:]
        ast.parse(result)
        path = HERE / f"prepared_{'end' if end else 'start'}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            end_metadata=end, edits=edits))
    with (HERE / "prepared_manifest.json").open("x") as out:
        json.dump(dict(baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       variants=records, scope="existing default packed mathcast S8",
                       extra_kernel_launches=0, same_call_metadata=True,
                       original_guards_replaced_by_producer_validation=True), out, indent=2)
        out.write("\n")
    print("Generated two same-call index preparation probes")


if __name__ == "__main__":
    main()
