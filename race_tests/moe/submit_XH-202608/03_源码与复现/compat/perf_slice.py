"""Run the starter kit's performance test at a batch size that fits a 15 GiB sGPU slice.

`moe_test_configs.json`'s performance entries use bs=4 / bs=8, and the harness's own
post-processing (`torch.scatter_reduce` over a `(group_sum, d_hidden)` int64 index)
then needs a 7 GiB temporary on top of 3 cloned weight sets -- more than this machine's
sliced 15.2 GiB.  The shapes below are the same as the functional configs (bs=1 / bs=2),
which is the largest batch that fits; nothing about the kernel changes.

Note what the starter kit's timer measures: every iteration calls `custom_kernel`,
which clones all weights (~700 MB for the 8-expert config), builds a fresh
`RoutedMoEKernel` and `MoE`, does the host-side routing/sort/gather in Python, and
finishes with a `scatter_reduce`.  The MoE kernel itself is a small part of it, so this
number is an end-to-end figure and not a kernel time -- use it to compare two
implementations under the same harness, and read `../../02_日志与结果/04_perf_test.log` for the kernel.

    python perf_slice.py                    # our kernel
    MOE_IMPL=template python perf_slice.py  # the starter kit's kernel
"""
from fusedmoe_benchmark import run_moe_test

CONFIGS = [
    {"dhidden": 7168, "dexpert": 2048, "nroutedexperts": 8, "nexpertspertoken": 4,
     "bs": 1, "seqlen": 8192, "seed": 81394},
    {"dhidden": 3584, "dexpert": 1024, "nroutedexperts": 4, "nexpertspertoken": 2,
     "bs": 2, "seqlen": 4096, "seed": 81394},
]

if __name__ == "__main__":
    print("=== Running performance tests (batch reduced to fit the 15 GiB slice) ===")
    for cfg in CONFIGS:
        run_moe_test(cfg, "performance", warm_up=5, iteration=30)
