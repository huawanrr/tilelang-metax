"""Trade shared capacity for fewer Q/K/V staging barriers in medium S1."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGET = "_coalesced_block_loads_prim_oct8"


def code(node):
    return ast.unparse(node)


def statement(text):
    return ast.parse(text).body[0]


class Rename(ast.NodeTransformer):
    def visit_Name(self, node):
        if node.id == "KV_shared":
            node.id = "K_shared"
        return node


def transform(function, all_three):
    prim = next(n for n in function.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
    body = prim.body[0].body
    valid = next(n for n in body if isinstance(n, ast.If) and "qk.mma(" in code(n))
    steps = valid.body
    iqstore = next(i for i, n in enumerate(steps) if code(n) == "T.copy(Q_stage, Q_shared)")
    iqload = next(i for i, n in enumerate(steps) if code(n) == "T.copy(Q_shared, Q_reg)")
    ikstore = next(i for i, n in enumerate(steps) if isinstance(n, ast.If) and code(n.test) == "not direct_k")
    iclear = next(i for i, n in enumerate(steps) if code(n) == "T.clear(acc_s)")
    ikb = next(i for i, n in enumerate(steps) if code(n).startswith("kb = T.alloc_local("))
    ikloop = next(i for i, n in enumerate(steps) if isinstance(n, ast.For) and "qk.mma(" in code(n))
    ivstore = next(i for i, n in enumerate(steps) if code(n).startswith("for j, d in T.Parallel(BS, BV):\n    KV_shared["))
    assert iqstore < iqload < ikstore < iclear < ikb < ikloop < ivstore
    assert code(steps[-1]).startswith("if wave_sync:")
    new_steps = steps[:iqstore] + [steps[iqstore], steps[ikstore]]
    if all_three:
        new_steps.append(steps[ivstore])
        Rename().visit(steps[ikstore])
        Rename().visit(steps[ikloop])
        ikalloc = next(i for i, n in enumerate(body) if code(n).startswith("KV_shared = T.alloc_shared("))
        body.insert(ikalloc + 1, statement("K_shared = T.alloc_shared([BS * VSTRIDE], T.float16)"))
        ilayout = next(i for i, n in enumerate(body) if code(n) == "T.annotate_layout(_layout)")
        body.insert(ilayout, statement("_layout[K_shared] = T.Layout([BS * VSTRIDE], lambda i: i)"))
    new_steps += [statement("T.sync_warp()"), steps[iqload], steps[iclear], steps[ikb], steps[ikloop]]
    if not all_three:
        new_steps += [steps[ikloop + 1], steps[ivstore]]
    new_steps += steps[ivstore + 1:-1 if all_three else None]
    valid.body = new_steps
    # Only this helper's default, one-wave, shared-K path is dispatched here.
    function.body.insert(1, statement("assert threads == 64 and wave_sync and not direct_k"))
    ast.fix_missing_locations(function)
    return function


def main():
    base = (HERE / "parent.py").read_text()
    variants = [
        ("coalesced_qk_joint", "parent.py", False),
        ("coalesced_qkv_joint", "parent.py", True),
        ("coalesced_qkv_mask", "boundary_mask_post.py", True),
    ]
    reports = []
    for name, source, all_three in variants:
        function = next(n for n in ast.parse((HERE / source).read_text()).body
                        if isinstance(n, ast.FunctionDef) and n.name == TARGET)
        function = transform(copy.deepcopy(function), all_three)
        original = next(n for n in ast.parse(base).body
                        if isinstance(n, ast.FunctionDef) and n.name == TARGET)
        lines = base.splitlines(keepends=True)
        lines[original.lineno - 1:original.end_lineno] = [code(function) + "\n"]
        value = "".join(lines)
        ast.parse(value)
        path = HERE / (name + ".py")
        with path.open("x") as handle:
            handle.write(value)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            joint_inputs="QKV" if all_three else "QK",
                            boundary_mask=source != "parent.py", wave_barriers=3 if all_three else 5,
                            shared_bytes_d64=6144 if all_three else 4096))
        print(name)
    (HERE / "joint_shared_manifest.json").write_text(json.dumps(dict(
        parent="parent.py", modified_function=TARGET, variants=reports,
        synchronization="Joint input RAW, optional K/V WAR and V RAW, input/output WAR, output RAW",
        memory="Shared lifetimes overlap until the first reads, preventing unsafe aliasing",
        safety_passes_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
