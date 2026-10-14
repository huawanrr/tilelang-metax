"""Assemble reviewable default-path candidates without editing old builders."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PACK_NAME = "native_sparse_attention_pack_kv_bs32_tiles"
PRIM_NAME = "_coalesced_block_loads_prim_boundary"
MID_NAME = "native_sparse_attention_coalesced_boundary"


def function(source, name):
    return next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)


def once(source, old, new):
    assert source.count(old) == 1, old
    return source.replace(old, new)


def main():
    base = (HERE / "parent.py").read_text()
    pack_source = (HERE / "pack_quads_w64.py").read_text()
    mask_source = (HERE / "boundary_mask_post.py").read_text()
    pack = copy.deepcopy(function(pack_source, "native_sparse_attention_pack_kv_bs32_shared"))
    pack.name = PACK_NAME
    pack.body.insert(0, ast.parse("assert dim == 128 and block_size == 32").body[0])
    prim = copy.deepcopy(function(mask_source, "_coalesced_block_loads_prim_oct8"))
    prim.name = PRIM_NAME
    wrapper = copy.deepcopy(function(base, "native_sparse_attention_coalesced_blocks_oct8"))
    wrapper.name = MID_NAME
    for node in ast.walk(wrapper):
        if isinstance(node, ast.Name) and node.id == "_coalesced_block_loads_prim_oct8":
            node.id = PRIM_NAME
    for node in (pack, prim, wrapper):
        ast.fix_missing_locations(node)
    reports = []
    for add_mask in (False, True):
        name = "candidate_pack_mask" if add_mask else "candidate_pack"
        additions = [pack] + ([prim, wrapper] if add_mask else [])
        result = once(base, "def _get_kernel(\n", "\n\n".join(ast.unparse(n) for n in additions) + "\n\ndef _get_kernel(\n")
        result = once(result, "    key = (\n", '''    # Four independent 16x64 tiles improve underfilled shared pack grids.
    # Keep direct packing and larger, already populated pack grids unchanged.
    # This is the number of source K/V blocks, including a padded final block.
    tiled_pack = (mathcast_single and not packed_direct
        and B * H * ((seq_len + block_size - 1) // block_size) <= 256)

    key = (
''')
        result = once(result, "        preload_direct,\n", "        preload_direct, tiled_pack,\n")
        result = once(result,
            "            pack_builder = (native_sparse_attention_pack_kv_bs32_direct if packed_direct\n"
            "                            else native_sparse_attention_pack_kv_bs32_shared)\n",
            "            pack_builder = (native_sparse_attention_pack_kv_bs32_tiles if tiled_pack else\n"
            "                            native_sparse_attention_pack_kv_bs32_direct if packed_direct else\n"
            "                            native_sparse_attention_pack_kv_bs32_shared)\n")
        if add_mask:
            result = once(result,
                "            kernel = native_sparse_attention_coalesced_blocks_oct8(q_vec=8, pv_width=128, **common)\n",
                f"            kernel = {MID_NAME}(q_vec=8, pv_width=128, **common)\n")
        ast.parse(result)
        old = {n.name: ast.dump(n) for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)}
        new = {n.name: ast.dump(n) for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        changed = [key for key in old if old[key] != new.get(key)]
        assert changed == ["_get_kernel"]
        path = HERE / (name + ".py")
        with path.open("x") as handle:
            handle.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            old_functions_changed=changed, old_functions_preserved=len(old)-1,
                            functions_added=sorted(new.keys()-old.keys()), boundary_mask=add_mask))
        print(path.name)
    (HERE / "pack_candidate_assembly.json").write_text(json.dumps(dict(
        parent="parent.py", parent_sha256=hashlib.sha256(base.encode()).hexdigest(), candidates=reports,
        tiled_pack_scope="Default S1/D128/BS32/G16 on existing shared pack path; source block count <= 256",
        threshold_evidence="Original shared pack: 46/48 records improved. All studied grids <=8192 improved; grid16384 regressed in hot and cold checks.",
        mask_scope="Optional complete default S1/D64/BS16 medium coalesced family, unchanged shape limits",
        safety_passes_unchanged=True, new_submission_status="Not validated or released"), indent=2) + "\n")


if __name__ == "__main__":
    main()
