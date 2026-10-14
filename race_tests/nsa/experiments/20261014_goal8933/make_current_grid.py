"""Change CTA traversal in current coalesced FP32/mid paths only."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGETS = {"_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
           "_coalesced_block_loads_prim_fp32_sum", "_coalesced_block_loads_prim_fp32_mask",
           "_coalesced_block_loads_prim_boundary_v8"}


def transform(fn, mode, group):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    pos = fn.body.index(kernel)
    fn.body[pos:pos] = ast.parse(f"order_group = {group} if seq_len % {group} == 0 else 1").body
    launch = next(n for n in kernel.body if isinstance(n, ast.With))
    if mode == "batch":
        replacement = ast.parse('''with T.Kernel(order_group, batch * head_kv, seq_len // order_group, threads=threads) as (grid_minor, grid_head, grid_major):
    bx = grid_major * order_group + grid_minor
    by = 0
    bz = grid_head
''').body[0]
    else:
        replacement = ast.parse('''with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv, threads=threads) as (grid_token, by, bz):
    bx = grid_token % order_group * (seq_len // order_group) + grid_token // order_group
''').body[0]
    replacement.body.extend(launch.body)
    kernel.body[kernel.body.index(launch)] = replacement
    return ast.unparse(ast.fix_missing_locations(fn))


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for mode, group in (("batch", 1), ("batch", 8), ("batch", 32), ("stripe", 8)):
        for length in (128, 256, 512, 1024, 1536, 2048):
            for bh in (1, 2, 3, 4):
                if mode == "batch":
                    visited = [(major*group+minor, head) for major in range(length//group)
                               for head in range(bh) for minor in range(group)]
                else:
                    visited = [(token%group*(length//group)+token//group, head)
                               for head in range(bh) for token in range(length)]
                assert sorted(visited) == [(t,h) for t in range(length) for h in range(bh)]
        revised = source
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in TARGETS:
                revised = revised.replace(ast.get_source_segment(source, fn), transform(fn, mode, group), 1)
        ast.parse(revised)
        path = HERE / f"current_grid_{mode}{group}.py"
        with path.open("x") as out:
            out.write(revised)
        records.append(dict(path=path.name, mode=mode, group=group,
            sha256=hashlib.sha256(revised.encode()).hexdigest()))
    with (HERE / "current_grid_manifest.json").open("x") as out:
        json.dump(dict(variants=records, baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
            proof="Traversal bijection for six sequence lengths and four B*H values; per-CTA memory and synchronization unchanged"), out, indent=2)
        out.write("\n")
    print("Generated four current-grid probes", flush=True)


if __name__ == "__main__":
    main()
