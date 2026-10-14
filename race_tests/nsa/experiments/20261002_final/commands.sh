#!/usr/bin/env bash
# Run from /data/tilelang-metax/race_tests/nsa. GPU commands are sequential.
set -eo pipefail
source env.sh
python check_submission_nsa.py experiments/20261002_final/nsa.py experiments/20261002_final/submission.py \
  > experiments/20261002_final/static_checks.log
python experiments/20261002_tuning/compare_family.py \
  experiments/20261002_tuning/reference_1001.py experiments/20261002_final/submission.py \
  --cases all --rounds 4 --repeat 200 --samples 7 --dump \
  --output experiments/20261002_final/full.json > experiments/20261002_final/full.log 2>&1
python experiments/20261002_tuning/verify_reference.py experiments/20261002_final/submission.py --extras \
  --output experiments/20261002_final/verification_fp32.json > experiments/20261002_final/verification_fp32.log 2>&1
python experiments/20261002_tuning/verify_candidate.py --directory experiments/20261002_final \
  --output experiments/20261002_final/release_checks.json > experiments/20261002_final/release_checks.log 2>&1
python check_equiv.py experiments/20261002_final/nsa.py experiments/20261002_final/submission.py \
  > experiments/20261002_final/equivalence.log 2>&1
python experiments/20261002_tuning/bracketed_family.py \
  experiments/20261001_final/submission.py experiments/20261002_tuning/reference_1001.py \
  experiments/20261002_final/submission.py \
  --cases oj6,83,84,69,70,76,oj12,oj9,s2_b1_t2048_h1,s2_b2_t512_h2,s2_b8_t256_h1,s2_b16_t128_h1,s2_b32_t64_h1,s2_b1_t3072_h1,d128_bs32_b4_h2_t1024 \
  --attempts 40 --repeat 500 --max-drift 0.01 \
  --output experiments/20261002_final/bracketed.json > experiments/20261002_final/bracketed.log 2>&1
python experiments/20261002_tuning/check_qo_layouts.py
python experiments/20261002_tuning/check_pack_layouts.py
python experiments/20261002_tuning/write_release.py --directory experiments/20261002_final
