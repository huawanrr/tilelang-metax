"""Enumerate the manual shared addresses from the screened S2 function AST."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_short_list_oct8_sum_v11"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def base_name(node):
    return node.value.id if isinstance(node, ast.Subscript) and isinstance(node.value, ast.Name) else None


def expression(node):
    return compile(ast.Expression(node), "<screened-address>", "eval")


def main():
    source = HERE / "wave_output.py"
    fn = next(n for n in ast.parse(source.read_text()).body
              if isinstance(n, ast.FunctionDef) and n.name == NAME)
    stores = {base_name(n.value): n.targets[0].slice for n in ast.walk(fn)
              if isinstance(n, ast.Assign) and len(n.targets) == 1
              and base_name(n.targets[0]) == "KV_shared"}
    loads = {base_name(n.targets[0]): n.value.slice for n in ast.walk(fn)
             if isinstance(n, ast.Assign) and len(n.targets) == 1
             and base_name(n.value) == "KV_shared"}
    assert set(stores) == {"K_reg", "V_reg"}, stores
    assert set(loads) == {"kb", "vb"}, loads
    for node in [*stores.values(), *loads.values()]:
        assert not any(isinstance(n, (ast.Call, ast.Attribute)) for n in ast.walk(node))
    codes = {name: expression(node) for name, node in {**stores, **loads}.items()}

    def address(name, **values):
        return eval(codes[name], {"__builtins__": {}}, dict(BK=64, KPHASE=1, KMAX=8, **values))

    writer_maps = {}
    for name in stores:
        mapping = {}
        for j in range(32):
            for d in range(64):
                index = address(name, j=j, d=d)
                assert index not in mapping
                mapping[index] = (j, d)
        assert sorted(mapping) == list(range(2048))
        writer_maps[name] = mapping
    key_reads, value_reads = [], []
    for ki in range(2):
        for j in range(2):
            for tid in range(64):
                for e in range(8):
                    index = address("kb", ki=ki, j=j, tid=tid, e=e)
                    logical = (j * 16 + tid % 16, ki * 32 + tid // 16 * 8 + e)
                    assert writer_maps["K_reg"][index] == logical
                    key_reads.append(index)
        for j in range(4):
            for tid in range(64):
                for e in range(4):
                    index = address("vb", ki=ki, j=j, tid=tid, e=e)
                    logical = (ki * 16 + tid // 16 * 4 + e, j * 16 + tid % 16)
                    assert writer_maps["V_reg"][index] == logical
                    value_reads.append(index)
    assert sorted(key_reads) == sorted(value_reads) == list(range(2048))
    syncs = [n for n in ast.walk(fn) if isinstance(n, ast.Call)
             and isinstance(n.func, ast.Attribute) and ast.unparse(n.func) == "T.sync_warp"]
    assert len(syncs) == 5
    for node in ast.walk(fn):
        if isinstance(node, ast.Attribute):
            assert node.attr != "TL_DISABLE_DATA_RACE_CHECK"
    report = dict(status="PASS", module=source.name, sha256=sha(source),
                  proof_script_sha256=sha(Path(__file__)),
                  scope=dict(groups=16, dim=64, selected_blocks=2, block_size=16, threads=64),
                  expressions={name: ast.unparse(node) for name, node in {**stores, **loads}.items()},
                  key_store_elements=2048, value_store_elements=2048,
                  key_read_elements=len(key_reads), value_read_elements=len(value_reads),
                  bijective=True, every_read_matches_producer=True,
                  explicit_wave_barriers=5,
                  barrier_roles=["K write to K read", "K reads before V overwrite",
                                 "V write to V read", "V reads before output reuse",
                                 "Output shared write to global copy"],
                  limitations="Address enumeration proves manual K/V mappings; ordering is reviewed against the emitted source and explicit one-wave fences. This is not a dynamic race detector.")
    output = HERE / "shared_layout_proof.json"
    with output.open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print("PASS: 4096 shared stores, 4096 operand reads, five explicit wave barriers; race check stays enabled")


if __name__ == "__main__":
    main()
