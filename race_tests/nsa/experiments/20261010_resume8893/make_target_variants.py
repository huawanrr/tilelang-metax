"""Create narrow dispatch variants from the validated v9 submission."""

import hashlib
import subprocess
import sys
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
SOURCE = HERE / "candidate_v9_submission.py"
MAKE_SUBMISSION = ROOT / "experiments/20261007_exp_math/make_submission.py"


REPLACEMENTS = {
    # The boundary-v8 large D64 path is slightly slower on the OJ5 shape.
    "v10_oj5_mathcast": (
        "fp32_large = mathcast_blocks and (D == 128 or is_causal)",
        "fp32_large = mathcast_blocks and (D == 128 or (is_causal and not (D == 64 and H == 1 and B == 4 and seq_len == 1024)))",
    ),
    # Compare the older FP32 MMA reduction on exactly OJ5.
    "v10_oj5_fp32sum": (
        "native_sparse_attention_coalesced_blocks_fp32_sum if D == 128 else native_sparse_attention_coalesced_blocks_boundary_v8",
        "native_sparse_attention_coalesced_blocks_fp32_sum if (D == 128 or (D == 64 and H == 1 and B == 4 and seq_len == 1024)) else native_sparse_attention_coalesced_blocks_boundary_v8",
    ),
    # OJ1 uses the same complete-block direct family, but without the V-first
    # load ordering used by v9.
    "v10_oj1_qpreload": (
        "tiny_vfirst = preload_direct and D == 32",
        "tiny_vfirst = preload_direct and D == 32 and grid != 64",
    ),
    # Let OJ1 use the direct K/V register path instead of the Q-preload path.
    "v10_oj1_direct": (
        "preload_direct = oct8_direct and (D != 32 or (seq_len >= 64 and grid <= 64 and is_causal)) or (oct8_complete and D == 128 and (grid <= 128))",
        "preload_direct = (oct8_direct and (D != 32 or (seq_len >= 64 and grid <= 64 and is_causal)) or (oct8_complete and D == 128 and (grid <= 128))) and not (D == 32 and grid == 64)",
    ),
    # Try the FP32-MMA denominator with the alternate natural-exponential
    # implementation on the two-head OJ13 family.
    "v10_oj13_fp32sum": (
        "native_sparse_attention_coalesced_blocks_fp32_mask if fp32_multih else native_sparse_attention_coalesced_blocks_oct8",
        "native_sparse_attention_coalesced_blocks_fp32_sum if fp32_multih else native_sparse_attention_coalesced_blocks_oct8",
    ),
    "v10_oj13_mathcast": (
        "native_sparse_attention_coalesced_blocks_fp32_mask if fp32_multih else native_sparse_attention_coalesced_blocks_oct8",
        "native_sparse_attention_coalesced_blocks_mathcast if fp32_multih else native_sparse_attention_coalesced_blocks_oct8",
    ),
    # Keep the v9 large dispatch but vary the load width only for the long
    # single-head D64 family.
    "v10_large_q4": (
        "builder(q_vec=4 if qo_four else 8, pv_width=64 if qo_narrow else 128, **common)",
        "builder(q_vec=4 if (qo_four or (mathcast_blocks and D == 64 and H == 1 and grid >= 4096)) else 8, pv_width=64 if qo_narrow else 128, **common)",
    ),
    "v10_large_pv64": (
        "builder(q_vec=4 if qo_four else 8, pv_width=64 if qo_narrow else 128, **common)",
        "builder(q_vec=4 if qo_four else 8, pv_width=64 if (qo_narrow or (mathcast_blocks and D == 64 and H == 1 and grid >= 4096)) else 128, **common)",
    ),
}


def main():
    source = SOURCE.read_text()
    for name, (old, new) in REPLACEMENTS.items():
        if source.count(old) != 1:
            raise RuntimeError(f"{name}: expected one match, got {source.count(old)}")
        result = source.replace(old, new, 1)
        dev = HERE / f"{name}.py"
        sub = HERE / f"{name}_submission.py"
        if dev.exists() or sub.exists():
            raise FileExistsError(name)
        dev.write_text(result)
        subprocess.run([sys.executable, str(MAKE_SUBMISSION), str(dev), str(sub)], check=True)
        print(name, hashlib.sha256(sub.read_bytes()).hexdigest(), flush=True)


if __name__ == "__main__":
    main()
