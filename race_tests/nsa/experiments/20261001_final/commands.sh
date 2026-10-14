#!/usr/bin/env bash
# Run from /data/tilelang-metax/race_tests/nsa. GPU commands are sequential.
set -eo pipefail
source env.sh
python check_submission_nsa.py experiments/20261001_final/nsa.py experiments/20261001_final/submission.py > experiments/20261001_final/static_checks.log
python experiments/20261001_tuning/compare_family.py \
  experiments/20260930_candidate/submission.py experiments/20261001_final/nsa.py \
  --cases all --rounds 4 --repeat 150 --samples 7 --dump \
  --output experiments/20261001_final/full.json > experiments/20261001_final/full.log 2>&1
python verify_nsa.py experiments/20261001_final/submission.py --extras \
  --output experiments/20261001_final/verification.json > experiments/20261001_final/verification.log 2>&1
python experiments/20261001_tuning/verify_release.py \
  --dev experiments/20261001_final/nsa.py --submission experiments/20261001_final/submission.py \
  --packed-bs32-min 1024 --output experiments/20261001_final/release_checks.json > experiments/20261001_final/release_checks.log 2>&1
python check_equiv.py experiments/20261001_final/nsa.py experiments/20261001_final/submission.py > experiments/20261001_final/equivalence.log 2>&1
python experiments/20261001_tuning/bracketed_family.py \
  experiments/20260930_candidate/submission.py experiments/20260930_candidate/nsa.py \
  experiments/20261001_final/submission.py \
  --cases oj6,oj9,59,69,108,83,28,29,43,84,d128_bs32_t1280,d128_bs32_b2_h2_t512,d128_bs16_t1280,d64_bs16_t2304,oj12 \
  --attempts 40 --repeat 500 --max-drift 0.01 --output experiments/20261001_final/bracketed.json > experiments/20261001_final/bracketed.log 2>&1
python experiments/20261001_tuning/check_qo_layouts.py
python experiments/20261001_tuning/write_release.py
