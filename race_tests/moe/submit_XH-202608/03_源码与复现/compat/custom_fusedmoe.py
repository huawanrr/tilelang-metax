"""Adapter: the starter kit's `RoutedMoEKernel` interface -> our optimised kernel.

`fusedmoe_benchmark.py` (the organisers' harness, unmodified in this directory) drives
a class called `RoutedMoEKernel` from `custom_fusedmoe`.  Its layout differs from the
one the online judge uses in exactly one respect:

    starter kit : `input` holds the routed tokens *packed* (expert e's rows start at
                  `group_offsets[e]`), while the block grid is still expert-aligned in
                  the *padded* space, so a block addresses row
                  `group_offsets[e] + token_offset + i`.
    online judge : `stacked_expert_tokens` holds the rows at their *padded* positions,
                  so the same block addresses row `block_start + i`.

Everything else -- the expert-aligned 128-row block mapping, `group_idx_for_bx`,
`group_sizes`, the SwiGLU, the routing-weight multiply, the "never write a padding
row" rule -- is identical.  `03_源码与复现/kernel/moe.py` therefore takes one compile-time flag,
`unpadded_rows`, that picks the row base; at its default value the generated device
code is byte-identical to the submitted kernel's (proved by `test/check_equiv.py`),
so this file exercises the real thing and not a variant of it.

Two small conversions are unavoidable and stay inside the timed region, because the
starter kit's argument dtypes/lengths differ from the judge's:

  * `routed_expert_weights` is float16 here and float32 in the judge's contract;
  * `group_offsets` / `group_padded_offsets` are `n_experts` long here and
    `n_experts + 1` long in the judge's contract.

Both are copies into preallocated buffers (a few tens of microseconds in total); the
authoritative kernel timings are the ones in `../../02_日志与结果/04_perf_test.log`, measured through
the judge's own contract by `test/local_bench.py`.

    MOE_IMPL=template python fusedmoe_benchmark.py   # the starter kit's own kernel
    python fusedmoe_benchmark.py                     # ours (default)
"""
import importlib.util
import os

import torch

_HERE = os.path.dirname(os.path.abspath(__file__))
_MOE_PATH = os.path.join(_HERE, os.pardir, "kernel", "moe.py")


def _load_kernel_module():
    spec = importlib.util.spec_from_file_location("moe_kernel_src", _MOE_PATH)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


if os.environ.get("MOE_IMPL", "optimized").lower() == "template":
    from custom_fusedmoe_template import RoutedMoEKernel  # noqa: F401
else:
    moe = _load_kernel_module()

    class RoutedMoEKernel:
        """Same constructor and call signature as the starter kit's class."""

        def __init__(
            self,
            d_hidden: int,
            d_expert: int,
            n_routed_experts: int,
            group_sum: int,
            group_count: int,
            block_token: int = 128,
            block_dhidden: int = 128,
            block_dexpert: int = 128,
            threads: int = 256,
            num_stages: int = 1,
            backend: str = "tilelang",
        ):
            self.d_hidden = d_hidden
            self.d_expert = d_expert
            self.n_routed_experts = n_routed_experts
            self.group_sum = group_sum
            self.group_count = group_count
            self._buffers = {}

        def _buf(self, name, size, dtype, device):
            key = (name, size, dtype, str(device))
            buf = self._buffers.get(key)
            if buf is None:
                buf = torch.empty((size,), dtype=dtype, device=device)
                self._buffers[key] = buf
            return buf

        def __call__(
            self,
            input,
            routed_expert_gate,
            routed_expert_up,
            routed_expert_down,
            routed_expert_weights,
            group_sizes,
            group_offsets,
            group_padded_offsets,
            group_idx_for_bx,
            up_logits,
            output,
        ):
            experts = int(routed_expert_gate.shape[0])
            hidden = int(input.shape[1])
            intermediate = int(routed_expert_gate.shape[1])
            rows = int(input.shape[0])
            valid = int(routed_expert_weights.shape[0])
            blocks = int(group_idx_for_bx.shape[0])
            dev = input.device

            # (E,) -> (E+1); the extra slot is never read by the kernel, it only has to
            # exist for the declared shape.
            off = self._buf("off", experts + 1, torch.int32, dev)
            off[:experts] = group_offsets
            off[experts] = valid
            pad = self._buf("pad", experts + 1, torch.int32, dev)
            pad[:experts] = group_padded_offsets
            pad[experts] = rows
            # float16 -> float32 routing weights
            weights32 = self._buf("w32", valid, torch.float32, dev)
            weights32.copy_(routed_expert_weights)

            block_m, tail_rows = moe._choose_block_m(experts, valid, blocks)
            kernel = moe._get_kernel(
                hidden,
                intermediate,
                experts,
                rows,
                valid,
                blocks,
                block_m,
                tail_rows,
                unpadded_rows=1,
            )
            return kernel(
                input,
                routed_expert_gate,
                routed_expert_up,
                routed_expert_down,
                weights32,
                group_sizes,
                off,
                pad,
                group_idx_for_bx,
                up_logits,
                output,
            )
