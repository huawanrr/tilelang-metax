"""Assemble selected changes over the frozen, officially confirmed baseline."""
import argparse
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ATTENTION = "native_sparse_attention_single_packed_qo_v2_mathcast"
PACKERS = {"native_sparse_attention_pack_kv_bs32_tiles", "native_sparse_attention_pack_kv_bs32_direct",
           "native_sparse_attention_pack_kv_bs32_shared"}


def nodes(source):
    return {n.name:n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}


def decorated_source(source, node):
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return "".join(source.splitlines(keepends=True)[start:node.end_lineno])


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--name", required=True)
    p.add_argument("--s2", action="store_true")
    p.add_argument("--s4-max-grid", type=int, default=0)
    p.add_argument("--mid-head-first", action="store_true")
    p.add_argument("--guard-legacy-indices", action="store_true")
    args = p.parse_args()
    baseline = (HERE / "baseline.py").read_text()
    original = nodes(baseline)
    joint = (HERE / "bs32_j1_g1_m0.py").read_text()
    joint_nodes = nodes(joint)
    small = (HERE / "small_nr2.py").read_text()
    small_nodes = nodes(small)
    revised = baseline
    if args.guard_legacy_indices:
        for legacy_name, block_size_name, output_name in (
            ("native_sparse_attention_online_emitter", "BS", "indices"),
            ("native_sparse_attention_short_list", "IBS", "starts"),
        ):
            legacy = copy.deepcopy(original[legacy_name])
            legacy.decorator_list = []
            class GuardIndex(ast.NodeTransformer):
                count = 0
                def visit_Assign(self, node):
                    if (len(node.targets) == 1 and ast.unparse(node.targets[0]) == f"{output_name}[si]"
                        and ast.unparse(node.value) == f"BlockIndices[i_b, i_t, i_h, si] * {block_size_name}"):
                        self.count += 1
                        return ast.parse(f'''_raw_block_before_scale = BlockIndices[i_b, i_t, i_h, si]
{output_name}[si] = T.if_then_else(_raw_block_before_scale >= 0 and
    _raw_block_before_scale < (seq_len + {block_size_name} - 1) // {block_size_name},
    _raw_block_before_scale, -1) * {block_size_name}
''').body
                    return self.generic_visit(node)
            guard = GuardIndex()
            legacy = guard.visit(legacy)
            assert guard.count == 1, legacy_name
            revised = revised.replace(ast.get_source_segment(baseline, original[legacy_name]),
                                      ast.unparse(ast.fix_missing_locations(legacy)), 1)
    tiny = "native_sparse_attention_q_preload_vfirst"
    revised = revised.replace(ast.get_source_segment(baseline, original[tiny]),
                               ast.get_source_segment(small, small_nodes[tiny]), 1)
    additions = [ast.get_source_segment(small, small_nodes["_small_newton2"])]
    additions += [decorated_source(joint, node) for name, node in joint_nodes.items()
                  if name.endswith("_block_joint") or name == "_make_block_joint_attention"]
    if args.mid_head_first:
        grid = (HERE / "current_grid_batch1.py").read_text()
        grid_nodes = nodes(grid)
        raw_name = "_coalesced_block_loads_prim_fp32_mask"
        new_raw = raw_name + "_head_first_v11"
        raw = copy.deepcopy(grid_nodes[raw_name])
        raw.name = new_raw
        additions.append(ast.unparse(ast.fix_missing_locations(raw)))
        wrapper_name = "native_sparse_attention_coalesced_blocks_fp32_mask"
        wrapper = copy.deepcopy(original[wrapper_name])
        wrapper.decorator_list = []
        call = wrapper.body[0].value
        assert isinstance(wrapper.body[0], ast.Return) and isinstance(call, ast.Call)
        assert ast.unparse(call.func) == raw_name
        call.func = ast.IfExp(test=ast.parse("heads // groups == 2 and batch * seq_len * (heads // groups) <= 1024", mode="eval").body,
            body=ast.Name(id=new_raw, ctx=ast.Load()), orelse=ast.Name(id=raw_name, ctx=ast.Load()))
        revised = revised.replace(ast.get_source_segment(baseline, original[wrapper_name]),
                                  ast.unparse(ast.fix_missing_locations(wrapper)), 1)
    dispatch = copy.deepcopy(original["_get_kernel"])
    branch = next(n for n in ast.walk(dispatch) if isinstance(n, ast.If) and ast.unparse(n.test) == "packed_qo")
    class ChooseJoint(ast.NodeTransformer):
        def visit_Name(self, node):
            if node.id in PACKERS | {ATTENTION, "_make_packed_attention"}:
                name = "_make_block_joint_attention" if node.id == "_make_packed_attention" else node.id + "_block_joint"
                return ast.copy_location(ast.IfExp(test=ast.parse("mathcast_single and grid >= 4096", mode="eval").body,
                    body=ast.Name(id=name, ctx=ast.Load()), orelse=node), node)
            return node
    branch.body = [ChooseJoint().visit(n) for n in branch.body]
    if args.s2 or args.s4_max_grid:
        short = (HERE / "short_sum_r2_m1_n1.py").read_text()
        short_nodes = nodes(short)
        for name, selected, condition in (
            ("native_sparse_attention_short_list_oct8", args.s2, "H == 1"),
            ("native_sparse_attention_staged_sparse_blocks", bool(args.s4_max_grid),
             f"H == 1 and is_causal and seq_len <= 1024 and grid <= {args.s4_max_grid}"),
        ):
            if not selected:
                continue
            new_name = name + "_sum_v11"
            addition = copy.deepcopy(short_nodes[name])
            addition.name = new_name
            additions.append(ast.unparse(ast.fix_missing_locations(addition)))
            class ChooseShort(ast.NodeTransformer):
                def visit_Name(self, node):
                    if node.id == name:
                        return ast.copy_location(ast.IfExp(test=ast.parse(condition, mode="eval").body,
                            body=ast.Name(id=new_name, ctx=ast.Load()), orelse=node), node)
                    return node
            dispatch = ChooseShort().visit(dispatch)
    revised = revised.replace(ast.get_source_segment(baseline, original["_get_kernel"]),
        "\n\n".join(additions) + "\n\n" + ast.unparse(ast.fix_missing_locations(dispatch)), 1)
    ast.parse(revised)
    path = HERE / (args.name + ".py")
    with path.open("x") as out:
        out.write(revised)
    metadata = dict(path=path.name, sha256=hashlib.sha256(revised.encode()).hexdigest(),
        baseline_sha256=hashlib.sha256(baseline.encode()).hexdigest(), tiny_newton2=True,
        joint_bs32_condition="Existing default packed S1 path with grid >= 4096",
        s2_fp32_newton2=args.s2, s2_extra_condition="H == 1", s4_max_grid=args.s4_max_grid,
        s4_extra_condition="H == 1 and is_causal and seq_len <= 1024",
        mid_head_first=args.mid_head_first,
        legacy_raw_index_guards=args.guard_legacy_indices,
        mid_extra_condition="Existing FP32-mask path, H == 2 and grid <= 1024",
        source_probes=["bs32_j1_g1_m0.py", "small_nr2.py", "short_sum_r2_m1_n1.py", "current_grid_batch1.py"])
    with (HERE / (args.name + "_manifest.json")).open("x") as out:
        json.dump(metadata, out, indent=2)
        out.write("\n")
    print(json.dumps(metadata, indent=2), flush=True)


if __name__ == "__main__":
    main()
