"""Reuse the established GPU checks with the newly selected S1 families."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / "20261015_goal8933/verify_changed_families.py"


def main():
    source = PARENT.read_text()
    result = source.replace(
        '"""Extend the v11 family checks with strict FP32 operands for the D32 builder."""',
        '"""Check S1 dispatch boundaries, strict FP32 types and current-input replay."""', 1)
    start = result.index("    boundaries = ")
    end = result.index("    for c in boundaries:", start)
    result = result[:start] + '''    boundaries = [cfg(t, d=128) for t in
                  (112, 127, 128, 129, 144, 255, 256, 257, 1008, 1024, 1264, 1280, 1296)]
    boundaries += [cfg(64, b=2, d=128), cfg(32, b=4, d=128), cfg(16, b=16, d=128),
                   cfg(64, h=2, d=128), cfg(48, h=3, d=128), cfg(32, h=4, d=128),
                   cfg(16, h=8, d=128), cfg(64, b=2, h=3, d=128),
                   cfg(128, b=3, h=2, d=128), cfg(304, b=2, h=2, d=128)]
    boundaries += [cfg(t, d=128, causal=False) for t in (128, 144, 256, 1024)]
    boundaries += [cfg(t) for t in (240, 256, 272, 384, 496, 511, 512, 513)]
    boundaries += [cfg(128, b=2), cfg(64, b=4), cfg(32, b=8), cfg(16, b=16),
                   cfg(64, b=2, h=2), cfg(96, h=3), cfg(256, causal=False)]
''' + result[end:]
    start = result.index("    active = ")
    end = result.index("    for c in active:", start)
    result = result[:start] + '''    active = [cfg(256, d=128), cfg(96, h=3, d=128),
              cfg(256, d=128, causal=False), cfg(256), cfg(64, b=4)]
''' + result[end:]
    anchor = '    assert report["source_sha256"] == hashlib.sha256(path.read_bytes()).hexdigest()\n'
    assert result.count(anchor) == 1
    extra = '''    # Verify the actual compiled callables in both cache orders.
    parent_path = HERE / "baseline.py"
    parent = load_module(str(parent_path))
    report["parent_sha256"] = hashlib.sha256(parent_path.read_bytes()).hexdigest()
    report["compiled_cache_orders"] = []
    for c in (cfg(256, d=128), cfg(96, h=3, d=128), cfg(256), cfg(64, b=4)):
        inputs = list(make_inputs(c, 2026))
        inputs[3].copy_(helpers.adversarial_indices(inputs[3], c["block_size"], True))
        expected = sparse_reference(*inputs, c["block_size"], c["is_causal"], 0.1)
        out = torch.empty_like(inputs[0])
        for options in ({"q_frag": False}, {"q_preload": True}):
            parent._KERNEL_CACHE.clear()
            original = parent._get_kernel(*shape(c), **options)
            explicit_hash = hashlib.sha256(original.get_kernel_source().encode()).hexdigest()
            module._KERNEL_CACHE.clear()
            normal = module._get_kernel(*shape(c))
            default_hash = hashlib.sha256(normal.get_kernel_source().encode()).hexdigest()
            for order in (({}, options, {}, options), (options, {}, options, {})):
                module._KERNEL_CACHE.clear()
                for request in order:
                    compiled = module._get_kernel(*shape(c), **request)
                    actual_hash = hashlib.sha256(compiled.get_kernel_source().encode()).hexdigest()
                    assert actual_hash == (explicit_hash if request else default_hash), (c, request)
                    out.fill_(float("nan"))
                    compiled(*inputs, out)
                    error = check_output(out, expected, "compiled cache order")
                    report["compiled_cache_orders"].append(dict(config=c, options=request,
                        device_source_sha256=actual_hash, max_abs_error=error))
                save()
        print("compiled cache order", c, "PASS", flush=True)
'''
    result = result.replace(anchor, extra + anchor, 1)
    compile(result, "verify_dispatch_gpu", "exec")
    path = HERE / "verify_dispatch_gpu.py"
    with path.open("x") as out:
        out.write(result)
    with (HERE / "dispatch_validation_manifest.json").open("x") as out:
        json.dump(dict(parent=str(PARENT), parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                       changes=["S1 family boundaries", "S1 scales and current inputs",
                                "actual default/explicit compiled cache orders"]), out, indent=2)
        out.write("\n")
    print(path)


if __name__ == "__main__":
    main()
