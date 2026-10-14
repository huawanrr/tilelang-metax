"""Check measured/submitted device code, dispatch, synchronization and lane maps."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module
from make_submission import no_docs
from verify_candidate import parts, prior, shape


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def selected(c):
    if c["HQ"] != c["H"] * 16:
        return False
    grid = c["B"] * c["H"] * c["SEQ_LEN"]
    if c["S"] == 8 and c["D"] == 64 and c["block_size"] == 16:
        return grid >= 4096
    if c["S"] != 1:
        return False
    if c["D"] == 128 and c["block_size"] == 32:
        return grid >= 1024
    if c["block_size"] == 16 and c["SEQ_LEN"] % 16 == 0:
        return ((c["D"] == 64 and c["SEQ_LEN"] >= 128 and grid >= 2304)
                or (c["D"] == 128 and grid >= 1280))
    return False


def compiled(module, c):
    values = []
    for part in parts(module._get_kernel(*shape(c))):
        source = part.get_kernel_source()
        assert not any(marker in source for marker in ("memcpy_async", "cp.async", "maca_async", "tma_load", "mbarrier"))
        assert not any(value for key, value in part.pass_configs.items()
                       if "disable_data_race" in str(key) or "disable_safe_memory" in str(key))
        shared, method, _ = prior.helpers.shared_bytes(part)
        values.append(dict(sha256=hashlib.sha256(source.encode()).hexdigest(),
            flags=list(part.compile_flags or []), shared_bytes=shared,
            block_barriers=source.count("__syncthreads()"), wave_barriers=source.count("__syncwarp()"),
            shared_evidence=method))
    return values


def actual_lane_maps(source):
    tree = ast.parse(source)
    parents = {child: node for node in ast.walk(tree) for child in ast.iter_child_nodes(node)}

    class BindThread(ast.NodeTransformer):
        def visit_Call(self, node):
            assert ast.unparse(node) == "T.get_thread_binding()", ast.unparse(node)
            return ast.Name(id="tid", ctx=ast.Load())

    def code(expr):
        clone = ast.parse(ast.unparse(expr), mode="eval")
        return compile(ast.fix_missing_locations(BindThread().visit(clone)), "<lane coordinates>", "eval")

    result = []
    for fn in tree.body:
        if not isinstance(fn, ast.FunctionDef) or not fn.name.endswith("_mathcast"):
            continue
        for node in ast.walk(fn):
            if not isinstance(node, ast.Assign) or len(node.targets) != 1:
                continue
            lhs = node.targets[0]
            if not isinstance(lhs, ast.Subscript) or not isinstance(node.value, ast.Subscript):
                continue
            if "T.get_thread_binding()" not in ast.unparse(lhs):
                continue
            dst = ast.unparse(lhs.value)
            if dst not in ("acc_s_cast", "prob", "O_reg", "output_reg"):
                continue
            parent = parents[node]
            loop = None
            while parent is not fn:
                if isinstance(parent, ast.For) and isinstance(parent.target, ast.Name) and parent.target.id == "cast_chunk":
                    loop = parent
                    break
                parent = parents[parent]
            assert loop is not None and ast.unparse(loop.iter.func) == "T.unroll"
            chunks = code(loop.iter.args[0])
            left, right = code(lhs.slice), code(node.value.slice)
            for d in (64, 128):
                for bs in (16, 32):
                    for width in (32, 64, 128):
                        width = min(width, d)
                        env = dict(D=d, BK=d, BV=d, BS=bs, W=width, VW=width)
                        n_chunks = eval(chunks, {"__builtins__": {}}, env)
                        has_vo = "vo" in ast.unparse(lhs.slice)
                        target_width = d if dst in ("O_reg", "output_reg") else bs
                        seen = set()
                        for vo in range(d // width if has_vo else 1):
                            for tid in range(64):
                                for chunk in range(n_chunks):
                                    for lane in range(4):
                                        local = dict(env, vo=vo, tid=tid, cast_chunk=chunk, cast_lane=lane)
                                        i, j = eval(left, {"__builtins__": {}}, local)
                                        si, sj = eval(right, {"__builtins__": {}}, local)
                                        assert 0 <= i < 16 and 0 <= j < target_width
                                        assert 0 <= si < 16 and 0 <= sj < n_chunks * 16
                                        assert i + (j % 16 // 4) * 16 == tid
                                        assert si + (sj % 16 // 4) * 16 == tid
                                        assert (i, j) not in seen
                                        seen.add((i, j))
                        assert len(seen) == 16 * target_width
            result.append(dict(function=fn.name, destination=dst,
                lhs=ast.unparse(lhs.slice), rhs=ast.unparse(node.value.slice),
                chunk_extent=ast.unparse(loop.iter.args[0]), unique_complete_and_same_thread=True))
    assert result
    return result


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--dev", required=True)
    p.add_argument("--submission", required=True)
    p.add_argument("--family", required=True)
    p.add_argument("--full", required=True)
    p.add_argument("--output", required=True)
    a = p.parse_args()
    dev_source, sub_source = Path(a.dev).read_text(), Path(a.submission).read_text()
    assert ast.dump(no_docs(ast.parse(dev_source))) == ast.dump(no_docs(ast.parse(sub_source)))
    report = dict(status="running", command=sys.argv, source_sha256={p: digest(p) for p in (a.dev, a.submission)},
                  family=[], full=[], lane_maps=actual_lane_maps(dev_source), ast_equal_ignoring_docstrings=True)
    baseline_path = ROOT / "experiments/20261002_mid_v1/submission.py"
    assert digest(baseline_path) == "ee780d62a64e427d742db494596feffd0f3f9834e4587cad61a66713f2936c31"
    dev, sub, baseline = [load_module(str(p)) for p in (a.dev, a.submission, baseline_path)]

    def save():
        Path(a.output).write_text(json.dumps(report, indent=2) + "\n")

    for label, path, measured_source in (("family", a.family, a.dev), ("full", a.full, a.submission)):
        data = json.loads(Path(path).read_text())
        assert data["shared_pool"]
        for name, expected in data["sha256"].items():
            assert digest(ROOT / name) == expected, name
        modules = list(data["sha256"])
        index = next(i for i, name in enumerate(modules) if (ROOT / name).resolve() == Path(measured_source).resolve())
        seen = set()
        for row in data["rows"]:
            key = json.dumps(row["config"], sort_keys=True)
            if label == "family" and key in seen:
                continue
            seen.add(key)
            c = row["config"]
            submitted = compiled(sub, c)
            assert submitted == compiled(dev, c), (label, row["case"], "dev/sub")
            assert [p["sha256"] for p in submitted] == row["device_source_sha256"][index]
            assert [p["flags"] for p in submitted] == row["compile_flags"][index]
            original = compiled(baseline, c)
            equal = submitted == original
            if not selected(c):
                assert equal, (label, row["case"], "out-of-scope change")
            else:
                assert not equal, (label, row["case"], "new path not reached")
                assert len(submitted) == len(original)
                for new, old in zip(submitted, original):
                    for field in ("shared_bytes", "block_barriers", "wave_barriers", "flags"):
                        assert new[field] == old[field], (label, row["case"], field, new, old)
            report[label].append(dict(case=row["case"], config=c, baseline_equal=equal,
                actual_timed_sources_equal=True, development_submission_equal=True, kernels=submitted))
            save()
            print(label, row["case"], "same" if equal else "changed", flush=True)
    report["status"] = "PASS"
    save()
    print("PASS", len(report["family"]), len(report["full"]), "device configurations", flush=True)


if __name__ == "__main__":
    main()
