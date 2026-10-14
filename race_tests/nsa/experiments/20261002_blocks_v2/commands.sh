#!/usr/bin/env bash
# Run from race_tests/nsa; keep GPU commands sequential.
set -eo pipefail
source env.sh

python check_submission_nsa.py experiments/20261002_blocks_v2/nsa.py experiments/20261002_blocks_v2/submission.py > experiments/20261002_blocks_v2/static_checks.log
python experiments/20261002_goal885/compare_family.py experiments/20261001_final/submission.py experiments/20261002_d32_v1/submission.py experiments/20261002_blocks_v2/submission.py --cases all --rounds 4 --repeat 200 --samples 7 --output experiments/20261002_blocks_v2/full.json > experiments/20261002_blocks_v2/full.log 2>&1
python experiments/20261002_goal885/verify_reference.py experiments/20261002_blocks_v2/submission.py --extras --output experiments/20261002_blocks_v2/verification_fp32.json > experiments/20261002_blocks_v2/verification_fp32.log 2>&1
python experiments/20261002_goal885/verify_blocks.py --directory experiments/20261002_blocks_v2 --output experiments/20261002_blocks_v2/release_checks.json > experiments/20261002_blocks_v2/release_checks.log 2>&1
python experiments/20261002_goal885/check_block_layouts.py experiments/20261002_blocks_v2/nsa.py --output experiments/20261002_blocks_v2/layout_proof.json
python check_equiv.py experiments/20261002_blocks_v2/nsa.py experiments/20261002_blocks_v2/submission.py > experiments/20261002_blocks_v2/equivalence.log 2>&1
python experiments/20261002_goal885/audit_sources.py --directory experiments/20261002_blocks_v2 > experiments/20261002_blocks_v2/device_audit.log 2>&1
python experiments/20261002_goal885/bracketed_multiseed.py experiments/20261002_goal885/reference_d32.py experiments/20261002_goal885/reference_d32_control.py experiments/20261002_blocks_v2/submission.py --cases 41,43,55,58,59,29,104,d64_bs16_t8192,d64_bs16_t2304,d64_bs16_t3072,d128_bs16_t1280,d64_bs16_b1_h4_t1024,d128_bs16_b1_h4_t1024,d64_bs16_b1_h1_t2305,d128_bs16_b1_h1_t1281,blocks_d64_b128_t32_h1_c1,blocks_d64_b64_t64_h1_c1,blocks_d64_b32_t112_h1_c1,blocks_d64_b32_t128_h1_c1,blocks_d64_b16_t144_h1_c1,blocks_d64_b8_t160_h2_c1,blocks_d128_b128_t16_h1_c1,blocks_d128_b64_t32_h1_c1,blocks_d128_b32_t48_h1_c1,blocks_d128_b32_t64_h1_c1,blocks_d64_b1_t3072_h1_c0,blocks_d128_b1_t1536_h1_c0 --seeds 0,61,2026 --attempts 24 --repeat 500 --max-drift 0.01 --output experiments/20261002_blocks_v2/bracketed_multiseed.json > experiments/20261002_blocks_v2/bracketed_multiseed.log 2>&1
python experiments/20261002_goal885/write_release.py --directory experiments/20261002_blocks_v2
