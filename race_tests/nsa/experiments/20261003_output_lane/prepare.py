"""Replace output staging with a bit-preserving, one-step lane permutation."""

import ast
import hashlib
import json
from pathlib import Path
import shutil


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261003_d128_v1/nsa.py"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def output_code(acc, dim="BV", b="i_b", t="i_t", h="i_h", offset="i_v * BV"):
    return f'''            output_tid = T.get_thread_binding()
            output_raw = T.alloc_local([{dim} // 4], T.float16)
            output_words = T.Tensor([{dim} // 8], T.uint32, data=output_raw.data, scope="local")
            output_exchanged = T.alloc_local([{dim} // 8], T.uint32)
            output_halves = T.Tensor([{dim} // 4], T.float16, data=output_exchanged.data, scope="local")
            for output_slot in T.unroll({dim} // 16):
                for output_element in T.vectorized(4):
                    output_raw[output_slot * 4 + output_element] = {acc}[
                        output_tid % 16, output_slot * 16 + output_tid // 16 * 4 + output_element]
            for output_word in T.unroll({dim} // 8):
                output_exchanged[output_word] = T.shfl_sync(output_words[output_word],
                    output_tid // 4 + output_tid % 4 * 16, 64, 0xffffffffffffffff)
            for output_slot in T.unroll({dim} // 16):
                for output_element in T.vectorized(4):
                    Output[{b}, {t}, {h} * G + output_tid // 4,
                           {offset} + output_slot * 16 + output_tid % 4 * 4 + output_element] = output_halves[
                               output_slot * 4 + output_element]
'''


def replace_tail(source, name, marker, code):
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    fn = "".join(lines[start:node.end_lineno])
    assert fn.count(marker) == 1, (name, marker)
    before, tail = fn.split(marker)
    end = tail.index("    return kernel")
    # These kernels have no operations after their final output stores.
    result = before + code + "\n" + tail[end:]
    ast.parse(result)
    return "".join(lines[:start]) + result + "".join(lines[node.end_lineno:])


def functions(source):
    return {n.name: ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}


def main():
    assert digest(BASE) == json.loads(
        BASE.with_name("release_manifest.json").read_text())["source_sha256"]["nsa.py"]
    for name in ("compare_family.py", "bracketed_multiseed.py", "family_cases.json", "inspect_resources.py"):
        target = HERE / name
        assert not target.exists(), target
        shutil.copyfile(ROOT / "experiments/20261003_continue" / name, target)
    for name in ("reference_d128.py", "reference_control.py"):
        target = HERE / name
        assert not target.exists(), target
        shutil.copyfile(BASE, target)
    source = BASE.read_text()
    original = functions(source)
    shared_changes = (
        ("_coalesced_qo_prim", "            O_shared = T.alloc_shared", output_code("O_reg", offset="0")),
        ("_coalesced_block_loads_prim", "            O_shared = T.alloc_shared", output_code("O_reg", offset="0")),
        ("native_sparse_attention_single_packed_qo_v2", "            output_shared = T.alloc_shared", output_code("output_reg", "D", "b", "token", "h", "0")),
        ("native_sparse_attention_online_packed_batch_minor_o_v2", "            O_reg = T.alloc_fragment", output_code("acc_o")),
        ("native_sparse_attention_online_packed_quad_batch_minor_o_v2", "            O_reg = T.alloc_fragment", output_code("acc_o")),
    )
    d32_changes = [
        (name, "            T.copy(acc_o, Output[", output_code("acc_o")) for name in (
            "native_sparse_attention_single_block_emitter_index_guard",
            "native_sparse_attention_single_block_emitter_wave_index_guard",
            "native_sparse_attention_d32_shuffle_wave_index_guard",
            "native_sparse_attention_d32_shuffle", "native_sparse_attention_d32_shuffle_wave",
        )
    ]
    d32_changes += [("native_sparse_attention_d32_compact", "            T.copy(out, Output[",
                     output_code("out", "BV", "b", "t_0", "h", "0"))]
    variants = []
    for label, changes in (("shared", shared_changes), ("d32", d32_changes)):
        result = source
        for name, marker, code in changes:
            result = replace_tail(result, name, marker, code)
        after = functions(result)
        names = {entry[0] for entry in changes}
        assert all(original[n] == after[n] for n in original if n not in names)
        path = HERE / f"output_lane_{label}.py"
        with path.open("x") as output:
            output.write(result)
        variants.append(dict(path=str(path.relative_to(ROOT)), sha256=digest(path), changed_functions=sorted(names)))
    record = dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=digest(BASE), variants=variants,
                  method="Pair fp16 outputs into uint32, permute the lane, store four consecutive fp16 per lane",
                  source_lane="destination_lane // 4 + destination_lane % 4 * 16",
                  unchanged_math=True, asynchronous_operations=False)
    with (HERE / "assembly.json").open("x") as output:
        output.write(json.dumps(record, indent=2) + "\n")
    print(json.dumps(record, indent=2))


if __name__ == "__main__":
    main()
